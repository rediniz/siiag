<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%
	matricula = request.Cookies("co_usuario_siiag")
	responsavel = request("matResponsavel")
	co_demanda = request("co_demanda")
	tipo_demanda = request("tipo_demanda")
	descricao = trim(request("descricao"))
	descricao = replace(descricao,"'","''")

	query = "UPDATE TB_DEMANDAS SET DESCRICAO = '"& descricao &"' WHERE CO_DEMANDA= "&co_demanda&" "
	objConn.execute(query)

	if objConn.errors.count = 0 THEN
		Response.Write "<script>"
		Response.Write "alert('Demanda editada com sucesso!');"
		Response.Write "window.location.assign('demanda_manter.asp?demanda="& co_demanda &"');"
		Response.Write "</script>"
	ELSE
		Response.Write "<script>"
		Response.Write "alert('Não foi possível editar a demanda.');"
		Response.Write "window.location.assign('demanda_manter.asp?demanda="& co_demanda &"');"
		Response.Write "</script>"
	END IF


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
