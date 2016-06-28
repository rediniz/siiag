<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	Dim coordenacao
	Dim cargo
	Dim output
	
	'Set conexao = Server.CreateObject("ADODB.Connection")
	'conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 'Efetua a Conexão

	co_usuario = Request.QueryString("co_usuario")
	'co_usuario = Request.QueryString("term")	
	
	
	' SQL de pesquisa
	strQuery = 	"SELECT (QT_DIAS - QT_DIAS_UTILIZADO) AS QT_DISPONIVEL FROM VW_TRE WHERE co_matricula = '" & co_usuario & "'  " 	
	Set query = objConn.execute(strQuery)
	if Not query.eof then
	    'output = output & "{""qt_disponivel"":""" & query("QT_DISPONIVEL") & """},"
		response.write query("QT_DISPONIVEL")
	else
		response.write 0
	end if
	
	Set query = Nothing
	Set conexao = Nothing
	
%>
