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
		sql = "UPDATE A SET CO_GERENTE = '" & matricula & "' FROM TB_GS A WHERE CO_GS = " & co_coordenacao & ""
	elseif tp = "2" then
		sql = "UPDATE A SET CO_SUBSTITUTO = '" & matricula & "' FROM TB_GS A WHERE CO_GS = " & co_coordenacao & ""
	elseif tp = "3" then
		no_coordenacao = request("no_coordenacao")
		sql = "UPDATE A SET NO_GS = '" & no_coordenacao & "' FROM TB_GS A WHERE CO_GS = " & co_coordenacao & ""
	elseif tp = "4" then
		no_coordenacao = request("no_coordenacao")
		sql = "INSERT INTO TB_GS  (NO_GS,IC_ATIVO, CO_UNIDADE)  VALUES('" & no_coordenacao & "',1,'" & request.Cookies("co_usuario_unidade_siiag") & "')"
	end if
	objConn.execute(sql)
	set objConn = nothing
%>
