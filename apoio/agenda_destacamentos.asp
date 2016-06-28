<%@LANGUAGE="VBScript" CODEPAGE="65001"%><head>
<!-- #INCLUDE FILE ="../include/funcoes.asp" -->
		<link href="../tabela.css" rel="stylesheet" type="text/css" />
		<link href="../menu.css" rel="stylesheet" type="text/css" />
</head>

<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<%

dataPesquisar = Request("data")


if dataPesquisar <> "" Then 




	Query4  =          " SELECT  "
	Query4  = Query4 & " 	DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME "
	Query4  = Query4 & " FROM TB_DESTACAMENTOS AS DESTACAMENTOS "
	Query4  = Query4 & " INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA "
	Query4  = Query4 & " WHERE "
	Query4  = Query4 & " 	DESTACAMENTOS.CO_UNIDADE = '"& Request.Cookies("co_usuario_unidade_siiag") & "' "
	Query4  = Query4 & " 	AND USUARIOS.CO_UNIDADE = '" &  request.Cookies("co_usuario_unidade_siiag") & "' "
	Query4  = Query4 & " 	AND((DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5) "
	Query4  = Query4 & " 	AND ('"& dataPesquisar &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM)) OR(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5) AND "
	Query4  = Query4 & "      (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataPesquisar &"'))) "
'RESPONSE.WRITE Query4
set zs=Server.CreateObject("ADODB.RecordSet")
zs.Open Query4, dados_sys, 3, , 32
'RESPONSE.WRITE rs("CO_MATRICULA")

if zs.eof THEN
	response.Write "<p>N&atilde;o h&aacute; destacamentos no per&iacute;odo atual.</p>"
ELSE

%>


<div class='tabela'>
<table>
              <tr>
              
                <td width='8%' height='1%'>Nome</td>
                <td width='8%' height='1%' >Evento/Motivo</td>
                <td width='8%' height='1%'>Local/Per&iacute;odo</td>
                <td width='8%' height='1%' >Observa&ccedil;&atilde;o</td>
                              
              </tr>


<%

		DO UNTIL zs.eof
			
			matricula = zs("CO_MATRICULA")
			projeto=zs("DE_PROJETO")
			cidade=zs("NO_CIDADE")
			NO_NOME = zs("NO_NOME")
			data_inicio_banco = zs("DT_INICIO")
			data_final_banco = zs("DT_FIM")
			DE_OBS = " - "
			
			data_inicio_total = DAY(data_inicio_banco)&"/"&MONTH(data_inicio_banco)&"/"&YEAR(data_inicio_banco)
			data_final_total =  DAY(data_final_banco)&"/"&MONTH(data_final_banco)&"/"&YEAR(data_final_banco)

			response.write "<tr>"
			response.write "<td id='nome' >"& NO_NOME &"</td>"
			response.write "<td id='projeto' >"& projeto &"</td>"
			response.write "<td id='cidade' >"& cidade & "/  "& Formatar_Data(data_inicio_total) &" - "&Formatar_Data(data_final_total)&"</td>"
			response.Write "<td id='observacao'>"&DE_OBS&"</td>"
			response.write "</tr>"
			zs.movenext
			
		LOOP
			response.Write"</table>"
			response.write "</div>"
			
END IF			


set zs = nothing
set objConn = nothing




Else
dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

	Query4  =          " SELECT  "
	Query4  = Query4 & " 	DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME "
	Query4  = Query4 & " FROM TB_DESTACAMENTOS AS DESTACAMENTOS "
	Query4  = Query4 & " INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA "
	Query4  = Query4 & " WHERE "
	Query4  = Query4 & " 	DESTACAMENTOS.CO_UNIDADE = '"& Request.Cookies("co_usuario_unidade_siiag") & "' "
	Query4  = Query4 & " 	AND USUARIOS.CO_UNIDADE = '" &  request.Cookies("co_usuario_unidade_siiag") & "' "
	Query4  = Query4 & " 	AND((DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5) "
	Query4  = Query4 & " 	AND ('"& dataTotal &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM)) OR(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5) AND "
	Query4  = Query4 & "      (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataTotal &"'))) "
'RESPONSE.WRITE Query4
set zs=Server.CreateObject("ADODB.RecordSet")
zs.Open Query4, dados_sys, 3, , 32
'RESPONSE.WRITE rs("CO_MATRICULA")

if zs.eof THEN
	response.Write "<p>N&atilde;o h&aacute; destacamentos no per&iacute;odo atual.</p>"
ELSE

%>


<div class='tabela'>
<table>
              <tr>
              
                <td width="8%">Nome</td>
                <td width="10%" >Evento/Motivo</td>
                <td width="8%">Local/Per&iacute;odo</td>
                <td width="10%" >Observa&ccedil;&atilde;o</td>
                              
              </tr>


<%

		DO UNTIL zs.eof
			
			matricula = zs("CO_MATRICULA")
			projeto=zs("DE_PROJETO")
			cidade=zs("NO_CIDADE")
			NO_NOME = zs("NO_NOME")
			data_inicio_banco = zs("DT_INICIO")
			data_final_banco = zs("DT_FIM")
			DE_OBS = " - "
			
			data_inicio_total = DAY(data_inicio_banco)&"/"&MONTH(data_inicio_banco)&"/"&YEAR(data_inicio_banco)
			data_final_total =  DAY(data_final_banco)&"/"&MONTH(data_final_banco)&"/"&YEAR(data_final_banco)

			response.write "<tr>"
			response.write "<td id='nome' >"& NO_NOME &"</td>"
			response.write "<td id='projeto' >"& projeto &"</td>"
			response.write "<td id='cidade' >"& cidade & "/  "& Formatar_Data(data_inicio_total) &" - "&Formatar_Data(data_final_total)&"</td>"
			response.Write "<td id='observacao'>"&DE_OBS&"</td>"
			response.write "</tr>"
			zs.movenext
			
		LOOP
			response.Write"</table>"
			response.write "</div>"
			
END IF			


set zs = nothing
set objConn = nothing

End If

%>

