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

tabela ="<table ><tr><td width='8%'>Matr&iacute;cula</td><td width='24%'>Nome</td><td width='17%'>Coordena&ccedil;&atilde;o</td><td width='10%' >Situa&ccedil;&atilde;o</td><td width='12%' >Solicitado em</td><td>Editar</td></tr>"

strQuery = "SELECT * FROM VW_PENDENCIAS_JORNADA AS PEND_JORNADA INNER JOIN TB_USUARIOS AS USUARIOS ON PEND_JORNADA.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE PEND_JORNADA.CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "'"

'response.write(strQuery)

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

if rs.eof Then
	Response.Write "<p>N&atilde;o h&aacute; pend&ecirc;ncias nas jornadas</p>"
	
	Else
	Response.write "<div class='tabela'>"
	Response.Write tabela	
   			
		
	DO UNTIL rs.eof
	
		CO_MATRICULA = rs("CO_MATRICULA")
		NO_NOME = ucase(rs("NO_NOME"))
		NO_GS = rs("NO_GS")
		DE_SITUACAO = rs("DE_SITUACAO")
		DH_CRIACAO = rs("DH_CRIACAO")
		CO_JORNADA = rs("CO_JORNADA")
		Digito_Mat = rs("CO_DIGITO")
	
		response.write "<tr>"
		response.write "<td id='CO_MATRICULA'>"& CO_MATRICULA &" - "&Digito_Mat&"</td>"
		response.Write "<td id='NO_NOME' style='text-align:left;'>"&NO_NOME&"</td>"
		response.write "<td id='NO_GS'>"& NO_GS&"</td>"
		response.write "<td id='DE_SITUACAO'>"& DE_SITUACAO&"</td>"
		response.write "<td id='DH_CRIACAO'>"& DH_CRIACAO&"</td>"
		response.Write "<input type='hidden' name='co_jornada' id='co_jornada' value='"&CO_JORNADA&"'/>"
		response.Write "<td width='15%'><img class='editar_jornada' id='editar_jornada'  width='15' height'15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'>"
		
		
		
		response.write "</tr>"
		rs.movenext
			
	LOOP
	response.Write"</table>"
	response.Write "</div>"
			
		
End If
objConn.close 
set rs = nothing
set objConn = nothing

%>            
            