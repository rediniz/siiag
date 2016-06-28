<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}
</style>



            
           
<%

'tabela ="<table width='100%'><tr><td width='26%'>Nome</td><td width='20%'>Coordena&ccedil;&atilde;o</td><td width='8%'>In&iacute;cio</td><td width='8%' >Fim</td><td width='19%' >Afastamento</td><td width='10%' >Situa&ccedil;&atilde;o</td><td width='15%' >Solicitado em</td><td>Editar</td></tr>"
tabela ="<table width='100%'><tr><td width='27%'>Nome</td><td width='20%'>Coordena&ccedil;&atilde;o</td><td width='15%'>Per&iacute;odo</td><td width='19%' >Afastamento</td><td width='10%' >Situa&ccedil;&atilde;o</td><td width='15%' >Solicitado em</td><td>Editar</td></tr>"


strQuery = "SELECT * FROM VW_PENDENCIAS_SUBSTITUICOES WHERE CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY dt_inicio "

'response.write(strQuery)


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

if rs.eof Then

	Response.Write "<p>N&atilde;o h&aacute; pend&ecirc;ncias nas substitui&ccedil;&otilde;es</p>"
	
	Else
	response.write "<div class='tabela'>"

	Response.Write tabela	
   			
		
	DO UNTIL rs.eof
	
		NO_NOME         = UCAsE(rs("NO_NOME"))
		NO_GS           = rs("NO_GS")
		DT_INICIO       = rs("DT_INICIO")
		DT_FIM          = rs("DT_FIM")
		DE_TIPO_AFASTAMENTO = rs("DE_TIPO_AFASTAMENTO")
		'CO_CAIXA        = rs("CO_CAIXA")
		DE_SITUACAO     = rs("DE_SITUACAO")
		DH_CRIACAO      = rs("DH_CRIACAO")
		CO_SUBSTITUICAO = rs("CO_SUBSTITUICAO")
		
	
		response.write "<tr>"

		response.write "<td id='NO_NOME' style='text-align:left;'><input id='co_substituicao' type='hidden' value="&CO_SUBSTITUICAO&">"& rs("co_substituto") & "-" & RS("CO_SUBSTITUICAO_DIGITO") & " - " & NO_NOME &"</td>"
		response.Write "<td id='NO_GS' width='20%'>"& NO_GS &"</td>"
		response.write "<td id='DT_INICIO'>"& DT_INICIO & " - "& DT_FIM & "</td>"
		'response.write "<td id='DT_FIM'>"& DT_FIM &"</td>"
		response.write "<td id='DE_TIPO_AFASTAMENTO'>"& DE_TIPO_AFASTAMENTO &" </td>"
		response.write "<td id='DE_SITUACAO'>"& DE_SITUACAO &"</td>"
		response.write "<td id='DH_CRIACAO'>"& DAY(DH_CRIACAO)&"/"&MONTH(DH_CRIACAO)&"/"&YEAR(DH_CRIACAO) &"</td>"
		%>
		<td width='15%'><img class='editar_substituicao' id='bt_editar_substituicao'  width='15' height='15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'></td></tr>
        <%
		
		
	
		rs.movenext
			
	LOOP
	response.Write"</table>"
	response.write "</div>"
		
End If
objConn.close 
set rs = nothing
set objConn = nothing

%>            
            