<div class='tabela'>
<table  >
              <tr>
              
                <td width="8%">Nome</td>
                <td width="8%">Per&iacute;odo</td>
                <td width="10%" >Observa&ccedil;&atilde;o</td>
               
</tr>


<%
dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'


QueryQT_dias = "DECLARE @DATA DATETIME SET @DATA = CONVERT(DATETIME, '"&dataTotal&"', 103) select DISTINCT FERIAS.DT_INICIO,FERIAS.CO_MATRICULA, FERIAS.QT_DIAS, USUARIOS.NO_NOME, USUARIOS.CO_UNIDADE, CONVERT(datetime, DATEADD(day, FERIAS.QT_DIAS, FERIAS.DT_INICIO), 103)-1 AS DATA_FINAL from TB_FERIAS AS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE CO_SITUACAO=2 AND USUARIOS.IC_ATIVO=1 AND USUARIOS.CO_UNIDADE = 7180 AND @DATA BETWEEN (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1 AND DATEADD(DAY, FERIAS.QT_DIAS, (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1) ORDER BY USUARIOS.NO_NOME"


set dias=Server.CreateObject("ADODB.RecordSet")
dias.Open QueryQT_dias, dados_sys


if DIAS.eof THEN

response.Write "<p>N&atilde;o h&aacute; F&eacute;rias no per&iacute;odo atual.</p>"

ELSE

	DO UNTIL dias.eof
		
		dataInicialBanco = dias("DT_INICIO")
		'codigoMatricula = dias("CO_MATRICULA")
		'quantidadeDias = dias("QT_DIAS")
		dataFinal = dias("DATA_FINAL")
		NO_NOME = dias("NO_NOME")
		DE_OBS = " - "
	
'		
			response.write "<tr>"
			response.write "<td id='nome' >"& NO_NOME &"</td>"
			response.write "<td id='cidade' >"& dataInicialBanco &" a "&dataFinal&"</td>"
			response.Write "<td id='observacao'>"&DE_OBS&"</td>"
			response.write "</tr>"
		
	


	dias.movenext
	LOOP
END IF	
'	

set dias = nothing
set objConn = nothing 

%>
</table>
</div>
