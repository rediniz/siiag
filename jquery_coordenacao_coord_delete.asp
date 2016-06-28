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
	tp = request("tp")
	co_coordenacao = request("co_coordenacao")

	if tp = "1" then
		'sql = "UPDATE A SET CO_GERENTE = '" & matricula & "' FROM TB_GS A WHERE CO_GS = " & co_coordenacao & ""
	elseif tp = "2" then
		'sql = "UPDATE A SET CO_SUBSTITUTO = '" & matricula & "' FROM TB_GS A WHERE CO_GS = " & co_coordenacao & ""
	elseif tp = "3" then
		sql = " DELETE FROM TB_GS WHERE CO_GS = " & co_coordenacao & ""
	end if
	'response.write sql
	objConn.execute(sql)
	set objConn = nothing
%>
