
<script>
	$(document).ready(function() {
	
	
		var matricula = $("#mat").val();
		
		//alert(matricula);
		
		if (matricula == "C022903" || matricula == "C053498" || matricula =="C124937" || matricula =="E712237"){
			$("#divEditar").show();
		}	
		else{	
			$("#divEditar").hide();	
		}
		
	
	
		$("#divSalvar").hide();
	

		
		
		$('.edit').on('click',function(){
	
	
			if (matricula == "C022903" || matricula == "C053498" || matricula =="C124937"){
			
				var demanda = $(this).parent().parent().find("#demanda").val();
				
				window.location.assign("demanda_manter.asp?demanda="+demanda+"");		
			}
			else{
			
				alert("Você não tem permissão para editar demanda.");
			
			}
						
		});
	
	
	
		
		$('#editaPrioridade').on('click', function(){
			
			//$(".setaOrdem").hide();
			//$(".setaOrdem").append("<input type='text' class='inputOrdem' class='form-field' style='width:30px;' value=''/>");
			$(".inputOrdem").show();
			$(".lblOrdem").hide();
			
			$("#divEditar").hide();
			$("#divSalvar").show();

			
			
		});
		
		
		
		$('#salvaPrioridade').on('click', function(){
			
			
			
			 var string='';	
			$('.inputOrdem').each(function(){
			
				var co_demanda;
				var ordem;
				
				co_demanda = $(this).parent().parent().find('#demanda').val();
				ordem = $(this).val();
				//alert(co_demanda + " - " + ordem);
				string = string + co_demanda+":"+ordem+";";
				
				
				
			});
			
			window.location.assign("demanda_ordem_con.asp?ordens="+string+"");
	
			
			
		});
		
		
	});
	
</script> 



<!-- #INCLUDE FILE ="include/conexao_sr001.asp" -->


<%

	dim WHERE(3)
	dim cont
	dim query
	dim ordem
	
	
	tabela = "<table name='tabela' ><tr><td width='15%' >Tipo de Demanda</td><td width='25%'> Nome do Aplicativo </td><td width='11%'> Situação </td><td width='25%'> Nome do Solicitante </td><td width='11%'> Data de Solicitação </td><td width='11%'> Previsão de Conclusão </td><td width='11%'> Ordem de Prioridade </td><td width='11%'> Atender Demanda </td><td width='11%' id='visuOrdenacao' style='display:none;'> Ordenação </td></tr>"
	

	situacao = Request("situacao")
	data_inicio= Request("data_inicio")
	data_final=Request("data_final")
	nomeSolicitante = Request("nomeSolicitante")
	click = Request("click")
	'Response.Write click
	
	if click = 1 THEN

	strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA "
	strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON DEMANDAS.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
	
	

	cont = 0
	
	if situacao <> "" and situacao <> 0 then
		cont = cont + 1
		WHERE(cont) = " (DEMANDAS.CO_SITUACAO = "&situacao&")"
	else
		
	end if
	
	if nomeSolicitante <> ""  then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.NO_NOME like '"& nomeSolicitante &"') " 
		
 	end if
	
	if data_inicio <> "" and data_final <> "" then
	
		cont = cont + 1
		WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
		
	end if


	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	
	ordem = " ORDER BY DEMANDAS.ORDEM_PRIORIDADE,DEMANDAS_SITUACOES.DE_SITUACAO "

	strQuery = strQuery & query & ordem
	'Response.Write strQuery
	
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
	Else
		
		Response.Write tabela
		ota = 1
		DO WHILE (NOT rs.eof)
		
		'Response.Write "TESTE"
		 Response.Write "<tr>"
		 Response.Write "<td>"&rs("NO_TIPO")&"</td>"
		 Response.Write"<td style='text-align:center;'>"&rs("NOME")&"</td>"
		 Response.Write"<td>"&rs("DE_SITUACAO")&"</td>"
		 Response.Write"<td style='text-align:left;'>"& ucase(rs("NO_NOME"))&"</td>"
		 Response.Write"<td>"&rs("SOLICITACAO_DATA")&"</td>"
		 Response.Write"<td>"&rs("CONCLUSAO_DATA_PREVISTA")&"</td>"
		 Response.Write "<td class='setaOrdem' id='ordem' value="&rs("ORDEM_PRIORIDADE")&"><label class='lblOrdem'>"&rs("ORDEM_PRIORIDADE") & "</label>"

			'response.write rs("DE_SITUACAO")
		if rs("DE_SITUACAO") = "Solicitada" THEN
			'Response.Write "<td>"&ota&"</td>"
			ota = ota + 1
		ELSE
			'Response.Write  "<td>  </td>"
			
		END IF
		response.write "<input type='text' class='inputOrdem' class='form-field' style='width:30px;display:none;' value='" & rs("ORDEM_PRIORIDADE") & "'/>"
		response.write "</td>"
		
		RESPONSE.Write "<td width='10%'> <img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer; width:16px; height:16px'> <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
	
		'Response.Write "<td>  </td>"
	    Response.Write "</tr>"
	
		rs.movenext
		LOOP
	
	Response.write "</table>"
	
	Response.Write "<div id='divEditar'><input type='button' id='editaPrioridade' class='myButton' value='Editar Prioridade' style='margin-left:41%;margin-top:1%;' /></div>"
	Response.Write "<div id='divSalvar'><input type='button' id='salvaPrioridade' class='myButton' value='Salvar Prioridade' style='margin-left:41%;margin-top:1%;' /></div>"
	Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"'</div>"
	
	END IF
	end if

 %>