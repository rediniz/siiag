
<%

function enviarCartao(para, de)
	if left(para, 1) = ";" then
		para = right(para, len(para)-1)
	end if
	matriz = split(para,";")
	if de = "" then de = "SUFUG - SN de Fundo de Garantia"
	for a = 0 to ubound(matriz)
		matrizUsu = split (matriz(a),"#")
		matricula = matrizUsu(0)
		nome = matrizUsu(1)
		
	next
	
	%>
	<script language="VBScript" type="text/vbscript">
		on error resume next
		titulo =  "Terte"
		texto = "Texto"
		
		Set OutApl = CreateObject("Outlook.Application")
		Set OutSes = OutApl.GetNameSpace("MAPI")
		OutSes.Logon "<%= de %>" ,"" , False, False
		erro = 0
		sucesso = 0
		
		<%
		randomize
		set fso = server.CreateObject("Scripting.FileSystemObject")

		
		%>
			err.clear
			Set OutMsg = OutApl.CreateItem(olMailItem)
			//OutMsg.Attachments.Add "\\ce7180nt005\cartoesSUFUG$\<%=tema%>"
			
	
			OutMsg.Subject = titulo
			OutMsg.HtmlBody = replace(replace(texto, "@@@", "<%= nome %>"), "***", "<%=tema%>")
			OutMsg.Recipients.Add  "<%="E712237@correiolivre.caixa"%>"
			
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
<%


end function
%>
