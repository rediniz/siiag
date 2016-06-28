<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Mudan&ccedil;a</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.mousewheel.js"></script>
<script src="scripts/globalize.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery.ui.button.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.timepicker.js"></script>
<script src="scripts/jquery.ui.mask.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

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

.ui-mask ui-spinner-input {

font-size:16px;

}
</style>

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

</style>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete({
					
					source: "autocompletar_nome2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#digito" ).val( ui.item.digito);
					$( "#matricula" ).val( ui.item.matricula);					
					return false;
					}
				  });
 
 					$("#matricula").focus().autocomplete({
					
					source: "autocompletar_matricula2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#digito" ).val( ui.item.digito);
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

    
    	<script>
	$(function() {
		$("#culture").change(function() {
			$( "input" ).timepicker( "option", "culture", $( this ).val() );
		});
		function setup() {

			$("#horario_inicio").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#horario_fim").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#intervalo_inicio").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#intervalo_fim").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
		}
		setup();
	});
	</script>
    
<script type="text/javascript">
	$(document).ready(function() {
	
		//$("#carregando").hide();
		
		$(document).on("click", "#solicitar", function() {
		
		if($("#perfil_jornada").val()=="False"){
			alert("Você não tem permissão para solicitar mudança de jornada.")
		return false;
	}
	
	if($("#matricula").val()=="" || $("#nome").val()==""){
		alert("Informe matrícula e nome do usuário.");
		return false;
	}
	if($("#data").val()==""){
		alert("Informe a data.");
		return false;
	}
		
		
      		$.ajax({
		
       			data: $("#formulario").serialize(), // DADOS A SEREM PASSADOS PARA O SERVIDOR
       			url: "jornada_inclusao.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        			//$("#carregando").show(); 
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		//$("#carregando").hide();  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			alert("Jornada alterada com sucesso."); 	  
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao alterar jornada.");  
 				}
		
      		})
  
		});
	
	});
 
</script>

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
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<%
  
  Perfil_Acesso("4") 
  response.write "<input type='hidden' id = 'perfil_jornada_consultar' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_jornada_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
   
  if not  perfil_acesso_admin_siiag then
  
  	response.Redirect ("consultar_jornada.asp")
    
  end if

%>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >JORNADA</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <%			
			  if perfil_acesso_admin_siiag then
              	response.write "<li class='active'><a href='jornada.asp'><span>Solicitar</span></a></li>"
			  	response.write "<li><a href='consultar_jornada.asp'><span>Consultar</span></a></li>"			  
			  else
			  	response.write "<li class='active'><a href='consultar_jornada.asp'><span>Consultar</span></a></li>"			  
			  end if			
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!--<li id="opener"><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>
          
          <!--<div id="dialog" title="Caixa de Ajuda">
            <p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
          </div>-->
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Solicitar Mudan&ccedil;a de Jornada</span></legend>
          <p class="paragrafoteste">
          <form  id="formulario" name="formulario" action="jornada_inclusao.asp">
          <table>
          <tr>
          <td><label>Colaborador:</label> </td>
          <td><input class="form-field" name="matricula" id="matricula"  type="text" size="7" maxlength="7" />
          <Label>-<Label>
          <input class="form-field" name="digito" id="digito"  type="text" size="1" maxlength="1" />
          <input class="form-field" name="nome" id="nome"  type="text" size="50" maxlength="70" style="margin-left:10px"/> </td>
          </tr>
          <tr>
          <td><label>Hora de Entrada:</label></td>
           <td><input id="horario_inicio" name="horario_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00"/>
            <label style = "margin-left:20px; margin-right:13px">Hora de Sa&iacute;da:</label>
            <input id="horario_fim" name="horario_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00"/>
            
          </td>
            
          </tr>
          <tr>
          <td>  <label>Início do intervalo:</label></td>
            
          <td><input id="intervalo_inicio" name="intervalo_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00"/>
            <label style = "margin-left:20px" >Fim do intervalo:</label>
            <input id="intervalo_fim" name="intervalo_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00"/> </td>
          </tr>
          <tr>
          <td>  <label>A partir de:</label></td>
          <td>  <input  name="data" id="data" class="datepicker" type="text" size="8" maxlength="8" /></td>
          </tr>
          
          
           
          </p>
          </table>
          </form>
          </p>
         <button class="myButton" id="solicitar" name="solicitar" style="margin-left:8px">Solicitar</button>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
          </fieldset>
        </div>
      </div>
       <!--include do calendario-->
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
