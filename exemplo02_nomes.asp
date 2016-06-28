<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	' Parametros de Conexao ao Banco
	SERVIDOR_DO_BANCO = "ce7180nt005"
	NOME_DO_BANCO = "GIFUG"
	USUARIO_DO_BANCO = "todos"
	SENHA_DO_BANCO = "todosce"

	' Conexao com o Banco de dados
	Dim conexao
	Set conexao = Server.CreateObject("ADODB.Connection")
	conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 'Efetua a Conexão
	
	valor = Replace(Request.QueryString("q"),"'","") 'Valor que vem como parâmetro 

	' SQL de pesquisa
	sql = "SELECT NO_NOME, DT_NASCIMENTO, NU_JORNADA FROM TB_USUARIOS where NO_NOME like '" & valor & "%';"
	Set query = conexao.execute(sql)
	While Not query.eof
		' Lista o nome
		response.write query("NO_NOME")&"|"&query("DT_NASCIMENTO")&"|"&query("NU_JORNADA")&vbCrLf
		query.movenext
	Wend
	
	Set query = Nothing
	Set conexao = Nothing
%>
