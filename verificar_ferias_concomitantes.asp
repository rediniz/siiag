<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->

<%
Response.buffer=true
Response.Expires = -1
Response.ExpiresAbsolute = Now() -1 
Response.AddHeader "pragma", "no-store"
Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"
server.ScriptTimeout = 1000
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body>

<%
matricula = request("matricula")
data_inicio = cdate(request("data_inicio"))
gozo = cint(request("gozo"))

set leitura = Server.CreateObject("ADODB.RecordSet")

SQL = "SELECT * FROM [TB_USUARIOS] WHERE CO_MATRICULA = '" & matricula & "'"

leitura.Open SQL, dados_sys, 3, , 32

gs = leitura("CO_GS")

leitura.close

SQL = "SELECT * FROM [VW_FERIAS_USUARIOS] WHERE (DT_INICIO BETWEEN '" & data_inicio & "' and '" & dateadd("d", data_inicio, gozo) & "' or (QT_DIAS + DT_INICIO) BETWEEN '" & data_inicio & "' and '" & dateadd("d", data_inicio, gozo) & "')  AND  (CO_SITUACAO = '1' or CO_SITUACAO = '2' or CO_SITUACAO = '8') ORDER BY DT_INICIO"

leitura.Open SQL, dados_sys, 3, , 32
'response.Write(SQL)

if leitura.eof then
	response.write ("<script language=""javascript""> alert('Não há choque de férias nesse período.'); </script>")
else

%>
<label style="text-align:center; font-size:14px">
Solicitaram férias no mesmo período:<br />

</label>
<table class="tabela" style="width:350px">
<tr>
	<td>
    	Nome
    </td>
    <td>
    	Período
    </td>
</tr>
<%

do while not leitura.eof
%>
<tr>
	<td><%=Pegar_qt_nomes(leitura("NO_NOME"), 2)%></td>
    <td><%=response.Write(leitura("DT_INICIO") & " --- " & dateadd("d", cdate(leitura("DT_INICIO")), cint(leitura("QT_DIAS"))))%></td>
</tr>
<%
leitura.movenext
loop
%>
</table>

<%
end if
%>

</body>
</html>
