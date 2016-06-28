<div class='tabela'>


<% 
dataTotal = Date() 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)


strQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM VW_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"') ORDER BY NO_NOME"

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	IF rs.eof Then
	
		response.Write "<p>N&atilde;o h&aacute; aniversariantes hoje.</p>"
		
	
	ELSE	
	response.write ""
	Response.Write "<table >"
    Response.Write "<tr>"
    Response.Write "<td width='8%'>Nome</td>"
    Response.Write "<td width='10%' >Data</td>"
    Response.write"</tr>"


	DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)
	

	response.Write "<tr>"	
	response.Write "<td>"&Nome&"</td>"
	response.Write "<td>"& DAY(dataBanco)&"/"&MONTH(dataBanco) &"</td>"
	response.write "</tr>"
	
 
	rs.movenext
	LOOP
	
	End If


set rs = nothing
set objConn = nothing

%>

</table>
</div>


  