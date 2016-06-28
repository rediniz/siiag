<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
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
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="jquery\jquery-ui-1.10.3.custom\development-bundle\themes\base\jquery.ui.all.css" />
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.mousewheel.js"></script>
<script src="scripts/globalize.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery.ui.button.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
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
<script>
	$(function() {
		$( ".spinner" ).spinner();
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
              <li class='active'><a href='jornada.asp'><span>Solicitar</span></a></li>
              <li ><a href='consultar_jornada.asp'><span>Consultar</span></a></li>
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
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Solicitar Mudan&ccedil;a de Jornada</span></legend>
          <p class="paragrafoteste">
            <label>Colaborador:</label>
            <input class="form-field" name="colaborador_matricula" id="colaborador_matricula" type="text" size="7" maxlength="7" />
            <input class="form-field" name="colaborador_nome" id="colaborador_nome" type="text" size="50" maxlength="70" />
            <br/>
            <br/>
            <label>Hora de Entrada:</label>
            <input style="width:20px;height:20px;font-size:14px;" class="spinner" id="spinner"  name="hora_entrada">
            <label>Hora de Sa&iacute;da</label>
            <input style="width:20px;height:20px;font-size:14px;" class="spinner" id="spinner"  name="hora_saida">
            <label>Intervalo:</label>
            <input style="width:20px;height:20px;font-size:14px;" class="spinner" id="spinner"  name="intervalo_de">
            <label>a:</label>
            <input style="width:20px;height:20px;font-size:14px;" class="spinner" id="spinner"  name="intervalo_a">
            <br/>
            <br/>
            <label>A partir de:</label>
             <input  name="data_fim" id="data_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>
          </p>
          <input  name="incluir" class="myButton" type="button" value="Salvar" />
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
