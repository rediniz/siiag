<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<style>
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

            
<div class='tabela' >  
<%

tabela ="<table><tr><td width='5%'>Tipo</td><td width='15%'>Descri&ccedil;&atilde;o</td><td width='5%'>In&iacute;cio</td><td width='5%' >Fim</td><td width='15%' >Iniciativa</td><td width='5%' >Situa&ccedil;&atilde;o</td><td width='10%' >Solicitado em</td><td>Editar</td></tr>"

strQuery = "SELECT * FROM VW_PENDENCIAS_EVENTOS WHERE CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY DH_INICIO"

'response.write(strQuery)


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

if rs.eof Then

	Response.Write "<p>N&atilde;o h&aacute; pend&ecirc;ncias nos eventos</p>"
	
	Else

	Response.Write tabela	
   			
		
	DO UNTIL rs.eof
	
		
		
		CO_EVENTO = rs("CO_EVENTO")
		DE_EVENTO = rs("DE_EVENTO")
		DE_TIPO_EVENTO = rs("DE_TIPO_EVENTO")
		DH_INICIO = rs("DH_INICIO")
		DH_FIM = rs("DH_FIM")
		NO_GS = rs("NO_GS")
		DE_SITUACAO = rs("DE_SITUACAO")
		DH_CRIACAO = rs("DH_CRIACAO")
	
		response.write "<tr>"
		response.Write "<td id='NO_NOME'>"&DE_TIPO_EVENTO &"</td>"
		response.write "<td id='CO_MATRICULA'><input type='hidden' id='co_evento' name='co_evento' value="&CO_EVENTO&">"& DE_EVENTO &"</td>"
		response.write "<td id='NO_GS'>"& DH_INICIO &"</td>"
		response.write "<td id='DE_SITUACAO'>"& DH_FIM &"</td>"
		response.write "<td id='DH_CRIACAO'>"& NO_GS &"</td>"
		response.write "<td id='DH_CRIACAO'>"& DE_SITUACAO &"</td>"
		response.write "<td id='DH_CRIACAO'>"& DH_CRIACAO &"</td>"
					%>
		<td width='1%'><img class='editar_evento' id='bt_editar_evento'  width='15' height='15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'></td>
        <%
		
		response.write "</tr>"
		rs.movenext
			
	LOOP
	response.Write"</table>"
			
		
End If
objConn.close 
set rs = nothing
set objConn = nothing

%>            
</div>     