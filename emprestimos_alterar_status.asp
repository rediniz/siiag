<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%	
	co_emprestimo = request("co_emprestimo")
	responsavel = request("responsavel")
	co_recurso = request("co_recurso")
	co_responsavel = request("co_responsavel")
	data_devolucao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	matricula = request.Cookies("co_usuario_siiag")
	
	query = "UPDATE TB_EMPRESTIMO_RECURSO SET CO_STATUS = 1, MT_CONTROLE = '"& matricula &"' WHERE CO_EMPRESTIMO = " & co_emprestimo & " AND CO_RECURSO = " & co_recurso & ""
	
	objConn.execute(query)
	
	query_checa_todos = "SELECT * FROM TB_EMPRESTIMO_RECURSO WHERE CO_EMPRESTIMO = " & co_emprestimo & ""
	
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open query_checa_todos, dados_sys
	
	todos = "true"
	
	lista_recursos = ""
		
	do while not rs.eof
		
		co_status = rs("CO_STATUS")
		co_recurso = rs("CO_RECURSO")
		qtd = rs("QT_RECURSO")
		
		query_nome_recurso = "SELECT DE_RECURSO FROM TB_TIPOS_RECURSOS WHERE CO_RECURSO = " & co_recurso
		set rs=Server.CreateObject("ADODB.RecordSet")
		rs.Open query_nome_recurso, dados_sys
		
		de_recurso = rs("DE_RECURSO")
		lista_recursos = lista_recursos & qtd & " " & de_recurso & ","
		
		if co_status = 0 then
		
			todos = "false"
		
		end if
	
		rs.movenext
		
	loop

	lista_recursos = left(lista_recursos, len(lista_recursos)-1)
	
	
	if todos = "true" then

		
		Envia_Email_GIFUG()
		
	end if

	set objConn = nothing	
%>


<%

 Sub Envia_Email_GIFUG

 vTexto = "<html><head><head>"
 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"
 vTexto = vTexto & "Para conhecimento. <br>"
 vTexto = vTexto & "Registramos a devolução, no dia " & data_devolucao & ", do(s) seguinte(s) recurso(s):<br>"
 vTexto = vTexto & lista_recursos & "<br><br>"
 vTexto = vTexto & "Atenciosamente<br><br>"
 vTexto = vTexto & "Informação e Apoio à Gestão<br>"
 vTexto = vTexto & "GI Fundo de Garantia Fortaleza/CE<br>"
 vTexto = vTexto & "<br>**** Encaminhada pelo SIIAG - Devolução de Empréstimo *****"
 vTexto = vTexto & "</body></html>"
 

  If Err.Number<>0 Then
   Response.Write("Erro: " & Err.Description & "<BR>")
   Response.end
  Else
   vDe =  "gifugfo@mail.caixa"
   vPara = co_responsavel & "@mail.caixa;"
   vCC = "gifugfo01@mail.caixa;"
   vCCO = "C124937@mail.caixa;"
   vAssunto = "SIIAG WEB - Devolução de Empréstimo"
   vUsuario = co_responsavel
   
		email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)

 End If
End Sub	

%>