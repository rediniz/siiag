<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%

	co_sequencial = request("co_sequencial")
	sql_pergunta = "DELETE FROM dbo.TB_DEMANDAS_RESPONSAVEL WHERE SEQUENCIAL = " & co_sequencial & " "
	objConn.execute(sql_pergunta)
	'response.Redirect("cadastrar_perguntas.asp?sucesso=true")
%>
