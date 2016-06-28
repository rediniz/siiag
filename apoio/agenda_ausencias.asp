<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<head>

		<link href="../tabela.css" rel="stylesheet" type="text/css" />
		<link href="../menu.css" rel="stylesheet" type="text/css" />
</head>

<!-- #INCLUDE FILE ="../include/Conexao.asp" -->

<%

dataPesquisar = Request("data")

'Response.Write dataPesquisar


if dataPesquisar <> "" Then


	QueryAfastamento =	"SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO in (3,2) ) AND ('"&dataPesquisar&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM) AND USUARIOS.IC_ATIVO = 1 AND AFASTAMENTOS.CO_UNIDADE='"&request.Cookies("co_usuario_unidade_siiag")&"' ORDER BY USUARIOS.NO_NOME"


	
	set afastamento =	Server.CreateObject("ADODB.RecordSet")
	afastamento.Open QueryAfastamento, dados_sys
	
	
	
	if afastamento.eof Then
	'response.Write QueryAfastamento
  	response.Write "<p>N&atildeo h&aacute; afastamentos ou aus&ecirc;ncias.<p>"
  	else	
				Response.Write "<div class='tabela2'>"
				Response.Write "<table>"
				Response.Write "<tr>"
				response.Write "<td width='8%'>Nome</td>"
                response.Write "<td width='8%'>Per&iacute;odo</td>"
                response.Write "<td width='8%'>Motivo</td>"
               	response.Write "<td width='8%'>Observa&ccedil;&atilde;o</td>"
				Response.write"</tr>"
		
'			   
				DO UNTIL afastamento.eof

					nomeFuncionario = afastamento("NO_NOME")
					descricaoAfastamento = afastamento("DE_TIPO_AFASTAMENTO")
					dataInicio=afastamento("DT_INICIO")
					dataFim=afastamento("DT_FIM")
					
					observacao = "-"
					response.Write "<tr>"	
					response.Write "<td>"&nomeFuncionario&"</td>"
					response.Write "<td>"& dataInicio&" a "&dataInicio &"</td>"
					response.Write "<td>"&descricaoAfastamento&"</td>"
					response.Write "<td>"&observacao&"</td>"
					response.write "</tr>"
					afastamento.movenext
					
				LOOP
				response.Write "</table>"
				response.Write "</div>"
	
	END IF
	
	

set afastamento = 	nothing
set objConn = 		nothing 










ELSE

dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

QueryAfastamento =	"SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO in (3,2) ) AND ('"&dataTotal&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM) AND USUARIOS.IC_ATIVO = 1 AND AFASTAMENTOS.CO_UNIDADE='"&request.Cookies("co_usuario_unidade_siiag")&"' ORDER BY USUARIOS.NO_NOME"


	
	set afastamento =	Server.CreateObject("ADODB.RecordSet")
	'response.Write QueryAfastamento
	afastamento.Open QueryAfastamento, dados_sys
	
	
	
	if afastamento.eof Then
	'response.Write QueryAfastamento
  	response.Write "<p>N&atildeo h&aacute; afastamentos ou aus&ecirc;ncias.<p>"
  	else	
				Response.Write "<div class='tabela'>"
				Response.Write "<table>"
				Response.Write "<tr>"
				response.Write "<td width='25%' >Nome</td>"
                response.Write "<td width='25%' >Per&iacute;odo</td>"
                response.Write "<td width='25%' >Motivo</td>"
               	response.Write " <td width='25%' >Observa&ccedil;&atilde;o</td>"
				Response.write"</tr>"
		
'			   
				DO UNTIL afastamento.eof
				
				
					nomeFuncionario = afastamento("NO_NOME")
					descricaoAfastamento = afastamento("DE_TIPO_AFASTAMENTO")
					dataInicio=afastamento("DT_INICIO")
					dataFim=afastamento("DT_FIM")
					
					observacao = "-"
					
					
					response.Write "<tr>"	
					response.Write "<td>"&nomeFuncionario&"</td>"
					response.Write "<td>"& dataInicio&" a "&dataInicio &"</td>"
					response.Write "<td>"&descricaoAfastamento&"</td>"
					response.Write "<td>"&observacao&"</td>"
					response.write "</tr>"
					
							
					afastamento.movenext
					
				LOOP
				response.Write "</table>"
				response.Write "</div>"
	
	END IF
	
	

set afastamento = 	nothing
set objConn = 		nothing 


END IF

%>

