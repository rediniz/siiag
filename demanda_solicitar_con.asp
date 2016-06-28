<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!-- #INCLUDE FILE="clsUpload.asp"-->
<!-- #include file = "Upload_funcoes.asp" -->
<%
	Server.ScriptTimeout=10000

	' Cria objeto que gerencia os campos do Form recebido, incluindo os arquivos			
	Set objUpload = new clsUpload

	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("12")


	matricula = request.Cookies("co_usuario_siiag")
	no_matricula = request.Cookies("no_usuario_siiag")
	aplicativo = objUpload("aplicativo").Value
	tipoDemanda = objUpload("tipoDemanda").Value
	descricao = objUpload("descricao").Value
	AplicativoNovo =  objUpload("AplicativoNovo").Value
	qtd_arquivo =  objUpload("qtd_arquivo").Value

	'Response.Write matricula & " "
	'Response.Write aplicativo & " "
	'Response.Write tipoDemanda & " "
	'Response.Write descricao & " "
	'Response.Write AplicativoNovo & " "
	

	
	set rs=Server.CreateObject("ADODB.RecordSet")	
	' Desenvolver Aplicativo
	if tipoDemanda = 1 THEN
		'*** VERIFICAR SE JÁ HÁ UM APLICATIVO COM O MESMO NOME ANTES DE INSERIR
		query2 = "SELECT CO_APLICATIVO FROM TB_APLICATIVOS WHERE NOME = '" & AplicativoNovo  & "'"
		rs.Open query2, dados_sys
		if rs.eof then
			query2 = "INSERT INTO TB_APLICATIVOS (NOME) VALUES ('"&AplicativoNovo&"')"
			objConn.execute(query2)

			query3 = "SELECT CO_APLICATIVO FROM TB_APLICATIVOS WHERE NOME = '"&AplicativoNovo&"'"
			rs.close
			rs.Open query3, dados_sys
		end if
		co_aplicativo = rs("CO_APLICATIVO")
		rs.close
	else
		co_aplicativo = aplicativo
	END IF
 
	'$data = pegaData();
	data = DATE()	

	' Reportar Erro
	IF tipoDemanda = 2 THEN

		queryPrioridade = "SELECT count(*) as qt FROM TB_DEMANDAS A INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE CO_SITUACAO in (1) and tipo_demanda = 2 "
		set rcrd=Server.CreateObject("ADODB.RecordSet")
		rcrd.Open queryPrioridade, dados_sys
		if not isnull(rcrd("qt")) then
			qt_erro = rcrd("qt")
		else
			qt_erro = 0
		end if
		rcrd.close
		set rcrd = nothing
		
		queryPrioridade = "SELECT * FROM TB_DEMANDAS A INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE CO_SITUACAO in (1) and tipo_demanda <> 2 order by ORDEM_PRIORIDADE"
		set rcrd=Server.CreateObject("ADODB.RecordSet")
		rcrd.Open queryPrioridade, dados_sys , 3, -1
		if not isnull(rcrd("CO_DEMANDA")) then
			'** atualiza as demais prioridades
			cont = qt_erro + 2
			do while not rcrd.eof
				sql_update = "UPDATE A SET ORDEM_PRIORIDADE = " & cont & " FROM TB_DEMANDAS A WHERE CO_DEMANDA = " & rcrd("co_demanda") & ""
				'response.write sql_update
				objConn.execute (sql_update)
				
				cont = cont + 1
				rcrd.movenext
			loop
		end if

		query = "INSERT INTO TB_DEMANDAS (SOLICITACAO_DATA, SOLICITACAO_MATRICULA, CO_COORD_DEMANDANTE, TIPO_DEMANDA, CO_APLICATIVO, DESCRICAO, ORDEM_PRIORIDADE) VALUES ('" & data & "', '" & matricula & "','" & REQUEST.Cookies("co_usuario_gs_siiag") & "' ," & tipoDemanda & ", " & co_aplicativo & " , '" & descricao & "', " & qt_erro + 1 & ")"
		'RESPONSE.WRITE QUERY
		objConn.execute(query)


		'************ INCLUI O HISTÓRICO DA SOLICITAÇÃO
		query = "SELECT MAX(CO_DEMANDA) AS CO_DEMANDA FROM TB_DEMANDAS"
		rs.Open query, dados_sys, 3, , 32
		CO_DEMANDA = RS("CO_DEMANDA")
		rs.close
		
		 dt_solicitacao = date()
		 hr_solicitacao = FormatDateTime(NOW(),4)
		query = "INSERT INTO TB_DEMANDAS_HISTORICO (CO_DEMANDA, CO_MATRICULA, DT_INCLUSAO, HR_INCLUSAO, CO_SITUACAO) VALUES (" & CO_DEMANDA & ", '" & matricula & "', '" & dt_solicitacao & "', '" & hr_solicitacao & "' , 1)"
		objConn.execute(query)
		'***********************
		
		'************* INCLUI O USUÁRIO COMO SOLICITANTE
		query = "INSERT INTO TB_DEMANDAS_RESPONSAVEL (CO_DEMANDA, CO_TIPO_RESPONSAVEL, CO_MATRICULA) VALUES (" & CO_DEMANDA & ", 1 ,'" & matricula & "')"
		objConn.execute(query)
		'*************


		query = "SELECT * FROM TB_APLICATIVOS WHERE CO_APLICATIVO = " & co_aplicativo
		rs.Open query, dados_sys, 3, , 32
		no_aplicativo = RS("NOME")
		rs.close
		

	ELSE

		queryPrioridade = "SELECT MAX(ORDEM_PRIORIDADE) AS ULTIMO FROM TB_DEMANDAS A INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE CO_SITUACAO in (1)"
		set resultadoPrioridade=Server.CreateObject("ADODB.RecordSet")
		resultadoPrioridade.Open queryPrioridade, dados_sys
		if isnull(resultadoPrioridade("ULTIMO")) then
			prioridade  = 1
		else
			prioridade = resultadoPrioridade("ULTIMO") + 1
		end if
	
		query = "INSERT INTO TB_DEMANDAS (SOLICITACAO_DATA, SOLICITACAO_MATRICULA,CO_COORD_DEMANDANTE, TIPO_DEMANDA, CO_APLICATIVO, DESCRICAO, ORDEM_PRIORIDADE) VALUES ('" & data & "', '" & matricula & "','" & REQUEST.Cookies("co_usuario_gs_siiag") & "' , " & tipoDemanda & ", " & co_aplicativo & " , '" & descricao & "', " & prioridade & ")"
		'RESPONSE.WRITE QUERY
		objConn.execute(query)


		query = "SELECT MAX(CO_DEMANDA) AS CO_DEMANDA FROM TB_DEMANDAS"
		rs.Open query, dados_sys, 3, , 32
		CO_DEMANDA = RS("CO_DEMANDA")
		rs.close
				 
		 dt_solicitacao = date()
		 hr_solicitacao = FormatDateTime(NOW(),4)
		 
	
		query = "INSERT INTO TB_DEMANDAS_HISTORICO (CO_DEMANDA, CO_MATRICULA, DT_INCLUSAO, HR_INCLUSAO, CO_SITUACAO) VALUES (" & CO_DEMANDA & ", '" & matricula & "', '" & dt_solicitacao & "', '" & hr_solicitacao & "' , 1)"
		'RESPONSE.WRITE QUERY
		objConn.execute(query)


		'************* INCLUI O USUÁRIO COMO SOLICITANTE
		query = "INSERT INTO TB_DEMANDAS_RESPONSAVEL (CO_DEMANDA, CO_TIPO_RESPONSAVEL, CO_MATRICULA) VALUES (" & CO_DEMANDA & ", 1 ,'" & matricula & "')"
		objConn.execute(query)
		'*************

		query = "SELECT * FROM TB_APLICATIVOS WHERE CO_APLICATIVO = " & co_aplicativo
		rs.Open query, dados_sys, 3, , 32
		no_aplicativo = RS("NOME")
		rs.close


	END IF
	
	query = "SELECT * FROM TB_DEMANDAS_TIPOS WHERE CO_TIPO = " & tipodemanda
	rs.Open query, dados_sys, 3, , 32
	no_tipo_demanda = RS("NO_TIPO")
	set rs = nothing
	
	'$PRIORIDADE = mssql_fetch_array($resultadoPrioridade);
	'$prioridadeAcrescida = $PRIORIDADE['ULTIMO']+1;
	
	'query = "INSERT INTO TB_DEMANDAS (SOLICITACAO_DATA, SOLICITACAO_MATRICULA, TIPO_DEMANDA, CO_APLICATIVO, DESCRICAO, CO_SITUACAO, ORDEM_PRIORIDADE) VALUES ('" & data & "', '" & matricula & "', " & tipoDemanda & ", " & co_aplicativo & " , '" & descricao & "', 1, " & prioridade & ")"


	'query3 = "INSERT INTO TB_DEMANDAS (SOLICITACAO_DATA, SOLICITACAO_MATRICULA, TIPO_DEMANDA, CO_APLICATIVO, DESCRICAO, CO_SITUACAO, ORDEM_PRIORIDADE) VALUES ('"&data&"', '"&matricula&"', "& tipoDemanda &", "& aplicativo* ", '"&descricao&"', 1, "&prioridadeAcrescida&")"
	'Response.Write query3
	'objConn.execute(query3)
	'//echo $query;
	'$resultado = mssql_query($query);
	
	for i=1 to qtd_arquivo
		'***** VERIFICA SE TEM ARQUIVO PARA UPLOAD
		' Pega as informações do arquivo
		Set arquivo = objUpload("arquivo"&i)
		nome_arquivo = arquivo.FileName
		extensao =  "."&LCase(arquivo.FileExt)
		tamanho_arquivo = round(arquivo.Length / 1024)
		
		'response.write "o nome do arquivo é: " & arquivo.FileName & "<BR>"
		
		if nome_arquivo <> "" then	
			Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
					
			pastaData = "//ce7180nt005/Aplicativos/Programas/Relatório Protocolo"
			' Salva o arquivo na pasta
			'arquivo.SaveAs(Server.MapPath("Relatorios Protocolo/") & "\" & arquivo.FileName)
			If Not ScriptObject.FolderExists("//CE7180NT005/Aplicativos/Programas/Demandas_TI/arquivos/"& co_demanda &"/") Then
				pasta = ScriptObject.CreateFolder("//CE7180NT005/Aplicativos/Programas/Demandas_TI/arquivos/"& co_demanda &"/")
			Else
				pasta = "//CE7180NT005/Aplicativos/Programas/Demandas_TI/arquivos/"& co_demanda &"/"
			End If
			
			endereco_arquivo = pasta & "\" & arquivo.FileName
			arquivo.SaveAs(pasta & "\" & arquivo.FileName)
			
			endereco_arquivo_banco = replace(endereco_arquivo, "/", "\")
			endereco_arquivo_banco = replace(endereco_arquivo_banco, "\\", "\")
			endereco_arquivo_banco = "\" & endereco_arquivo_banco
				
			' Insere as informações no banco
			sql3 = "INSERT INTO TB_DEMANDAS_ARQUIVOS (CO_DEMANDA,CO_MATRICULA,DT_INCLUSAO,NO_ARQUIVO,ENDERECO_ARQUIVO) VALUES ("&	co_demanda&",'" & matricula & "','" &date()& "','" & arquivo.FileName & "','" & endereco_arquivo_banco & "')"
			'response.write sql3
			Set query3 = objConn.execute(sql3)
		end if
		'*******************
	next


	if objConn.errors.count = 0 THEN
		Envia_Email_GIFUG()
		Response.Write "<script>"
		Response.Write "alert('Demanda solicitada com sucesso!');"
		Response.Write "window.location.assign('demanda_solicitar.asp');"
		Response.Write "</script>"

	ELSE
		Response.Write "<script>"
		Response.Write "alert('Não foi possível solicitar a demanda, tente novamente.');"
		Response.Write "window.location.assign('demanda_solicitar.asp');"
		Response.Write "</script>"
	END IF
	


Sub Envia_Email_GIFUG
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
 vTexto = vTexto & "Registro de solicitação de Demanda <br><br>"
 vTexto = vTexto & "<table border=""1"" width=""600px"" >"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#75aad0""><font size =""2"" face=""Verdana""><b>DADOS DA DEMANDA</b></font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Data Solicitação:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & dt_solicitacao & " " &  hr_solicitacao & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Solicitante:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & matricula & " - " &  no_matricula & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
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
   vPara = "gifugfo01@mail.caixa;"
   vCC = matricula & "@mail.caixa;"
   vCCO = "c053498@mail.caixa;C124937@mail.caixa;"
   'vPara = "gifugfo01@caixa.gov.br"
   vAssunto = "Demandas TI - Solicitação de Demanda " & co_demanda
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