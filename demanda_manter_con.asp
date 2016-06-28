<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%

  
	data_conclusao = request("data_conclusao")
	data_prev_inicio = request("data_prev_inicio")	
	data_inicio = request("data_inicio")
	observacao = request("motivo")	

	matricula = request.Cookies("co_usuario_siiag")
	'responsavel = request("matResponsavel")
	co_demanda = request("co_demanda")
	tipo_demanda = request("tipo_demanda")
	demandas_situacoes = request("demandas_situacoes")


	'**** consulta demanda
	query = "SELECT * FROM VW_DEMANDAS WHERE CO_DEMANDA = " & co_demanda

	set rcrd=Server.CreateObject("ADODB.RecordSet")
	rcrd.Open query, dados_sys
	if not isnull(rcrd("CO_DEMANDA")) then
		solicitacao_matricula = rcrd("solicitacao_matricula")
		'co_gerente = rcrd("co_gerente")
		'co_substituto = rcrd("co_substituto")
		
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
			else
				data_prev_inicio = date()
			end if
				
			if data_inicio = "" then
				query = "UPDATE TB_DEMANDAS SET INICIO_DATA = '"& data_inicio &"', DATA_PREVISAO_INICIO = '"& data_prev_inicio &"' WHERE CO_DEMANDA= "&co_demanda&" "
			else
				query = "UPDATE TB_DEMANDAS SET INICIO_DATA = '"& data_inicio &"' WHERE CO_DEMANDA= "&co_demanda&" "
			end if
			objConn.execute(query)
		
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
						cont = cont + 1
						rcrd.movenext
					loop					
				else
					qt_erro = 0
				end if
				rcrd.close
				
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
	if demandas_situacoes = 3 then ' FINALIZADA
		query = "UPDATE TB_DEMANDAS SET CONCLUSAO_DATA = '" & DATE() & "' WHERE CO_DEMANDA= " & co_demanda & " "
		objConn.execute(query)
	end if
	
	
	'#Alterado em 08/12/2015 (adicionado situações que deixam a demanda pendente [para o gráfico de demandas])
	'situacao 5 = gozado e 8-em andamento
	if demandas_situacoes = 5 OR demandas_situacoes = 8 then ' FINALIZADA
			dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			
			query_dt_conclusao = "UPDATE TB_DEMANDAS SET DT_PENDENTE = '"&dt_pendencia&"' WHERE CO_DEMANDA= " & co_demanda & " "
			objConn.execute(query_dt_conclusao)
	end if
	
	'*********   GRAVA O STATUS NO HISTORICO **************
	dt_atu = date()
	hr_atu = FormatDateTime(NOW(),4)
		
	query = "INSERT INTO TB_DEMANDAS_HISTORICO (CO_DEMANDA, CO_MATRICULA, DT_INCLUSAO, HR_INCLUSAO, CO_SITUACAO, OBSERVACAO) VALUES (" & CO_DEMANDA & ", '" & matricula & "', '" & dt_atu & "', '" & hr_atu & "' , " & demandas_situacoes & ",'" & observacao & "')"
	objConn.execute(query)
	'*********************************************************

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
		Envia_Email_Responsavel_TI co_demanda
	end if
	response.write "<script>"
	response.write "alert('Demanda editada com sucesso!');"
	Response.Write "window.location.assign('demanda_manter.asp?demanda="& co_demanda &"');"
	'response.write "window.location.assign('demanda_consultar.asp?situacao=0&nomeSolicitante=&data_inicio=&data_final=&click=1');"
	response.write "</script>"




Sub Envia_Email_GIFUG()
	IF no_aplicativo = "" then
		no_aplicativo = AplicativoNovo
	END IF

	set rs_resp=Server.CreateObject("ADODB.RecordSet")
	SQL = "SELECT distinct co_matricula_responsavel,no_responsavel FROM VW_USUARIOS_RESPONSAVEL WHERE CO_TIPO_RESPONSAVEL IN (2,3) and co_demanda = " & co_demanda & ""
	'response.write sql
	rs_resp.Open SQL, dados_sys
	no_responsavel = ""
	vPara = ""
	do while not rs_resp.eof
		no_responsavel = no_responsavel & rs_resp("no_responsavel") & "<br/>"
		vPara = vPara & trim(rs_resp("co_matricula_responsavel")) & "@mail.caixa;"
		rs_resp.movenext
	loop
	set rs_resp =nothing
	
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
	 if demandas_situacoes = "8" then
		 cor_fonte = "#FFFFFF"
	 	 bgcolor = "#04b937"
		 vTexto = vTexto & "Sua demanda está DISPONÍVEL PARA TESTE.<br><br>"
		 vTexto = vTexto & "Você tem até " & dateadd("d",3,date()) & " para <u>FINALIZAR A DEMANDA</u> ou <u>COMUNICAR INCONFORMIDADE</u> através do"
		 vTexto = vTexto & "<a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """> Detalhe da Demanda clicando aqui.</a><br><br>"
	 else
		 cor_fonte = "#FFFFFF"	 
	 	 bgcolor = "#074aac"
		 vTexto = vTexto & "A demanda a seguir teve seu status alterado, conforme quadro abaixo:<br><br>"	 
	 end if


	 vTexto = vTexto & "<table border=""0"" width=""600px"" style=""border: #000 solid 1px;"" >"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" ><img src=""\\ce7180nt005\Intranet\SIIAG_WEB_HOM\imagens\topo_image_tabela.png"" border=""0""  /></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor="""& bgcolor  & """><font size =""2"" face=""Verdana"" color="""& cor_fonte &"""><b>DADOS DA DEMANDA</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2"" ><font size =""2"" face=""Verdana""><b>Solicitante:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""  align=center><font size =""2"" face=""Verdana"">&nbsp;&nbsp;" & solicitacao_matricula & " - " &  solicitacao_nome & "<br/></font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"

 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><b>Código - Tipo - Aplicativo:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""  align=center ><font size =""2"" face=""Verdana"">&nbsp;&nbsp;" & co_demanda & " - " & no_tipo_demanda & " - " & no_aplicativo &  "&nbsp;&nbsp;(<a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """><i>Visualizar Demanda</i></a>)</font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><b>Descrição:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana"">&nbsp;&nbsp;" & descricao  & "</font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor="""& bgcolor  & """><font size =""2"" face=""Verdana"" color="""& cor_fonte &"""><b>DADOS DO ANDAMENTO</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 ><font size =""2"" face=""Verdana""><b>Data - Hora - Status:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & dt_atu & " - " &  hr_atu & " - " & NO_SITUACAO &"</font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 ><font size =""2"" face=""Verdana""><b>Observação:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & OBSERVACAO & "</font></td>"
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
   'vPara = solicitacao_matricula & "@mail.caixa;" & co_gerente & "@mail.caixa;" & co_substituto & "@mail.caixa;" 
   vPara = vPara
   'vCC = vPara
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
    	email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
		'email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
		'response.write email
   'end if

  End If
 End If
End Sub	


Sub Envia_Email_Responsavel_TI(co_demanda)

	IF no_aplicativo = "" then
		no_aplicativo = AplicativoNovo
	END IF

	set rs_resp=Server.CreateObject("ADODB.RecordSet")
	SQL = "SELECT distinct co_matricula_responsavel,no_responsavel,NO_TIPO_RESPONSAVEL FROM VW_USUARIOS_RESPONSAVEL WHERE CO_TIPO_RESPONSAVEL IN (2,3) and co_demanda = " & co_demanda & " order by NO_TIPO_RESPONSAVEL desc"
	'response.write sql
	rs_resp.Open SQL, dados_sys
	no_responsavel = ""
	vPara = ""
	do while not rs_resp.eof
		no_responsavel = no_responsavel & rs_resp("no_responsavel") & "(" & rs_resp("NO_TIPO_RESPONSAVEL")  & ")<br/>"
		vPara = vPara & trim(rs_resp("co_matricula_responsavel")) & "@mail.caixa;"
		rs_resp.movenext
	loop
	set rs_resp =nothing
	 vTexto = "<html><head><head>"
	 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
	 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
	 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"

	 vTexto = vTexto & "A demanda a seguir foi designada para você:<br><br>"


	 vTexto = vTexto & "<table border=""0"" width=""500px"" style="" border: #000 solid 1px;"" >"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" ><img src=""\\ce7180nt005\Intranet\SIIAG_WEB_HOM\imagens\topo_image_tabela.png"" border=""0""  /></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#074aac"" style=""color:#fff;""><font size =""2"" face=""Verdana""><b>DADOS DA DEMANDA</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2"" ><font size =""2"" face=""Verdana""><b>Solicitante:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""  align=center><font size =""2"" face=""Verdana"">&nbsp;&nbsp;" & solicitacao_matricula & " - " &  solicitacao_nome & "<br/></font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"

 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><b>Código - Tipo - Aplicativo:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""  align=center><font size =""2"" face=""Verdana"">&nbsp;&nbsp;" & co_demanda & " - " & no_tipo_demanda & " - " & no_aplicativo &  "&nbsp;&nbsp;(<a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """><i>Visualizar Demanda</i></a>)</font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><b>Descrição:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana"">&nbsp;&nbsp;" & descricao  & "</font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#074aac"" style=""color:#fff;""><font size =""2"" face=""Verdana""><b>DADOS DO ANDAMENTO</b></font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 ><font size =""2"" face=""Verdana""><b>Data - Hora - Status:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td align=""center""><font size =""2"" face=""Verdana"">" & dt_atu & " - " &  hr_atu & " - " & NO_SITUACAO &"</font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 ><font size =""2"" face=""Verdana""><b>Responsável pelo Atendimento:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td align=""center""><font size =""2"" face=""Verdana"">" & no_responsavel & "</font></td>"
	 vTexto = vTexto & "</tr>"
 	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=""2""><font size =""2"" face=""Verdana""><br/></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Data Previsão de Conclusão:</b></font><br/><hr width=""300px"" align=""left"" /></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td align=""center""><font size =""2"" face=""Verdana"">" & data_conclusao & "</font></td>"
	 vTexto = vTexto & "</tr>"

	 vTexto = vTexto & "</table>"
	 'vTexto = vTexto & "2. Clique <a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>aqui</a> para visualizar a demanda." & "<br><br>"
	 vTexto = vTexto & "<br>**** Encaminhada por SIIAG - Demandas TI *****"
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
			vPara = vPara
			'vCC = vPara
			'vCC = matricula & "@mail.caixa;"
			'vCCO = "c077563@mail.caixa;"
			'vPara = "gifugfo01@caixa.gov.br"
			vAssunto = "Demandas TI - Designação da demanda " & co_demanda
			vUsuario = matricula
		
			'response.write vTexto
			'response.write "DE " & vDE & "<br>"
			'response.write "PARA " & vPara & "<br>"
			'response.write "CC " & vCC & "<br>"
			'response.write "CCO " & vCCO & "<br>"
			'response.write "ASSUNTO " & vAssunto & "<br>"
			'response.write "TEXTO" & vTexto & "<br>"
			'response.write "RETORNO " & vRetorno & "<br>"
			'response.write "USUARIO " & vUsuario & "<br>"
		
	    	email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
			'email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
		
		End If
		
	 End If
End Sub	


%>
