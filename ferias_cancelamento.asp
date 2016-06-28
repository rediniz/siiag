<!-- #INCLUDE FILE ="include/Conexao.asp" -->

<%
	matricula_a_excluir = Request("matriculaaexcluir")
	situacao = Request("situacao")
	
	' SQL de update da tabela 
	sql = "UPDATE TB_FERIAS SET CO_SITUACAO = 7  WHERE CO_MATRICULA= '" & matricula_a_excluir & "' AND CO_SITUACAO = " & situacao & ""
	Set query = objConn.execute(sql)
	
	'Fechando conexão
	Set query = Nothing
	Set objConn = Nothing
	
	'Redireciona para página anterior informando sucesso e o número do protocolo incluído (alterar valores)
	Response.Redirect("consultar_ferias.asp?sucesso=true")
%>