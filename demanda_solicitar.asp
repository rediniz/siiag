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
			
			if (tipoDemanda == "0"){
				alert("Informe o tipo de demanda.");
				return false;
			}
			if (tipoDemanda == "1" && AplicativoNovo == ""){
				alert("Informe o nome do novo aplicativo.");
				return false;
			}
			if ((tipoDemanda == "3" || tipoDemanda == "2") && codigoApp == "0"){
				alert("Informe o aplicativo.");
				return false;
			}
			if (descricao == ""){
				alert("Informe a descrição da demanda.");
				return false;
			}

			//return false;
			//form.submit();
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
$(function() {
	
		var qtde = 1;
	$( document ).on("click", "#addArquivo", function(){
		var confirma = window.confirm("Deseja adicionar outro arquivo?");
		
		if(confirma){
			qtde = qtde + 1;
			$("#arquivos").append("<p style='padding-bottom:0px'/><input type='file' class='arquivo' id='arquivo"+qtde+"' name='arquivo"+qtde+"' />");
			$("#qtd_arquivo").val(qtde);
		}
		else
		{
			return false;
		}
		//alert($("#arquivo2").val());
	});
	
});

</script>
</head>


<body>
<form action="demanda_solicitar_con.asp" method="post" enctype="multipart/form-data">
	<div class="teste2">
		<!--fundo azul do meio-->
		
        <!-- #INCLUDE FILE ="topo.asp" -->
<%
	'Chama a subrotina para verificar o perfil
	'Perfil_Acesso("12")
	Perfil_Acesso_cookie("12")
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
                <!-- <div class="titulosModulos" ><span >ESTOQUE</span> </div>  -->
      				<div class="titulosModulos" ><span >DEMANDAS T.I.</span> </div>
                    <p>
                        <div id='cssmenu' >
                            <ul>
                                <li class='active'><a href='demanda_solicitar.asp'><span>Solicitar Demanda</span></a></li>
                                <li ><a href='demanda_consultar.asp'><span>Painel de Demandas</span></a></li>
                                <li ><a href='demanda_listar.asp?situacao=0&nomeSolicitante=&data_inicio=&data_final=&click=1'><span>Consultar Demandas</span></a></li>
                                
                                
                                
                                
                              
                                <!--<li ><a href='demanda_manter.php'><span>Manter Demandas</span></a></li>-->
                            </ul>
                        </div>
                    </p>
      
                    <div id='submenu'>
                        <ul>
                            <!--<li><a href='#'><span>Ajuda</span></a></li>-->
                        </ul>
                    </div>
    
                    <fieldset class="testess" style="border:#FFCC66 1px solid; border-radius:4px; min-height:430px;">
                    <!-- #INC LUDE FILE ="include/conexao_sr001.asp" -->
                        <legend><span class="titulos" >Solicitar Demanda</span></legend>
                        <table border="0">
                         

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
                                        <td><textarea class="form-select" name="descricao" id="descricao" cols="100" rows="10" style="max-width:400px; min-width:400px; max-height:80px; min-height:80px;"></textarea> </td>
                                    </tr>
  
                                    <tr> <td>&nbsp;  </td> </tr>
                                    <tr>
                                    	<td colspan="2">
                                        <!--<div align="center"> -->
                                        <p/>
                                        <label>Anexar arquivos:&nbsp;</label>
                                        <div  style="background-color:#F1f1f1; width:500px; border-radius: 4px;" >
                                            <p/>
                                            
                                            <p/>
                                            <p style='color:red; font-size: 12px'>*O processo de envio de arquivos pode demorar alguns minutos.</p>
                                           <p style='color:red; font-size: 12px'>*Arquivos de imagem devem estar no formato .JPG ou .PNG.</p>
                                                <div id="arquivos" align="center">
                                                    <input type="file" class = "arquivo" id="arquivo1" name="arquivo1">
                                                    <input type="hidden" id="qtd_arquivo" name="qtd_arquivo" value="1" />
                                                    <input type="hidden" id="data" name="data" disabled="disabled" value="<% date() %>">
                                                </div>
                                            
                                            </p>
                                            <label id="addArquivo" style="cursor:pointer"><img src="imagens\add_16x16.png" /> Adicionar outro arquivo</label>
                                            </p>
                                            </p>
                                        </div>       
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><input type="submit" class='myButton' name="btnSolicitar" id="btnSolicitar" value="Solicitar" style="margin-left:35%;"/></td>
                                    </tr>
                                <!--<input type="hidden" value="<? echo $_COOKIE['co_usuario_siiag']; ?>" id="matricula" />-->  </table>
                            </form>
                      
                    </fieldset>
                  <%end if%>  
                </div>    
            </div>
            <!--fim do corpo-->
            
              <!-- #INCLUDE FILE ="rodape.asp" -->
        </div>
    </div>
    <!--teste-->
</body>
</html>