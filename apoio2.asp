<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <title>Apoio</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <meta name="description" content="Flexible Slide-to-top Accordion" />
        <meta name="keywords" content="accordion, jquery, flexible, responsive, slide to top, tabs, UI, web design" />
        <meta name="author" content="Codrops" />
        
        <link rel="stylesheet" href="estilo.css" type="text/css"/>
        
        <link rel="shortcut icon" href="../favicon.ico"> 
        
        <link rel="stylesheet" type="text/css" href="css/demo.css" />
        
        <link rel="stylesheet" href="estilo.css" type="text/css"/>
        
        <link rel="stylesheet" type="text/css" href="css/style.css" /> <!-- estilo das tabs -->
        
        <link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet"> <!-- css do datepicker -->
        
        <link href="botao_azul.css" rel="stylesheet" type="text/css" /> <!-- css do botao azul -->
        
        <link href="tabela.css" rel="stylesheet" type="text/css" />
		<link href="menu.css" rel="stylesheet" type="text/css" />
      
        
		<script src="js/jquery-1.9.1.js" type="text/javascript"></script>
		<script src="js/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/jquery.accordion.js"></script>
		<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
        <script src="scripts/jquery.ui.core.js"></script>
		<script src="scripts/jquery.ui.widget.js"></script>
        <script src="scripts/jquery.ui.datepicker.js"></script>
        <script src="js/jquery.ui.tabs.js"></script>
        
		<script>
            $(function() {
                $( "#tabs" ).tabs();
            });
            
            $(function() {
                $( "#tabs_2" ).tabs();
            });
        </script>
     
        
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<noscript>
	<style>
    .st-accordion ul li{
    height:auto;
    }
    .st-accordion ul li > a span{
    visibility:hidden;
    }
                
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
    
    .edit{
        width:2px;
        height:2px;
    }
    
    </style>
</noscript>
        
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
  
<script type="text/javascript">
	$(function() {
	
		$('#st-accordion').accordion({
			oneOpenedItem	: true
		});
		
	});
</script> 
        

        
<script>
	$(function() {
		$( "#pesquisarAniversariantes" ).click(function(){
		$.ajax({
				type: "POST",
				contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001",
				url: 'apoio/consulta2.asp',
				data:  {
				data_inicio: $("#data_inicio").val(),
				grupo : $("#grupo").val()
				},
				dataType: "html",
				success: function (data) {
					$("#appPesquisa").html(data);
            	},			    
  			});
		});
	});
	
</script>     

</head>
<body>
    
<div class="teste2"> <!-- class="teste" -->
   
  <!--fundo azul do meio-->
  <!-- fazendo o include do topo aqui -->
  
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite"><!-- class="corposite"> -->
    <!--corpo-->
    <div class="container2"> <!-- class="container2" -->
      <div class="conteudo2" style="height:auto;" > <!-- class="conteudo2" -->
 <!--   <div class="titulosModulos" ><span >APOIO</span> </div> -->
    
       <div class="wrapper"> <!--  class="wrapper" -->
       
                <div id="st-accordion" class="st-accordion"> <!-- st-accordion" class="st-accordion" -->
                
                
                
                    <ul> <!-- COMEÇO DA LISTA DE MENUS-->
                        <li>
                        
                            <a class="listasOpcoes" href="#">Anivers&aacute;rios<span class="st-arrow">Open or Close</span></a>
                            <div class="st-content" style="height:auto;border:#000000 solid 1px;width:auto;">
                            
                            <table width="650" height="auto" border="0" align="center" cellpadding="0">
                              <tr>
                                <td colspan="4"><h3 style="font-family: 'Futura', Arial, sans-serif; font-size:14px;margin-top:0px;margin-left:35%;margin-bottom:5%;">Enviar Cart&atilde;o de Anivers&aacute;rio</h3></td>
                             
                              </tr>
                              <tr>
                                <td><input name="data_inicio" id="data_inicio" class="datepicker" type="text"/></td>
                                <td><select class="form-select" id="grupo"> 
                                                            
                                <option value="1">Todos os Aniversariantes</option>
                                <option value="0">Apenas os n&atilde;o enviados</option>
                                                                
                                 </select></td>
                                <td><input name="pesquisar" id="pesquisarAniversariantes" class="myButton" type="button" value="Pesquisar"  style="width:auto;"/></td>
                                <td><input name="enviarCartao" class="myButton" type="button" value="Enviar Cart&atilde;o" onClick="enviarCartao();" style="width:auto;"/></td>
                              </tr>
                            </table>
                            
                        	<div id="appPesquisa" class="tabela" align="center"  style="height:auto;"></div>
                            	                  
                            </div>
             
                        </li>
                        
                         
                            
                        <li><a class="listasOpcoes" href="#">Agenda<span class="st-arrow">Open or Close</span></a>
                            <div class="st-content" style="min-height:1000px;">

          						<div id="tabs" style="font-size:13px;font-family: 'Futura', Arial, sans-serif;"> 
                                   
                                    <ul>
                                        <li><a href="#tabs-1">Aniversariantes</a></li>
                                        <li><a href="#tabs-2">Aniversariantes CAIXA</a></li>
                                        <li><a href="#tabs-3">Eventos</a></li>
                                        <li><a href="#tabs-4">Destacamentos</a></li>
                                        <li><a href="#tabs-5">F&eacute;rias</a></li>
                                        <li><a href="#tabs-6">Aus&ecirc;ncias</a></li>
                                        <li><a href="#tabs-7">Visualizar Agenda</a></li>
                                        
									</ul>
                                    
                               <div id="tabs-1">
                               <!-- #INCLUDE FILE="apoio/aniversariantes.asp" -->  
                               </div>
                                
                                <div id="tabs-2">                        
                                <!-- #INCLUDE FILE="apoio/aniversariantesCaixa.asp" -->       
                                </div>
                                
                                <div id="tabs-3">
                                <!-- #INCLUDE FILE="apoio/eventos.asp" -->        
                                </div>
                                
                                
                                <div id="tabs-4">
                                <!-- #INCLUDE FILE="apoio/destacamentos.asp" -->      
                                </div>
                                
                                
                                <div id="tabs-5">     
                                <!-- #INCLUDE FILE="apoio/ferias.asp" -->                  
                                </div>
                                
                                
                                <div id="tabs-6">     
                                <!-- #INCLUDE FILE="apoio/ausencias.asp" -->                    
                                </div>
                                
                                <div id="tabs-7">         
                                <!-- #INCLUDE FILE="apoio/visualizarAgenda.asp" -->                        
                                </div> 
                                
          			 </div> <!-- Fecha Tabs -->		    
                    </div> <!-- Fecha st-content -->
                    
                    
                    
                   <li><a class="listasOpcoes" href="#">Pend&ecirc;ncias<span class="st-arrow">Open or Close</span></a>
                    	 <div class="st-content" style="min-height:1000px;">

          						<div id="tabs_2" style="font-size:13px;font-family:'Futura', Arial, sans-serif;width:98%;">
                         	
                                    <ul>
                                        <li><a href="#tabs-8">Destacamentos</a></li>
                                        <li><a href="#tabs-9">F&eacute;rias</a></li>
                                        <li><a href="#tabs-10">Jornada</a></li>
                                        <li><a href="#tabs-11">Afastamentos</a></li>
                                        <li><a href="#tabs-12">Eventos</a></li>
                                        <li><a href="#tabs-13">Empr&eacute;stimos</a></li>
                                        <li><a href="#tabs-14">Substitui&ccedil;&atilde;o</a></li>
                                        <li><a href="#tabs-15">Estoque</a></li>
                                        <li><a href="#tabs-16">Vis&atilde;o Unificada</a></li>
                                    </ul>
                					
                                    
                                    <div id="tabs-8">
								    <!-- #INCLUDE FILE="apoio/pend_Destacamento.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-10">
								    <!-- #INCLUDE FILE="apoio/pend_Jornada.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-9">
								    <!-- #INCLUDE FILE="apoio/pend_Ferias.asp" -->  
                                    </div>
                                    
                                    
                                    
                                    <div id="tabs-11">
								    <!-- #INCLUDE FILE="apoio/pend_Afastamento.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-12">
								    <!-- #INCLUDE FILE="apoio/pend_Eventos.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-13">
								    <!-- #INCLUDE FILE="apoio/pend_Emprestimo.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-14">
								    <!-- #INCLUDE FILE="apoio/pend_Substituicao.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-15">
								    <!-- #INCLUDE FILE="apoio/pend_Estoque.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-16">
								    <!-- #INCLUDE FILE="apoio/pend_Unifacada.asp" -->  
                                    </div>
                                    
                                    
                                    
                                 </div>
                           </div>
                   </li> 
                            
            
      
                    </ul><!-- FIM DA LISTA DE MENUS-->
                    
                    
                    
                </div><!-- FIM DO st-accordion" class="st-accordion" -->
                
            </div> <!--  FIM class="wrapper" -->
            
            
        </div><!-- class="conteudo2" -->
        
   </div><!-- class="container2" -->
   
  </div> <!-- FIM class="corposite" -->
  
  <!--fim do corpo-->
  
  <!-- #INCLUDE FILE ="rodape.asp" -->
  
</div> <!-- class="teste" -->


</body>
</html>