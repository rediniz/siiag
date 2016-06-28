<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Nova Requisi&ccedil;&atilde;o - Estoque</title>
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!-- Favicon -->
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="submenu.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">

<script>
$(document).ready(function() {

	$("#apagar_todos").hide();
	$("#apagar_todos_reser").hide();
	$("#carregando").hide();
	
		$.ajax({
				method: "POST",
       			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
       			url: "estoque_lista_materiais.asp?filtro=", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
					$("#lista").hide();
        			$("#carregando").show(); 
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
					$("#lista").show();
            		$("#carregando").hide();  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$('#lista').html(data); 
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro.");
 				}
		
      		})
});

$(function() {
	var header = false;
	var header_reserva = false;
	var qtd_pedido = 0;
	var nome = "";
	var nome_pedido = "";
	$("#filtro").on("keyup", function(){
		//window.location.assign("estoque_requisicao.asp?filtro="+$("#filtro").val());
		
			$.ajax({
				method: "POST",
				data: {
				filtro: $("#filtro").val()
				},
       			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
       			url: "estoque_lista_materiais.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        			$("#carregando").show(); 
					$("#tab_materiais").hide();
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		$("#carregando").hide();  
					$("#tab_materiais").show();
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$('#lista').html(data);	  
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro.");
 				}
		
      		})
});

	$('#tab_pedido').on('click', '#X', function(){
		$(this).parent().parent().remove(); 
		qtd_pedido--;
		if(qtd_pedido == 0){
			$("#tab_pedido").hide();
			$("#apagar_todos").hide();
		}
		});

	$('#tab_reserva').on('click', '#X_reser', function(){
		$(this).parent().parent().remove(); 
		qtd_pedido--;
		if(qtd_pedido == 0){
			$("#tab_pedido").hide();
			$("#apagar_todos_reser").hide();
		}
		});

	$(document).on("click",".adicionar",function(){

		nome = $(this).parent().parent().find("#nome").html();
		var disponivel = parseInt($(this).parent().parent().find("#disponivel").html());
		var unidade = $(this).parent().parent().find("#unidade").html()
		var quantidade = parseInt($(this).parent().parent().find("#quantidade").val());
		var codigo = $(this).parent().parent().find("#codigo").val()
		var igual = false;
		
		$(".linha_pedidos").each(function(){
	
			nome_pedido = $(this).find("#pedido_nome").html();
		
			if(nome_pedido == nome){
				alert("O material selecionado já foi adicionado.");
				igual=true;
			}
		});
	
		if(igual){
			return false;
		}
		if(quantidade == 0){
	
			alert("A quantidade não pode ser zero.");
			return false;
		} 	

		if(quantidade > disponivel){
	
			//alert("Você solicitou uma quantidade maior que a disponível no momento.Informe uma quantidade menor.");
			confirmacao = window.confirm("Você solicitou "+quantidade+" "+nome+". A quantidade disponível no momento é "+disponivel+". Aperte 'OK' para pedir a quantidade disponível e reservar o restante ou 'Cancelar' para pedir uma quantidade diferente.");
			
			if(confirmacao){
			
				var quantidade_reserva = quantidade-disponivel;
				
				alert("Você será avisado(a) por e-mail quando o material estiver disponível no estoque.");
					
				if(header_reserva===false){
					$( "#tab_reserva" ).append( "<tr><td> Nome </td><td> Unidade </td><td> Quantidade </td><td> Excluir </td></tr>");
					header_reserva=true;		
				}
				$("#tab_reserva").append(
					"<tr class='linha_reservas'> " +	
					"<input type='hidden' id='codigo_reserva' name='codigo_reserva' value="+codigo+">" +
					"<td id='pedido_nome'>" + nome + "</td>" +
					"<td id='pedido_unidade'>" + unidade + "</td>" +
					"<td id='pedido_quantidade'>" + quantidade_reserva + "</td>" +
					"<td><img class='X_reser' id='X_reser'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>" +
					"</tr>"
				);
				
				

					if (disponivel >0) {
						$("#tab_pedido").show();
			
						if(header===false){
							$( "#tab_pedido" ).append( "<tr><td> Nome </td><td> Disponível </td><td> Unidade </td><td> Quantidade </td><td> Excluir </td></tr>");
							header=true;		
						}
		
						$("#tab_pedido").append(
					
						"<tr class='linha_pedidos'> " +	
						"<input type='hidden' id='codigo' name='codigo' value="+codigo+">" +
						"<td id='pedido_nome'>" + nome + "</td>" +
						"<td id='pedido_disponivel'>" + disponivel + "</td>" +
						"<td id='pedido_unidade'>" + unidade + "</td>" +
						"<td id='pedido_quantidade'>" + disponivel + "</td>" +
						"<td><img class='X' id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>" +
						"</tr>");
						$("#apagar_todos").show();
						qtd_pedido++;
					}
					if ( quantidade_reserva >  0) {
						$("#apagar_todos_reser").show();
					}
					return false;
	
			
			}else{
			
				return false;			
				
			}
	
		} 	
	
		$("#tab_pedido").show();
	
		if(header===false){
			$( "#tab_pedido" ).append( "<tr><td> Nome </td><td> Disponível </td><td> Unidade </td><td> Quantidade </td><td> Excluir </td></tr>");
			header=true;		
		}
	
		$("#tab_pedido").append(
			"<tr class='linha_pedidos'> " +	
			"<input type='hidden' id='codigo' name='codigo' value="+codigo+">" +
			"<td id='pedido_nome'>" + nome + "</td>" +
			"<td id='pedido_disponivel'>" + disponivel + "</td>" +
			"<td id='pedido_unidade'>" + unidade + "</td>" +
			"<td id='pedido_quantidade'>" + quantidade + "</td>" +
			"<td><img class='X' id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>" +
			"</tr>"
		);
		$("#apagar_todos").show();
		qtd_pedido++;
	});

	$("#apagar_todos").click(function(){
		
		apagar = window.confirm("Apagar todos os pedidos?");
		
		if(apagar){
			$("#apagar_todos").hide();				
			$(".linha_pedidos").remove();
			$("#tab_pedido").hide();
			qtd_pedido=0;
		}else{
			return false;
		}

	});
	
	$("#apagar_todos_reser").click(function(){
		
		apagar = window.confirm("Apagar todas reservas?");
		
		if(apagar){
			$("#apagar_todos_reser").hide();				
			$(".linha_reservas").remove();
			$("#tab_reserva").hide();
			quantidade_reserva=0;
		}else{
			return false;
		}

	});
	
	$("#salvar").click(function(){
	
		if( $("#perfil_estoque_solicitar").val() == 'False' ){
			alert("Você não tem permissão para realizar um pedido.");
			return false;
		}
	
		var pedidos = false;
		var reservas = false;		
		
		$(".linha_pedidos").each(function(){
			valor = $(this).find("#codigo").val()+":"+$(this).find("#pedido_quantidade").html();
			$("#pedidos").append("<input type='hidden' value="+valor+" id='pedido' name='pedido'>");
			pedidos = true;
		});

		$(".linha_reservas").each(function(){
			valor = $(this).find("#codigo_reserva").val()+":"+$(this).find("#pedido_quantidade").html();
			$("#reservas").append("<input type='hidden' value="+valor+" id='reserva' name='reserva'>");
			reservas = true;
		});

	
		/*$(".linha").each(function(){
			valor = $(this).find("#codigo").val()+":"+$(this).find("#pedido_quantidade").html();
			$("#pedidos").append("<input type='hidden' value="+valor+" id='pedido' name='pedido'>");
		});*/

		if(!pedidos && !reservas){
			alert("Nenhum material foi selecionado.");
			return false;
		}
	
		salvar = window.confirm("Deseja salvar o pedido?")
		
		if(salvar){
				$.ajax({
					method: "POST",
					data: $("#formulario").serialize(),
					contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
					url: "estoque_requisicao_salvar.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
						
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO

					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						alert("Pedido realizado com sucesso.");
						window.location.assign("estoque_pendentes.asp");
					},
					error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao salvar o pedido.");
					}
			
				})
				//$("#formulario").submit();
		}
	
	});
	
});

</script>

</head>
<%
  
  Perfil_Acesso("16") 
  response.write "<input type='hidden' id = 'perfil_estoque_consultar' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_estoque_solicitar' value=" & perfil_acesso_siiag  & ">"
  
  'if not perfil_acesso_admin_siiag then
  if not perfil_acesso_siiag then
  	response.Redirect("estoque_consulta.asp")
  end if
   

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
      <div id='cssmenu' >
        <ul>
           <%			
			  'if perfil_acesso_admin_siiag then
              	response.write "<li class='active'><a href='estoque_requisicao.asp'><span>Novo Pedido</span></a></li>"
				if tem_acesso("8") then
				  	response.write "<li ><a href='estoque_pendentes.asp'><span>Pedidos</span></a></li>"	
				end if
				if tem_acesso("10") then
					response.write "<li ><a href='estoque_manutencao.asp'><span>Manutenção</span></a></li> 	 "
				end if
			  'else
			  '	response.write "<li class='active'><a href='estoque_requisicao.asp'><span>Novo Pedido</span></a></li> "			  
			  'end if			
			 %>
        </ul>
      </div>
      </p>
      <div id='submenu'>
        <ul>
         <!-- <li><a href='#'><span>Ajuda</span></a></li>-->
        </ul>
      </div>
      <p class="paragrafoteste">
      <div class="testess">
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Lista de materiais</span></legend>
        <div  align="center" style="padding-bottom:5px; padding-top:-5px">
          <label>Filtro de Materiais:</label>
          <input class="form-field" id = "filtro" name="filtro" type="text" size="35" maxlength="100" />
        </div>
        
         <div id="carregando" align="center">                      
        <img src="imagens/carregando.gif" />
        </div> 
        <div id= "lista" class="tabela" style="overflow:auto ; height:300px" >
    	 
        </div>
        </fieldset>
        </p>
        <form  action="estoque_requisicao_salvar.asp" id='formulario' method="post" enctype="application/x-www-form-urlencoded">
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px" >
        <legend><span class="titulos">Pedidos</span></legend>
        <div  class="tabela" style="margin-left:0.8%" >
		<table id = "tab_pedido"></table>
        </div>
     
        <div align="center">
          <input name="apagar_todos" id="apagar_todos" class="myButton" type="button"  value="Apagar todos os pedidos" style="padding-right:10px; padding-left:10px; margin:10px; padding-top:1px; padding-bottom:1px" />
        </div>
        
        </fieldset>
        
        
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px" >
        <legend><span class="titulos">Reservas</span></legend>
        <div  class="tabela" style="margin-left:0.8%" >
		<table id = "tab_reserva"></table>
        </div>
        <div align="center">
          <input name="apagar_todos_reser" id="apagar_todos_reser" class="myButton" type="button"  value="Apagar todas as reservas" style="padding-right:10px; padding-left:10px; margin:10px; padding-top:1px; padding-bottom:1px" />
        </div>

        
        </fieldset>
        
        
		<div id='pedidos'>
        </div>
   		<div id='reservas'>
        </div>
       
            </form>
             <div align="center" style="padding-top:10px">
        <button class="myButton" id="salvar"> Salvar </button>
          
          <p></p>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
