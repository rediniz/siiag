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

tabela ="<table ><tr><td width='8%'>Matr&iacute;cula</td><td width='23%'>Nome</td><td width='10%' >In&iacute;cio</td><td width='10%'>Fim</td><td width='17%' >Coordena&ccedil;&atilde;o</td><td width='10%' >Situa&ccedil;&atilde;o</td><td width='15%' >Solicitado em</td><td>Editar</td></tr>"

strQuery = "SELECT * FROM VW_PENDENCIAS_DESTACAMENTOS AS PEND_DESTACAMENTOS INNER JOIN TB_USUARIOS AS USUARIOS ON PEND_DESTACAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE PEND_DESTACAMENTOS.CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY DT_INICIO"

'response.write(strQuery)


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

if rs.eof Then
	Response.Write "<p>N&atilde;o h&aacute; pend&ecirc;ncias nos destacamentos</p>"
	
	Else
	
	Response.write "<div class='tabela'>"

	Response.Write tabela	
   			
		
	DO UNTIL rs.eof
	
		CO_MATRICULA = rs("CO_MATRICULA")
		NO_NOME = ucase(rs("NO_NOME"))
		DT_INICIO = rs("DT_INICIO")
		DT_FIM = rs("DT_FIM")
		NO_GS = rs("NO_GS")
		DE_SITUACAO = rs("DE_SITUACAO")
		DH_CRIACAO = rs("DH_CRIACAO")
		CO_DESTACAMENTO = rs("CO_DESTACAMENTO")
		Digito_Mat = rs("CO_DIGITO")
		
	
		response.write "<tr>"
		response.write "<td id='CO_MATRICULA'><input type='hidden' id='co_destacamento' name='co_destacamento' value="&CO_DESTACAMENTO&">"& CO_MATRICULA &" - "&Digito_Mat&"</td>"
		response.Write "<td id='NO_NOME' style='text-align:left;'>"&NO_NOME&"</td>"
		response.write "<td id='DT_INICIO'>"& DT_INICIO &"</td>"
		response.Write "<td id='QT_DIAS'>"&DT_FIM&"</td>"
		response.write "<td id='NO_GS'>"& NO_GS&"</td>"
		response.write "<td id='DE_SITUACAO'>"& DE_SITUACAO&"</td>"
		response.write "<td id='DH_CRIACAO'>"& DH_CRIACAO&"</td>"
				%>
		<td width='15%'><img class='editar_destacamento' id='bt_editar_destacamento'  width='15' height='15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'></td>
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
            