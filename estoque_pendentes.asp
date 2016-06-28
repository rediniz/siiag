<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_Usuario.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Estoque-Pendentes</title>
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!-- Favicon -->
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<script src="scripts/jquery.ui.datepicker.js"></script>
<!--<script src="scripts/jquery-1.9.1.js"></script> -->

<style>
	.ui-datepicker {
		font-size:12px;
	}
	.datepicker {
		height:15px;
		border: 1px solid #b5cce2;
		background: #edf4fc;
		-webkit-border-radius: 4px;
		-moz-border-radius: 4px;
		border-radius: 4px;
		color: #666;
		box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
		padding:6px;
		width:auto;
	}
	.datepicker:focus {
		background: #fff;
		color: #000000;
		outline:none;
		padding:6px;
		box-shadow: 0 0 5px #9ecaed;
	}
	.ui-widget-header .ui-state-focus {
		border: 1px solid #fbcb09;
		background: #fdf5ce;
		font-weight: bold;
		color: #c77405;
	}
	.ui-widget {
		font-family: Arial, sans-serif;
		font-size: 0.8em;
	}
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	.ui-menu .ui-menu-item a {
		height:14px;
		font-size:13px;
	}
	.ui-widget-header .ui-state-focus {
		border: 1px solid #fbcb09;
		background: #fdf5ce;
		font-weight: bold;
		color: #c77405;
	}
	.ui-widget {
		font-family: Arial, sans-serif;
		font-size: 0.8em;
	}
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	.ui-menu .ui-menu-item a {
		height:14px;
		font-size:13px;
	}
	.ui-autocomplete {
		height:200px;
		overflow-y:scroll;
		overflow-x:hidden;
	}
</style>



<script>
function Recarregar(){
	$.ajax({
			method: "POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
			url: "estoque_pendentes_con.asp?coordenacao="+$("#coordenacao").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
			dataType: "html", // TIPO DE DADOS DE RETORNO
			//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
			beforeSend: function() { // ANTES DA REQUISIÇÃO
				$("#carregando").show(); 
				$("#pendencias").hide();
			},
			complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
				$("#carregando").hide();  
				$("#pendencias").show();
			},
			success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
				$('#pendencias').html(data);	  
			},
			error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
				alert("Erro ao carregar pendências.");
			}
					
		})

}

function Recarregar_Atendidos(){
	$.ajax({
			method: "POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
			url: "estoque_atendidos_con.asp?coordenacao="+$("#coordenacao").val() + "&dt_entrega_ini="+ $("#data_entrega_ini").val() + "&dt_entrega_fin=" + $("#data_entrega_fin").val() , // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
			dataType: "html", // TIPO DE DADOS DE RETORNO
			//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
			beforeSend: function() { // ANTES DA REQUISIÇÃO
				$("#carregando_atendidos").show(); 
				$("#atendidos").hide();
			},
			complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
				$("#carregando_atendidos").hide();  
				$("#atendidos").show();
			},
			success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
				$('#atendidos').html(data);	  
			},
			error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
				alert("Erro ao carregar atendidos.");
			}
					
		})

}


function Recarregar_Reservas(){
	$.ajax({
			method: "POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
			url: "estoque_reservas_con.asp?coordenacao="+$("#coordenacao").val() + "&dt_entrega_ini="+ $("#data_entrega_ini").val() + "&dt_entrega_fin=" + $("#data_entrega_fin").val() , // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
			dataType: "html", // TIPO DE DADOS DE RETORNO
			//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
			beforeSend: function() { // ANTES DA REQUISIÇÃO
				$("#carregando_reservas").show(); 
				$("#reservas").hide();
			},
			complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
				$("#carregando_reservas").hide();  
				$("#reservas").show();
			},
			success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
				$('#reservas').html(data);	  
			},
			error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
				alert("Erro ao carregar reserva.");
			}
					
		})

}

$(function() {
	$(document).ready(function(){
		Recarregar();
		if ($("#perfil_admin_estoque").val()=="True")
		{
			Recarregar_Atendidos();
			Recarregar_Reservas();		
		}
	});

	$(".datepicker" ).datepicker({
		dateFormat: 'dd/mm/yy',
		dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
		dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
		dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
		monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		nextText: 'Próximo',
		prevText: 'Anterior'
	});

	$("#coordenacao").on("change", function(){
	
		$.ajax({
					method: "POST",
					contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
					url: "estoque_pendentes_con.asp?coordenacao="+$("#coordenacao").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
						$("#carregando").show(); 
						$("#pendencias").hide();
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
						$("#carregando").hide();  
						$("#pendencias").show();
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						$('#pendencias').html(data);	  
					},
					error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao carregar coordenações.");
					}
						
				})
	
	});

	$("#coordenacao_atendidos").on("change", function(){
	
		$.ajax({
			method: "POST",
			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
			url: "estoque_atendidos_con.asp?coordenacao="+$("#coordenacao_atendidos").val() + "&dt_entrega_ini="+ $("#data_entrega_ini").val() + "&dt_entrega_fin=" + $("#data_entrega_fin").val() , // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
			dataType: "html", // TIPO DE DADOS DE RETORNO
			//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
			beforeSend: function() { // ANTES DA REQUISIÇÃO
				$("#carregando_atendidos").show(); 
				$("#atendidos").hide();
			},
			complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
				$("#carregando_atendidos").hide();  
				$("#atendidos").show();
			},
			success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
				$('#atendidos').html(data);	  
			},
			error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
				alert("Erro ao carregar atendidos.");
			}
					
		})
	
	});


	$("#atualizar").click(function(){
		Recarregar();
	});

	$("#atualizar_atendidos").click(function(){
		if ($("#data_entrega_fin").val()=="")
		{
			$("#data_entrega_fin").val($("#data_entrega_ini").val());
		}
		Recarregar_Atendidos();

	});

	$(document).on("click", ".atender", function(){
		
			if($("#perfil_estoque").val()=="False"){
				alert("Você não tem permissão para atender a solicitação.")
				return false;
			}	
			
			var qtd_liberar = $(this).parent().find("#qtd_liberar").val();
			var qtd_disponivel = $(this).parent().find("#qtd_disponivel").html();
			
			if(qtd_liberar == 0){
			
				alert("A quantidade a ser liberada não pode ser zero.");
				return false;		
			}
			
			if((qtd_disponivel - qtd_liberar) < 0){
				alert("A quantidade a ser liberada é maior que a disponível no estoque.");
				return false;
			}
			
			atender = window.confirm("Deseja atender o pedido com a quantidade informada?\nQuantidade: "+qtd_liberar);
			
			if(atender){
	
				var co_pedido = $(this).parent().find("#co_pedido").val();
				var co_material = $(this).parent().find("#co_material").val();
				
				var pedido = co_pedido + ":" + co_material + ":" + qtd_liberar;
				$.ajax({
						method: "POST",
						data: {
							pedido:pedido
						},
						contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
						url: "estoque_pendentes_atender.asp?acao=atender", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
						dataType: "html", // TIPO DE DADOS DE RETORNO
						//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
						success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
							alert("Pedido atendido com sucesso.");	
							Recarregar();
							Recarregar_Reservas();

							  
						},
						error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
							alert("Erro na solicitação.");
						}
					})
				    //window.open('estoque_pendentes_atender.asp?acao=atender&pedido=' + pedido);
			
				
			} else {
			
			return false;
			
			}
	
	});

	$(document).on("click", ".rejeitar", function(){
	
			if($("#perfil_estoque").val()=="False"){
				alert("Você não tem permissão para rejeitar a solicitação.")
				return false;
			}
	
			rejeitar = window.confirm("Deseja rejeitar o pedido?");
			
			if(rejeitar){
	
				var co_pedido = $(this).parent().find("#co_pedido").val();
				var co_material = $(this).parent().find("#co_material").val();		
				var pedido = co_pedido + ":" + co_material;
		
				$.ajax({
						method: "POST",
						data: {
							pedido:pedido
						},
						contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
						url: "estoque_pendentes_atender.asp?acao=rejeitar", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
						dataType: "html", // TIPO DE DADOS DE RETORNO
						//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
						success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
							alert("Pedido rejeitado com sucesso.");	  
							Recarregar();

						},
						error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
							alert("Erro na solicitação.");
						}		
					})
					//window.open('estoque_pendentes_atender.asp?acao=rejeitar&pedido=' + pedido);
					
			} else {
				
				return false;
					
			}
	
	});

	$(document).on("click", ".restaurar", function(){
	
			restaurar = window.confirm("Deseja restaurar o pedido?");
			
			if(restaurar){
	
				var co_pedido = $(this).parent().find("#co_pedido").val();
				var co_material = $(this).parent().find("#co_material").val();		
				var pedido = co_pedido + ":" + co_material;
		
				$.ajax({
						method: "POST",
						data: {
							pedido:pedido
						},
						contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
						url: "estoque_pendentes_atender.asp?acao=restaurar", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
						dataType: "html", // TIPO DE DADOS DE RETORNO
						//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
						success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
							alert(data);	  
						},
						error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
							alert("Erro na solicitação.");
						}		
				})
				
		   } else {
			  
				return false;
		   }   
	});

});

</script>

<script>
	function abreRelatorio(){
		window.open("relatorio_estoque_pendencias.asp?coordenacao="+$("#coordenacao").val());
	}
	function abreRelatorioAtendidos(){
		window.open("relatorio_estoque_entregue.asp?coordenacao="+$("#coordenacao").val() + "&dt_entrega_ini=" +$("#data_entrega_ini").val() + "&dt_entrega_fin="+$("#data_entrega_fin").val());
	}

</script>

</head>

<%
	Perfil_Acesso("8")
	
	response.write "<input type='hidden' id = 'perfil_estoque' value='" & perfil_acesso_siiag & "'>"
    'acesso_rh = Tem_Acesso("10")
	'perfil_acesso_admin_siiag = Tem_Acesso("10")
	response.write "<input type='hidden' id = 'perfil_admin_estoque' value=" & perfil_acesso_admin_siiag & ">"
	if not perfil_acesso_siiag then
		response.Redirect("estoque_requisicao.asp")
	end if
	'response.write perfil_acesso_admin_siiag
%>
<body>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      	<div class="titulosModulos" ><span >ESTOQUE</span> </div>
        <p>
        <div id='cssmenu'>
          <ul>
			<%if Tem_Acesso("16") then%>
	          	<li><a href='estoque_requisicao.asp'><span>Novo Pedido</span></a></li>          
			<%end if%>
            <li class='active'><a href='estoque_pendentes.asp'><span>Pedidos</span></a></li>
			<%if Tem_Acesso("10") then%>
	            <li ><a href='estoque_manutencao.asp'><span>Manutenção</span></a></li>
            <%end if%>
          </ul>
        </div>
        </p>
        <div id='submenu'>
          <ul>
            <!--<li><a href='#'><span>Ajuda</span></a></li>-->
          </ul>
        </div>
        <p class="paragrafoteste">
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Pedidos Solicitados</span></legend>
        <div align="center">
       <label>Coordenação: </label>
          <select class="form-select" id="coordenacao">

   		  <%
			if perfil_acesso_admin_siiag then
				query = "SELECT CO_GS, NO_GS FROM VW_GS WHERE IC_ATIVO = 1 and co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" order by no_gs"
			%>
               <option value=""> Todas </option>
            <%'
			else
				query = "SELECT CO_GS, NO_GS FROM VW_GS WHERE IC_ATIVO = 1 and co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" and co_gs = " & request.Cookies("co_usuario_gs_siiag") & " order by no_gs"
			end if
			set ds=Server.CreateObject("ADODB.RecordSet")
			
			ds.Open query, dados_sys 

				DO UNTIL ds.eof
				response.write "<option value="& ds("co_gs") & " "
				if cint(request.Cookies("co_usuario_gs_siiag")) = cint(ds("co_gs")) then
					response.write " selected "
				end if
				response.write  " >" & ds("no_gs") & "</option>"				 
				ds.movenext
				LOOP	  
		  %>
          </select>
        </div>
        
        <div id="carregando" align="center">
       	  <br />
		  <img src="imagens/carregando.gif" />     
        </div>
        
        <div id = "pendencias" class="tabela" align="center">

        </div>
     
        <div align="center">
        <br />
 		<input  name="atualizar" class="myButton" type="button" id="atualizar" value="Atualizar" style="padding-right:10px; padding-left	:10px; padding-top:1px; padding-bottom:1px" />
        
        <input name="geraRelatorio" class="myButton" type="button" id="geraRelatorio" value="Relatório" style="padding-right:10px; padding-left	:10px; padding-top:1px; padding-bottom:1px;margin-left:10px;" onclick="abreRelatorio()" />

        </div>
        </fieldset>
		<br>
		<%if perfil_acesso_admin_siiag then%>
            <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
            <legend><span class="titulos">Pedidos Entregues</span></legend>
            <div align="center">
            <table border="0" width="100%"> <tr> <td style="text-align:left;">
           <label>Coordenação: </label>
              <select class="form-select" id="coordenacao_atendidos">
              <option value=""> Todas </option>
              <%
                  query = "SELECT CO_GS, NO_GS FROM VW_GS WHERE IC_ATIVO = 1 and co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" order by no_gs"
                  set ds=Server.CreateObject("ADODB.RecordSet")
                 
                  ds.Open query, dados_sys 
                  DO UNTIL ds.eof
                    response.write "<option value="& ds("co_gs") & " "
                    if cint(request.Cookies("co_usuario_gs_siiag")) = cint(ds("co_gs")) then
                        response.write " selected "
                    end if
                    response.write  " >" & ds("no_gs") & "</option>"				 
                    ds.movenext
                  LOOP	  
              %>
              </select>
              </td>
              <td><label>Data Entrega:</label><input name="data_entrega_ini" id="data_entrega_ini" type="text" class="datepicker" size="10" readonly="readonly" value="" /><label> a</label> <input name="data_entrega_fin" id="data_entrega_fin" type="text" class="datepicker" size="10" readonly="readonly" value="" /> </td>
            <td>
            <input  name="atualizar_atendidos" class="myButton" type="button" id="atualizar_atendidos" value="Pesquisar" style="padding-right:10px; padding-left	:10px; padding-top:1px; padding-bottom:1px" />
            </td>
            </tr>
            </table>
            </div>
            
            <div id="carregando_atendidos" align="center">
              <br />
              <img src="imagens/carregando.gif" />     
            </div>
            
            <div id = "atendidos" class="tabela" align="center">
    
            </div>
         
            <div align="center">
            <br />
            
            
            <input name="geraRelatorioAtendidos" class="myButton" type="button" id="geraRelatorioAtendidos" value="Relatório" style="padding-right:10px; padding-left	:10px; padding-top:1px; padding-bottom:1px;margin-left:10px;" onclick="abreRelatorioAtendidos()" />
    
            </div>
            </fieldset>

            <BR>
     <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
            <legend><span class="titulos">Pedidos Reservados</span></legend>
            <div align="center">
    
            </div>
            
            <div id="carregando_reservas" align="center">
              <br />
              <img src="imagens/carregando.gif" />     
            </div>
            
            <div id = "reservas" class="tabela" align="center">
    
            </div>
         
            <div align="center">
            <br />
            </div>
            </fieldset>        
		<%end if%>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
