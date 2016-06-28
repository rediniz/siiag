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


tabela ="<table><tr><td width='13%'>Responsavel</td><td width='17%'>Observa&ccedil;&atilde;o</td><td width='17%'>In&iacute;cio</td><td width='19%' >Local</td><td width='10%' >C&oacute;digo</td><td width='10%' >Situa&ccedil;&atilde;o</td><td width='15%'>Solicitado em</td><td>Editar</td></tr>"

strQuery = "SELECT * FROM VW_PENDENCIAS_EMPRESTIMOS WHERE CO_UNIDADE_FGTS = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY DH_INICIO"

'response.write(strQuery)


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

if rs.eof Then

	Response.Write "<p>N&atilde;o h&aacute; pend&ecirc;ncias nos empr&eacute;stimos</p>"
	
	Else
	
	Response.Write "<div class='tabela'>"
	Response.Write tabela	
   			
		
	DO UNTIL rs.eof
	
		
		CO_EMPRESTIMO = rs("CO_EMPRESTIMO")
		CO_RESPONSAVEL = ucase(rs("CO_MATRICULA_RESPONSAVEL"))
		DE_RESPONSAVEL = ucase(rs("DE_RESPONSAVEL"))
		DE_OBS = rs("DE_OBS")
		DH_INICIO = rs("DH_INICIO")
		DE_LOCAL = rs("DE_LOCAL")
		DE_TIPO_EMPRESTIMO = rs("DE_TIPO_EMPRESTIMO")
		DE_SITUACAO = rs("DE_SITUACAO")
		DH_CRIACAO = rs("DH_CRIACAO")
		
		
	
		response.write "<tr>"
		response.write "<td id='CO_MATRICULA' TITLE='" & DE_RESPONSAVEL  & "'><input type='hidden' id='co_emprestimo' name='co_emprestimo' value="&CO_EMPRESTIMO&">"& CO_RESPONSAVEL &"</td>"
		response.Write "<td id='NO_NOME'>"& DE_OBS &"</td>"
		response.write "<td id='NO_GS'>"& DH_INICIO &"</td>"
		response.write "<td id='DE_SITUACAO'>"& DE_LOCAL &"</td>"
		response.write "<td id='DH_CRIACAO'>"& DE_TIPO_EMPRESTIMO &"</td>"
		response.write "<td id='DH_CRIACAO'>"& DE_SITUACAO &"</td>"
		response.write "<td id='DH_CRIACAO'>"& DH_CRIACAO &"</td>"
				%>
		<td width='15%'><img class='editar_emprestimo' id='bt_editar_emprestimo'  width='15' height='15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'></td>
        <%
		
		response.write "</tr>"
		rs.movenext
			
	LOOP
	response.Write"</table>"
	response.write "</div>"
			
		
End If
objConn.close 
set rs = nothing
set objConn = nothing

%>            
            