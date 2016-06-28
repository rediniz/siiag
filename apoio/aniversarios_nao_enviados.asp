
<script>
	function enviar(){
	
	
		confirmacao = window.confirm("Deseja Enviar?");
		
		
			if(confirmacao == true){
				
			}
	}
</script>  


<!-- VERIFICAR DEPOIS NO BANCO SIIAG A VIEW DE USUARIOS_PV QUE ESTÁ LA, PARA VERIFICAR SE SERÁ POSSIVEL O CORRETO FUNCIONAMENTO DA CONSULTA, TANTO AQUI, QUANTO NA PÁGINA DE TODOS. --> 
<h2 class="titulos"> Apenas os n&atilde;o enviados</h2>
<div class='tabela'>
<% 
dataTotal = Date() 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)



strQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM TB_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"')"  'WHERE gifug.dbo.tb_log.co_tipo = 11 and gifug.dbo.tb_usuarios.ic_ativo = 1

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	IF rs.eof Then
	
		response.Write "<p>N&atilde;o h&aacute; aniversariantes hoje.</p>"
		
	
	ELSE	
	
	Response.Write "<table  >"
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