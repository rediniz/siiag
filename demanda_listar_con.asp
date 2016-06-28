
<script>
	$(document).ready(function() {
	
	
		var matricula = $("#mat").val();
		
		//alert(matricula);
		
		//$("#divEditar").show();
	
	
		$("#divSalvar").hide();
	

		
		$('.edit').on('click',function(){
			var acesso_admin = $('#acesso_admin').val();
			var perfil = $('#perfil').val();
			var co_gs_usuario = $('#co_gs_usuario').val();
			var co_gs_demanda = $(this).parent().parent().find('#co_gs_demanda').val();		
			//alert(co_gs_usuario + ' ' + co_gs_demanda);
			//if (acesso_admin == 'True' || perfil == '7' || (perfil == 5 && co_gs_usuario == co_gs_demanda) ){
			if (acesso_admin == 'True' || (acesso_admin == 'False' && co_gs_usuario == co_gs_demanda) ){			
				var demanda = $(this).parent().parent().find("#demanda").val();
				
				window.location.assign("demanda_manter.asp?demanda="+demanda+"");		
			}
			else{
			
				alert("Você não tem permissão para detalhar esta demanda.");
			
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



<!-- #INCLUDE FILE ="include/conexao.asp" -->


<%

	dim WHERE(4)
	dim cont
	dim query
	dim ordem
	
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2


	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("15")
	Perfil_Nome()	
%>
	
	<input type="hidden" name="perfil" id="perfil" value="<%=request.Cookies("perfil_acesso_siiag_cod")%>" />
	<input type="hidden" name="acesso_admin" id="acesso_admin" value="<%=perfil_acesso_admin_siiag%>" />
	<input type="hidden" name="co_gs_usuario" id="co_gs_usuario" value="<%=request.Cookies("co_usuario_gs_siiag")%>" />
<%	
	tabela = "<table name='tabela' ><tr><td width='15%' >Código da Demanda</td><td width='15%' >Tipo de Demanda</td><td width='25%'> Nome do Aplicativo </td><td width='11%'> Situação </td><td width='25%'> Nome do Solicitante </td><td width='11%'> Data de Solicitação </td><td width='11%'> Previsão de Conclusão </td><td width='11%'> Detalhar Demanda </td><td width='11%' id='visuOrdenacao' style='display:none;'> Ordenação </td></tr>"
	

	situacao = Request("situacao")
	'response.write situacao
	data_inicio= Request("data_inicio")
	data_final=Request("data_final")
	'nomeSolicitante = Request("nomeSolicitante")
	coSolicitante = Request("coSolicitante")
	codigo = Request("codigo")
	click = Request("click")
	'Response.Write click
	
	if click = 1 THEN

	'strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA "
	'strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON DEMANDAS.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
  
	strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA,DEMANDAS.SOLICITACAO_MATRICULA, B.*, USUARIOS.co_gs  "
	strQuery = strQuery &  " FROM TB_DEMANDAS AS DEMANDAS "
	strQuery = strQuery &  " INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA "
	strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO  "
	strQuery = strQuery &  " INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
	strQuery = strQuery &  " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON DEMANDAS.CO_DEMANDA = B.CO_DEMANDA "
	strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON B.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO "
		

	cont = 0
	
	if situacao <> "" then
		cont = cont + 1
		WHERE(cont) = " (B.CO_SITUACAO = "&situacao&")"
	else
		
	end if
	
	'if nomeSolicitante <> ""  then
	'	cont = cont + 1
	'	WHERE(cont) = " (USUARIOS.NO_NOME like '"& nomeSolicitante &"') " 
 	'end if

	if coSolicitante <> ""  then
		cont = cont + 1
		WHERE(cont) = " (SOLICITACAO_MATRICULA = '" & coSolicitante & "') " 
 	end if

	
	if data_inicio <> "" and data_final <> "" then
	
		cont = cont + 1
		WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
		
	end if
	
	if codigo <> "" then
	
		cont = cont + 1
		WHERE(cont) = " (DEMANDAS.CO_DEMANDA="&codigo&") "
		
	End If	


	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	
	ordem = " ORDER BY DEMANDAS.CO_DEMANDA"

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
		 Response.Write "<td>"&rs("CO_DEMANDA")&"</td>"
		 Response.Write "<td>"&rs("NO_TIPO")&"</td>"
		 Response.Write"<td style='text-align:center;'>"&rs("NOME")&"</td>"
		 Response.Write"<td>"&rs("DE_SITUACAO")&"</td>"
		 Response.Write"<td style='text-align:left;'>"& ucase(rs("NO_NOME"))&"</td>"
		 Response.Write"<td>"&rs("SOLICITACAO_DATA")&"</td>"
		 Response.Write"<td>"&rs("CONCLUSAO_DATA_PREVISTA")&"</td>"
			%>
			<input type="hidden" id="co_gs_demanda" name="co_gs_demanda" value="<%=RS("CO_GS")%>" />
			<%		

		 'Response.Write "<td class='setaOrdem' id='ordem' value="&rs("ORDEM_PRIORIDADE")&"><label class='lblOrdem'>"&rs("ORDEM_PRIORIDADE") & "</label>"
		'response.write "<input type='text' class='inputOrdem' class='form-field' style='width:30px;display:none;' value='" & rs("ORDEM_PRIORIDADE") & "'/>"
		'response.write "</td>"
		RESPONSE.Write "<td width='10%'> <img class='edit' id='edit'  src='imagens/edit_23_23_2.png' style='cursor:pointer;'> <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
		'Response.Write "<td>  </td>"
	    Response.Write "</tr>"
	
		rs.movenext
		LOOP
	
	Response.write "</table>"
	
	'Response.Write "<div id='divEditar'><input type='button' id='editaPrioridade' class='myButton' value='Editar Prioridade' style='margin-left:41%;margin-top:1%;' /></div>"
	'Response.Write "<div id='divSalvar'><input type='button' id='salvaPrioridade' class='myButton' value='Salvar Prioridade' style='margin-left:41%;margin-top:1%;' /></div>"
	Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"'</div>"
	
	END IF
	end if

 %>