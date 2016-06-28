<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%

matricula = request("matricula")

set leitura = Server.CreateObject("ADODB.RecordSet")
SQL = "SELECT * FROM TB_USUARIOS_PERFIS WHERE CO_MATRICULA = '" & matricula & "'"
'response.Write(SQL)
'response.Write("<br>")
leitura.Open SQL, dados_sys, 3, , 32

valor = "no"

'response.Write(leitura("CO_PERFIL"))

do while not leitura.eof
	if leitura("CO_PERFIL") = 5 or leitura("CO_PERFIL") = 1 or leitura("CO_PERFIL") = 9 then
	valor = "yes"
	end if
leitura.movenext
loop
leitura.close
%>
<input type="hidden" id="soli_subst" value="<%=valor%>">