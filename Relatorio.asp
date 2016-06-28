<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<title>SIIAG-WEB</title>

<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">

<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<link type="text/css" rel="stylesheet" href="css/rcarousel.css" />

<style>

.botaoFerias{ margin-left:auto;}

.labels{margin-left:auto;}

.inputFerias{margin-left:auto;}

</style>

<style>
.ui-datepicker {
	font-size:12px;
}
</style>
<script>
    $(function() {
    $( ".datepicker" ).datepicker({
    dateFormat: 'dd/mm/yy',
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText: 'Próximo',
    prevText: 'Anterior'
  });
   });
  </script>
  
 <style type="text/css">
    <!--
       
		.datepicker{
		
				margin-left:12px;
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
-->
    </style>  

</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- fazendo o include do topo aqui -->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container2">
      <div class="conteudo">
       
       <%
	   relatorio = Request("relatorio")
	   SELECT CASE relatorio 
	   
	   CASE "ferias"

	   	%>
        
        <!-- #INCLUDE FILE ="relatorio_ferias.asp" -->
        
	   <%
	   Case "destacamento"
	   
		%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Destacamentos</h3>	
		
		<%   
	   
	   
	   Case "estoque"
	   
	   	%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Estoque</h3>	
		
		<% 
	   
		   
			
		
	   
	   Case "treinamentos"
	   
	   	%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Treinamentos</h3>	
		
		<% 
		   
	   
	   Case "emprestimos"
	   
	  	%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Empr&eacute;stimos</h3>	
		
		<% 	  
	   
  
	   END SELECT
	   
	   %> 
       
      </div>
      <!-- #INCLUDE FILE ="calendario.asp" -->
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
