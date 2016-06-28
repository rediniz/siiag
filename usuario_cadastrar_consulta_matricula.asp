<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	' Conexao com o Banco de dados
	Dim conexao
	Dim coordenacao
	Dim cargo

%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
	' SQL de pesquisa
	matricula = request("matricula")
	sql = "SELECT * FROM TB_USUARIOS where CO_MATRICULA = '" & matricula & "';"
	'response.Write(sql)
	
	Set query = objConn.execute(sql)
	'response.Write(query("co_matricula"))
	
	if query.eof then
		response.Redirect "usuario_cadastrar.asp?f_matricula=" & matricula & "&existe=2"
	else
		response.Redirect "usuario_cadastrar.asp?f_matricula=" & query("co_matricula") & "&existe=1&ativo="  & query("ic_ativo")
	end if
	
	Set query = 	Nothing
	set objConn = nothing
%>
