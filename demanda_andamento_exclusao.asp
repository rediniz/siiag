
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%

co_andamento = request("co_andamento")
demanda = request("demanda")


strQuery = "DELETE FROM TB_DEMANDAS_HISTORICO WHERE co_sequencial = "&co_andamento&""
objConn.execute(strQuery)

'Response.Write strQuery


objConn.close
set objConn = nothing

response.write ("<script language=""javascript""> window.close(); </script>")

Response.Redirect("demanda_manter.asp?demanda="&demanda&"")

%>