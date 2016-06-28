<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->

<%
  
  descricao = request("descricao")
  local = request("local")
  tipo = request("tipo")
  situacao = 1 

  co_responsavel = request.Cookies("co_usuario_siiag")
  no_responsavel = request.Cookies("no_usuario_siiag")
   
  data_criacao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
  
  consultaDeTp ="SELECT DE_TIPO FROM TB_TIPO_REPAROS WHERE CO_TIPO = " & tipo 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set ts=Server.CreateObject("ADODB.RecordSet")
                                                ts.Open consultaDeTp, dados_sys
												
												
                                                if not ts.eof then
                                                    de_tp=ts("DE_TIPO")						

                                                end if
                                                set ts= nothing

query = "INSERT INTO TB_REPAROS (DE_DESCRICAO, DE_LOCAL, CO_RESPONSAVEL, NO_RESPONSAVEL, CO_SITUACAO, DH_CRIACAO, CO_TIPO) VALUES ('"&descricao&"','"&local&"', '"&co_responsavel&"', '"&no_responsavel&"',"&situacao&", convert(datetime,'"&data_criacao&"',103),"&tipo&")"
   
   objConn.execute(query)
  
	if objConn.errors.count = 0 THEN
		'enviar o email
		'Envia_Email_GIFUG()
		
		Response.Write "<script>"
		Response.Write "alert('Reparo solicitado com sucesso!');"
		Response.Write "window.location.assign('reparos.asp');"
		Response.Write "</ script>"

	ELSE
		Response.Write "<script>"
		Response.Write "alert('Não foi possível solicitar o reparo, tente novamente.');"
		Response.Write "window.location.assign('reparos.asp');"
		Response.Write "</ script>"
	END IF
	
	  set query = nothing
  	  set objConn = nothing

%>



<%

Sub Envia_Email_GIFUG

 vTexto = "<html><head><head>"
 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"
 vTexto = vTexto & "Registro de solicitação de Reparo <br><br>"
 vTexto = vTexto & "<table border=""1"" width=""600px"" >"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#75aad0""><font size =""2"" face=""Verdana""><b>INFORMAÇÕES DA SOLICITAÇÃO</b></font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Data Solicitação:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & data_criacao & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Solicitante:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & co_responsavel & " - " &  no_responsavel & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Tipo do reparo:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & de_tp  & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Descrição</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & descricao  & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Local:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & local  & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "</table>"

 vTexto = vTexto & "<br>**** Encaminhada pelo SIIAG - Solicitação de Reparos *****"
 vTexto = vTexto & "</body></html>"
 
If Err.Number<>0 Then
  Response.Write("Erro: " & Err.Description & "<BR>")
  Response.end	
 Else 
  If Err.Number<>0 Then
   Response.Write("Erro: " & Err.Description & "<BR>")
   Response.end
  Else
  
   vDe = "gifugfo@mail.caixa"
   vPara = "gifugfo01@mail.caixa;"
   vCC = co_responsavel & "@mail.caixa;"
   vCCO = "C124937@mail.caixa;"
   vAssunto = "SIIAG WEB - Solicitação de Reparo "
   vUsuario = co_responsavel

' response.write vDe & "<br/>"
'   response.write vPara & "<br/>"
'   response.write vCC & "<br/>"
'   response.write vCCO & "<br/>"
'   response.write vAssunto & "<br/>"
'   response.write vUsuario & "<br/>"
'   response.write vTexto & "<br/>"
'   
 		email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
		'response.write email
  End If
 End If
End Sub	

%>