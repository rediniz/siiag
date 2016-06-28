
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Demanda</title>
<!--CSS -->
<link rel="stylesheet" href="../estilo.css" type="text/css"/>
<link rel="stylesheet" href="../abas.css" type="text/css"/>
<link href="../botao_azul.css" rel="stylesheet" type="text/css" />
<link href="../tabela.css" rel="stylesheet" type="text/css" />
<link href="../menu.css" rel="stylesheet" type="text/css" />
<link href="../css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="../imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->

<script src="../scripts/jquery.ui.core.js"></script>
<script src="../scripts/jquery.ui.widget.js"></script>
<script src="../scripts/jquery-1.9.1.js"></script>
<script src="../scripts/jquery.ui.datepicker.js"></script>
<script src="../scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	
<style>
	.ui-datepicker {
		font-size:12px;
	}
	
	.datepicker{
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
		font-family: Arial,sans-serif;
		font-size: 0.8em;
	}
	
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}

	.ui-menu .ui-menu-item a{
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
		font-family: Arial,sans-serif;
		font-size: 0.8em;
	}
	
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	
	.ui-menu .ui-menu-item a{
		height:14px;
		font-size:13px;
	}

	.ui-autocomplete {
		height:200px;
		overflow-y:scroll;
		overflow-x:hidden;
	}
</style>    
<!-- efeito da janela de ajuda -->


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
</head>


<body>
	<div class="teste">
		<!--fundo azul do meio-->
  		<? include 'topo.php'; ?>
		<div class="corposite">
  			<!--corpo-->
  			<div class="container">
    			<div class="conteudo2">
     				<!-- <div class="titulosModulos" ><span >ESTOQUE</span> </div>  -->
      				<p>
      					<div id='cssmenu' >
        					<ul>
    							<li class='active'><a href='demanda_solicitar.php'><span>Solicitar Demanda</span></a></li>
								<li ><a href='demanda_consultar.php'><span>Consultar Demanda</span></a></li>
								<li ><a href='demanda_manter.php'><span>Manter Demandas</span></a></li>
     						</ul>
        	 	 		</div>
          			</p>
          
          			<div id='submenu'>
            			<ul>
              				<!--<li><a href='#'><span>Ajuda</span></a></li>-->
            			</ul>
          			</div>
     	
       				<?   // o conteudo vai aqui    ?> 
       
        			<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          				<legend><span class="titulos" >Solicitar Demanda</span></legend>
          
          				<select>
        			</fieldset>  
    			</div>
  			</div>
  			<!--fim do corpo-->
            
  			<?   include 'rodape.php'  ?>
		</div>
	</div>
	<!--teste-->
</body>
</html>