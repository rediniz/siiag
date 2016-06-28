<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Eventos e Treinamentos</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
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
<style>
#X {
	cursor:pointer
}
.ui-datepicker {
	font-size:12px;
}
.datepicker {
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
</style>
<style>
.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce;
	font-weight: bold;
	color: #c77405;
}
.ui-widget {
	font-family: Arial, sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}
.ui-menu .ui-menu-item a {
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
	font-family: Arial, sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}
.ui-menu .ui-menu-item a {
	height:14px;
	font-size:13px;
}
.ui-autocomplete {
	height:200px;
	overflow-y:scroll;
	overflow-x:hidden;
}
.datepicker {
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
</style>
<script type="text/javascript" language="javascript">
	$(document).ready(function(){
				//Ao digitar executar essa função
				$("#responsavel_usuario").focus().autocomplete({
					
					source: "autocompletar_nome3.asp?responsavel=sim",
					minlength: 2,
					select: function( event, ui ) {
					$( "#responsavel_usuario" ).val( ui.item.nome);
					$( "#responsavel_matricula" ).val( ui.item.matricula);			
					return false;
					}
				  });
 
 					$("#responsavel_matricula").focus().autocomplete({
					
					source: "autocompletar_matricula3.asp?responsavel=sim",
					minlength: 2,
					select: function( event, ui ) {
					$( "#responsavel_usuario" ).val( ui.item.nome);
					$( "#responsavel_matricula" ).val( ui.item.matricula);				
					return false;
					}
					
				  });
 
			});
	</script>
<script>
    $(function() {
    $( ".datepicker" ).datepicker({
		dateFormat: 		'dd/mm/yy',
		dayNames: 			['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
		dayNamesMin: 		['D','S','T','Q','Q','S','S','D'],
		dayNamesShort: 		['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
		monthNames: 		['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
		monthNamesShort: 	['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
		nextText: 			'Próximo',
		prevText: 			'Anterior'
  });
   });
</script>
<script>
  $(function() {
    $( "#tabss" ).tabs();
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
		}
		setup();
	});
	</script>
<script language="javascript" type="text/javascript">
  
  $(function() {
  
  $('.table').on('click', '#X', function(){
		$(this).parent().remove(); 
		});
  	
  	$( "#incluirResponsavel" ).click(function() {
	
	   var matricula 	= $("#responsavel_matricula").val();
	   var usuario 		= $("#responsavel_usuario").val();	   
	    
				$( "#tabela_responsavel" ).append( 
							"<tr class='responsavel'>" +
							"<td id='responsavel_matricula'>" + matricula + "</td>" +
							"<td id='responsavel_nome'>" + usuario + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
								
	 	$( "#incluirPublico" ).click(function() {
	
	   var publico 	= $("#publico_alvo option:selected").html();
	   var codigo 	= $("#publico_alvo").val();
	   
				$( "#tabela_publico" ).append( 
							"<tr class='publico'>" +
							"<input type='hidden' id='publico_codigo' value="+codigo+">" +
							"<td id='publico_publico'>" + publico + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
		$( "#incluirServico" ).click(function() {
	
	   var tipo 		= $("#tipo_servico option:selected").html();
	   var codigo 		= $("#tipo_servico ").val();
	   var quantidade	= $("#quantidade_servico").val();
	   var observacao 	= $("#observacao_servico").val();
	   
				$( "#tabela_servicos" ).append( 
							"<tr class='servico'>" +
							"<input type='hidden' id='servico_codigo' value="+codigo+">" +
							"<td id='servico_tipo'>" + tipo + "</td>" +
							"<td id='servico_observacao'>" + observacao + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
		$( "#incluirRecurso" ).click(function() {
	
	   var tipo 		= $("#tipo_recurso option:selected").html();
	   var codigo 		= $("#tipo_recurso").val();
	   var quantidade 	= $("#quantidade_recurso").val();
	   
	   if(quantidade == ""){
		   alert("Informe a quantidade");
		   return false;
	   }
	   
				$( "#tabela_recurso" ).append( 
							"<tr class='recurso'>" +
							"<input type='hidden' id='recurso_codigo' value="+codigo+">" +
							"<td id='recurso_tipo'>" + tipo + "</td>" +
							"<td id='recurso_quantidade'>" + quantidade + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
	  $( "#incluirMaterial" ).click(function() {
	
	   var nome 		= $("#materiais option:selected").html();
	   var codigo 		= $("#materiais").val();
	   var quantidade 	= $("#quantidade_material").val();
	   
				$( "#tabela_material" ).append( 
							"<tr class='material'>" +
							"<input type='hidden' id='material_codigo' value="+codigo+">" +
							"<td id='material_nome'>" + nome + "</td>" +
							"<td id='material_quantidade'>" + quantidade + "</td>" +
							"<td id='material_disponivel'> ? </td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
		$( "#incluirArquivo" ).click(function() {
	
	   var recurso 		= $("#recursos").val();
	   var quantidade 	= $("#spinner").val();
	   
				$( "#tabela" ).append( 
							"<tr class='arquivo'>" +
							"<td id='arquivo_recurso'>" + recurso + "</td>" +
							"<td id='arquivo_quantidade'>" + quantidade + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
	$(".presenca").click(function(){
		if($(this).val()=="1"){
			$("#tr_qt_presenca").show();
			$("#qtd_participantes").focus();
		}
		else
		{
			$("#tr_qt_presenca").hide();
			$("#qtd_participantes").val("");
		}
	
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
<script>
var responsavel;

$(function() {

$("#salvar").click(function(){

	if($("#perfil_eventos").val()=="False"){
		alert("Você não tem permissão para solicitar eventos e treinamentos.")
		return false;
	}
	
	descricao 			= $("#descricao").val();
	iniciativa 			= $("#iniciativa").val();
	periodo_inicio		= $("#periodo_inicio").val();
	periodo_fim 		= $("#periodo_fim").val();
	local 				= $("#local").val();
	situacao 			= $("#situacao").val();
	horario_inicio 		= $("#horario_inicio").val();
	horario_fim 		= $("#horario_fim").val();
	tipo_evento 		= $("#tipo_evento").val();
	qtd_participantes 	= $("#qtd_participantes").val();
	desc_participantes 	= $("#desc_participantes").val();
	rd_participantes = $("#rd_presenca_sim").prop("checked");

	if(descricao == ""){
		alert("Informe a descrição do evento.");
		return false;
	}
	if(iniciativa == ""){
		alert("Informe a iniciativa.");
		return false;
	}
	if(periodo_inicio == "" || periodo_fim == ""){
		alert("Informe o período.");
		return false;
	}
	if(local == ""){
		alert("Informe o local.");
		return false;
	}
	if(situacao == ""){
		alert("Informe a situação.");
		return false;
	}
	if(tipo_evento == ""){
		alert("Informe o tipo do evento.");
		return false;
	}
	if(horario_inicio  == "" || horario_fim== ""){
		alert("Informe o horário.");
		return false;
	}
	//if(situacao == ""){
	//	alert("Informe a descrição do evento");
	//}
	if (rd_participantes){
		if(qtd_participantes == ""){
			alert("Informe a quantidade de participantes.");
			return false;
		}
	}	
	
	
	if(desc_participantes == ""){
		alert("Informe a descrição dos participantes.");
		return false;
	}
	
	//==========================================================================================
	//{RESPONSÁVEIS}
	//==========================================================================================
	$(".responsavel").each(function(){
		responsavel = $(this).find("#responsavel_matricula").html()+":"+$(this).find("#responsavel_nome").html();
		$("#variaveis").append("<input type='hidden' id='v_responsavel' name='v_responsavel' value='"+responsavel+"'>");
	});
	//==========================================================================================
	//{PÚBLICO}
	//==========================================================================================
	$(".publico").each(function(){
		publico = $(this).find("#publico_codigo").val();
		$("#variaveis").append("<input type='hidden' id='v_publico' name='v_publico' value='"+publico+"'>");
	});
	//==========================================================================================
	//{SERVIÇOS}
	//==========================================================================================
	$(".servico").each(function(){
		servico = $(this).find("#servico_codigo").val()+":"+$(this).find("#servico_observacao").html();
		$("#variaveis").append("<input type='hidden' id='v_servico' name='v_servico' value='"+servico+"'>");
	});
	//==========================================================================================
	//{RECURSOS}
	//==========================================================================================
	$(".recurso").each(function(){
		recurso = $(this).find("#recurso_codigo").val()+":"+$(this).find("#recurso_quantidade").html()
		var observacao = $("#observacao_recurso").val();
		$("#variaveis").append("<input type='hidden' id='v_recurso' name='v_recurso' value='"+recurso+"'>");
		$("#variaveis").append("<input type='hidden' id='v_observacao_recurso' name='v_observacao_recurso' value='"+observacao+"'>");
	});
	//==========================================================================================
	//{MATERIAIS}
	//==========================================================================================
	$(".material").each(function(){
		material = $(this).find("#material_codigo").val()+":"+$(this).find("#material_quantidade").html()+":"+$(this).find(	"#material_disponivel").html();
		$("#variaveis").append("<input type='hidden' id='v_material' name='v_material' value='"+material+"'>");
	});
	$("#variaveis").append("<input type='hidden' id='v_observacoes' name='v_observacoes' value='"+$("#v_observacoes").text()+"'>");

	/*$.ajax({
				type: "POST",
				url: 'eventos_editar.asp',
				data:  $("#formulario").serialize(),
				success: function (data) {
					alert("Evento editado com sucesso.");
					$("#variaveis").empty();
            	},		
				error: function(data){
				alert("Erro ao editar evento.");
				}	    
  	});*/
	$("#dt_ini_atdmt_v").val($("#dt_ini_atdmt").val());
	$("#dt_prev_conc_v").val($("#dt_prev_conc").val());
	$("#observacaoEdicao_v").val($("#observacaoEdicao").val());
	$("#formulario").submit();
});

});

</script>
<!-- fecha efeito da janela de ajuda -->
</head>
<body>

<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE file ="topo.asp" -->
<%
	Perfil_Acesso("29") 
	if not perfil_acesso_siiag then
	  response.Redirect ("acesso_negado.asp")
	end if

	pagina_pai = request("pagina_pai")
	
	query = "SELECT DH_CRIACAO, CO_CRIADOR, NO_NOME AS NO_CRIADOR, CO_SITUACAO,CO_LOCAL, CO_TIPO_EVENTO, CO_GS_INICIATIVA, DE_EVENTO, DE_OBS, DH_INICIO, QT_PARTICIPANTES, DE_PARTICIPANTES, DH_FIM,DH_HORA_INICIO, DH_HORA_FIM, DE_PARTICIPANTES, DT_INI_ATDMT, DT_PREV_CONC, OBS_EDICAO FROM TB_EVENTOS LEFT JOIN VW_USUARIOS ON CO_CRIADOR = CO_MATRICULA WHERE CO_EVENTO = "& request("co_evento")
	
	resultado 			= objConn.execute(query)
	
	co_situacao 		= resultado("CO_SITUACAO")
	co_local 			= resultado("CO_LOCAL")
	co_tipo_evento		= resultado("CO_TIPO_EVENTO")
	co_iniciativa 		= resultado("CO_GS_INICIATIVA")
	qtd_participantes 	= resultado("QT_PARTICIPANTES")
	de_participantes 	= resultado("DE_PARTICIPANTES")
	de_evento			= resultado("DE_EVENTO")
	de_obs 				= resultado("DE_OBS")
	data_inicio			= resultado("DH_INICIO")
	data_fim 			= resultado("DH_FIM")
	hora_inicio 		= resultado("DH_HORA_INICIO")
	hora_fim 			= resultado("DH_HORA_FIM")
	qt_participantes    = resultado("QT_PARTICIPANTES")

	dt_ini_atdmt = resultado("dt_ini_atdmt")
	dt_prev_conc = resultado("dt_prev_conc")
	observacaoEdicao = resultado("OBS_EDICAO")
	
%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
          <div class="titulosModulos" ><span >EVENTOS E TREINAMENTOS</span> </div>
          <div id='cssmenu'>
            <ul>
             <%			
			if tem_acesso("7") then
				response.write "<li  class='inactive'><a href='eventos_e_treinamentos.asp'><span>Solicitar</span></a></li>"
			end if
			if tem_acesso("26") then
				response.write "<li  class='inactive'><a href='consultar_eventos_e_treinamentos.asp'><span>Consultar</span></a></li>"	
			end if
			response.write "<li  class='active'><a href='eventos_e_treinamentos_editar.asp'><span>Editar</span></a></li>"		  			
			if tem_acesso("7") then
				response.write "<li  class='inactive'><a href='eventos_treinamentos_pendencia.asp'><span>Prestação de Contas</span></a></li>"	
			end if
			 %>
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
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
          <legend><span class="titulos">Eventos e Treinamentos</span></legend>
          <p class="paragrafoteste">
          
          <!-- fim do dados da inclusão -->
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
			<legend><span class="titulos">Cadastramento</span></legend>
            <table width="915" height="" border="0" cellpadding="0" cellspacing="5">
              <tr>
                <td ><label for="label"><%=resultado("dh_criacao")%> - <%=resultado("co_criador")%> - <%=resultado("no_criador")%></label></td>
              </tr>
			</table>
           </fieldset>
          <p><img src="imagens/info_16x16.png" /> <span class="style1">Entre com os dados abaixo para Eventos. Para Treinamento, basta substituir o Tipo para "Treinamento".</span></p>
          <form id='formulario' action="eventos_editar.asp"  enctype="application/x-www-form-urlencoded" method="post">
          <input type="hidden" name="pagina_pai" id="pagina_pai"  value="<%=pagina_pai%>" />
            <table width="915" height="135" border="0" cellpadding="0" cellspacing="5">
              <tr>
                <td width="133"><label for="label">Descri&ccedil;&atilde;o:</label></td>
                <td colspan="4"><input name="descricao" id ="descricao" class="form-field" type="text" size="68" maxlength="1024" value="<%=de_evento%>"/>
                </td>
              </tr>
              <tr>
                <td><label for="label">Iniciativa:</label></td>
                <td colspan="4"><select class="form-select" name="iniciativa" id="iniciativa">
                    <option value=""></option>
                    <!-- #INCLUDE FILE ="include/Conexao.asp" -->
                    <%
				  query = "SELECT CO_GS, NO_GS FROM VW_GS WHERE  co_unidade = " & request.Cookies("co_usuario_unidade_siiag") &" order by no_gs"
				  set ds=Server.CreateObject("ADODB.RecordSet")
				  ds.Open query, dados_sys 
				  DO UNTIL ds.eof
				  %>
				  <option <% if co_iniciativa = ds("CO_GS") then response.write "selected=selected"  %> value="<%=ds("CO_GS")%>"><%=ds("NO_GS")%></option>
				  <%				 
					ds.movenext
				  LOOP	  
				  %>
                  </select></td>
              </tr>
              <tr>
                <td><label>Per&iacute;odo:</label></td>
                <td colspan="4"><input  name="periodo_inicio" id="periodo_inicio" class="datepicker" type="text" size="8" maxlength="8"  value="<%=data_inicio%>"/>
                  <input  name="periodo_fim" id="periodo_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<%=data_fim%>"/>
                </td>
              </tr>
              <tr>
                <td><label for="local">Local:</label>
                </td>
                <td colspan="4"><select class="form-select" name="local" id="local">
                    <option value=""></option>
                    <%
			
					strQuery = "select CO_LOCAL, DE_LOCAL from TB_LOCAL where co_unidade = " & request.Cookies("co_usuario_unidade_siiag") &" ORDER BY DE_LOCAL" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
					DO UNTIL rs.eof 
		  
		  			%>
                    <!--r-->
                    <option <% if co_local = rs("CO_LOCAL") then response.write "selected=selected" %> value=<%=rs("CO_LOCAL")%>><%=rs("DE_LOCAL")%></option>
                    <%				
						rs.movenext 
				
					LOOP
							
					set rs = nothing
		
				%>
                  </select>
                </td>
              </tr>
              <tr>
                <td><label>Situa&ccedil;&atilde;o:</label>
                </td>
                <td colspan="4">                
                    <%
					response.write "<select class='form-select'  name='situacao' id='situacao' style='width:140px'>"
					
					
                    'response.write "<option value=''></option>"
					if  (perfil_acesso_admin_siiag) then			
						strQuery = "select CO_SITUACAO, DE_SITUACAO from TB_SITUACOES ORDER BY DE_SITUACAO" 
					else
						strQuery = "select CO_SITUACAO, DE_SITUACAO from TB_SITUACOES where co_situacao in ("& resultado("co_situacao") &",1,7) ORDER BY DE_SITUACAO" 					
					end if
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
					DO UNTIL rs.eof 

                     %>
             		 <option <% if co_situacao = rs("CO_SITUACAO") then response.write "selected=selected" %> value=<%=rs("CO_SITUACAO")%>><%=rs("DE_SITUACAO")%></option>
                     
              		 <%
                
						rs.movenext 
				
					LOOP
		
					set rs = nothing
		
				%>
                  </select>
                </td>
              </tr>
              <tr>
                <td><label>Tipo do Evento:</label>
                  &nbsp;</td>
                <td colspan="4"><select  class="form-select" name="tipo_evento" id="tipo_evento">
                    <option value=""></option>
                    <%
			
					strQuery = "select CO_TIPO_EVENTO, DE_TIPO_EVENTO from TB_TIPOS_EVENTO ORDER BY DE_TIPO_EVENTO" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
					DO UNTIL rs.eof 
		  			             %>
             		 <option <% if co_tipo_evento = rs("CO_TIPO_EVENTO") then response.write "selected=selected"  %> value=<%=rs("CO_TIPO_EVENTO")%>><%=rs("DE_TIPO_EVENTO")%></option>
              		 <%			
						rs.movenext 
				
					LOOP
		
					set rs = nothing
		
				%>
                  </select>
                </td>
              </tr>
              <tr>
                <td><label for="horario_de">Horário &nbsp;do&nbsp;Evento:</label></td>
                <td colspan="2"><input id="horario_inicio" name="horario_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="<%=formatdatetime(hora_inicio, 4)%>" style="height:24px"/>
                  <input id="horario_fim" name="horario_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="<%=formatdatetime(hora_fim, 4)%>" style="height:24px"/></td>
              </tr>
              <tr>
              
               <tr>
                <td  colspan="5"><label for="label">Deseja ter controle de presença dos participantes?
                <input type="radio" name="rd_presenca" id="rd_presenca_sim" class="presenca" value="1" /> Sim
                <input type="radio" name="rd_presenca" id="rd_presenca_nao" class="presenca" value="0" checked="checked" /> Não
                </label>
                </td>
              </tr>

              <tr id="tr_qt_presenca" style="display:none">
                <td colspan="5"><label for="label">Quantidade&nbsp;de Participantes:</label>
                <input name="qtd_participantes" type="text" class="form-field" id="qtd_participantes" size="2" maxlength="3" value="<%=qt_participantes%>"/> <a href="lista_frequencia_branca.asp?co_evento=<%=request("co_evento")%>">lista</a>
                </td>
              </tr>
                <!--<td><label for="label">Quantidade<br/>
                  &nbsp;de Participantes:</label></td>
                <td width="86"><input name="qtd_participantes" type="text" class="form-field" id="qtd_participantes" size="2" maxlength="3" value="<%=qtd_participantes%>"/></td>-->
                <td colspan="2"></td>
                <td width="484"></td>
              </tr>
              <tr>
                <td><label for="label"> Descrição dos &nbsp;participantes:</label></td>
                <td><input name="desc_participantes" type="text" class="form-field" id="desc_participantes" style="width:429px;" size="30" maxlength="100" value="<%=de_participantes%>"/></td>
                <td colspan="2">&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table>
            <div id='variaveis'> </div>
            <%response.write "<input type='hidden' id = 'co_evento' name='co_evento' value="&request("co_evento")&">"%>
            <div id='datas'>
            <input type='hidden' id="dt_ini_atdmt_v" name = "dt_ini_atdmt_v"  />
            <input type='hidden' id="dt_prev_conc_v" name = "dt_prev_conc_v"  />
            <input type='hidden' id="observacaoEdicao_v" name = "observacaoEdicao"  />
            </div>
          </form>
          <p> <img src="imagens/info_16x16.png" /> Inclua os dados em cada aba clicando em Incluir. Por fim, clique em Salvar.</p>
          <fieldset style="border:none;">
          <div id="tabss">
            <ul>
              <li><a href="#responsaveis" style="font-size:11px">Responsáveis/Facilitadores</a></li>
              <li><a href="#publico" 	  style="font-size:11px">Público Alvo</a></li>
              <li><a href="#servicos" 	  style="font-size:11px">Servi&ccedil;os</a></li>
              <li><a href="#recursos" 	  style="font-size:11px">Recursos</a></li>
              <li><a href="#material"  	  style="font-size:11px">Material</a></li>
              <!-- <li><a href="#arquivos"     style="font-size:11px">Arquivos</a></li>-->
              <li><a href="#observacoes"  style="font-size:11px">Observações</a></li>
            </ul>
            <div id="responsaveis"> <img src="imagens/info_16x16.png"/> <span style="font-size:12px; margin-bottom:4px">Informe os responsáveis pelo evento ou, no caso de treinamentos, os 			facilitadores.</span>
              <p></p>
              <label for="usuario" >Usuário:</label>
              <input class="form-field" name="responsavel_matricula" type="text" size="7" maxlength="7" id="responsavel_matricula" style="font-size:12px"/>
              <input class="form-field" name="responsavel_usuario" type="text" size="40" maxlength="100" id="responsavel_usuario" style="font-size:12px"/>
              <input  name="incluirResponsavel" class="myButton" type="button"   value="Incluir" id="incluirResponsavel" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <%
			  
			  query = "SELECT USUARIO.CO_MATRICULA, USUARIO.NO_NOME FROM TB_EVENTO_ORGANIZADORES AS EVENTO JOIN VW_USUARIOS AS USUARIO ON EVENTO.CO_MATRICULA = USUARIO.CO_MATRICULA WHERE CO_EVENTO="&request("co_evento")
			  
			  
			  		set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open query, dados_sys

			  %>
              <div class="tabela" align="center">
                <table class="table" id="tabela_responsavel">
                  <tr>
                    <td style="width:20%"> Código/Matrícula </td>
                    <td> Nome </td>
                    <td style="width:5%"></td>
                  </tr>
                   <%
                  	 DO UNTIL rs.eof 
		  		   %>
                 	<tr class='responsavel'>
							<td id='responsavel_matricula'><%=rs("CO_MATRICULA")%></td>
							<td id='responsavel_nome'><%=rs("NO_NOME")%></td>
							<td id='X'><img src='imagens/delete_16x16.png' /> </td>
							</tr>
                    <%
              		 		
						rs.movenext 

					LOOP
						  %>
                </table>
              </div>
            </div>
            <div id="publico">
              <label for="publico">P&uacute;blico:</label>
              <select class="form-select" name="incluirPublico" id="publico_alvo" style="font-size:12px;">
                <%
					strQuery = "select CO_PUBLICO_ALVO,DE_PUBLICO_ALVO from TB_PUBLICO_ALVO ORDER BY DE_PUBLICO_ALVO" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
						DO UNTIL rs.eof 
						  
								response.write "<option value="&rs("CO_PUBLICO_ALVO")&">"&rs("DE_PUBLICO_ALVO")&"</option>"
								rs.movenext 
						  
						LOOP
					
					set rs = nothing			
				%>
              </select>
              <input  name="incluirPublico" class="myButton" type="button"  value="Incluir" id = "incluirPublico" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
                     <%
			  
			  query = "SELECT PUBLICO.CO_PUBLICO_ALVO, PUBLICO.DE_PUBLICO_ALVO FROM TB_EVENTO_PUBLICO AS EVENTO JOIN TB_PUBLICO_ALVO AS PUBLICO ON EVENTO.CO_PUBLICO_ALVO = PUBLICO.CO_PUBLICO_ALVO WHERE EVENTO.CO_EVENTO="&request("co_evento")
			  
			  
			  		set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open query, dados_sys

			  %>
              <div class="tabela" align="center">
              
                <table class="table" id="tabela_publico">
                  <tr>
                    <td style="width:20%"> Público </td>
                    <td style="width:0.8%"></td>
                           <%
                  	 DO UNTIL rs.eof 
		  		   %>
                   <tr class='publico'>
							<input type='hidden' id='publico_codigo' value="<%=rs("CO_PUBLICO_ALVO")%>">
							<td id='publico_publico'><%=rs("DE_PUBLICO_ALVO")%></td>
							<td id='X'><img src='imagens/delete_16x16.png' /> </td>
				  </tr>
                    <%
              		 		
						rs.movenext 

					LOOP
						  %>
                  </tr>
                </table>
              </div>
            </div>
            <div id="servicos"> <img src="imagens/info_16x16.png" /> <span style="font-size:12px;">Servi&ccedil;os que dever&atilde;o ser contratados para o evento.</span>
              <p></p>
              <label for="tipo">Tipo:</label>
              <select class="form-select" style="font-size:12px;" id="tipo_servico">
                <%
					strQuery = "select CO_TIPO_CONTRATACAO,DE_TIPO from TB_TIPOS_CONTRATACAO ORDER BY DE_TIPO" 
					
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
						DO UNTIL rs.eof 
						  
							response.write "<option value="&rs("CO_TIPO_CONTRATACAO")&">"&rs("DE_TIPO")&"</option>"
							rs.movenext 
						  
						LOOP
					
					set rs = nothing
					
					%>
              </select>
              <input  name="incluir_servico" class="myButton" type="button"  value="Incluir" id="incluirServico" style="padding-right:10px; padding-left:10px; margin:16px; margin-bottom:0px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p></p>
              <p>
                <label style="margin-bottom:4px;" >Observações:</label>
              <p/>
              <textarea class="form-field" name="observacao_servico" id="observacao_servico" cols="60" rows="2" style="font-size:12px; margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
              <%
			  			  query = "SELECT SERVICO.CO_TIPO_CONTRATACAO, SERVICO.DE_TIPO, EVENTO.DE_OBS FROM TB_EVENTO_CONTRATACAO AS EVENTO JOIN TB_TIPOS_CONTRATACAO AS SERVICO ON EVENTO.CO_TIPO_CONTRATACAO = SERVICO.CO_TIPO_CONTRATACAO WHERE EVENTO.CO_EVENTO="&request("co_evento")
			  
			  
			  		set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open query, dados_sys
			  %>
              <div class="tabela" align="center">
                <table class="table" id="tabela_servicos">
                  <tr>
                    <td> Tipo </td>
                    <td> Observação </td>
                    <td style="width:5%"></td>
                  </tr>
                               <%
                  	 DO UNTIL rs.eof 
		  		   %>
               	<tr class='servico'>
							<input type='hidden' id='servico_codigo' value="<%=rs("CO_TIPO_CONTRATACAO")%>">
							<td id='servico_tipo'><%=rs("DE_TIPO")%></td>
							<td id='servico_observacao'><%=rs("DE_OBS")%></td>
							<td id='X'><img src='imagens/delete_16x16.png' /> </td>
							</tr>
                    <%
              		 		
						rs.movenext 

					LOOP
						  %>
                </table>
              </div>
            </div>
            <div id="recursos">
              <label for="tipo">Tipo:</label>
              <select class="form-select" style="font-size:12px;" id="tipo_recurso">
                <%
					strQuery = "select CO_RECURSO, DE_RECURSO from TB_TIPOS_RECURSOS ORDER BY DE_RECURSO" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
						DO UNTIL rs.eof 
							response.write "<option value="&rs("CO_RECURSO")&">"&rs("DE_RECURSO")&"</option>"
							rs.movenext 
						LOOP
					
					set rs = nothing
				
				%>
              </select>
              <label for "quantidade">Quantidade:</label>
              <input name="quantidade_recurso" id="quantidade_recurso" class="form-field" type="text" size="2" maxlength="5" style="font-size:12px"/>
              <input  name="imprimir_termo_recurso" class="myButton" type="button"  id="imprimir_termo_recurso"value="Imprimir termo" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <input  name="incluir_recurso" class="myButton" type="button" value="Incluir" id="incluirRecurso" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p/>
              <label >Observações sobre o empréstimo:</label>
              <p/>
              <textarea class="form-field" name="observacao_recurso" cols="60" rows="2"  id="observacao_recurso" style="font-size:12px; padding-top:5px;margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
              <p></p>
              <%
			  
			  	query1 = "SELECT EMP_REC.CO_RECURSO, EMP_REC.QT_RECURSO FROM TB_EMPRESTIMO AS EMPRESTIMO JOIN TB_EMPRESTIMO_RECURSO AS EMP_REC ON EMPRESTIMO.CO_EMPRESTIMO = EMP_REC.CO_EMPRESTIMO WHERE EMPRESTIMO.CO_EVENTO="&request("co_evento")
				
			  	set rs=Server.CreateObject("ADODB.RecordSet")
				rs.Open query1, dados_sys

			  %>
              <div class="tabela" align="center">
                <table class="table" id="tabela_recurso">
                  <tr>
                    <td> Descrição </td>
                    <td> Quantidade </td>
                    <td style="width:5%" id="remover"></td>
                  </tr>
                    <%
                  	 DO UNTIL rs.eof 
					 
					 codigo = rs("CO_RECURSO")
					 query2 = "SELECT DE_RECURSO FROM TB_TIPOS_RECURSOS WHERE CO_RECURSO="&codigo
					 tipo = objConn.execute(query2)("DE_RECURSO")
		  		   %>
            				<tr class='recurso'>
							<input type='hidden' id='recurso_codigo' value=<%=codigo%>>
							<td id='recurso_tipo'><%=tipo%></td>
							<td id='recurso_quantidade'><%=rs("QT_RECURSO")%></td>
							<td id='X'><img src='imagens/delete_16x16.png'/></td>
							</tr>
                    <%
              		 		
						rs.movenext 

					LOOP
						  %>
                </table>
              </div> <!--fim div tabela-->
            </div> <!--fim div recurso-->
            <div id="material">
              <label for="tipo">Material:</label>
              <select class="form-select" style="font-size:12px;" id="materiais">
                <%

					strQuery = "select CO_MATERIAL, NO_MATERIAL from TB_ESTOQUE_MATERIAL WHERE IC_ATIVO=1  and co_unidade_fgts = "&request.Cookies("co_usuario_unidade_siiag")&"ORDER BY NO_MATERIAL" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
					DO UNTIL rs.eof   
						response.write "<option value="&rs("CO_MATERIAL")&">"&rs("NO_MATERIAL")&"</option>"
						rs.movenext 
					LOOP
					
					set rs = nothing
				
				%>
              </select>
              <label for "quantidade_material">Quantidade:</label>
              <input name="quantidade_material" id = "quantidade_material" class="form-field" type="text" size="2" maxlength="5" style="font-size:12px"/>
              <input  name="incluirMaterial" class="myButton" type="button"  value="Incluir" id="incluirMaterial" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p></p>
                 <%
			 	
				'rESPONSE.Write request("co_evento")
				
			  	query1 = "SELECT CO_PEDIDO FROM TB_EVENTO_PEDIDOS WHERE CO_EVENTO="&request("co_evento")
				'rESPONSE.Write query1
				set bs=Server.CreateObject("ADODB.RecordSet")
				bs.Open query1, dados_sys
				
				if  not bs.eof then
				codigo = bs("CO_PEDIDO")
				 'response.write "código" & codigo
			  %>
              <div class="tabela" align="center">
                <table class="table" id="tabela_material">
                  <tr>
                    <td> Nome </td>
                    <td> Quantidade </td>
                    <td> Disponíveis </td>
                    <td style="width:5%"></td>
                  </tr>
                   <%
				   
				   	query2 = "SELECT PEDIDO.QT_SOLICITADA, MATERIAL.NO_MATERIAL, MATERIAL.CO_MATERIAL, MATERIAL.QT_QUANTIDADE FROM TB_ESTOQUE_ITEM_PEDIDO AS PEDIDO JOIN TB_ESTOQUE_MATERIAL AS MATERIAL ON PEDIDO.CO_MATERIAL = MATERIAL.CO_MATERIAL WHERE CO_PEDIDO="&codigo
				   set rs=Server.CreateObject("ADODB.RecordSet")
				   
					rs.Open query2, dados_sys
				   if not rs.eof then
						 DO UNTIL rs.eof 
						 
							 codigo = rs("CO_MATERIAL")
							 nome = rs("NO_MATERIAL")
							 quantidade = rs("QT_SOLICITADA")
							 qtd_disp = rs("QT_QUANTIDADE")
							 
					   %>
							<tr class='material'>
							<input type='hidden' id='material_codigo' value=<%=codigo%>>
							<td id='material_nome'><%=nome%></td>
							<td id='material_quantidade'><%=quantidade%></td>
							<td id='material_disponivel'><%=qtd_disp%></td>
							<td id='X'><img src='imagens/delete_16x16.png' /></td>
							</tr>
						<%
								
							rs.movenext 
	
						LOOP
					end if
					response.Write "</table>"
					response.write "</div>"

					end if
					
						  %>
               
              </div>
        
           <!-- arquivos ficava aqui -->
            <div id="observacoes"> <img src="imagens/info_16x16.png" /> <span style="font-size:12px;">Use este espaço para dar mais informações ao Apoio.</span>
              <p></p>
              <textarea class="form-field" id ="v_observacoes" name="v_observacoes" cols="70" rows="5" style="font-size:12px;margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"><%=de_obs%></textarea>
            </div>
          </div>
          <!-- Fim da div Tabs -->
          <p/>
            
          <TABLE>
          	<% tipo_prazo_demanda = 7 %> 
 
             <!-- #INCLUDE FILE ="include_campo_datas.asp" -->
          </TABLE>
          	<!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->
          
          <div align="center">
            <input name="incluir" class="myButton" type="button" value="Salvar" id="salvar" />
          </div>
          </fieldset>
          </p>
          </fieldset>
        </div>
      </div>
      <!--include calendario-->
    </div>
  </div>
  <!-- #INCLUDE file ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
