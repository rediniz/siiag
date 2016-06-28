<%

QueryAfastamento =	"SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO = 2) AND ('"&dataTotal&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM)ORDER BY USUARIOS.NO_NOME"

	
	set afastamento =	Server.CreateObject("ADODB.RecordSet")
	afastamento.Open QueryAfastamento, dados_sys
	
	if afastamento.eof Then
  	response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Afastamentos ou Aus&ecirc;ncias<p>"
  	else	
				Response.Write "<div class='tabela'>"
				Response.Write "<table>"
				Response.Write "<tr>"
				response.Write "<td width='8%'>Nome</td>"
                response.Write "<td width='15%'>Per&iacute;odo</td>"
                response.Write "<td width='10%'>Motivo</td>"
               	response.Write " <td width='17%'>observa&ccedil;&atilde;o</td>"
				Response.write"</tr>"
			   
	DO UNTIL afastamento.eof
	
	
		nomeFuncionario = afastamento("NO_NOME")
		descricaoAfastamento = afastamento("DE_TIPO_AFASTAMENTO")
		dataInicio=afastamento("DT_INICIO")
		dataFim=afastamento("DT_FIM")
		
		observacao = "-"
		
		
		response.Write "<tr>"	
		response.Write "<td>"&nomeFuncionario&"</td>"
		response.Write "<td>"& dataInicio&" &agrave; "&dataInicio &"</td>"
		response.Write "<td>"&descricaoAfastamento&"</td>"
		response.Write "<td>"&observacao&"</td>"
		response.write "</tr>"
		
				
			
		
		
		

		afastamento.movenext
		
	LOOP
	END IF
	

set afastamento = 	nothing
set objConn = 		nothing 

%>
</table>
</div>
<!--<table class="tabela" >
              <tr>
              
                <td width="8%">Nome</td>
                <td width="15%">Per&iacute;odo</td>
                <td width="10%" >Motivo</td>
                <td width="17%" >observa&ccedil;&atilde;o</td>

              </tr>
   			</table>-->