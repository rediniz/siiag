<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%

  
	data_conclusao = request("data_conclusao")
	data_prev_inicio = request("data_prev_inicio")	
	
	matricula = request.Cookies("co_usuario_siiag")
	responsavel = request("matResponsavel")
	co_demanda = request("co_demanda")
	tipo_demanda = request("tipo_demanda")
	demandas_situacoes = request("demandas_situacoes")


	'**** consulta demanda
	query = "SELECT * FROM VW_DEMANDAS WHERE CO_DEMANDA = " & co_demanda
	set rcrd=Server.CreateObject("ADODB.RecordSet")
	rcrd.Open query, dados_sys
	if not isnull(rcrd("CO_DEMANDA")) then
		solicitacao_matricula = rcrd("solicitacao_matricula")
		solicitacao_nome = rcrd("solicitacao_nome")		
		no_tipo_demanda = rcrd("no_tipo")
		no_aplicativo = rcrd("no_aplicativo")
		descricao = rcrd("descricao")
	else
		response.write "Demanda não localizada."
		response.end
	end if
	rcrd.close
	'****

	
	if demandas_situacoes = 2 then ' EM ATENDIMENTO
	
			if data_conclusao <> "" then
				query = "UPDATE TB_DEMANDAS SET CONCLUSAO_DATA_PREVISTA = '"&data_conclusao&"', ORDEM_PRIORIDADE = NULL WHERE CO_DEMANDA= "&co_demanda&" "
				objConn.execute(query)
			end if

			if data_prev_inicio <> "" then
				query = "UPDATE TB_DEMANDAS SET DATA_PREVISAO_INICIO = '"&data_prev_inicio&"' WHERE CO_DEMANDA= "&co_demanda&" "
				objConn.execute(query)
			end if
				
			if data_prev_inicio = "" then
				query = "UPDATE TB_DEMANDAS SET INICIO_DATA = '"& date() &"', DATA_PREVISAO_INICIO = '"& date() &"' WHERE CO_DEMANDA= "&co_demanda&" "
			else
				query = "UPDATE TB_DEMANDAS SET INICIO_DATA = '"& date() &"' WHERE CO_DEMANDA= "&co_demanda&" "
			end if
			objConn.execute(query)

			'queryResponsavel = "UPDATE TB_DEMANDAS_RESPONSAVEIS set mat_responsavel = '"&responsavel&"' where co_demanda = "&co_demanda&" "
			'objConn.execute(queryResponsavel)
			
			'response.write queryResponsavel
			queryResponsavel = "DELETE FROM TB_DEMANDAS_RESPONSAVEIS where co_demanda = "&co_demanda&" "
			objConn.execute(queryResponsavel)
			
			tem_estagiario = false
			For Each estagiario in request("v_estagiarios")
				'valores = split(estagiario,":")
				'matricula = valores(0)
				'nome = valores(1)
				queryINSERT = "INSERT INTO TB_DEMANDAS_RESPONSAVEIS (CO_DEMANDA, MAT_RESPONSAVEL, MAT_ESTAGIARIO) VALUES ("&co_demanda&", '"&responsavel&"', '"&estagiario&"')"
				'response.write queryINSERT
				objConn.execute(queryINSERT)
				tem_estagiario = true
			next	
			if not tem_estagiario  then
				queryINSERT = "INSERT INTO TB_DEMANDAS_RESPONSAVEIS (CO_DEMANDA, MAT_RESPONSAVEL) VALUES ("&co_demanda&", '"&responsavel&"')"
				objConn.execute(queryINSERT)
			end if

	end if
	if demandas_situacoes = 7 then ' AGUARDANDO ATENDIMENTO
			if data_conclusao <> "" then
				query = "UPDATE TB_DEMANDAS SET CONCLUSAO_DATA_PREVISTA = '"&data_conclusao&"' WHERE CO_DEMANDA= "&co_demanda&" "
				objConn.execute(query)
			end if

			if data_prev_inicio <> "" then
				query = "UPDATE TB_DEMANDAS SET DATA_PREVISAO_INICIO = '"&data_prev_inicio&"' WHERE CO_DEMANDA= "&co_demanda&" "
				objConn.execute(query)
			end if
				
			if data_prev_inicio = "" then
				query = "UPDATE TB_DEMANDAS SET INICIO_DATA = '"& date() &"', DATA_PREVISAO_INICIO = '"& date() &"' WHERE CO_DEMANDA= "&co_demanda&" "
			else
				query = "UPDATE TB_DEMANDAS SET INICIO_DATA = '"& date() &"' WHERE CO_DEMANDA= "&co_demanda&" "
			end if
			objConn.execute(query)
			
			IF tipo_demanda = 2 then 'reportar erro
				queryPrioridade = "SELECT * FROM TB_DEMANDAS A INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE CO_SITUACAO in (6,7) and tipo_demanda = 2 order by tipo_demanda, ordem_prioridade "
				set rcrd=Server.CreateObject("ADODB.RecordSet")
				rcrd.Open queryPrioridade, dados_sys
				if not isnull(rcrd("co_demanda")) then
					qt_erro = 0
					cont = 1
					do while not rcrd.eof
						qt_erro = qt_erro + 1
						objConn.execute ("UPDATE A SET ORDEM_PRIORIDADE = " & qt_erro & " FROM TB_DEMANDAS A WHERE CO_DEMANDA = " & rcrd("co_demanda") & "")
						'response.write qt_erro & "<br>"
						cont = cont + 1
						rcrd.movenext
					loop					
				else
					qt_erro = 0
				end if
				rcrd.close
				'response.write qt_erro

				
				queryPrioridade = "SELECT * FROM TB_DEMANDAS A INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE CO_SITUACAO in (6,7) and tipo_demanda <> 2 order by ORDEM_PRIORIDADE"
				set rcrd=Server.CreateObject("ADODB.RecordSet")
				rcrd.Open queryPrioridade, dados_sys
				if not isnull(rcrd("CO_DEMANDA")) then
					'** atualiza as demais prioridades
					cont = qt_erro + 2
					do while not rcrd.eof
						objConn.execute ("UPDATE A SET ORDEM_PRIORIDADE = " & cont & " FROM TB_DEMANDAS A WHERE CO_DEMANDA = " & rcrd("co_demanda") & "")
						'response.write cont & "<br>"
						cont = cont + 1
						rcrd.movenext
					loop
				end if
				rcrd.close
				'response.end				
				objConn.execute ("UPDATE A SET ORDEM_PRIORIDADE = " & qt_erro + 1 & " FROM TB_DEMANDAS A WHERE CO_DEMANDA = " & co_demanda & "")
				
				
			else
				queryPrioridade = "SELECT MAX(ORDEM_PRIORIDADE) AS ULTIMO FROM TB_DEMANDAS A INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE CO_SITUACAO in (6,7)"
				set resultadoPrioridade=Server.CreateObject("ADODB.RecordSet")
				resultadoPrioridade.Open queryPrioridade, dados_sys
				if isnull(resultadoPrioridade("ULTIMO")) then
					prioridade  = 1
				else
					prioridade = resultadoPrioridade("ULTIMO") + 1
				end if
	
				query = "UPDATE TB_DEMANDAS SET ORDEM_PRIORIDADE = " & prioridade  & " WHERE CO_DEMANDA= "&co_demanda&" "
				objConn.execute(query)			
			end if
			
	end if

	if demandas_situacoes <> 1 and demandas_situacoes <> 7 and demandas_situacoes <> 6  then
		query = "UPDATE TB_DEMANDAS SET ORDEM_PRIORIDADE = NULL WHERE CO_DEMANDA= "&co_demanda&" "
		objConn.execute(query)
	end if

	dt_atu = date()
	hr_atu = FormatDateTime(NOW(),4)
		
	query = "INSERT INTO TB_DEMANDAS_HISTORICO (CO_DEMANDA, CO_MATRICULA, DT_INCLUSAO, HR_INCLUSAO, CO_SITUACAO) VALUES (" & CO_DEMANDA & ", '" & matricula & "', '" & dt_atu & "', '" & hr_atu & "' , " & demandas_situacoes & ")"
	objConn.execute(query)	

	'**** REORDENA AS PRIORIDADES
	if demandas_situacoes = "2" then ' EM ATENDIMENTO
		'***** 
		queryPrioridade = "SELECT * FROM TB_DEMANDAS A INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE CO_SITUACAO in (6,7) order by ORDEM_PRIORIDADE"
		set rcrd=Server.CreateObject("ADODB.RecordSet")
		rcrd.Open queryPrioridade, dados_sys
		if not isnull(rcrd("CO_DEMANDA")) then
			cont = 1
			do while not rcrd.eof
				objConn.execute ("UPDATE A SET ORDEM_PRIORIDADE = " & cont & " FROM TB_DEMANDAS A WHERE CO_DEMANDA = " & rcrd("co_demanda") & "")
				response.write cont & "<br>"
				cont = cont + 1
				rcrd.movenext
			loop
		end if
		rcrd.close
		'response.end
	end if


	'**** consulta historico
	query = "SELECT * FROM TB_DEMANDAS_SITUACOES WHERE CO_SITUACAO = " & demandas_situacoes
	set rcrd=Server.CreateObject("ADODB.RecordSet")
	rcrd.Open query, dados_sys
	if not isnull(rcrd("CO_SITUACAO")) then
		NO_SITUACAO = rcrd("DE_SITUACAO")
	end if
	rcrd.close
	'****

	 Envia_Email_GIFUG
	if demandas_situacoes = "2" then ' EM ATENDIMENTO
		Envia_Email_Responsavel responsavel
	end if
	response.write "<script>"
	response.write "alert('Demanda editada com sucesso!');"
	response.write "window.location.assign('demanda_consultar.asp?situacao=0&nomeSolicitante=&data_inicio=&data_final=&click=1');"
	response.write "</script>"




Sub Envia_Email_GIFUG()
	IF no_aplicativo = "" then
		no_aplicativo = AplicativoNovo
	END IF
	
	 vTexto = "<html><head><head>"
	 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
	 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
	 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"
	 'vTexto = vTexto & "&Agrave;" & "<br>"
	 'vTexto = vTexto & "Coordenação Informação e Apoio à Gestão <br>"
	 'vTexto = vTexto & "" & "<br><br>"
	 'vTexto = vTexto & "Senhor Coordenador" & "<br>"
	 'vTexto = vTexto & "" & "<br><br>"
	 'vTexto = vTexto & "</b></font><br><br>"
	 vTexto = vTexto & "A demanda a seguir teve seu status alterado, conforme quadro abaixo:<br><br>"


	 vTexto = vTexto & "<table border=""1"" width=""600px"" >"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#75aad0""><font size =""2"" face=""Verdana""><b>DADOS DA DEMANDA</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Solicitante:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & solicitacao_matricula & " - " &  solicitacao_nome & "</font></td>"
	 vTexto = vTexto & "</tr>"
	
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Código da Demanda:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>" & co_demanda & "</a></font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Tipo Demanda:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & no_tipo_demanda  & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Aplicativo:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & no_aplicativo  & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Descrição:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & descricao  & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#75aad0""><font size =""2"" face=""Verdana""><b>STATUS ATUAL</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Data Andamento:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & dt_atu & " - " &  hr_atu & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Status:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & NO_SITUACAO & "</font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "</table>"
	 'vTexto = vTexto & "2. Clique <a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>aqui</a> para visualizar a demanda." & "<br><br>"
	 vTexto = vTexto & "<br>**** Encaminhada pelo SIIAG - Demandas TI *****"
	 vTexto = vTexto & "</body></html>"
 
 If Err.Number<>0 Then
  Response.Write("Erro: " & Err.Description & "<BR>")
  Response.end	
 Else
  'SQL3 = "EXECUTE usp_ADM_Inclui_Email_Enviado 1,'" & vDe & "','" & vPara & "','" & vAssunto & "','" & vTexto & "','" & vUsuario & "'"
  'Set rs3 = DB_Administrativo.Execute(SQL3)
  'vCodEmail = rs3("Cod")
 
  If Err.Number<>0 Then
   Response.Write("Erro: " & Err.Description & "<BR>")
   Response.end
  Else
   vDe =  "gifugfo@mail.caixa"
   vPara = solicitacao_matricula & "@mail.caixa;"
   'vCC = matricula & "@mail.caixa;"
   'vCCO = "c053498@mail.caixa;C124937@mail.caixa;"
   'vPara = "gifugfo01@caixa.gov.br"
   vAssunto = "Demandas TI - Alteração de Status da demanda " & co_demanda
   vUsuario = matricula
   
   'response.write vTexto
   'response.write "DE " & vDE & "<br>"
   'response.write "PARA " & vPara & "<br>"
   'response.write "ASSUNTO " & vAssunto & "<br>"
   'response.write "RETORNO " & vRetorno & "<br>"
   'response.write "USUARIO " & vUsuario & "<br>"
   
   'if enviar = "1" then
    	'email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
		email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
		'response.write email
   'end if

  End If
 End If
End Sub	


Sub Envia_Email_Responsavel(responsavel)
	IF no_aplicativo = "" then
		no_aplicativo = AplicativoNovo
	END IF
	
	 vTexto = "<html><head><head>"
	 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
	 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
	 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"
	 'vTexto = vTexto & "&Agrave;" & "<br>"
	 'vTexto = vTexto & "Coordenação Informação e Apoio à Gestão <br>"
	 'vTexto = vTexto & "" & "<br><br>"
	 'vTexto = vTexto & "Senhor Coordenador" & "<br>"
	 'vTexto = vTexto & "" & "<br><br>"
	 'vTexto = vTexto & "</b></font><br><br>"
	 vTexto = vTexto & "A demanda a seguir foi desiginada para você:<br><br>"


	 vTexto = vTexto & "<table border=""1"" width=""600px"" >"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#75aad0""><font size =""2"" face=""Verdana""><b>DADOS DA DEMANDA</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Solicitante:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & solicitacao_matricula & " - " &  solicitacao_nome & "</font></td>"
	 vTexto = vTexto & "</tr>"
	
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Código da Demanda:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>" & co_demanda & "</a></font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Tipo Demanda:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & no_tipo_demanda  & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Aplicativo:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & no_aplicativo  & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Descrição:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & descricao  & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#75aad0""><font size =""2"" face=""Verdana""><b>STATUS ATUAL</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Data Andamento:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & dt_atu & " - " &  hr_atu & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Status:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & NO_SITUACAO & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Responsável pelo Atendimento:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & responsavel & "</font></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Data Previsão de Conclusão:</b></font></td>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & data_conclusao & "</font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "</table>"
	 'vTexto = vTexto & "2. Clique <a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>aqui</a> para visualizar a demanda." & "<br><br>"
	 vTexto = vTexto & "<br>**** Encaminhada pelo SIIAG - Demandas TI *****"
	 vTexto = vTexto & "</body></html>"
 
 If Err.Number<>0 Then
  Response.Write("Erro: " & Err.Description & "<BR>")
  Response.end	
 Else
  'SQL3 = "EXECUTE usp_ADM_Inclui_Email_Enviado 1,'" & vDe & "','" & vPara & "','" & vAssunto & "','" & vTexto & "','" & vUsuario & "'"
  'Set rs3 = DB_Administrativo.Execute(SQL3)
  'vCodEmail = rs3("Cod")
 
  If Err.Number<>0 Then
   Response.Write("Erro: " & Err.Description & "<BR>")
   Response.end
  Else
   vDe =  "gifugfo@mail.caixa"
   vPara = responsavel & "@mail.caixa;"
   'vCC = matricula & "@mail.caixa;"
   'vCCO = "c053498@mail.caixa;C124937@mail.caixa;"
   'vPara = "gifugfo01@caixa.gov.br"
   vAssunto = "Demandas TI - Designação da demanda " & co_demanda
   vUsuario = matricula
   
   'response.write vTexto
   'response.write "DE " & vDE & "<br>"
   'response.write "PARA " & vPara & "<br>"
   'response.write "ASSUNTO " & vAssunto & "<br>"
   'response.write "RETORNO " & vRetorno & "<br>"
   'response.write "USUARIO " & vUsuario & "<br>"
   
   'if enviar = "1" then
    	'email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
		email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
		'response.write email
   'end if

  End If
 End If
End Sub	


%>
