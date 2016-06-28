<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Mudan&ccedil;as</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
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


<script type="text/javascript" language="javascript">

	$(document).ready(function(){
		
	  $(document).on("click",".cancelar", function(){
		  $("#divCancelamento" ).dialog({
			  modal: true,
			  dialogClass: "dialogo",
			  closeText: "Fechar",
			  width:'auto'
		  });
		  $("#codigoCancelamento").val( $(this).parent().parent().find("#codigo").html());
		  $("#divCancelamento").dialog("open");
	  });
	  
	  $('#botaoCancelar').on("click", function(){
		  if(window.confirm("Confirmar pedido de cancelamento?")){
			  var codigo = $("#codigoCancelamento").val(),
				  motivo = $("#motivoCancelamento").val();
			  
			  if(motivo == ""){
				  alert("Informe o motivo do cancelamento.");
				  return false;
			  }
			  
			  $.ajax({
				  url: "cancelar_demanda.asp",
				  data:{
					  tipo:"jornada",
					  codigo:codigo,
					  motivo:motivo
				  },
				  success: function(data) {
					  alert("Solicitação de cancelamento concluída com sucesso.");
				  },
				  error: function(data) {
					  console.log(data.responseText);
					  alert("Erro ao solicitar cancelamento.");
				  }
			  });
		  }
	  });
	
		
	$(document).on('click',".edit", function(){
			var co_situacao = $(this).parent().parent().find("#co_situacao").val()		
			
			if($("#perfil_jornada_editar").val()=="False"){
				alert("Você não tem permissão para editar.");
				return false;
			}					

			if(co_situacao != "1" && $("#consultaTodos").val()=="False" ){
				alert("Situação do pedido não permite edição.");
				return false;
			}
																		
			var codigo = $(this).parent().parent().find("#codigo").html()
			

			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			
			//#Alterado em 01/12/2015 (height passou de 290 para 360, width passou de 600 para 620)
			window.open("jornada_edicao.asp?codigo="+codigo+"", "Edi&ccedil;&atilde;o", "height=500, width=620, scrollbars=no, titlebar=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+",left="+left+"");

						
	});
		var abono=false;
		//Ao digitar executar essa função
		$("#nome_colaborador").focus().autocomplete({
		
		source: "autocompletar_nome.asp",
		minlength: 2,
		select: function( event, ui ) {
			$( "#nome_colaborador" ).val( ui.item.nome);
			$( "#digito" ).val( ui.item.digito);
			$( "#matr_colaborador" ).val( ui.item.matricula);					
			return false;
		}
		});
		
		
		$("#matr_colaborador").focus().autocomplete({
		
			source: "autocompletar_matricula.asp",
			minlength: 2,
			select: function( event, ui ) {
				$( "#nome_colaborador" ).val( ui.item.nome);
				$( "#digito" ).val( ui.item.digito);
				$( "#matr_colaborador" ).val( ui.item.matricula);				
				return false;
			}
		});
	});
	

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
			
			$.ajax({
		
       			data: $("#formulario").serialize(), // DADOS A SEREM PASSADOS PARA O SERVIDOR
       			url: "jornada_consultas.asp?consultaTodos="+$("#consultaTodos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        			//$("#carregando").show(); 
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		//$("#carregando").hide();  
            	},
        		success: function(data) { // CASO RECEBA RESPOSTA COM SUCESSO
          			$("#resultado").html(data); 	  
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao consultar jornada.");
					console.log(data.responseText);
 				}
		
      		})
	
			//window.open("jornada_consultas.asp?consultaTodos="+$("#consultaTodos").val());
	
		//$("#carregando").hide();
		
		$(document).on("click", "#consultar", function() {
		
      		$.ajax({
		
       			data: $("#formulario").serialize(), // DADOS A SEREM PASSADOS PARA O SERVIDOR
       			url: "jornada_consultas.asp?consultaTodos="+$("#consultaTodos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        			//$("#carregando").show(); 
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		//$("#carregando").hide();  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$("#resultado").html(data); 	  
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao consultar jornada.");
 				}
		
      		})
  
		});
	
	});
 
</script>

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
</style>
</head>
<body>
<%
	Perfil_Acesso_cookie("22") 
	if not perfil_acesso_siiag then
		response.Redirect ("acesso_negado.asp")
	end if
	'response.write "<input type='hidden' id = 'perfil_jornada_consultar' value=" & perfil_acesso_siiag & ">"
	response.write "<input type='hidden' id = 'perfil_jornada_editar' value='" & tem_acesso_cookie("23")  & "'>"
	


	if tem_acesso_admin_cookie("22") then ' VISAO UNIDADE
		consultaTodos = true
		consultaGS = false
	elseif request.Cookies("co_usuario_co_visao") = "2" then ' VISAO COORDENACAO
		consultaGS = true
		consultaTodos = false
	elseif request.Cookies("co_usuario_co_visao") = "1" then ' VISAO USUARIO
		consultaGS = false
		consultaTodos = false
		podeCancelar = true
	end if
	
	'if Tem_Acesso("10") then 'perfil controle
	'	consultaTodos = true
	'	consultaGS = false
	'elseif perfil_acesso_admin_siiag then
	'consultaGS = true
	'consultaTodos = false
	'else
	'consultaGS = false
	'consultaTodos = false
	'end if
	
	response.write "<input type='hidden' id='consultaTodos' name='consultaTodos' value="&consultaTodos&">"
%>

<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >JORNADA</span> </div>
        <div class="usuariodiv"  style=" min-height:540px;">
          <div id='cssmenu'>
            <ul>
              <%			
				if tem_acesso_cookie("4") then
					response.write "<li><a href='jornada.asp'><span>Solicitar</span></a></li>"
				end if			
				response.write "<li class='active'><a href='consultar_jornada.asp'><span>Consultar</span></a></li>"			  
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!--<li><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Consultar Altera&ccedil;&otilde;es de Jornada de Trabalho</span></legend>
          <p/>
          <form id="formulario" name="formulario">
		  <label>Matrícula:</label>
                  <input type='hidden' id='consultaGS' name='consultaGS' value="<%=consultaGS%>">
                  <input class="form-field" id="matr_colaborador" name="matr_colaborador" type="text" size="6" maxlength="7" style="margin-bottom:4px;margin-left:2px;"/> 
                  <label>-</label>
                  <input class="form-field" id="digito" name="digito" type="text" size="1" maxlength="1"  style="width:20px;" />                
		  &nbsp;
          <label>Nome:</label>
                  <input class="form-field" id="nome_colaborador" name="nome_colaborador" type="text" size="60" maxlength="50" />              
          
           <br/>    
			<%if consultaTodos then%>
                   <label> Coordenação:</label>
                        <%
                        strQuery = "select CO_GS, NO_GS  from VW_GS where co_unidade = "& request.Cookies("co_usuario_unidade_siiag") &" and ic_ativo=1 ORDER BY NO_GS" 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
                    set Ls=Server.CreateObject("ADODB.RecordSet")
                    Ls.Open strQuery, dados_sys
                    
                     'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
                     'Vamos percorrer o recordset até chegar no final do arquivo
                     
                                response.Write "<select id = 'coordenacao' name='coordenacao' class='form-select'>"
                                response.write "<option value=''>Todas</option>" 'imprimindo
                                
                      DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
                      
                     'atribuindo os valores dos campos as variáveis
                          nomeGerencia=Ls("NO_GS")
                          codigoGerencia=Ls("CO_GS")
                          
                           response.write "<option value='"& codigoGerencia &"' >"& nomeGerencia &"</option>" 'imprimindo
                                    
                        Ls.movenext 'passando para o proximo elemento da tabela
                      
                        LOOP
                        
                            response.Write "</select>" 'fechando o select
                    
                    set Ls = nothing
                    set objConn = nothing 
                    'fechando todas as conexoes
            end if
            %>  
   <label>Situa&ccedil;&atilde;o:</label>&nbsp;&nbsp;
            <select name="situacao" id='situacao' class='form-select' style="margin-bottom:5px;" >
            <option value=''>Todas</option>
			<%
            strQuery = "select CO_SITUACAO, DE_SITUACAO from TB_SITUACOES ORDER BY CO_SITUACAO" 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
            set Ls=Server.CreateObject("ADODB.RecordSet")
            Ls.Open strQuery, dados_sys
                        
              DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
                  
                   response.write "<option value="& Ls("CO_SITUACAO") &" >"& Ls("DE_SITUACAO") &"</option>" 'imprimindo
                            
                Ls.movenext 'passando para o proximo elemento da tabela
              
                LOOP
            %>

            </select>
            &nbsp;&nbsp;
             <label >Hor&aacute;rio:</label>
            <input id="horario_inicio" name="horario_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" />
            <input id="horario_fim" name="horario_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" />            

            </form>
            <br/>	
            <div align="left">
         	<button  class="myButton" id="consultar"  style="margin-left:5px" name="consultar">Consultar</button>  
         </div>    
            </p>
          <div class="tabela" id="resultado" style="margin-left:0.8%; margin-bottom:3%;">
          </div>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
          </fieldset>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
<div id="divCancelamento" class="msg-dialog" style="display:none;" title="Cancelar">
	<input type="hidden" id="codigoCancelamento"/>
    <label>Motivo do cancelamento:</label><br />
    <textarea  class="form-field" name="motivoCancelamento" id="motivoCancelamento" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px; margin-left:5px"></textarea><br />
    <input  style="margin-top:7px;margin-left:5px;" name="botaoCancelar" id="botaoCancelar" class="myButton" type="button" value="Cancelar"/>
</div>
</body>
</html>
