<%@LANGUAGE="VBScript" CODEPAGE="65001"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Demanda</title>
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
	
	span{color:blue;}
	
	
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
		$('#btnSolicitar').on('click',function(){
			var tipoDemanda = $("#tipoDemanda").val();
			//var nomeApp = $("#nomeApp").val();
			var AplicativoNovo =  $("#AplicativoNovo").val();
			var descricao = $("#descricao").val();
			var matricula =$("#matricula").val();
			var codigoApp = $("#aplicativo").val();
			//alert(codigoApp);
	
			//alert(tipoDemanda);
			//alert(nomeApp);
			//alert(descricao);
			//alert(matricula);		
			//window.location.assign("demanda_solicitar_con.php");
	
			form.submit();
		});
	});
</script>

<script>
	$(document).ready(function() {
		$('#tipoDemanda').on('change',function(){
	
			var codigo = $("#tipoDemanda").val();
		
				if (codigo==1){
					document.getElementById('label1').style.display = "";
					document.getElementById('td1').style.display = "";
					document.getElementById('AplicativoNovo').style.display = "";
					document.getElementById('label2').style.display = "none";
					document.getElementById('aplicativo').style.display = "none";
				}
				
				else{
					document.getElementById('label2').style.display = "";
					document.getElementById('aplicativo').style.display = "";
					document.getElementById('td1').style.display = "none"
					document.getElementById('label1').style.display = "none";
					document.getElementById('AplicativoNovo').style.display = "none";
				}
		});
	});
	
</script> 

<script>
	$(document).ready(function(){
		$('#nomeSugerido').hide();
		$('#tipoDemanda').on('change', function(){
			var tipoDemanda = $('#tipoDemanda').val();
			
			if (tipoDemanda==1){
				//alert('certo');
				$('#nomeSugerido').show();	
				$('#nomeApp').hide();
				//$('#aplicativo').hide();
				//$('#nomeApp').html("<td><label> Nome sugerido : </label></td> <td><input type='text' class='form-field' style='max-width:200px; min-width:200px;' /></td>");	
				
			} else{	
				$('#nomeSugerido').hide();	
				$('#nomeApp').show();
				//$('#aplicativo').show();
			}
			//alert(tipoDemanda);
		});	
	});
</script>

<script>
$(document).ready(function(){
	
	$('#btBotao').click(function(){
	
	  var cont=0;
	
		$('.jander').each(function(){
			cont++;
			alert(cont+' - '+$(this).parent().find('.elem1').html());
		
		
		});
	
	
	});
	
	
	
	
	$('.baixo').click(function(){
	
		var row = $(this).closest('tr');
		console.log(row);
		
		row.insertAfter(row.next());
		
	
		
		// InsertBefore(row.prev()) para o anterior
		//insertAfter(row.Next()) para o proximo
	
	});
	$('.cima').click(function(){
	
		var row = $(this).closest('tr');
		console.log(row);
		
		row.insertBefore(row.prev());
		
		
		// InsertBefore(row.Prev()) para o anterior
		//insertAfter(row.Next()) para o proximo
	
	});
	

});
</script>
</head>


<body>
	<div class="teste">
		<!--fundo azul do meio-->
		
        <!-- #INCLUDE FILE ="topo.asp" -->
       
        
        <div class="corposite">
            <!--corpo-->
            <div class="container">
                <div class="conteudo2">
       
                   <table>
                   		<tr>
                   			<td class="elem1">Elemento 1 </td>
                            <td class="jander" data-pos="0" data-category="1">
                            	<span class="cima"><img src="imagens/setacima.png" /></span>
                            	<span class="baixo"><img src="imagens/setabaixo.png" /></span>
                            </td>
                         </tr>
                         
                         
                         <tr>   
                            <td class="elem1">Elemento 2 </td>
                            <td class="jander" data-pos="1" data-category="1">
                            	<span class="cima"><img src="imagens/setacima.png" /></span>
                                <span class="baixo"><img src="imagens/setabaixo.png" /></span>
                            </td>
                         </tr>
                         
                         <tr>   
                            <td class="elem1">Elemento 3 </td>
                            <td class="jander" data-pos="1" data-category="1">
                            	<span class="cima"><img src="imagens/setacima.png" /></span>
                            	<span class="baixo"><img src="imagens/setabaixo.png" /></span>
                            </td>
                         </tr>   
                   </table>
      
                   
    			<input type="button" class="myButton" value="mostrar" id="btBotao" />
                 
                </div>    
            </div>
            <!--fim do corpo-->
            
              <!-- #INCLUDE FILE ="rodape.asp" -->
        </div>
    </div>
    <!--teste-->
</body>
</html>