<div class='tabela'>
<table  >
              <tr>
              
                <td width="8%">Nome</td>
                <td width="10%" >Evento/Motivo</td>
                <td width="8%">Local/Per&iacute;odo</td>
                <td width="10%" >Observa&ccedil;&atilde;o</td>
               
              </tr>

<%
dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

Query4 = "SELECT DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME FROM TB_DESTACAMENTOS AS DESTACAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA WHERE(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND ('"& dataTotal &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM) OR(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataTotal &"')"


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open Query4, dados_sys

if rs.eof THEN

response.Write "<p>N&atilde;o h&aacute; destacamentos no per&iacute;odo atual.</p>"

ELSE

DO UNTIL rs.eof
	
			
			matricula = rs("CO_MATRICULA")
			projeto=rs("DE_PROJETO")
			cidade=rs("NO_CIDADE")
			NO_NOME = rs("NO_NOME")
			data_inicio_banco = rs("DT_INICIO")
			data_final_banco = rs("DT_FIM")
			DE_OBS = " - "
			
			data_inicio_total = DAY(data_inicio_banco)&"/"&MONTH(data_inicio_banco)&"/"&YEAR(data_inicio_banco)
			data_final_total =  DAY(data_final_banco)&"/"&MONTH(data_final_banco)&"/"&YEAR(data_final_banco)
			
	
	
	
			response.write "<tr>"
			response.write "<td id='nome' >"& NO_NOME &"</td>"
			response.write "<td id='projeto' >"& projeto &"</td>"
			response.write "<td id='cidade' >"& cidade & "/  "& data_inicio_total &" - "&data_final_total&"</td>"
			response.Write "<td id='observacao'>"&DE_OBS&"</td>"
			response.write "</tr>"
			rs.movenext
			
			LOOP
			response.Write"</table>"
			
END IF			


set rs = nothing
set objConn = nothing

%>
</div>
