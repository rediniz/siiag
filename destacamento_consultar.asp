<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Destacamento</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

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
	
$('.cancelar').on("click", function(){
	$("#divCancelamento" ).dialog({
		modal: true,
		dialogClass: "dialogo",
		closeText: "Fechar",
		width:'auto'
	});
	$("#codigoCancelamento").val($(this).parent().parent().find("#codigo").html());
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
				tipo:"destacamento",
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

$('.edit').on('click',function(){
			var co_criador  = $(this).parent().parent().find("#co_criador").val()
			var co_usuario  = $("#co_usuario").val()
			var co_situacao = $(this).parent().parent().find("#co_situacao").val()		


			if(co_situacao != "1" && $("#perfil_controle").val()=="False" ){
				alert("Situação do pedido não permite edição.");
				return false;
			}
								
			var co_destacamento = $(this).parent().parent().find("#codigo").html()
			/*alert(matricula + nome + data+descricao+dtcriacao+empregadosolicitante+dias);*/
			

			var top = (window.innerHeight / 4) -300
			var left = (window.innerWidth / 4) -100
			
			window.location.assign("destacamentos_edicao.asp?co_destacamento="+co_destacamento)
						
	});
});
	
	
</script> 

<script>

function Pesquisar(){

 var situacao = document.getElementById("situacoes").value;
 var nome =  document.getElementById("nome").value;
 var data_inicio = document.getElementById("data_inicio").value;
 var data_final = document.getElementById("data_final").value;

 /*alert(situacao);
 alert(coordenacao);
 alert(data_inicio);
 alert(data_final);*/
 
 window.location.assign("destacamento_consultar.asp?situacao="+situacao+"&nome="+nome+"&data_inicio="+data_inicio+"&data_final="+data_final+"");
 
}

</script>

<script type="text/javascript" language="javascript">

	$(document).ready(function(){
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete({
					
					source: "autocompletar_nome.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
									
					return false;
					}
				  });
 
			});

</script>

</head>
<body>
<%

	Perfil_Acesso("18") 
	if not perfil_acesso_siiag then
		response.Redirect("acesso_negado.asp")
	end if

	response.write "<input type='hidden' id = 'perfil_destacamento_consultar' value=" & perfil_acesso_siiag & ">"
	response.write "<input type='hidden' id = 'perfil_destacamento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
	response.write "<input type='hidden' id = 'co_usuario' value=" & request.Cookies("co_usuario_siiag")  & ">"

	if  request.Cookies("co_usuario_co_visao") = "3" then ' VISAO UNIDADE
		consultaTodos = true
	elseif request.Cookies("co_usuario_co_visao") = "2" then ' VISAO COORDENACAO
		consultaGS = true
		consultaTodos = false
	elseif request.Cookies("co_usuario_co_visao") = "1" then ' VISAO USUARIO
		consultaGS = false
		consultaTodos = false
	end if

	'if Tem_Acesso("10") then 'perfil controle
	'	consultaTodos = true
	'elseif perfil_acesso_admin_siiag then
	'	consultaGS = true
	'	consultaTodos = false
	'else
	'	consultaGS = false
	'	consultaTodos = false
	'end if
	response.write "<input type='hidden' id = 'perfil_controle' value=" & consultaTodos  & ">"
	'#ALTERADO EM 11/04/2014
	observacaoEdicao = request("observacaoEdicao")

	
%>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos"><span>DESTACAMENTOS</span></div>
        <div class="usuariodiv" style="min-height:540px;">
          <div id='cssmenu'>
            <ul>
             <%			
              	response.write "<li><a href='destacamentos.asp'><span>Solicitar</span></a></li>"
			  	response.write "<li class='active'><a href='destacamento_consultar.asp'><span>Consultar</span></a></li>"			  
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
          <legend><span class="titulos">Consultar Destacamento</span></legend>
          <label>Situação:</label>
           <%
			situacao = Request("situacao")
			data_inicio =  Request("data_inicio")
			data_final =  Request("data_final")
			nome = Request("nome")		
		   %>         
            <select name="exibir_apenas" id="situacoes" class="form-select" style="width:100px;">
              <option <% if situacao="0" Then Response.Write "selected='selected'" END IF%> value="0">Todos</option>	 
              <option <% if situacao="1" Then Response.Write "selected='selected'" END IF%> value="1">Socilitado</option>
              <option <% if situacao="2" Then Response.Write "selected='selected'" END IF%> value="2">Confirmado</option>
              <option <% if situacao="3" Then Response.Write "selected='selected'" END IF%> value="3">Pendente</option>
              <option <% if situacao="5" Then Response.Write "selected='selected'" END IF%> value="5">Gozado</option>
              <option <% if situacao="6" Then Response.Write "selected='selected'" END IF%> value="6">Não Atendido</option>
              <option <% if situacao="7" Then Response.Write "selected='selected'" END IF%> value="7">Cancelado</option>
              <option <% if situacao="8" Then Response.Write "selected='selected'" END IF%> value="8">Em Andamento</option>
            </select>
            <% if perfil_acesso_admin_siiag then %>
	            <label> Nome: </label>
            <%end if%>
            <input <% if nome<>"" Then Response.Write "value='"&nome&"'" END IF%>style="margin-top:5px; <% if not perfil_acesso_admin_siiag then %> display:none;<%end if%>" class="form-field" name="nome" id="nome" type="text" size="43" maxlength="100"            />
          <label>De </label>
          <input <% if data_inicio <> "" Then Response.Write "value= '"&data_inicio&"' " End If %> name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8"/>
          <label>até </label>
          <input <% if data_final <> "" Then Response.Write "value= '"&data_final&"' " End If %>  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8"/>
          </legend>&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="submit" name="button" id="button" class="myButton" value="Pesquisar" onclick="Pesquisar();" />
          <br/>
          <br/>
          <div class="tabela" >
          
          <!-- #INCLUDE FILE ="consulta_destacamento_con.asp" -->
            
          </div>
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
