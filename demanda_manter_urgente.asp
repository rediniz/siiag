<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%

  
	matricula = request.Cookies("co_usuario_siiag")
	co_demanda = request("co_demanda")
	
	query = "INSERT INTO TB_DEMANDAS_HISTORICO (CO_DEMANDA, CO_MATRICULA, DT_INCLUSAO, HR_INCLUSAO, CO_SITUACAO) VALUES (" & CO_DEMANDA & ", '" & matricula & "', '" & DATE() & "', '" & FormatDateTime(NOW(),4) & "' , 6)"
	objConn.execute(query)	
	Envia_Email_GIFUG()
	Envia_Email_Usuario()

'}else{
'	$query = "UPDATE TB_DEMANDAS SET CONCLUSAO_DATA_PREVISTA = '$data_conclusao' WHERE CO_DEMANDA= $co_demanda ";
'	$resultado = mssql_query($query);
'}
		response.write "<script>"
		'response.write "alert('Solicitação de urgência encaminhada com sucesso!');"
		response.write "window.location.assign('demanda_consultar.asp?situacao=0&nomeSolicitante=&data_inicio=&data_final=&click=1');"
		response.write "</script>"



Sub Envia_Email_GIFUG
 vTexto = "<html><head><head>"
 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA *****" & "<br><br>"
 'vTexto = vTexto & "&Agrave;" & "<br>"
 'vTexto = vTexto & "Coordenação Informação e Apoio à Gestão <br>"
 'vTexto = vTexto & "" & "<br><br>"
 'vTexto = vTexto & "Senhor Coordenador" & "<br>"
 'vTexto = vTexto & "" & "<br><br>"
 'vTexto = vTexto & "</b></font><br><br>"
 vTexto = vTexto & "1. Solicitada urgência para a Demanda " & co_demanda  & " pelo usuário " & matricula & "<br>"
 vTexto = vTexto & "2. Clique <a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>aqui</a> para visualizar a demanda." & "<br><br>"
 vTexto = vTexto & "**** Mensagem encaminhada pelo SIIAG - Demandas TI *****"
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
   vPara = "c053498@mail.caixa;"
   'vPara = "gifugfo01@caixa.gov.br"
   vAssunto = "Demandas TI - Solicitação de Urgência - Demanda " & co_demanda
   vUsuario = matricula
   
   'response.write vTexto
   'response.write "DE " & vDE & "<br>"
   'response.write "PARA " & vPara & "<br>"
   'response.write "ASSUNTO " & vAssunto & "<br>"
   'response.write "RETORNO " & vRetorno & "<br>"
   'response.write "USUARIO " & vUsuario & "<br>"
   
   'if enviar = "1" then
    	email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
		'response.write email
   'end if

  End If
 End If
End Sub

Sub Envia_Email_Usuario
 vTexto = "<html><head><head>"
 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA *****" & "<br><br>"
 'vTexto = vTexto & "&Agrave;" & "<br>"
 'vTexto = vTexto & "Coordenação Informação e Apoio à Gestão <br>"
 'vTexto = vTexto & "" & "<br><br>"
 'vTexto = vTexto & "Senhor Coordenador" & "<br>"
 'vTexto = vTexto & "" & "<br><br>"
 'vTexto = vTexto & "</b></font><br><br>"
 vTexto = vTexto & "1. Sua solicitação de urgência para a Demanda " & co_demanda  & " foi encaminhada para a Equipe de TI.<br><br>"
 vTexto = vTexto & "2. Para acompanhar o andamento da solicitação você pode clicar <a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>aqui</a> ou entrar no SIIAG - Demandas TI na aba CONSULTAR DEMANDA." & "<br><br>"
 vTexto = vTexto & "**** Mensagem encaminhada pelo SIIAG - Demandas TI ****"
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
   vPara = matricula & "@mail.caixa;"
   'vPara = "gifugfo01@caixa.gov.br"
   vAssunto = "Demandas TI - Solicitação de Urgência - Demanda " & co_demanda
   vUsuario = matricula
   
   'response.write vTexto
   'response.write "DE " & vDE & "<br>"
   'response.write "PARA " & vPara & "<br>"
   'response.write "ASSUNTO " & vAssunto & "<br>"
   'response.write "RETORNO " & vRetorno & "<br>"
   'response.write "USUARIO " & vUsuario & "<br>"
   
   'if enviar = "1" then
    	email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
		'response.write email
   'end if

  End If
 End If
End Sub

%> 
