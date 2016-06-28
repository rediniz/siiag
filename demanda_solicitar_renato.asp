<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/conexao_sr001.asp" -->
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
</head>


<body>
	<div class="teste">
		<!--fundo azul do meio-->
		
        <!-- #INCLUDE FILE ="topo.asp" -->
        
        <div class="corposite">
            <!--corpo-->
            <div class="container">
                <div class="conteudo2">
                <!-- <div class="titulosModulos" ><span >ESTOQUE</span> </div>  -->
                    <p>
                        <div id='cssmenu' >
                            <ul>
                                <li class='active'><a href='demanda_solicitar.asp'><span>Solicitar Demanda</span></a></li>
                                <li ><a href='demanda_consultar.asp'><span>Consultar Demanda</span></a></li>
                                <!--<li ><a href='demanda_manter.php'><span>Manter Demandas</span></a></li>-->
                            </ul>
                        </div>
                    </p>
      
                    <div id='submenu'>
                        <ul>
                            <!--<li><a href='#'><span>Ajuda</span></a></li>-->
                        </ul>
                    </div>
    
                    <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
                        <legend><span class="titulos" >Solicitar Demanda</span></legend>
                        <table border="0">
                            <form action="demanda_solicitar_con.asp" method="post">
                                <tr> <!-- abre tipos -->
                                    <td> <label>Tipos: </label></td>
  
                                    <td><select class="form-select" id="tipoDemanda" name="tipoDemanda" style="max-width:213px; min-width:213px;">
                                        <option value="0">Escolha o Tipo de Demanda</option>
                                           
                                            <%  

												strQuery = "SELECT * FROM TB_DEMANDAS_TIPOS"
												
												set rs=Server.CreateObject("ADODB.RecordSet")
												rs.Open strQuery, dados_sys
                                                DO WHILE (NOT rs.eof)										
												
										 		RESPONSE.Write "<option value='"&rs("CO_TIPO")&"'>"&rs("NO_TIPO")&"</option>"
								  
								   		 		rs.movenext
												LOOP
                                                
                                    			
                                               
                                            %> 
                                            
                                        </select>   
                                    </td>
                                </tr> <!-- fecha tipos -->
                            
                                <tr>
                                     	   <td id="label1" style="display:none" ><label> Nome Sugerido: </label></td> <td id="td1" style="display:none"><input id = "AplicativoNovo" name = "AplicativoNovo" type='text' class='form-field' style='max-width:200px; min-width:200px; display:none;' /></td>  

                                            <td id="label2" style="display:none" ><label>Nome do Aplicativo: </label></td>
                                  
                                            <td><select id="aplicativo" name="aplicativo" class="form-select" style="max-width:213px; min-width:213px; display:none;">
                                 
                                            <option value="0">Selecione o Aplicativo</option>
                                            
                                         
                                          <%
										  
										  set objConn = 	server.CreateObject("ADODB.Connection") 
	dados_sys = 	"Provider=sqloledb;Data Source=CE7180sr001;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
	objConn.open dados_sys
										  strQueryApp = "SELECT CO_APLICATIVO, NOME from TB_APLICATIVOS ORDER BY NOME"
										  set rsApp=Server.CreateObject("ADODB.RecordSet")
										  rsApp.Open strQueryApp, dados_sys
										  DO UNTIL rsApp.eof
			
										 RESPONSE.Write "<option value='"&rsApp("CO_APLICATIVO")&"'>"&rsApp("NOME")&"</option>"
										  rsApp.movenext
										  LOOP
										  
										  %>
                                              
                                            </select></td>
                                       
                                    </tr>
                             
                                    <!--   <tr id="nomeSugerido"><td><label> </label></td> <td><input type='text' class='form-field' style='max-width:200px; min-width:200px;' /></td></tr>  -->
  
                                    <!--<tr><td><div id="novoApp_Container"> </div></td></tr>-->
                            
                                    <tr>
                                        <td><label>Descri&ccedil;&atilde;o:</label></td>
                                        <td><textarea class="form-select" name="descricao" id="descricao" cols="50" rows="5" style="max-width:200px; min-width:200px; max-height:80px; min-height:80px;"></textarea> </td>
                                    </tr>
  
                                    <tr> <td>&nbsp;  </td> </tr>
  
                                    <tr>
                                        <td colspan="2"><input type="submit" class='myButton' name="btnSolicitar" id="btnSolicitar" value="Solicitar" style="margin-left:35%;"/></td>
                                    </tr>
                                <!--<input type="hidden" value="<? echo $_COOKIE['co_usuario_siiag']; ?>" id="matricula" />-->
                            </form>
                        </table>
                    </fieldset>  
                </div>    
            </div>
            <!--fim do corpo-->
            
              <!-- #INCLUDE FILE ="rodape.asp" -->
        </div>
    </div>
    <!--teste-->
</body>
</html>