<!-- #include file="f_Email.asp" -->

<%
 vTexto = "<html><head><head>"
 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
 vTexto = vTexto & "À" & "<br>"
 vTexto = vTexto & "SR <br>"
 vTexto = vTexto & "e PA Vinculados" & "<br><br>"
 vTexto = vTexto & "Senhor Superintendente" & "<br>"
 vTexto = vTexto & "Senhor Gerente" & "<br><br>"
 vTexto = vTexto & "Assunto: " & vAssunto & "</b></font><br><br>"
 vTexto = vTexto & "1. Comunicamos o envio de correspondências aos clientes em atraso vinculados a essa Superintendência Regional, na quantidade abaixo relacionada:"  & "<br><br>"
 vTexto = vTexto & "<br><br>3. O modelo da correspondência pode ser acessado pelo link ." & "<br><br>"
 vTexto = vTexto & "4. Colocamo-nos à disposição para quaisquer dúvidas ou esclarecimentos." & "<br><br>"
 vTexto = vTexto & "Atenciosamente" & "<br><br>"
 vTexto = vTexto & "<b>Ítalo Reges Marques Cavalcante</b>" & "<br>"
 vTexto = vTexto & "Assistente Pleno" & "<br>"
 vTexto = vTexto & "GIREC/PO<br><br>"
 vTexto = vTexto & "<b>Jean Claude Marques Lacombe</b>" & "<br>"
 vTexto = vTexto & "Coordenador de Filial" & "<br>"
 vTexto = vTexto & "GIREC/PO<br><br>"
 vTexto = vTexto & "<b>Alexandre Machado Schuler</b>" & "<br>"
 vTexto = vTexto & "Gerente de Filial" & "<br>"
 vTexto = vTexto & "GIREC/PO<br>"
 
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
		vPara = "C053498@mail.caixa"
		vAssunto = "Teste"
		vUsuario = "C053498"
		response.write vTexto
		response.write "DE " & vDE & "<br>"
		response.write "PARA " & vPara & "<br>"
		'response.write "ASSUNTO " & vAssunto & "<br>"
		'response.write "RETORNO " & vRetorno & "<br>"
		'response.write "USUARIO " & vUsuario & "<br>"
		
		'if enviar = "1" then
		email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
		response.write email
		'end if
		
	End If
 End If

%> 