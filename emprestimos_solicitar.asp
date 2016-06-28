<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%	
	local = request("local")
	responsavel = request("responsavel")
	co_responsavel = request("co_responsavel")
	periodo_inicio = request("periodo_inicio")
	horario_inicio = request("horario_inicio")
	inicio = periodo_inicio & " " & horario_inicio
	periodo_fim = request("periodo_fim")
	horario_fim = request("horario_fim")
	fim = periodo_fim & " " & horario_fim
	observacoes = request("observacoes")
	co_criador = request.Cookies("co_usuario_siiag")
	co_unidade = request.Cookies("co_usuario_unidade_siiag")
	co_tipo_emprestimo = 1
	co_situacao = 1
	data_criacao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	
	sql_emprestimo = "INSERT INTO TB_EMPRESTIMO (CO_UNIDADE, CO_SITUACAO, co_matricula_responsavel, DE_OBS, DH_INICIO, DH_FIM, DH_CRIACAO, DE_LOCAL, CO_CRIADOR, CO_UNIDADE_FGTS, CO_TIPO_EMPRESTIMO) VALUES ("&co_unidade&", "&co_situacao&", '"& co_responsavel &"', '"&observacoes&"', '"&inicio&"', '"&fim&"', '"&data_criacao&"','"&local&"', '"&co_criador&"',"&co_unidade&","&co_tipo_emprestimo&")"
	
	objConn.execute(sql_emprestimo)
	
	sql_cod_emprestimo = "SELECT TOP 1 CO_EMPRESTIMO FROM TB_EMPRESTIMO ORDER BY CO_EMPRESTIMO DESC"
	cod = objConn.execute(sql_cod_emprestimo)
	cod_emprestimo = cod("CO_EMPRESTIMO")
	
	
	lista_recursos = ""
	
	For Each userVal in request.form("recurso_quantidade")
		qtd = mid(userVal,  instr(userVal, ":")+1, len(userVal) )
		cod = left(userVal, instr(userVal, ":")-1)
		response.write "Quantidade:" &qtd & "<br>"
		response.write "Código:" &cod & "<br>"
		sql_recursos = "INSERT INTO TB_EMPRESTIMO_RECURSO (CO_EMPRESTIMO, CO_RECURSO, QT_RECURSO, CO_UNIDADE, CO_STATUS) VALUES ("&cod_emprestimo&", "&cod&", "&qtd&",'" & co_unidade & "', 0)"
		
		query_nome_recurso = "SELECT DE_RECURSO FROM TB_TIPOS_RECURSOS WHERE CO_RECURSO = " & cod 
		set rs=Server.CreateObject("ADODB.RecordSet")
		rs.Open query_nome_recurso, dados_sys
		de_recurso = rs("DE_RECURSO")
		lista_recursos = lista_recursos & qtd & " " & de_recurso & ","
		objConn.execute(sql_recursos)
	next
	
	lista_recursos = left(lista_recursos, len(lista_recursos)-1)
	
	'Envia_Email_GIFUG()
	  
	set sql_emprestimo = nothing
	set sql_cod_emprestimo = nothing
	set sql_recursos = nothing
	set objConn = nothing	
%>

<%

Sub Envia_Email_GIFUG

 vTexto = "<html><head><head>"
 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"
 vTexto = vTexto & "Ao<br> Apoio <br><br>"
 vTexto = vTexto & "1	Registramos que o usuário " & responsavel & " solicitou no dia " & data_criacao & " o(s) seguinte(s) recurso(s):<br><br>"
 vTexto = vTexto & lista_recursos & "<br><br>"
 vTexto = vTexto & "2	No ato da soliciação o usuário concordou com o termo de responsabilidade pelo uso do(s) recurso(s) citado(s).<br><br>"
 vTexto = vTexto & "<br>**** Encaminhada pelo SIIAG - Solicitação de Empréstimo *****"
 vTexto = vTexto & "</body></html>"
 
 If Err.Number<>0 Then
  Response.Write("Erro: " & Err.Description & "<BR>")
  Response.end	
 Else
 
  If Err.Number<>0 Then
   Response.Write("Erro: " & Err.Description & "<BR>")
   Response.end
  Else
   vDe =  "gifugfo@mail.caixa"
   vPara = "gifugfo01@mail.caixa;"
   vCC = co_responsavel & "@mail.caixa;"
   vCCO = "C124937@mail.caixa;"
   vAssunto = "SIIAG WEB - Solicitação de Empréstimo "
   vUsuario = co_responsavel
   
		email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)

  End If
 End If
End Sub	

%>