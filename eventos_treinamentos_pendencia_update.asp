<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%

co_evento = request("co_evento")
qt_part = request("qt_presente")

strQuery = "UPDATE TB_EVENTOS SET QT_PARTICIPANTES_PRESENTES = " & qt_part  & ",PREST_CONTAS_DATA = '" & now & "', PREST_CONTAS_MATRICULA = '" & request.Cookies("co_usuario_siiag") & "'  FROM TB_EVENTOS WHERE co_evento = "&co_evento&""
Response.Write strQuery
objConn.execute(strQuery)

objConn.close
set objConn = nothing

response.write ("<script language=""javascript""> window.close(); </script>")
%>