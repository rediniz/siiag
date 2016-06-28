<script>
	function enviar(){
	
	
		confirmacao = window.confirm("Deseja Enviar?");
		
		
			if(confirmacao == true){
				
			}
	}
</script>   

<h2 class="titulos"> Todos os Aniversariantes</h2> 
<% 
dataTotal = Date() 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)



strQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM TB_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"')" 

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	IF rs.eof Then
	
		response.Write "<p>N&atilde;o h&aacute; aniversariantes hoje.</p>"
		
	
	ELSE	
	
	Response.write "<div class='tabela'>"
	Response.Write "<table >"
    Response.Write "<tr>"
    Response.Write "<td width='auto'>Nome</td>"
    Response.Write "<td width='auto' >Data</td>"
    Response.write"</tr>"


	DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)
	
	
	'if mesCorrente = mesBanco Then
	'	if diaCorrente=diaBanco Then
	response.Write "<tr>"	
	response.Write "<td>"&Nome&"</td>"
	response.Write "<td>"& DAY(dataBanco)&"/"&MONTH(dataBanco) &"</td>"
	response.write "</tr>"
	'End IF
	'End IF
	'END IF

	 
	rs.movenext
	LOOP
	
	End If


set rs = nothing
set objConn = nothing

%>

</table>
</div>

<input name="enviar_nenviados" class="myButton" type="button" value="Enviar Cart&atilde;o" id="enviar_nenviados" style="margin-left:84%;margin-top:15px; width:auto;" onclick="enviar();"/>
