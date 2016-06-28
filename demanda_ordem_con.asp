 <!-- #INCLUDE FILE ="include/conexao.asp" -->

<%

ordens = Request("ordens")

'Response.Write ordens

ordens = Left(ordens, len(ordens)-1)

'Response.Write ordens

valores = split(ordens,";")

for each var in valores 

	dados = split(var, ":")

	co_demanda = dados(0)
	ordem = dados(1)
	
	
	
	query = "UPDATE TB_DEMANDAS SET ORDEM_PRIORIDADE = '"&ordem&"' WHERE CO_DEMANDA= "&co_demanda&" "
	resultado = objConn.execute(query)
	
	'Response.Write co_demanda & "  - "& ordem & " "



Next


		response.write "<script>"
		response.write "alert('Prioridade editada com sucesso!');"
		response.write "window.location.assign('demanda_consultar.asp?situacao=0&nomeSolicitante=&data_inicio=&data_final=&click=1');"
		response.write "</script>"

%>