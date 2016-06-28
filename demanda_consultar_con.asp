<script>
$(document).ready(function(){
	
	$('#btBotao').click(function(){
	
	  var cont=0;
	
		$('.elemento').each(function(){
			var codigo = $(this).find('.classeCodigo').text()
			cont++;
			
			
			alert(codigo + ' ' + cont + ' - ' + $(this).find('.setaOrdem').text());
		
		
		});
	
	
	});
	
	
	
	
	$('.setabaixo').click(function(){

		var cont = 0 ;	
		var row = $(this).closest('tr');
		console.log(row);
		
		row.insertAfter(row.next());
	
		$('.elemento').each(function(){
			cont++;
			$(this).find('.inputOrdem').val(cont);

		});
		// InsertBefore(row.prev()) para o anterior
		//insertAfter(row.Next()) para o proximo
	
	});
	$('.setacima').click(function(){
		var cont = 0;
		var row = $(this).closest('tr');
		console.log(row);
		
		row.insertBefore(row.prev());
		//ordenar();
		$('.elemento').each(function(){
			cont++;
			$(this).find('.inputOrdem').val(cont);

		});
		//alert(cont);
		
			// InsertBefore(row.Prev()) para o anterior
		//insertAfter(row.Next()) para o proximo
	
	});
	

});
</script>
<script>
	$(document).ready(function() {
	
	
		var matricula = $("#mat").val();
		
		//alert(matricula);
		
		//if (matricula == "C022903" || matricula == "C053498" || matricula =="C124937" || matricula =="E712237"){
		//	$("#divEditar").show();
		//}	
		//else{	
		//	$("#divEditar").hide();	
		//}
		$("#divSalvar").hide();
	

		
		
		$('.edit').on('click',function(){
			var acesso_admin = $('#acesso_admin').val();
			var perfil = $('#perfil').val();
			var co_gs_usuario = $('#co_gs_usuario').val();
			var co_gs_demanda = $(this).parent().parent().find('#co_gs_demanda').val();		
			//alert(co_gs_usuario + ' ' + co_gs_demanda);
			if (acesso_admin == 'True' || perfil == '7' || (perfil == '5' && co_gs_usuario == co_gs_demanda) ){
			
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
			$(".tdseta").show();

			
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

		$('.urgent_solicitar').on('click', function(){
			 var string='';	
			//$('.inputOrdem').each(function(){
				var co_demanda;
				co_demanda = $(this).parent().parent().find('#demanda').val();
			//});
			//alert(co_demanda);
			window.location.assign("demanda_manter_urgente.asp?co_demanda="+co_demanda+"");
		});

	});
	
</script> 

<%

	dim WHERE(3)
	dim cont
	dim query
	dim ordem
	
		'Chama a subrotina para verificar o perfil
	Perfil_Acesso("12")
	Perfil_Nome()	
%>
	<input type="hidden" name="perfil" id="perfil" value="<%=request.Cookies("perfil_acesso_siiag_cod")%>" />
	<input type="hidden" name="acesso_admin" id="acesso_admin" value="<%=perfil_acesso_admin_siiag%>" />
	<input type="hidden" name="co_gs_usuario" id="co_gs_usuario" value="<%=request.Cookies("co_usuario_gs_siiag")%>" />
<%

	if perfil_acesso_admin_siiag then
	%>
	
		<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
		<legend><span class="titulos" >Urgentes/Previstos para os próximos 7 dias</span></legend>
	<%
	
	  '**
		tabela = "<table name='tabela' style='width:970px;' ><tr><td width='170px;' >Tipo de Demanda</td><td width='200px;'> Nome do Aplicativo </td><td width=''> Situação </td><td width=''> Nome do Solicitante </td><td width=''> Data de Solicitação </td><td width=''> Previsão de Início </td><td width=''> Detalhar Demanda </td></tr>"
	  
		strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA,DEMANDAS.DATA_PREVISAO_INICIO,B.CO_SITUACAO, B.* "
		strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS "
		strQuery = strQuery &  " INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO  "
		strQuery = strQuery &  " INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
		strQuery = strQuery &  " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON DEMANDAS.CO_DEMANDA = B.CO_DEMANDA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON B.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO "
	
		cont = 0
		cont = cont + 1
		WHERE(cont) = " (B.CO_SITUACAO = 6) OR (B.CO_SITUACAO = 7 AND ( DATA_PREVISAO_INICIO >= '" & date() & "' and DATA_PREVISAO_INICIO <= '" & dateadd("d",7,date()) & "'  )  )"
	
		if data_inicio <> "" and data_final <> "" then
		
			cont = cont + 1
			WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
			
		end if
	
	
		j=0
		query = ""
		For i=1 to cont
			If j=0 then
				Query = Query & " where " &  WHERE(i)
				j=1
		   Else
				Query = Query & " and " & WHERE(i)
		   End If
		Next
		
		
		ordem = " ORDER BY B.CO_SITUACAO, DEMANDAS.ORDEM_PRIORIDADE,DEMANDAS_SITUACOES.DE_SITUACAO "
	
		strQuery = strQuery & query & ordem
		'Response.Write strQuery
		set rs=Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys, 3, , 32
		IF rs.eof Then  'mensagem caso nao haja resultados
			Response.Write "<br><p align='center'>Não existem demandas nesta situação.</p>"
		Else
			
			Response.Write tabela
			ota = 1
			DO WHILE (NOT rs.eof)
			
				if rs("co_situacao")  = 6 then
					estilo = " color:#FF0000; "
					urgencia = " <img class='urgent' id='urgent'  src='imagens/urgente_vermelho.png' title='Urgente' >  "
				else
					estilo = " "
					urgencia = ""
				end if
			
			'Response.Write "TESTE"
			 Response.Write "<tr>"
			 Response.Write "<td style='" & estilo & "' >"&ucase(rs("NO_TIPO"))&"</td>"
			 Response.Write"<td style='text-align:center; " & estilo & "'>"&rs("NOME")&"</td>"
			 Response.Write"<td style='" & estilo & "' >"&rs("DE_SITUACAO")&"</td>"
			 Response.Write"<td style='text-align:left; " & estilo & "'>"& ucase(rs("NO_NOME"))&"</td>"
			 Response.Write"<td style='" & estilo & "' >"&rs("SOLICITACAO_DATA")&"</td>"
			 Response.Write"<td style='" & estilo & "' >"&rs("DATA_PREVISAO_INICIO")&"</td>"
			 Response.Write "<td class='' id='' value="&rs("ORDEM_PRIORIDADE")&" style='" & estilo & "' ><label class='' style='" & estilo & "'>"&rs("ORDEM_PRIORIDADE") & "</label>"
	
				'response.write rs("DE_SITUACAO")
			if rs("DE_SITUACAO") = "Solicitada" THEN
				'Response.Write "<td>"&ota&"</td>"
				ota = ota + 1
			ELSE
				'Response.Write  "<td>  </td>"
				
			END IF
			response.write "</td>"
			
			RESPONSE.Write "<td width='10%'> <img class='edit' id='edit'  title='Editar Demanda'  src='imagens/edit_23_23_2.png' style='cursor:pointer;'>"
			response.write urgencia
			RESPONSE.Write " <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
		
			'Response.Write "<td>  </td>"
			Response.Write "</tr>"
		
			rs.movenext
			LOOP
		
		Response.write "</table>"
	
		Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"'</div>"
		
		END IF
	
	  
	  '**
	
	
	 %>
	 </fieldset>
	<br>
	<%
	end if


	if perfil_acesso_admin_siiag then
	%>
	
		<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
		<legend><span class="titulos" >Inconformidade comunicada</span></legend>
	<%
	
	  '**
		tabela = "<table name='tabela' style='width:970px;' ><tr><td width='170px;' >Tipo de Demanda</td><td width='200px;'> Nome do Aplicativo </td><td width='250px;'> Nome do Solicitante </td><td width=''>Data da Comunicação</td><td width=''></td></tr>"
	  
		strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA,DEMANDAS.DATA_PREVISAO_INICIO,B.CO_SITUACAO, B.* "
		strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS "
		strQuery = strQuery &  " INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO  "
		strQuery = strQuery &  " INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
		strQuery = strQuery &  " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON DEMANDAS.CO_DEMANDA = B.CO_DEMANDA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON B.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO "
	
		cont = 0
		cont = cont + 1
		WHERE(cont) = " (B.CO_SITUACAO = 9) "
	
		if data_inicio <> "" and data_final <> "" then
		
			cont = cont + 1
			WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
			
		end if
	
	
		j=0
		query = ""
		For i=1 to cont
			If j=0 then
				Query = Query & " where " &  WHERE(i)
				j=1
		   Else
				Query = Query & " and " & WHERE(i)
		   End If
		Next
		
		
		ordem = " ORDER BY B.CO_SITUACAO, DEMANDAS.ORDEM_PRIORIDADE,DEMANDAS_SITUACOES.DE_SITUACAO "
	
		strQuery = strQuery & query & ordem
		'Response.Write strQuery
		set rs=Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys, 3, , 32
		IF rs.eof Then  'mensagem caso nao haja resultados
			Response.Write "<br><p align='center'>Não existem demandas nesta situação.</p>"
		Else
			
			Response.Write tabela
			ota = 1
			DO WHILE (NOT rs.eof)
			
			'Response.Write "TESTE"
			 Response.Write "<tr>"
			 Response.Write "<td style='" & estilo & "' >"&ucase(rs("NO_TIPO"))&"</td>"
			 Response.Write"<td style='text-align:center; " & estilo & "'>"&rs("NOME")&"</td>"
			 Response.Write"<td style='text-align:left; " & estilo & "'>"& ucase(rs("NO_NOME"))&"</td>"
			 Response.Write"<td style='" & estilo & "' >"&rs("SOLICITACAO_DATA")&"</td>"
				'response.write rs("DE_SITUACAO")
			if rs("DE_SITUACAO") = "Solicitada" THEN
				'Response.Write "<td>"&ota&"</td>"
				ota = ota + 1
			ELSE
				'Response.Write  "<td>  </td>"
				
			END IF
			response.write "</td>"
			
			RESPONSE.Write "<td width=''> <img class='edit' id='edit'  title='Detalhar Demanda'  src='imagens/edit_23_23_2.png' style='cursor:pointer;'>"
			response.write urgencia
			RESPONSE.Write " <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
		
			'Response.Write "<td>  </td>"
			Response.Write "</tr>"
		
			rs.movenext
			LOOP
		
		Response.write "</table>"
	
		Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"'</div>"
		
		END IF
	
	  
	  '**
	
	
	 %>
	 </fieldset>
	<br>
	<%
	end if

	if perfil_acesso_admin_siiag then
	%>
	
		<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
		<legend><span class="titulos" >Aguardando Teste do Usuário</span></legend>
	<%
	
	  '**
		tabela = "<table name='tabela' style='width:970px;' ><tr><td width='170px;' >Tipo de Demanda</td><td width='200px;'> Nome do Aplicativo </td><td width='250px;'> Nome do Solicitante </td><td width=''>Disponibilização para Teste</td><td width=''>Prazo para Finalização</td><td width=''></td></tr>"
	  
		strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA,DEMANDAS.DATA_PREVISAO_INICIO,B.CO_SITUACAO, B.* "
		strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS "
		strQuery = strQuery &  " INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO  "
		strQuery = strQuery &  " INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
		strQuery = strQuery &  " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON DEMANDAS.CO_DEMANDA = B.CO_DEMANDA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON B.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO "
	
		cont = 0
		cont = cont + 1
		WHERE(cont) = " (B.CO_SITUACAO = 8) "
	
		if data_inicio <> "" and data_final <> "" then
		
			cont = cont + 1
			WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
			
		end if
	
	
		j=0
		query = ""
		For i=1 to cont
			If j=0 then
				Query = Query & " where " &  WHERE(i)
				j=1
		   Else
				Query = Query & " and " & WHERE(i)
		   End If
		Next
		
		
		ordem = " ORDER BY B.CO_SITUACAO, DEMANDAS.ORDEM_PRIORIDADE,DEMANDAS_SITUACOES.DE_SITUACAO "
	
		strQuery = strQuery & query & ordem
		'Response.Write strQuery
		set rs=Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys, 3, , 32
		IF rs.eof Then  'mensagem caso nao haja resultados
			Response.Write "<br><p align='center'>Não existem demandas nesta situação.</p>"
		Else
			
			Response.Write tabela
			ota = 1
			DO WHILE (NOT rs.eof)
			
			'Response.Write "TESTE"
			 Response.Write "<tr>"
			 Response.Write "<td style='" & estilo & "' >"&ucase(rs("NO_TIPO"))&"</td>"
			 Response.Write"<td style='text-align:center; " & estilo & "'>"&rs("NOME")&"</td>"
			 Response.Write"<td style='text-align:left; " & estilo & "'>"& ucase(rs("NO_NOME"))&"</td>"
			 Response.Write"<td style='" & estilo & "' >"&rs("DT_INCLUSAO")&"</td>"
			 Response.Write"<td style='" & estilo & "' >"& dateadd("d",3,rs("DT_INCLUSAO"))&"</td>"
				'response.write rs("DE_SITUACAO")
			if rs("DE_SITUACAO") = "Solicitada" THEN
				'Response.Write "<td>"&ota&"</td>"
				ota = ota + 1
			ELSE
				'Response.Write  "<td>  </td>"
				
			END IF
			response.write "</td>"
			
			RESPONSE.Write "<td > <img class='edit' id='edit'  title='Editar Demanda'  src='imagens/edit_23_23_2.png' style='cursor:pointer;'>"
			response.write urgencia
			RESPONSE.Write " <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
		
			'Response.Write "<td>  </td>"
			Response.Write "</tr>"
		
			rs.movenext
			LOOP
		
		Response.write "</table>"
	
		Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"'</div>"
		
		END IF
	
	  
	  '**
	
	
	 %>
	 </fieldset>
	<br>
	<%
	end if

	if perfil_acesso_admin_siiag or request.Cookies("perfil_acesso_siiag_cod")="7" then	
	
		tabela = "<table name='tabela' style='width:970px;' ><tr><td width='170px;' >Tipo de Demanda</td><td width='200px;'> Nome do Aplicativo </td><td width='250px;'> Nome do Solicitante </td><td width=''> Data de Solicitação </td><td width=''> Responsável TI </td><td width=''> Data de Início </td><td width='%'> Previsão Conclusão </td><td width=''></td></tr>"
		
	
		situacao = Request("situacao")
		data_inicio= Request("data_inicio")
		data_final=Request("data_final")
		nomeSolicitante = Request("nomeSolicitante")
		click = Request("click")
		'Response.Write click
		
	%>
		<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:100px;">
		<legend><span class="titulos" >Em Atendimento</span></legend>
	<%
		strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA,DEMANDAS.INICIO_DATA, B.* , RESP.*, USUARIOS.CO_GS"

		strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS "
		strQuery = strQuery &  " INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO  "
		strQuery = strQuery &  " INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
		strQuery = strQuery &  " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON DEMANDAS.CO_DEMANDA = B.CO_DEMANDA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON B.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO "
		strQuery = strQuery &  " INNER JOIN VW_USUARIOS_RESPONSAVEL AS RESP ON DEMANDAS.CO_DEMANDA = RESP.CO_DEMANDA "
		
	
		cont = 0
		
		cont = cont + 1
		WHERE(cont) = " (B.CO_SITUACAO = 2) AND (RESP.CO_TIPO_RESPONSAVEL = 2)"
		
		if nomeSolicitante <> ""  then
			cont = cont + 1
			WHERE(cont) = " (USUARIOS.NO_NOME like '"& nomeSolicitante &"') " 
			
		end if
		
		if data_inicio <> "" and data_final <> "" then
		
			cont = cont + 1
			WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
			
		end if
	
	
		j=0
		Query = ""
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
			Response.Write "<br><p align='center'>Não existem demandas nesta situação.</p>"
		Else
			
			Response.Write tabela
			ota = 1
			DO WHILE (NOT rs.eof)
			
			'Response.Write "TESTE"
			 Response.Write "<tr>"
			 Response.Write "<td>"&ucase(rs("NO_TIPO"))&"</td>"
			 Response.Write"<td style='text-align:center;'>"&rs("NOME")&"</td>"
			 Response.Write"<td style='text-align:left;'>"& ucase(rs("NO_NOME"))&"</td>"
			 Response.Write"<td>"&rs("SOLICITACAO_DATA")&"</td>"
			 Response.Write"<td title='" & rs("no_responsavel") & "'>"&Primeiro_Nome(rs("NO_RESPONSAVEL")) & "</td>"
			 Response.Write"<td>"&rs("INICIO_DATA")&"</td>"
			 Response.Write"<td>"&rs("CONCLUSAO_DATA_PREVISTA")&"</td>"
			 'Response.Write "<td class='setaOrdem' id='ordem' value="&rs("ORDEM_PRIORIDADE")&"><label class='lblOrdem'>"&rs("ORDEM_PRIORIDADE") & "</label>"
			%>
			<input type="hidden" id="co_gs_demanda" name="co_gs_demanda" value="<%=RS("CO_GS")%>" />
			<%		
				'response.write rs("DE_SITUACAO")
			'if rs("DE_SITUACAO") = "Solicitada" THEN
				'Response.Write "<td>"&ota&"</td>"
			'	ota = ota + 1
			'ELSE
				'Response.Write  "<td>  </td>"
				
			'END IF
			'response.write "<input type='text' class='inputOrdem' class='form-field' style='width:30px;display:none;' value='" & rs("ORDEM_PRIORIDADE") & "'/>"
			response.write "</td>"
			
			RESPONSE.Write "<td width=''> <img class='edit' id='edit'  title='Editar Demanda'  src='imagens/edit_23_23_2.png' style='cursor:pointer; '> <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
		
			'Response.Write "<td>  </td>"
			Response.Write "</tr>"
		
			rs.movenext
			LOOP
		
		Response.write "</table>"
	
		Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"'</div>"
		
		END IF
		set rs = nothing
	%>
		</fieldset>
		<br>
<%  end if %>

	<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
  	<legend><span class="titulos" >Aguardando Atendimento</span></legend>
<%

  '**
  	tabela = "<table name='tabela' style='width:970px;' ><tr><td width='170px;' >Cód - Tipo de Demanda</td><td width='200px;'> Nome do Aplicativo </td><td width='250px;'> Nome do Solicitante </td><td width=''> Data de Solicitação </td><td width=''> Previsão de Início </td><td width=''>Ordem Atendimento</td><td width='50px'></td></tr>"

  
	strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA,DEMANDAS.DATA_PREVISAO_INICIO, B.* "
	strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS "
	strQuery = strQuery &  " INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA "
	strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO  "
	strQuery = strQuery &  " INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
	strQuery = strQuery &  " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON DEMANDAS.CO_DEMANDA = B.CO_DEMANDA "
	strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON B.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO "

	cont = 0
	cont = cont + 1
	WHERE(cont) = " (B.CO_SITUACAO in (6,7) )"
	
	if nomeSolicitante <> ""  then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.NO_NOME like '"& nomeSolicitante &"') " 
		
 	end if
	
	if data_inicio <> "" and data_final <> "" then
	
		cont = cont + 1
		WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
		
	end if


	j=0
	query = ""
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
		Response.Write "<br><p align='center'>Não existem demandas nesta situação.</p>"
	Else
		
		Response.Write tabela
		ota = 1
		DO WHILE (NOT rs.eof)
			if rs("co_situacao")  = 6 then
				estilo = " color:#FF0000; "
				urgencia = " <img class='urgent' id='urgent'  src='imagens/urgente_vermelho.png' title='Urgente' >  "
			else
				estilo = " "
				if Eh_Perfil_Verificado("7") or perfil_acesso_admin_siiag  then
					urgencia = "  <img class='urgent_solicitar'  src='imagens/urgente_amarelo.png' title='Solicitar urgência' style='cursor:pointer;' >  "
				else
					urgencia = ""
				end if
			end if
		
		'Response.Write "TESTE"
		 Response.Write "<tr class='elemento' >"
		 Response.Write "<td style='" & estilo & "'  >"& rs("co_demanda") & " - " & ucase(rs("NO_TIPO"))&"</td>"
		 Response.Write"<td style='text-align:center; " & estilo & "'>"&rs("NOME")&"</td>"
		 'Response.Write"<td>"&rs("DE_SITUACAO")&"</td>"
		 Response.Write"<td style='text-align:left; " & estilo & "'>"& ucase(rs("NO_NOME"))&"</td>"
		 Response.Write"<td style='" & estilo & "'>"&rs("SOLICITACAO_DATA")&"</td>"
		 Response.Write"<td style='" & estilo & "'>"&rs("DATA_PREVISAO_INICIO")&"</td>"
		 Response.Write "<td class='setaOrdem' id='ordem' value="&rs("ORDEM_PRIORIDADE")&"  style='display:non;'><label class='lblOrdem' style='" & estilo & "' >"&rs("ORDEM_PRIORIDADE") & "</label>"

			'response.write rs("DE_SITUACAO")
		if rs("DE_SITUACAO") = "Solicitada" THEN
			'Response.Write "<td>"&ota&"</td>"
			ota = ota + 1
		ELSE
			'Response.Write  "<td>  </td>"
			
		END IF
		response.write "<input type='text' class='form-field inputOrdem' style='width:30px;display:none;' value='" & rs("ORDEM_PRIORIDADE") & "'/>"
		response.write "</td>"
		
		RESPONSE.Write "<td width=''> <img class='edit' id='edit'  title='Editar Demanda'  src='imagens/edit_23_23_2.png' style='cursor:pointer; '> "
		response.write urgencia
		RESPONSE.Write " <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
	
		'Response.Write "<td>  </td>"
%>
        <td class="tdseta" data-pos="0" data-category="1" style="display:none;">
            <span class="setacima"><img src="imagens/setacima.png" style='cursor:pointer; ' /></span>
            <span class="setabaixo"><img src="imagens/setabaixo.png" style='cursor:pointer; ' /></span>
        </td>
<%
	    Response.Write "</tr>"
	
		rs.movenext
		LOOP
		rs.movefirst
		
	'response.Write"<tr>"
	'response.Write"<td colspan='8'>"
	'  	response.Write " <select size='5' name='cDemandas' id='cDemandas' multiple style='font-size: 8 pt; width: 900px' onDblClick='return(Control(this))' > "
 	'	Do while not rs.eof
	' 		response.Write "   <option value='"&rs("co_demanda") &"' >" & rs("co_demanda") & " - " & rs("no_tipo") & "-" & rs("nome") & " " & rs("de_situacao") & "</option> "
	' 		rs.movenext
	'	Loop
	'	set rs =  nothing
'
'		response.Write " </select> "
'	response.Write"</td>"
'	response.Write"</tr>"
	Response.write "</table>"
	Response.Write "<div id='divEditar'><input type='button' id='editaPrioridade' class='myButton' value='Editar Prioridade' style='margin-left:41%;margin-top:1%;' /></div>"
	Response.Write "<div id='divSalvar'><input type='button' id='salvaPrioridade' class='myButton' value='Salvar Prioridade' style='margin-left:41%;margin-top:1%;' /></div>"
	Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"' </div>"
	
	END IF

  
  '**


 %>
 </fieldset>
 
 
 <BR>
 <%
  	'if perfil_acesso_admin_siiag or request.Cookies("perfil_acesso_siiag_cod") = "7" then
	 %>
		<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
		<legend style=""><span class="titulos" >Aguardando Análise</span></legend>
	 <%
	  '**
		'tabela = "<table name='tabela' ><tr><td width='5%' >Cód<BR> Demanda</td><td width='15%' >Tipo de Demanda</td><td width='20%'> Nome do Aplicativo </td><td width='11%'> Situação </td><td width='25%'> Nome do Solicitante </td><td width='11%'> Data de Solicitação </td><td width='11%'> Ordem de Prioridade </td><td width='11%'> Editar Demanda </td><td width='11%' id='visuOrdenacao' style='display:none;'> Ordenação </td></tr>"
		tabela = "<table name='tabela' style='width:970px;' ><tr><td width='170px;' >Cód - Tipo de Demanda</td><td width='200px;'> Nome do Aplicativo </td><td width='250px;'> Nome do Solicitante </td><td width=''> Data de Solicitação </td><td width='30px;'></td><td width='' id='visuOrdenacao' style='display:none;'> Ordenação </td></tr>"
		
	
	  
		strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA, B.*,USUARIOS.CO_GS "
		strQuery = strQuery &  "  FROM TB_DEMANDAS AS DEMANDAS "
		strQuery = strQuery &  " INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO  "
		strQuery = strQuery &  " INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO "
		strQuery = strQuery &  " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO B ON DEMANDAS.CO_DEMANDA = B.CO_DEMANDA "
		strQuery = strQuery &  " INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON B.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO "
	
		cont = 0
		cont = cont + 1
		WHERE(cont) = " (B.CO_SITUACAO = 1)"
		
		if nomeSolicitante <> ""  then
			cont = cont + 1
			WHERE(cont) = " (USUARIOS.NO_NOME like '"& nomeSolicitante &"') " 
			
		end if
		
		if data_inicio <> "" and data_final <> "" then
		
			cont = cont + 1
			WHERE(cont) = " (DEMANDAS.SOLICITACAO_DATA BETWEEN '"& data_inicio &"' AND '"&data_final&"') "
			
		end if
	
	
		j=0
		query = ""
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
			Response.Write "<br><p align='center'>Não existem demandas nesta situação.</p>"
		Else
			
			Response.Write tabela
			ota = 1
			DO WHILE (NOT rs.eof)
			
			'Response.Write "TESTE"
			 Response.Write "<tr>"
			 Response.Write "<td>"&rs("CO_DEMANDA") & " - " &ucase(rs("NO_TIPO"))&"</td>"
			 Response.Write"<td style='text-align:center;'>"&rs("NOME")&"</td>"
			 Response.Write"<td style='text-align:left;'>"& ucase(rs("NO_NOME"))&"</td>"
			 Response.Write"<td>"&rs("SOLICITACAO_DATA")&"</td>"
			 'Response.Write"<td>"&rs("ORDEM_PRIORIDADE")&"</td>"
			RESPONSE.Write "<td width=''> <img class='edit' id='edit'  src='imagens/edit_23_23_2.png' title='Editar Demanda' style='cursor:pointer; '> <input type='hidden' id='demanda' value="&rs("CO_DEMANDA")&" /></td>"
			%>
			<input type="hidden" id="co_gs_demanda" name="co_gs_demanda" value="<%=RS("CO_GS")%>" />
			<%		

			'Response.Write "<td>  </td>"
			Response.Write "</tr>"
		
			rs.movenext
			LOOP
		
		Response.write "</table>"
	
		Response.Write "<div id='divMat'><input type='hidden' id='mat' value='"&request.Cookies("co_usuario_siiag")&"'</div>"
		
		END IF
	  '**
	 %>
	 </fieldset>
	 <BR>
 <%'end if%>