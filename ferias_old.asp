<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
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
<title>Solicitar F&eacute;rias</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
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

</style>

<style>
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

.alinhador{
/*border:#000000 solid 1px;*/
width:351px;




}
.datepicker1 {			
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
</style>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete({
					
					source: "autocompletar_nome2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#matricula" ).val( ui.item.matricula);					
					return false;
					}
				  });
 
 					$("#matricula").focus().autocomplete({
					
					source: "autocompletar_matricula2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#matricula" ).val( ui.item.matricula);				
					return false;
					}
				  });
 
			});
			
	
	</script>
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
<script src="scripts/jquery.ui.core.js"></script>
<!-- efeito da janela de ajuda -->
<script>
	$(function() {
		$( "#dialog" ).dialog({
			autoOpen: false,
			show: {
				effect: "blind",
				duration: 1000
			},
			hide: {
				effect: "explode",
				duration: 500
			}
		});

		$( "#opener" ).click(function() {
			$( "#dialog" ).dialog( "open" );
		});
	});
	</script>
    
 <script>
 
 
 
 function habilitaDias()		
	{
		var ativo = document.getElementById("1").value;
		//alert(tipoProtocolo);
		
		//alert(ativo);	
			if (ativo == 1){
			
				$("#quantDias").prop("disabled", false);
				 
			}else{
				$("#quantDias").prop("disabled",true);
	
			}
		}
		
	
 
 </script>   
    
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='ferias.asp'><span>Solicitar</span></a></li>
              <li ><a href='consultar_ferias.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li id="opener"><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <div id="dialog" title="Caixa de Ajuda">
            <p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
          </div>
          
          
        
          
          <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos" >Solicitar F&eacute;rias</span></legend>
          <table width="653" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="129"><span class="alinhador">
                <label>Usu&aacute;rio:</label>
              </span></td>
              <td width="524"><span class="alinhador">
                <input class="form-field" name="matricula" id="matricula" type="text" size="10" maxlength="7" />
                <label>Nome:</label>
                <input style="margin-top:5px;" class="form-field" name="nome" id="nome" type="text" size="41" maxlength="100" />
              </span></td>
            </tr>
            <tr>
              <td><span class="alinhador">
                <label></label>
              </span></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><span class="alinhador">
                <label>In&iacute;cio das F&eacute;rias:</label>
              </span></td>
              <td><span class="alinhador">
                <input  style="margin-top:5px;" name="data_inicio" id="data_inicio" class="datepicker1" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>
                <label>Gozo:</label>
                <input  class="form-field" name="quantidade2" type="text" size="6" maxlength="2" />
</span></td>
            </tr>
            <tr>
              <td><span class="alinhador">
                <label>Abono:</label>
              </span></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
          <p>&nbsp;</p>
          </p>
          
          <div class="alinhador"> <!--comeco alinhador -->  
          
          
          <label></label>
          <br/>
          
          <label></label>
          <br/>
          
          <label></label>
          <label></label>
          <br/>
          
          <label></label>
          <label>
          <input type="radio" style="margin-top:10px;margin-left:0px;" name="RadiodoAbono"  id="1" value="1" id="RadiodaJornada_0" checked="checked"/>
          N&atilde;o
          </label>
          
          <label>
          <input type="radio" style="margin-left:0px;" name="RadiodoAbono"  id="RadiodaJornada_1"  onclick="javascript:habilitaDias();"/>
          Sim
          </label>
          
          <label>Quantº de Dias:</label>
          
          <input style="margin-left:1px;" class="form-field" name="quantidade" id="quantDias" type="text" size="1" maxlength="3" disabled="disabled" />
          
         
          <label>
          <p style="margin-left:4px;">Observa&ccedil;&atilde;o:</p>
          </label>
          <!--  <input class="form-field" name="quantidade" type="t size="50" maxlength="100" />    -->
          <textarea  class="form-field" name="observacoes" cols="50" rows="5" style="max-width:318px;min-width:318px;max-height:100px;min-height:100px;"></textarea>
          
         <br/> 
            <input style="margin-top:7px;margin-left:31%;" name="incluir" class="myButton" type="button" value="Solicitar" />
          
          
          </div> <!--fecha alinhador -->
          
          </fieldset>
          
        
          
          
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
