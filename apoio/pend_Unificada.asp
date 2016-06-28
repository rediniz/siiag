<!-- #INCLUDE FILE ="../include/Conexao.asp" -->     
<%

tabela ="<table ><tr><td width='18%'>Tipo</td><td width='22%'>Descrição</td><td width='26%'>Nome</td><td width='14%' >Data</td><td width='10%' >Situa&ccedil;&atilde;o</td><td width='10%'>Editar</td></tr>"

strQuery = "SELECT * FROM VW_PENDENCIAS_UNIFICADA WHERE unidade = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY data"

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

if rs.eof Then

	Response.Write "<p>N&atilde;o h&aacute; nenhum tipo de pend&ecirc;ncias</p>"
	
	Else

	Response.write "<div class='tabela' style='overflow:auto;max-height:800px;' >"
	Response.Write tabela	
   			
		
	DO UNTIL rs.eof
	
		
		codigo = rs("codigo")
		tipo = rs("tipo")
		descricao = rs("descricao")
		nome = ucase(rs("nome"))
		data = rs("data")
		situacao = rs("situacao")

		
		select case  tipo
		
		case "DESTACAMENTO"
			classe = "editar_destacamento"
			id_input = "co_destacamento"
		case "FERIAS"
			classe = "editar_ferias"
			id_input = "co_ferias"
		case "JORNADA"
			classe = "editar_jornada"
			id_input = "co_jornada"
		case "AFASTAMENTO"
			classe = "editar_afastamento"
			id_input = "co_afastamento"
		case "EVENTO"
			classe = "editar_evento"
			id_input = "co_evento"
		case "EMPRESTIMO"
			classe = "editar_emprestimo"
			id_input = "co_emprestimo"
		case "SUBSTITUIÇÃO"
			classe = "editar_substituicao"
			id_input = "co_substituicao"
		case "ESTOQUE"
			classe = "editar_estoque"
			id_input = "co_estoque"
		
		end select
		
		response.write "<tr>"
		response.write "<td id='tipo'><input type='hidden' id='"&id_input&"' name='"&id_input&"' value="&codigo&">"& tipo &"</td>"
		response.Write "<td id='descricao'>"& descricao &"</td>"
		response.write "<td id='nome' style='text-align:left;'>"& nome &"</td>"
		response.write "<td id='data'>"& data &"</td>"
		response.write "<td id='situacao'>"& situacao &"</td>"
		%>
        
		<td width='15%'><img class=<%=classe%>  width='15' height='15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'></td>
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
    