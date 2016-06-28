
<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
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
        <script src="scripts/jquery.ui.button.js"></script>
        

            <script type="text/javascript" language="javascript">

	$(document).ready(function(){
	
	
	$(".edicao").hide();
	
	$("#salvar").hide();


			});
			
	
	</script>
    

 <script>

	$(function() { 
	
	
	
		  $("#tipos").on( "change",function() {

				$.ajax({
					method: "GET",
					contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
					url: "consulta_tipos_con.asp?tipo="+$("#tipos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						$('#lista_tipos').html(data); 
						$('.bloqueio').attr("disabled", true); 
						$('#edicao').html("");
					},
					error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao pesquisar tipos.");
					}
			
				})
          });
		
		  $("#lista_tipos").on( "change",function() {
				
				$('#edicao').html(""); 
				$("#salvar").hide();
				
		   });
	
		$("#editar").on( "click",function() {
		//window.location.assign("manutencao_teste.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val());
				$.ajax({
					method: "GET",
					url: "manutencao_tipos_monta_form.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						$('#edicao').html(data); 
						$("#salvar").show();
							//$("#coordenacao_substituto").hide();
						
								$("#coordenacao_substituto").focus().autocomplete({
								
								source: "autocompletar_matricula2.asp",
								minlength: 2,
								select: function( event, ui ) {		
								
								$("#coordenacao_substituto").val(ui.item.matricula);
								$("#no_substituto").html(" - "+ui.item.nome);
									
								return false;
							}
							
							
				})
				
									$("#coordenacao_gerente").focus().autocomplete({
								
								source: "autocompletar_matricula2.asp",
								minlength: 2,
								select: function( event, ui ) {		
								
								$("#coordenacao_gerente").val(ui.item.matricula);
								$("#no_coordenador").html(" - "+ui.item.nome);
									
								return false;
							}
							
							
				})
					},
					error: function(erro){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro.");
					}		
				})
				
				
			
          });	
	
				  $("#salvar").on( "click",function() {
				    
					confirma = window.confirm("Confirmar edição?");
			  
					if(!confirma){
						return false;
					} else {
					
					//$("#edicao").append("<input type='text' class='form-field bloqueio'   id='tipo' name='tipo' size='60' value="+$("#tipos").val()+">")
//					$("#edicao").append("<input type='text' class='form-field bloqueio'   id='codigo' name='codigo' size='60' value="+$("#lista_tipos").val()+">")
//					
					//$("#formulario").submit();
					//window.location.assign("manutencao_tipos_editar_con.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val());

						$.ajax({
							method: "GET",
							url: "manutencao_tipos_editar_con.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
							data: $("#formulario").serialize(),
							dataType: "html", // TIPO DE DADOS DE RETORNO
							//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
							beforeSend: function() { // ANTES DA REQUISIÇÃO
							},
							complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
							},
							success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
								alert("Edição realizada com sucesso.");
							},
							error: function(data, error){ // CASO OCORRA ERRO NA REQUISIÇÃO
								alert("Erro na edição");
							}		
					})

			}
    });	
	});

 </script>
        
		<script>
            $(function() {
                $( "#tabs" ).tabs();
            });
            
            $(function() {
                $( "#tabs_2" ).tabs();
            });
			$(function() {
                $( "#tabs_3" ).tabs();
            });
			$(function() {
                $( "#tabs_4" ).tabs();
            });
        </script>
        
        <script>
$(document).ready(function() {

	$('.editar_substituicao').on('click',function(){
								
			var co_substituicao = $(this).parent().parent().find("#co_substituicao").val();
	
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60

			window.open("substituicao_edicao.asp?co_substituicao="+co_substituicao, "Editar Substituição", "height=500, width=600, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");

	});
	
	$('.editar_emprestimo').on('click',function(){
								
		   var co_emprestimo = $(this).parent().parent().find("#co_emprestimo").val();
									
	
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("emprestimos_edicao.asp?co_emprestimo="+co_emprestimo, "Editar Empréstimo", "height=500, width=600, scrollbars=yes, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", left="+left+"");

	});
	
	$('.editar_afastamento').on('click',function(){
			
			var codigo = $(this).parent().parent().find("#co_afastamento").val()
			
			
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("afastamento_edicao.asp?co_afastamento="+codigo+"", "Edi&ccedil;&atilde;o", "height=500, width=450, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+",left="+left+"");
						
	});
	
		$('.editar_destacamento').on('click',function(){
			
			var codigo = $(this).parent().parent().find("#co_destacamento").val()
			window.location.assign("destacamentos_edicao.asp?co_destacamento="+codigo)									
	});
	
		$('.editar_evento').on('click',function(){
			
			var codigo = $(this).parent().parent().find("#co_evento").val()
			window.location.assign("eventos_e_treinamentos_editar.asp?co_evento="+codigo)									
	});
	
		$('.editar_estoque').on('click',function(){				
			window.location.assign("estoque_pendentes.asp");							
	});
	
		$('.editar_jornada').on('click',function(){	
					
			var codigo = $(this).parent().parent().find("#co_jornada").val()		
					
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("jornada_edicao.asp?codigo="+codigo+"", "Edi&ccedil;&atilde;o", "height=400, width=620, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+",left="+left+"");							
	});
	
	$('.editar_reparo').on('click',function(){	
					
			var codigo = $(this).parent().parent().find("#co_reparo").val()		
					
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.location.assign("reparos_consultar.asp");							
	});
	
	
	
	
	

});
</script> 



 <script>

	$(function() { 
			
		  $("#tipos_cadastrar").on( "change",function() {

		//window.location.assign("consulta_tipos_con.asp?tipo="+$("#tipos").val());
					$.ajax({
				method: "GET",
       			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
       			url: "manutencao_formularios_cadastrar.asp?tipo="+$("#tipos_cadastrar").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$('#edicao_cadastrar').html(data); 
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao pesquisar tipos.");
 				}
		
      		})
    });
	
			  $(document).on( "click","#cadastrar",function() {
			  
			  confirma = window.confirm("Tem certeza que deseja cadastrar o tipo?");
			  
			  if(!confirma){
			  return false
			  } else{

				$("#formulario_cadastrar").submit();
				$.ajax({
				method: "GET",
       			url: "manutencao_tipos_cadastrar_con?tipo="+$("#tipos_cadastrar").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
				data: $("#formulario_cadastrar").serialize(),
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
       				alert("Tipo cadastrado com sucesso.");
        		},
		 		error: function(erro){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao cadastrar tipo.");
 				}		
      		})
			}
    });	
	
	});

 </script>
 
 
 
 
 <script>
$(document).ready(function() {

$('#mudaFrase').on('change',function(){
	
		
		
		//var codigoFrase = $("#mudaFrase").val();
		$('#visuAgenda').attr('src','apoio/agenda_visualizarAgenda2.asp?codFrase=' + $("#mudaFrase").val()+'&data='+$("#data").val());
		//alert(codigoFrase);
		//window.opener.location.reload();
		//alert("deu certo");
		
	});
	});
</script>  

 <script>
$(document).ready(function() {

$('#data').on('change',function(){
	
		
		
		//var codigoFrase = $("#data").val();
		//alert(codigoFrase);
		$('#visuAniversariantes').attr('src','apoio/agenda_aniversariantes.asp?data=' + $("#data").val());
		$('#visuEventos').attr('src', 'apoio/agenda_eventos.asp?dataPesquisada=' + $("#data").val());
		$('#aniversariantesCaixa').attr('src', 'apoio/agenda_aniversariantesCaixa.asp?data='+$("#data").val());
		$('#agendaDestacamentos').attr('src','apoio/agenda_destacamentos.asp?data='+$("#data").val());
		$('#agendaFerias').attr('src', 'apoio/agenda_ferias.asp?data='+$("#data").val());
		$('#agendaAusencias').attr('src', 'apoio/agenda_ausencias.asp?data='+$("#data").val());
		$('#visuAgenda').attr('src', 'apoio/agenda_visualizarAgenda2.asp?data='+$("#data").val()+'&codFrase=' + $("#mudaFrase").val());
		//$('#visuAgenda').attr('src', 'apoio/agenda_visualizar.asp?data='+$("#data").val());
		//alert(codigoFrase);
		//window.opener.location.reload();
		//alert("deu certo");
		
	});
	});
</script>  

<script> <!-- SCRIPT PARA ADICIONAR FRASE -->

$(document).ready(function() {

$('#addfrase').on('click',function(){
			
			//alert("deu certo");

			var sim=1;
			
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("cadastrar_frase.asp?cadastrar="+sim, "Cadastrar Frase", "height=280, width=510, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
						
	});
	});
	
	
</script>  




        
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
	<style>
    .st-accordion ul li{
    height:auto;
	
    }
	
    /*.st-accordion ul li > a span{
    visibility:hidden;
    }*/
	
	input{
	
	padding:0px;
	margin:0px;
	border:0px;
	width:auto;
	
	}
	
	.ui-menu .ui-menu-item a{
    height:14px;
    font-size:13px;
}
                
    .ui-datepicker {
        font-size:12px;
    }
    
	
	.ui-autocomplete {
	
	height:200px;
	overflow-y:scroll;
	overflow-x:hidden;
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
	
	//#ALTERADO em 02/12/2015 (adicionado)#
	$("#medicao").on("click", function(){
		
		window.location.assign("medicao_demandas.asp");
	});
	
	$("#log").on("click", function(){
		
		window.location.assign("log.asp");
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
<%
  Perfil_Acesso_Cookie("10")    
%>
  <div class="corposite"><!-- class="corposite"> -->
    <!--corpo-->
    <div class="container2"> <!-- class="container2" -->
      <div class="conteudo2" style="height:auto;" > <!-- class="conteudo2" -->
 <!--   <div class="titulosModulos" ><span >APOIO</span> </div> -->
   <%
   if not perfil_acesso_siiag then
		response.Write("O seu perfil não permite o acesso a este módulo")
	else
   
   %>
       <div class="wrapper" style="min-height:550px;"> <!--  class="wrapper" -->
  				<div class="titulosModulos" ><span >GERENCIAMENTO</span> </div>
       
                <div id="st-accordion" class="st-accordion"> <!-- st-accordion" class="st-accordion" -->
                    <ul> 
                        
                        <li><a class="listasOpcoes" href="#">Agenda<span class="st-arrow">Open or Close</span></a>
                            <div class="st-content" style="min-height:1500px;">

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
                               <iframe src="apoio/agenda_aniversariantes.asp" name="visuAniversariantes" id="visuAniversariantes" width="900" min-height="200px" style="border:0px solid #000000;" scrolling="no"></iframe> <!-- Ta OK -->
                               
                               <!-- #INC LUDE FILE="apoio/agenda_aniversariantes.asp" -->  
                               
                               <!--<br/>
                               <!--#INCL UDE FILE="apoio/alterna_data.asp" -->
                               </div>
                               
                               <div id="tabs-2">        
                               
                               <iframe src="apoio/agenda_aniversariantesCaixa.asp" name="aniversariantesCaixa" id="aniversariantesCaixa" width="900" min-height="200px" style="border:0px solid #000000;" scrolling="no"></iframe> <!-- Ta OK -->
                                                
                               <!-- #INCL UDE FILE="apoio/agenda_aniversariantesCaixa.asp" -->   
                                  
                               </div>
                               
                               <div id="tabs-3">
                               <iframe src="apoio/agenda_eventos.asp" name="visuEventos" id="visuEventos" width="900" min-height="200px" style="border:0px solid #000000;" scrolling="no"></iframe> <!-- Ta OK -->
                               
                               <!-- #INCLU DE FILE="apoio/agenda_eventos.asp" -->        
                               </div> 
                               
                               <div id="tabs-4">
                               <iframe src="apoio/agenda_destacamentos.asp" name="agendaDestacamentos" id="agendaDestacamentos" width="900" min-height="200px;" style="border: 0px solid #000000;" scrolling="no"></iframe>
                               
                               
                               <!-- #INCLU DE FILE="apoio/agenda_destacamentos.asp" -->  
                               </div>
                               
                               <div id="tabs-5"> 
                               <iframe src="apoio/agenda_ferias.asp" name="agendaFerias" id="agendaFerias" width="900" min-height="200px;" style="border: 0px solid #000000;" scrolling="yes"></iframe>   
                               <!-- #I NCLUDE FILE="apoio/agenda_ferias.asp" -->              
                               </div>
                       			
                                
                                
							   <div id="tabs-6">   
                               <iframe src="apoio/agenda_ausencias.asp" name="agendaAusencias" id="agendaAusencias" width="900"  style="border: 0px solid #000000; min-height:50px;" scrolling="yes"></iframe>      
                               <!-- #INCLU DE FILE="apoio/agenda_ausencias.asp" -->                   
                               </div>
                               
                               
                               
                               <div id="tabs-7" >
                               <iframe src="apoio/agenda_visualizarAgenda2.asp" name="visuAgenda" id="visuAgenda" width="900" height="600" style="border:0px solid #000000;" scrolling="yes"></iframe>         
                               <!--<iframe src="apoio/agenda_visualizar.asp" name="visuAgenda" id="visuAgenda" width="900" height="600" style="border:0px solid #000000;" scrolling="yes"></iframe> -->                
                               <!-- #INCLU DE FILE="apoio/agenda_visualizarAgenda_old.asp" -->
                                <br/>
								<br/>
                                <p>Alternar Frase:
                               <!-- #INCLUDE FILE="apoio/alterna_Frase.asp" -->
                          <!--    <a class="myButton" id="addfrase" title="Adicionar nova frase" style="height:20px; cursor:pointer;">Nova frase</a>-->
   <button type="button" id="addfrase" class="myButton" style="width:180px; margin-left:8px; font-size:12px">Adicionar frase</button><span id = "status_disp" style="font-size:16px; margin-left:8px"></span>
                                </p>
                               </div>
                               <!--#INCLUDE FILE="apoio/alterna_data.asp" -->
                               
                              
                                
          			 </div> <!-- Fecha Tabs -->		    
                    </div> <!-- Fecha st-content -->
                    
                  </li>  
                 
                 <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
                          <li><a class="listasOpcoes" href="#">Cartões de Aniversário<span class="st-arrow">Open or Close</span></a>
                    	 <div  class="st-content" style="min-height:1000px;">
							<!--#I NCLUDE FILE="apoio/alterna_data.asp" -->
                            <div align="center">
                                <!-- <table>
                                    <tr>
                                        <td>
                                            <label class="form">Data:</label>
                                        </td>
                                        <td>
                                            <input  name="data" id="dataCartao" class="datepicker form-field" type="text" size="12" maxlength="10" value="<%response.Write date()%>"/>
                                        </td>
                                        <td>
                                            <select id = "opcaoCartao" name = "opcao" class="form-select">
                                                <option value='0'>Todos os aniversariantes</option>
                                                <option value='1'>Apenas os não enviados</option>
                                            </select>
                                        </td>
                                        
                                    </tr>
                                </table>-->
                               	</div> 
                               <br /> 
                            
       						<iframe src="apoio/cartoes_aniversario.asp" name="cartoesDeAniversarios" id="cartoesDeAniversarios" width="900" height="600"  style="border: 0px;" scrolling="auto" > </iframe>
                            
                           </div>
                           
                            </li> 
                    
                   <% end if%>
                         <li><a class="listasOpcoes" href="#">Pend&ecirc;ncias<span class="st-arrow">Open or Close</span></a>
                    	 <div  class="st-content" style="min-height:1000px;">

          						<div id="tabs_2" style="font-size:13px;font-family:'Futura', Arial, sans-serif;width:98%;"   >
                         	
                                    <ul>
                                        <li><a href="#tabs-8">Destacamentos</a></li>
                                        <li><a href="#tabs-9">F&eacute;rias</a></li>
                                        <li><a href="#tabs-10">Jornada</a></li>
                                        <li><a href="#tabs-11">Afastamentos</a></li>
                                        <li><a href="#tabs-12">Eventos</a></li>
                                        <li><a href="#tabs-13">Empr&eacute;stimos</a></li>
                                        <li><a href="#tabs-14">Substitui&ccedil;&atilde;o</a></li>
                                        <li><a href="#tabs-15">Estoque</a></li> 
                                        <li><a href="#tabs-16">Todas</a></li>
                                        <li><a href="#tabs-cancelamento">Cancelamentos</a></li>
                                        
                                    </ul>
                					
                                    
                                    <div id="tabs-8">
								    <!-- #INCLUDE FILE="apoio/pend_Destacamento.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-9">
								    <!-- #INCLUDE FILE="apoio/pend_Ferias.asp" -->  
                                    </div>
                                    
                                    <div id="tabs-10">
								    <!-- #INCLUDE FILE="apoio/pend_Jornada.asp" -->  
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
                                     <!-- #INCLUDE FILE="apoio/pend_Unificada.asp" -->
                                    </div>
                                    
                                    <div id="tabs-cancelamento">
                                     <!-- #INCLUDE FILE="apoio/cancelamentos.asp" -->
                                    </div>
                                    
                                    
                                 </div>
                           </div>
                           
                            </li> 
                            
                         


                         <li><a class="listasOpcoes" href="#">Licenças TRE<span class="st-arrow">Open or Close</span></a>
                    	 <div class="st-content" style="min-height:1000px;">
                         
                         <div id="tabs_6" style="font-size:13px;font-family:'Futura', Arial, sans-serif;width:98%;">
                         
                                    
                                     <div id="tabs-20">
                                     <iframe src="manutencao_tre.asp" width="900" height="400"  style="border: #000000 solid 0px;" scrolling="yes" > </iframe>
								    <!-- #INCLU DE FILE="manutencao_tipos_editar.asp" -->  
                                    </div>
                         
                         </div> <!-- tabs_3-->
                           
                         <li><a class="listasOpcoes" href="#">Manutenção de Tipos<span class="st-arrow">Open or Close</span></a>
                    	 <div class="st-content" style="min-height:1000px;">
                         
                         <div id="tabs_4" style="font-size:13px;font-family:'Futura', Arial, sans-serif;width:98%;">
                         
                             <ul>
                                        <li><a href="#tabs-17">Editar Tipos</a></li>
                                        <li><a href="#tabs-18">Cadastrar Tipos</a></li>
                                        
                                    </ul>
                                    
                                     <div id="tabs-17">
								    <!-- #INCLUDE FILE="manutencao_tipos_editar.asp" -->  
                                    </div>
                                     <div id="tabs-18">
								    <!-- #INCLUDE FILE="manutencao_tipos_cadastrar.asp" -->  
                                    </div>
                         
                         </div> <!-- tabs_3-->

				<%if Eh_Perfil_Verificado("1") and request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
                         <li><a class="listasOpcoes" href="#">Manutenção de Permissões Perfis<span class="st-arrow">Open or Close</span></a>
                    	 <div class="st-content" style="min-height:1000px;">
                         
                         <div id="tabs_5" style="font-size:13px;font-family:'Futura', Arial, sans-serif;width:98%;">
                         
                                     <div id="tabs-19">
                                     <iframe src="manutencao_permissao_perfis_tabela.asp" width="900" height="900"  style="border: 0px;" scrolling="yes" > </iframe>
								    <!-- #INC LUDE FILE="manutencao_permissao_perfis_tabela.asp" -->  
                                    </div>
                         </div> <!-- tabs_4-->    
                         
                                              

                         
                         </div> <!-- st-content-->
                         
                         </li>
				<%end if%>
                
                 <li><a class="listasOpcoes" href="#">Manutenção de Coordenações<span class="st-arrow">Open or Close</span></a>
                    	 <div class="st-content" style="min-height:1000px;">             
                             <div id="tabs_6" style="font-size:13px;font-family:'Futura', Arial, sans-serif;width:98%;">
                             
                                         <div id="tabs-20">
                                         <iframe src="coordenacao_manter.asp" width="900" height="1600"  style="border: 0px;" scrolling="yes" > </iframe>
                                        </div>
                             </div> <!-- tabs_4-->    
                         </div> <!-- st-content-->
                         
                </li>
                
                <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
              	 <li><a class="listasOpcoes" id= "medicao" href="medicao_demandas.asp">Indicador de tempestividade</a></li>
				<%end if %>
                 
                <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
                	<li><a class="listasOpcoes" id= "log" href="log.asp">LOG de Ocorrências</a></li>
				<%end if %>


            
      
                    </ul><!-- FIM DA LISTA DE MENUS-->
                    
                    
                    
                </div><!-- FIM DO st-accordion" class="st-accordion" -->
                
            </div> <!--  FIM class="wrapper" -->
            
<%
	end if
%>            
        </div><!-- class="conteudo2" -->
        
   </div><!-- class="container2" -->
   
  </div> <!-- FIM class="corposite" -->
  
  <!--fim do corpo-->
  
  <!-- #INCLUDE FILE ="rodape.asp" -->
  
</div> <!-- class="teste" -->


</body>
</html>