<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	' Parametros de Conexao ao Banco
	SERVIDOR_DO_BANCO = "ce7180nt005"
	NOME_DO_BANCO = "GIFUG"
	USUARIO_DO_BANCO = "todos"
	SENHA_DO_BANCO = "todosce"

	' Conexao com o Banco de dados
	Dim conexao
	Dim output
	Set conexao = Server.CreateObject("ADODB.Connection")
	conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 'Efetua a Conexão
	
	valor = Request.QueryString("term")

	' SQL de pesquisa
	sql = "SELECT co_matricula, dt_nascimento FROM tb_usuarios where co_matricula like '"&valor&"%'"
	Set query = conexao.execute(sql)
		output = "["
	While Not query.eof
		' Lista o nome
	    output = output & "{""nome"":""" & query("co_matricula") & """,""nascimento"":""" & query("dt_nascimento") & """,""value"":""" & query("co_matricula") & """},"
		
		'query("co_matricula")&"|"&query("dt_nascimento")&vbCrLf
		query.movenext
	Wend
	Set query = Nothing
	Set conexao = Nothing
	
	output=Left(output,Len(output)-1)
	output = output & "]"
	response.write output
%>
