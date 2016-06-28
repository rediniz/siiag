<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Demanda</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->

<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="scripts/jquery.ui.draggable.js"></script>
	<script src="scripts/jquery.ui.sortable.js"></script>
	
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

<script>
	$(document).ready(function() {
		$('#btnPesquisar').on('click',function(){
			//alert("deu certo");
			//var situacao = document.getElementById("situacoes").value;
			// var nome =  document.getElementById("nome").value;
			//var data_inicio = document.getElementById("data_inicio").value;
			//var data_final = document.getElementById("data_final").value;
 
			var situacao = $("#situacoes").val();
			var nomeSolicitante = $("#nomeSolicitante").val();
			var data_inicio = $("#data_inicio").val();
			var data_final =$("#data_final").val();
				
			window.location.assign("demanda_consultar.asp?situacao="+situacao+"&nomeSolicitante="+nomeSolicitante+"&data_inicio="+data_inicio+"&data_final="+data_final+"&click=1");
		});
	});
</script>

<script>
	$(document).ready(function() {
		$('#btnOrdenar').on('click',function(){
		
			//var situacao = $("#situacao").val();
			//var nomeSolicitante = $("#nomeSolicitante").val();
			//var data_inicio = $("#data_inicio").val();
			//var data_final =$("#data_final").val();
			
			//window.location.assign("demanda_ordenacao.php?situacao="+situacao+"&data_inicio="+data_inicio+"&data_final="+data_final+"&click=1");
			//var top = (window.innerHeight / 4) +80;
			//var left = (window.innerWidth / 4) -60;
			//window.open("demanda_ordenacao.php?situacao="+situacao+"&data_inicio="+data_inicio+"&data_final="+data_final+"", "Ordenação de Demanda", "height=280, width=400, scrollbars=yes, toolbar=no, resizable=yes, location=no, modal=yes, top="+top+", 	left="+left+"");
			
			//alert("Ordenar");
			
			document.getElementById('visuOrdenacao').style.display = "";
			document.getElementById('inputPrioridade').style.display = "";
			
 
		});
	});
</script>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
		//Ao digitar executar essa função
		$("#nomeSolicitante").focus().autocomplete({
			source: "autocompletar_nome2.asp",
			minlength: 2,
			select: function( event, ui ) {
				$( "#nomeSolicitante" ).val( ui.item.nome);				
				return false;
			}
		});
		
		
		
		
		
	});
</script>

<script type="text/javascript" language="javascript">

	
</script>

</head>
<body>
	<div class="teste2">
		<!--fundo azul do meio-->
        
		<!-- #INCLUDE FILE="topo.asp" -->
  <%
	'Chama a subrotina para verificar o perfil
	Perfil_Acesso_Cookie("12")
	if not perfil_acesso_siiag then
		response.redirect("demanda_listar.asp")
	end if	
%>   
		<div class="corposite">
			<!--corpo-->
  			<div class="container">
    			<div class="conteudo2">
                <%
				if not perfil_acesso_siiag then
					response.Write("O seu perfil não permite o acesso a este módulo")
				else
				%>                
      				<div class="titulosModulos" ><span >DEMANDAS T.I.</span> </div>
     				<!-- <div class="titulosModulos" ><span >ESTOQUE</span> </div>  -->
      				<p>
      					<div id='cssmenu' >
        					<ul>
    							<li ><a href='demanda_solicitar.asp'><span>Solicitar Demanda</span></a></li>
								<li class='active'><a href='demanda_consultar.asp'><span>Painel de Demandas</span></a></li>
								<li class='inactive'><a href='demanda_listar.asp?situacao=0&nomeSolicitante=&data_inicio=&data_final=&click=1'><span>Consultar Demandas</span></a></li>
								<!--<li ><a href='demanda_manter.php'><span>Manter Demandas</span></a></li>-->
     						</ul>
          				</div>
          			</p>
          
          			<div id='submenu'>
            			<ul>
              				<!--<li><a href='#'><span>Ajuda</span></a></li>-->
            			</ul>
          			</div>
     	
       				<?    // o conteudo vai aqui   ?> 
       
        		         
          				<br/>
          				<br/>
          				<div class="tabela" >
          					<!-- #INCLUDE FILE="demanda_consultar_con.asp" -->
          				</div>
				<%END IF%>        		
    			</div>
  			</div>
  			<!--fim do corpo-->
  			<!-- #INCLUDE FILE="rodape.asp" -->
		</div>
	</div>
	<!--teste-->
</body>
</html>
