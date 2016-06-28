<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%

co_equipamento = request("co_equipamento")


strQuery = "DELETE FROM TB_EQUIPAMENTOS WHERE co_equipamento = "&co_equipamento&""



'Response.Write strQuery

'
objConn.execute(strQuery)

objConn.close
set objConn = nothing

response.write ("<script language=""javascript""> window.close(); </script>")

Response.Redirect("controle.asp?sucesso=true")

%>