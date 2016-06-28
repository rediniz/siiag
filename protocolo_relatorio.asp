<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Usu&aacute;rio</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
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

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

<!--CSS-->
    <style type="text/css">
    <!--
        .style2 {
            font-size: 14
        }
        .style3 {
            color: #5683C4
        }
		
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

<script type="text/javascript" language="javascript"></script>
                     
			
  
 
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo_protocolo.asp" -->
 
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='protocolo.asp'><span>Inclus&atilde;o</span></a></li>
              <li><a href='protocolo_consultar.asp'><span>Consulta</span></a></li>
              <li><a href='protocolo_editar.asp'><span>Editar AR - Ofício</span></a></li>
              <li  class='active'><a href='protocolo_relatorio.asp'><span>Relat&oacute;rios</span></a></li>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Relat&oacute;rios</legend>
          <p class="paragrafoteste style2"> <span class="style4 style2">
          
          <label class="labels">Per&iacute;odo:</label><br/><br/>
        
        
        
        <label>De:&nbsp;</label>
        <input type="text" id="dataInicial" class="datepicker" onclick="ChamarLink();"> 
						

        <br/><br/>                
        <label>At&eacute;:</label>  
        <input type="text" id="dataFinal" class="datepicker" onclick="ChamarLink();"> 
                       
	 <br/><br/><br/>	
   
  
 <!--  <%Response.Write YEAR(DATE()+366)%> -->
   
   <script language="javascript">
    function ChamarLink() {
        var dataInicial = document.getElementById("dataInicial").value;
		var dataFinal = document.getElementById("dataFinal").value;
		
		
        document.getElementById("receberLink").innerHTML = "<a href='geraRelatorio.asp?dataInicial="+dataInicial+"&dataFinal="+dataFinal+"'>Gerar Relat&oacute;rio</a>";
		
    }
	


   	 
	/*var nome = "Belmondo";
			'document.write ("<a id='adicionarRecurso' href='geraRelatorio.asp?nome="+nome+"'><p> Gerar Relat&oacute;rio</p> </a>");*/
			
	</script>
    
    <div id="receberLink"></div>
   
    
    
        
        
            
            
         
         
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
