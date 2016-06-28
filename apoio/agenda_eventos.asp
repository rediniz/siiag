<%@LANGUAGE="VBScript" CODEPAGE="65001"%><head>

		<link href="../tabela.css" rel="stylesheet" type="text/css" />
		<link href="../menu.css" rel="stylesheet" type="text/css" />
        
</head>

<!-- #INCLUDE FILE ="../include/Conexao.asp" -->		


<div class='tabela'>
           
<%


dataPesquisar = Request("dataPesquisada")


if dataPesquisar <> "" Then


strQuery = "SELECT EVENTOS.DE_EVENTO, EVENTOS.DE_PARTICIPANTES, EVENTOS.DE_OBS, GS.NO_GS, LOCAL.DE_LOCAL FROM TB_EVENTOS EVENTOS INNER JOIN VW_GS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA INNER JOIN TB_LOCAL LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL WHERE(LOCAL.ATIVO = 1) AND ('"&dataPesquisar&"' BETWEEN EVENTOS.DH_INICIO AND EVENTOS.DH_FIM) AND CO_UNIDADE_FGTS="&request.Cookies("co_usuario_unidade_siiag")&" AND EVENTOS.CO_SITUACAO = 2"



set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	
	IF rs.eof Then
		response.Write "<p>Não há eventos hoje.</p>"		
	ELSE

		%>
        
        	
            <table>
              <tr>
              
                <td width="8%">Evento</td>
                <td width="8%">Ger&ecirc;ncia</td>
                <td width="10%" >Participantes</td>
                <td width="15%">Local/Per&iacute;odo</td>
                <td width="17%" >observa&ccedil;&atilde;o</td>

              </tr>
        
        <%

	DO UNTIL rs.eof
	
	DE_EVENTO = rs("DE_EVENTO")
	DE_PARTICIPANTES = rs("DE_PARTICIPANTES")
	DE_OBS = " - "
	NO_GS = rs("NO_GS")
	DE_LOCAL = rs("DE_LOCAL")
 
	
			response.write "<tr>"
			response.write "<td id='DE_EVENTO' >"& DE_EVENTO &"</td>"
			response.Write "<td id='NO_GS'>"&NO_GS&"</td>"
			response.write "<td id='DE_PARTICIPANTES' >"& DE_PARTICIPANTES &"</td>"
			response.Write "<td id='DE_LOCAL'>"&DE_LOCAL&"</td>"
			response.write "<td id='DE_OBS' >"& DE_OBS&"</td>"
			
			response.write "</tr>"
			rs.movenext
			
			LOOP
			response.Write"</table>"
	
			end if

set rs = nothing
set objConn = nothing



Else


dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

strQuery = "SELECT EVENTOS.DE_EVENTO, EVENTOS.DE_PARTICIPANTES, EVENTOS.DE_OBS, GS.NO_GS, LOCAL.DE_LOCAL FROM TB_EVENTOS EVENTOS INNER JOIN VW_GS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA INNER JOIN TB_LOCAL LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL WHERE(LOCAL.ATIVO = 1) AND ('"&dataTotal&"' BETWEEN EVENTOS.DH_INICIO AND EVENTOS.DH_FIM) AND CO_UNIDADE_FGTS="&request.Cookies("co_usuario_unidade_siiag")&" AND EVENTOS.CO_SITUACAO = 2" 


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	
	IF rs.eof Then
		response.Write "<p>Não há eventos hoje.</p>"		
	ELSE

		%>
        
        	
            <table >
              <tr>
              
                <td width="8%">Evento</td>
                <td width="8%">Ger&ecirc;ncia</td>
                <td width="10%" >Participantes</td>
                <td width="15%">Local/Per&iacute;odo</td>
                <td width="17%" >observa&ccedil;&atilde;o</td>

              </tr>
        
        <%

	DO UNTIL rs.eof
	
	DE_EVENTO = rs("DE_EVENTO")
	DE_PARTICIPANTES = rs("DE_PARTICIPANTES")
	DE_OBS = " - "
	NO_GS = rs("NO_GS")
	DE_LOCAL = rs("DE_LOCAL")
 
	
			response.write "<tr>"
			response.write "<td id='DE_EVENTO' >"& DE_EVENTO &"</td>"
			response.Write "<td id='NO_GS'>"&NO_GS&"</td>"
			response.write "<td id='DE_PARTICIPANTES' >"& DE_PARTICIPANTES &"</td>"
			response.Write "<td id='DE_LOCAL'>"&DE_LOCAL&"</td>"
			response.write "<td id='DE_OBS' >"& DE_OBS&"</td>"
			
			response.write "</tr>"
			rs.movenext
			
			LOOP
			response.Write"</table>"
	
			end if

set rs = nothing
set objConn = nothing

End If

%>     
</table>       
</div>
            