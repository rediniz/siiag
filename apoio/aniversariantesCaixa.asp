<div class='tabela'>

<%
dataTotal = Date() 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)



strQuery = "SELECT NO_NOME, DT_ADMISSAO FROM VW_USUARIOS WHERE(DAY(DT_ADMISSAO) = '"&diaCorrente&"') AND (MONTH(DT_ADMISSAO) = '"&mesCorrente&"') ORDER BY NO_NOME"
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	IF rs.eof Then
	
		response.Write "<p>N&atilde;o h&aacute; aniversariantes de CAIXA hoje.</p>"
		
	
	ELSE	
	
	Response.Write "<table>"
    Response.Write "<tr>"
    Response.Write "<td width='8%'>Nome</td>"
    Response.Write "<td width='10%' >Data de Admiss&atilde;o</td>"
    Response.write"</tr>"
	
	DO UNTIL rs.eof
	
	NO_NOME=rs("NO_NOME")
	
	DATA_ADMISSAO=rs("DT_ADMISSAO")
	
	response.Write "<tr>"	
	response.Write "<td>"& NO_NOME &"</td>"
	response.Write "<td>"& DATA_ADMISSAO &"</td>"
	response.write "</tr>"
	
	rs.movenext
	LOOP
	
	End If
	
	
objConn.close 
set rs = nothing
set objConn = nothing

%>
</table>
</div>