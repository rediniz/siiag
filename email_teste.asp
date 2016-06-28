<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%

texto = request("texto")

%>


<script language="VBScript" type="text/vbscript">
on error resume next

		titulo =  "Feliz Aniversário"
		texto = <%=texto%>
		Set OutApl = CreateObject("Outlook.Application")
		Set OutSes = OutApl.GetNameSpace("MAPI")
		OutSes.Logon "Remetente" ,"", False, False
		erro = 0
		sucesso = 0
		
			
			Set OutMsg = OutApl.CreateItem(olMailItem)
			
			OutMsg.Attachments.Add "Teste"
	
			OutMsg.Subject = titulo
			OutMsg.HtmlBody = "teste"
			OutMsg.Recipients.Add  "e711000@mail.caixa"			
			OutMsg.Send
			
			Set OutMsg = Nothing
	
			Set OutApl = Nothing
			
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
