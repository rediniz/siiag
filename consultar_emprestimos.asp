<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Reserva de Equipamentos</title>
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
$(document).ready(function() {

$('.cancelar').on("click", function(){
	$("#divCancelamento" ).dialog({
		modal: true,
		dialogClass: "dialogo",
		closeText: "Fechar",
		width:'auto'
	});
	$("#codigoCancelamento").val($(this).parent().parent().find("#codigo").val());
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
				tipo:"emprestimo",
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
	
	//FAZ O CONTROLE AQUI
	$('.check_controle').on('click',function(){
		
		var co_emprestimo = $(this).parent().parent().find("#recurso").find("#codigo").val();
		var co_recurso = $(this).parent().parent().find("#recurso").find("#co_recurso").val();
		var co_responsavel = $(this).parent().parent().find("#recurso").find("#co_matricula_responsavel").val();
		
		//alert(co_emprestimo + ":" + co_recurso+":"+co_responsavel);
		
		  $.ajax({
			  type: "GET",
			  url: "emprestimos_alterar_status.asp?co_emprestimo="+co_emprestimo+"&co_recurso="+co_recurso+"&co_responsavel="+co_responsavel,
			  success: function (data) {
				  alert("Status do recurso mudado para 'devolvido'.");
				  window.location.reload();
			  },	
			  error: function (data) {
				  alert("Erro ao mudar status do recurso.");
			  },	
		  });
		
	});

$('.edit').on('click',function(){
			var co_matricula_resp = $(this).parent().parent().find("#co_matricula_responsavel").val();
			var co_criador = $(this).parent().parent().find("#co_criador").val();
			var co_usuario =  $("#usuario").val();
			var co_situacao = $(this).parent().parent().find("#co_situacao").val();	

			if( $("#perfil_emprestimo_editar").val()=="False" && co_usuario != co_criador && co_usuario != co_matricula_resp  ) {
				alert("Você não tem permissão para editar.");
				return false;
			}
								
			if(co_situacao != "1" && $("#perfil_emprestimo_editar").val()=="False"){
				alert("Situação do pedido não permite edição.");
				return false;
			}
			
			var co_emprestimo = $(this).parent().parent().find("#codigo").val()
			/*alert(matricula + nome + data+descricao+dtcriacao+empregadosolicitante+dias);*/
			
			var top  = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("emprestimos_edicao.asp?co_emprestimo="+co_emprestimo, "Teste", "height=500, width=600, scrollbars=yes, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
						
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
function Pesquisar(){
	//var Recurso = document.getElementById("");
	var situacao = document.getElementById("situacoes").value;
	var data_inicial = document.getElementById("data_inicio").value;
	var data_final = document.getElementById("data_final").value;
	var Recurso = document.getElementById("recurso").value;
	//var situacao = document.getElementById("");
	
	//alert(data_inicial);
	//alert(data_final);
	//alert(situacao);
	//alert(Recurso);
	
	window.location.assign("consultar_emprestimos.asp?situacao="+situacao+"&data_inicio="+data_inicial+"&data_final="+data_final+"&recurso="+Recurso+"");
}
</script>

</head>
<body>

<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
<%
	Perfil_Acesso("27") 
	if not perfil_acesso_siiag then
		response.Redirect ("acesso_negado.asp")
	end if
	'response.write "<input type='hidden' id = 'perfil_emprestimo_consultar' value=" & perfil_acesso_siiag & ">"
	response.write "<input type='hidden' id = 'perfil_emprestimo_editar' value=" & tem_acesso_admin("28")  & ">"
	response.write "<input type='hidden' id = 'usuario' value=" & request.Cookies("co_usuario_siiag")  & ">"   
	
	if perfil_acesso_admin_siiag then ' VISAO UNIDADE
		consultaTodos = true
		consultaGS = false
	elseif request.Cookies("co_usuario_co_visao") = "2" then ' VISAO COORDENACAO
		consultaGS = true
		consultaTodos = false
	elseif request.Cookies("co_usuario_co_visao") = "1" then ' VISAO USUARIO
		consultaGS = false
		consultaTodos = false
	end if
%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv" style="min-height:550px;">
      	<div class="titulosModulos" ><span >RESERVA DE EQUIPAMENTOS</span> </div>
          <div id='cssmenu'>
            <ul>
             <%			
				if tem_acesso("6") then
					response.write "<li ><a href='emprestimos.asp'><span>Solicitar</span></a></li>"
				end if			
				response.write "<li class='active'><a href='consultar_emprestimos.asp'><span>Consultar</span></a></li>"			  
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
               <li><a href='index.html'><span>Termo de Responsabilidade</span></a></li>
              <li><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Consultar Reserva de Equipamentos</span></legend>
          <p class="paragrafoteste">

			<%
                situacao 	= Request("situacao")
                data_inicio	= Request("data_inicio")
                data_final	= Request("data_final")
                recurso 	= Request("recurso")
            %>

			<%
			
				strQuery = "select CO_RECURSO, DE_RECURSO  from TB_TIPOS_RECURSOS ORDER BY DE_RECURSO; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
				set rs=Server.CreateObject("ADODB.RecordSet")
				rs.Open strQuery, dados_sys
			%>
          	<label> Recursos:</label>
    		<select class="form-select" name='recursos' id="recurso">
            
              <option <% if recurso="" Then Response.Write "selected='selected'" END IF%> value="">Todos</option>	 
             
			<% do while not rs.eof%>              
	              <option <% if recurso=cStr(rs("CO_RECURSO")) Then Response.Write "selected='selected'" END IF%> value="<%=rs("CO_RECURSO")%>"><%=RS("DE_RECURSO")%></option>	 
			<%
					rs.movenext
			  loop
			%>
			</select>&nbsp; &nbsp;
 			
            
            
            <label>Per&iacute;odo: de</label>
            <input <% if data_inicio <> "" Then Response.Write "value= '"&data_inicio&"' " End If %> name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8"/>
            <label>&nbsp;a&nbsp;</label>
            <input <% if data_final <> "" Then Response.Write "value= '"&data_final&"' " End If %>  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8"/>
            &nbsp;&nbsp;
            <%
			
				strQuery = "select CO_SITUACAO, DE_SITUACAO  from TB_SITUACOES ORDER BY DE_SITUACAO; " 
				set rs=Server.CreateObject("ADODB.RecordSet")
				rs.Open strQuery, dados_sys
			%>
            <label>Situa&ccedil;&atilde;o</label>
            
            <select name="exibir_apenas" id="situacoes" class="form-select" style="width:100px;"> 
              <option <% if situacao="" Then Response.Write "selected='selected'" END IF%> value="">Todos</option>	 
              			
			<% do while not rs.eof%>              
	              <option <% if recurso=cStr(rs("CO_SITUACAO")) Then Response.Write "selected='selected'" END IF%> value="<%=rs("CO_SITUACAO")%>"><%=RS("DE_SITUACAO")%></option>	 
			<%
					rs.movenext
			  loop
			%>

            </select>
            <!--<img src="imagens/search_24x24.png" class="imgsearch" /></p> -->
          <input type="submit" name="button" id="button" class="myButton" value="Pesquisar" onclick="Pesquisar();" />
          <br/>
          <br/>
          <div class="tabela" >
          
          <!-- #INCLUDE FILE ="consulta_emprestimo_con.asp" -->
            
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
</body>
</html>
