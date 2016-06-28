<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<%

Dim teste

teste = Request.QueryString("cpfgts")
response.write "<center><a href='javascript:history.go(-1)'>"&teste&"</a></center>"

%>