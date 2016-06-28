<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<style>
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

            
           
<%




tabela ="<table  ><tr><td width='20%'>Material</td><td width='8%'>Quantidade</td><td width='19%'>Nome</td><td width='15%' >Coordena&ccedil;&atilde;o</td><td width='10%' >Solicitado em</td><td>Editar</td></tr>"

strQuery = "SELECT * FROM VW_PENDENCIAS_ESTOQUE WHERE CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY NO_NOME"

'response.write(strQuery)


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

if rs.eof Then

	Response.Write "<p>N&atilde;o h&aacute; pend&ecirc;ncias no estoque</p>"
	
	Else

	Response.write "<div class='tabela'>"
	Response.Write tabela	
   			
		
	DO UNTIL rs.eof
	

		
		NO_MATERIAL = rs("NO_MATERIAL")
		QT_SOLICITADA = rs("QT_SOLICITADA")
		NO_NOME= ucase(rs("NO_NOME"))
		NO_GS = rs("NO_GS")
		DT_PEDIDO = formatar_data(rs("DT_PEDIDO"))
		
	
		response.write "<tr>"
		response.write "<td id='CO_MATRICULA'>"& NO_MATERIAL &"</td>"
		response.Write "<td id='NO_NOME' >"& QT_SOLICITADA &"</td>"
		response.write "<td id='NO_GS' style='text-align:left;'>"& NO_NOME &"</td>"
		response.write "<td id='DE_SITUACAO'>"& NO_GS &"</td>"
		response.write "<td id='DH_CRIACAO'>"& DAY(DT_PEDIDO)&"/"&MONTH(DT_PEDIDO)&"/"&YEAR(DT_PEDIDO) &"</td>"
				%>
		<td width='1%'><img class='editar_estoque' id='bt_editar_estoque'  width='15' height='15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'></td>
        <%
	
		response.write "</tr>"
		rs.movenext
			
	LOOP
	response.Write"</table>"
	response.write "</div>"
			
		
End If

set rs = nothing
set objConn = nothing

%>            
            