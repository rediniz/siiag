<script language="VBScript" type="text/vbscript">
		on error resume next
		titulo =  "PARABÉNS"
		texto = "<table>" & _
		"	<tr>" & _
		"		<td style=""position:relative"">" & _
		"			<div style=""position:absolute; width:228px; text-align:left; " & _
		"			font-family:'Trebuchet MS', Verdana, Arial; font-size:16px; font-weight:bold; top:35px; left:60px;""> " & _
		"			@@@" & _
		"			</div>" & _
		"			<img src=""***"" />" & _
		"		</td>" & _
		"	</tr>" & _
		"</table>"
		
		
		Set OutApl = CreateObject("Outlook.Application")
		Set OutSes = OutApl.GetNameSpace("MAPI")
		OutSes.Logon "C124937" ,"" , False, False
		erro = 0
		sucesso = 0

	
			err.clear
			Set OutMsg = OutApl.CreateItem(olMailItem)
			//OutMsg.Attachments.Add "\\ce7180nt005\cartoesSUFUG$\<%=tema%>"
			//OutMsg.Attachments.Add "\\ce7180nt005\Intranet\aniversarioSUFUG\cartoesSUFUG\<%=tema%>"
	
			OutMsg.Subject = titulo
			OutMsg.HtmlBody = replace(replace(texto, "@@@", "<%= nome %>"), "***", "<%=tema%>")
			OutMsg.Recipients.Add  "C053498@MAIL.CAIXA"
			
			OutMsg.Send
			
			if err.number <> 0 then 
				msgbox "Erro no envio do cartão: " & vbnewline & "DE: <%= de %>" & vbnewline & "<%= data %>  Nome: <%= nome %> Matrícula: <%=matricula%> " & vbnewline & err.description & vbnewline & vbnewline & "Continuando envio de cartões."
				erro = erro + 1
			else
				sucesso = sucesso + 1
			End if
			
			Set OutMsg = Nothing
			
		Set OutApl = Nothing
		

		msgbox "Cartões enviados: " & sucesso & " sucesso(s) / " & erro & " erro(s)"
		
	</script>