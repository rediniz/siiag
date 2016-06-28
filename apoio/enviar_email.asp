<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<html>
<style>

.titulos{

color:#248fc5;
font-size:16px;
font-weight:bold;

}

.eventos{
color:#000000;
letter-spacing:0px;
font-family:Arial, Helvetica, sans-serif;
/*border:#000000 solid 1px;*/}

.topoFrase{
border:#aed7e4 solid 1px; 
height:auto;
margin:0px;
padding:0px;
}

.agendaFerias{

margin:0px;
padding:0px;
max-height:5px;
min-height:5px;
}

</style>

<body  onload="enviar_mensagem('<%= mensagem %>')">
<%

texto = request("texto")
mensagem = "Olá"
matricula = request.Cookies("co_usuario_siiag")

response.write mensagem
'RESPONSE.Write(matricula)

%>
</body>

<script language="VBScript" type="text/vbscript">
sub imprimir(texto)
	msgbox texto
end sub



sub enviar_mensagem(texto)
		on error resume next
		titulo =  "PARABÉNS"
		texto_mensagem = texto
		
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
			OutMsg.HtmlBody = replace(replace(texto_mensagem, "@@@", "<%= nome %>"), "***", "<%=tema%>")
			OutMsg.Recipients.Add  "C053498"
			
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
		
end sub
</script>
</html>