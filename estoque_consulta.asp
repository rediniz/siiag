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

	$("#carregando").hide();
	
		$.ajax({
				method: "POST",
       			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
       			url: "estoque_lista_consulta.asp?filtro=", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
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




</script>

<script>
$(function() {
	$("#filtro").on("keyup", function(){
		//window.location.assign("estoque_requisicao.asp?filtro="+$("#filtro").val());
		
			$.ajax({
				method: "POST",
				data: {
				filtro: $("#filtro").val()
				},
       			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
       			url: "estoque_lista_consulta.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
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
});
</script>

</head>
<%
  
  Perfil_Acesso("8") 
  response.write "<input type='hidden' id = 'perfil_estoque_consultar' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_estoque_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
   
%>
<body>
<div class="teste2">
<!--fundo azul do meio-->
<!-- #INCLUDE FILE ="topo.asp" -->
<div class="corposite">
  <!--corpo-->
  <div class="container">
    <div class="conteudo2">
      <div class="titulosModulos"><span>ESTOQUE</span></div>
      <div id='cssmenu' >
        <ul>
           <%			
			  	response.write "<li class='active'><a href='estoque_consulta.asp'><span>Lista de Materiais</span></a></li> "			  
						
			 %>
        </ul>
      </div>
      </p>
      <div id='submenu'>
        <ul>
          <li><a href='#'><span>Ajuda</span></a></li>
        </ul>
      </div>
      <p class="paragrafoteste">
      <div class="testess">
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:425px;">
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
