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

<script> <!-- SCRIPT PARA ADICIONAR LOCAL -->

$(document).ready(function() {

$('#addlocal').on('click',function(){
			
			//alert("deu certo");

			var sim=1;
			
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("eventos_cadastrar_local.asp?cadastrar="+sim, "Cadastrar Local", "height=280, width=510, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
						
	});
	});
	
	
</script>  




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
	
	   var matricula = $("#responsavel_matricula").val();
	   var usuario = $("#responsavel_usuario").val();	   
	    
				$( "#tabela_responsavel" ).append( 
							"<tr class='responsavel'>" +
							"<td id='responsavel_matricula'>" + matricula + "</td>" +
							"<td id='responsavel_nome'>" + usuario + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
	});
								
 	$( "#incluirPublico" ).click(function() {
	
	   var publico = $("#publico_alvo option:selected").html();
	   var codigo = $("#publico_alvo").val();
	   
				$( "#tabela_publico" ).append( 
							"<tr class='publico'>" +
							"<input type='hidden' id='publico_codigo' value="+codigo+">" +
							"<td id='publico_publico'>" + publico + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
	});

				
		$( "#incluirServico" ).click(function() {
	
	   var tipo = $("#tipo_servico option:selected").html();
	   var codigo = $("#tipo_servico ").val();
	   var quantidade = $("#quantidade_servico").val();
	   var observacao = $("#observacao_servico").val();
	   
				$( "#tabela_servicos" ).append( 
							"<tr class='servico'>" +
							"<input type='hidden' id='servico_codigo' value="+codigo+">" +
							"<td id='servico_tipo'>" + tipo + "</td>" +
							"<td id='servico_observacao'>" + observacao + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
		});
				
		$( "#incluirRecurso" ).click(function() {
	
	   var tipo = $("#tipo_recurso option:selected").html();
	   var codigo = $("#tipo_recurso").val();
	   var quantidade = $("#quantidade_recurso").val();
	   
	   if (quantidade == 0 || quantidade == ""){
	   
	   		alert("Informe a quantidade do recurso.");
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
	
	   var nome = $("#materiais option:selected").html();
	   var codigo = $("#materiais").val();
	   var quantidade = $("#quantidade_material").val();
	   
	   if (quantidade == 0 || quantidade == ""){
	   
	   		alert("Informe a quantidade do material.");
			return false;
	   
	   }
	   
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
	
	   var recurso = $("#recursos").val();
	   var quantidade = $("#spinner").val();
	   
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
	
	descricao = $("#descricao").val();
	iniciativa = $("#iniciativa").val();
	periodo_inicio = $("#periodo_inicio").val();
	periodo_fim = $("#periodo_fim").val();
	local = $("#local").val();
	situacao = $("#situacao").val();
	horario_inicio = $("#horario_inicio").val();
	horario_fim = $("#horario_fim").val();
	situacao = $("#situacao").val();
	tipo_evento = $("#tipo_evento").val();
	qtd_participantes =  $("#qtd_participantes").val();
	desc_participantes =  $("#desc_participantes").val();
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
	$("#variaveis").append("<input type='hidden' id='v_observacoes' name='v_observacoes' value='"+$("#observacoes_gerais").text()+"'>");
	
		//$.ajax({
	//				type: "POST",
	//				url: 'eventos_solicitar.asp',
	//				data:  $("#formulario").serialize(),
	//				success: function (data) {
	//					alert("Evento cadastrado com sucesso.");
	//					$("#variaveis").empty();
	//            	},		
	//				error: function(data){
	//				alert("Erro.");
	//				}	    
	//  			});
	
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
  
  Perfil_Acesso("7") 
  response.write "<input type='hidden' id = 'perfil_evento_consultar' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_evento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
   
  if not perfil_acesso_siiag then
	  response.Redirect ("consultar_eventos_e_treinamentos.asp")
  end if

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
				'if request.Cookies("co_usuario_siiag") <> "C053498" then
				'	response.write "Estamos realizando um alteração neste módulo"
				'	response.End()
				'end if
			response.write "<li class='active'><a href='eventos_e_treinamentos.asp'><span>Solicitar</span></a></li>"
			if tem_acesso("26") then
				response.write "<li class='inactive'><a href='consultar_eventos_e_treinamentos.asp'><span>Consultar</span></a></li>"			
			end if			
			response.write "<li class='inactive'><a href='eventos_treinamentos_pendencia.asp'><span>Prestação de Contas</span></a></li>"	

			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
            <!--  <li id="opener"><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>	
          <!--<div id="dialog" title="Caixa de Ajuda">
            <p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
          </div>-->
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
          <legend><span class="titulos">Eventos e Treinamentos</span></legend>
          <p class="paragrafoteste">
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; padding-bottom:0">

<%
		' CONSULTA PARA VERIFICAR SE EXISTEM EVENTOS PARA REALIZAR A PRESTAÇÃO DE CONTAS DA QT DE PARTICIPANTES PRESENTES
		strQuery = "SELECT  " 
		strQuery = strQuery &  " EVENTOS.CO_EVENTO, EVENTOS.DE_EVENTO,  EVENTOS.DH_INICIO, EVENTOS.DH_FIM,  EVENTOS.DH_CRIACAO, EVENTOS.CO_CRIADOR, EVENTOS.QT_PARTICIPANTES,TIPO.DE_TIPO_EVENTO,SITUACOES.DE_SITUACAO,GS.NO_GS,LOCAL.DE_LOCAL "
		strQuery = strQuery &  " FROM TB_EVENTOS AS  EVENTOS "
		strQuery = strQuery &  " INNER JOIN TB_TIPOS_EVENTO AS TIPO ON TIPO.CO_TIPO_EVENTO = EVENTOS.CO_TIPO_EVENTO "
		strQuery = strQuery &  " INNER JOIN TB_SITUACOES AS SITUACOES ON SITUACOES.CO_SITUACAO = EVENTOS.CO_SITUACAO "
		strQuery = strQuery &  " INNER JOIN VW_GS AS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA "
		strQuery = strQuery &  " INNER JOIN TB_LOCAL AS LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL  "
		strQuery = strQuery &  "  WHERE ('" & date() & "' > DH_FIM AND QT_PARTICIPANTES IS NOT NULL AND QT_PARTICIPANTES_PRESENTES IS NULL AND EVENTOS.CO_SITUACAO IN (2) ) AND (EVENTOS.CO_GS_INICIATIVA = "& request.Cookies("co_usuario_gs_siiag") &")"
		set ds=Server.CreateObject("ADODB.RecordSet")
		ds.Open strQuery, dados_sys 
		if not ds.eof then
			alerta = "ATENÇÃO: Existe PENDÊNCIA na PRESTAÇÃO DE CONTAS.Clique na aba 'Prestação de Contas' para concluir o processo. "
		end if
		set ds = nothing
%>

	<font color="#FF0000" ><%=alerta %></font>


          <!-- dados da inclusão -->
          <legend><span class="titulos">Dados da Inclus&atilde;o</span></legend>
          <p class="paragrafoteste"> <img src="imagens/X000000.png"  height="19" width="19"/>&nbsp;
            <label>Matr&iacute;cula: <%=usuario%></label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <label>Unidade:
            <% =request.Cookies("co_usuario_unidade_siiag") %>
            </label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <label>Data: </label>
            <label name="data">
            <% response.Write DAY(DATE()) &"/"& MONTH(DATE()) &"/"& YEAR(DATE()) %>
            </label>
          </p>
          </fieldset>


          <!-- fim do dados da inclusão -->
          <p><img src="imagens/info_16x16.png" /> <span class="style1">Entre com os dados abaixo para Eventos. Para Treinamento, basta substituir o Tipo para "Treinamento".</span></p>
          <form id='formulario' action="eventos_solicitar.asp"  enctype="application/x-www-form-urlencoded" method="post">
            <table width="915" height="135" border="0" cellpadding="0" cellspacing="5">
              <tr>
                <td width="120"><label for="label">Descri&ccedil;&atilde;o:</label></td>
                <td colspan="4"><input name="descricao" id ="descricao" class="form-field" type="text" size="68" maxlength="1024" />
                </td>
              </tr>
              <tr>
                <td width="120"><label for="label">Iniciativa:</label></td>
                <td colspan="4"><select class="form-select" name="iniciativa" id="iniciativa">
                    <option value=""></option>
				<%
                query = "SELECT CO_GS, NO_GS FROM VW_GS WHERE  co_unidade = " & request.Cookies("co_usuario_unidade_siiag") &" order by no_gs"
                set ds=Server.CreateObject("ADODB.RecordSet")
                ds.Open query, dados_sys 
                DO UNTIL ds.eof
	                response.write "<option value="& ds("co_gs") & ">" & ds("no_gs") & "</option>"				 
                ds.movenext
                LOOP	  
                %>
                  </select></td>
              </tr>
              <tr>
                <td width="120"><label>Per&iacute;odo:</label></td>
                <td colspan="4"><input  name="periodo_inicio" id="periodo_inicio" class="datepicker" type="text" size="10" maxlength="10"  value="<% Response.Write(Date) %>"/>
                  <input  name="periodo_fim" id="periodo_fim" class="datepicker" type="text" size="10" maxlength="10"  value="<% Response.Write(Date) %>"/>
                </td>
              </tr>
              <tr>
                <td width="120"><label for="local">Local:</label></td>
                <td colspan="3"><select class="form-select" name="local" id="local">
                    <option value=""></option>
                    <%
			
					strQuery = "select  CO_LOCAL, DE_LOCAL from TB_LOCAL where co_unidade = " & request.Cookies("co_usuario_unidade_siiag") &" and ativo=1 ORDER BY DE_LOCAL" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
					DO UNTIL rs.eof 
		  
						response.write "<option value="&rs("CO_LOCAL")&">"&rs("DE_LOCAL")&"</option>"						
						rs.movenext 
				
					LOOP
		
					set rs = nothing

		
				%>
                  </select>
				 <a class="myButton" id="addlocal" title="Adicionar Local" style="height:20px; cursor:pointer;"><img src="imagens/add_16x16.png"/></a>
                </td>
                <td colspan="1"></td>
              </tr>
              <tr>
                <td width="120"><label>Situa&ccedil;&atilde;o:</label>
                </td>
                <td colspan="4">
                
                    <%
					
					if not (perfil_acesso_siiag) then
							response.write "<select class='form-select' disabled='disabled' ame='situacao' id='situacao' style='width:140px'>"
					else
							response.write "<select class='form-select' name='situacao' id='situacao' style='width:140px'>"
					end if
					
					
                    response.write "<option value=''></option>"
			
					strQuery = "select CO_SITUACAO, DE_SITUACAO from TB_SITUACOES ORDER BY DE_SITUACAO" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
					DO UNTIL rs.eof 
					
						situacao = rs("DE_SITUACAO")
						disabled = ""
			  
						if(situacao = "Solicitado") then
							response.write "<option selected='selected' value="&rs("CO_SITUACAO")&">"+situacao+"</option>"
						else
							response.write "<option value="&rs("CO_SITUACAO")&">"+situacao+"</option>"
						end if
						
						rs.movenext 
				
					LOOP
		
					set rs = nothing
		
				%>
                  </select>
                </td>
              </tr>
              <tr>
                <td width="120"><label>Tipo do Evento:</label>
                  &nbsp;</td>
                <td colspan="4"><select class="form-select" name="tipo_evento" id="tipo_evento">
                    <option value=""></option>

                    <%
			
					strQuery = "select CO_TIPO_EVENTO, DE_TIPO_EVENTO from TB_TIPOS_EVENTO ORDER BY DE_TIPO_EVENTO" 
					set rs=Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					
				
					DO UNTIL rs.eof 
		  
						response.write "<option value="&rs("CO_TIPO_EVENTO")&">"+rs("DE_TIPO_EVENTO")+"</option>"				
						rs.movenext 
				
					LOOP
		
					set rs = nothing
		
				%>
                  </select>
                </td>
              </tr>
              <tr>
                <td width="130" colspan="1"><label for="horario_de">Horário &nbsp;do&nbsp;Evento:</label></td>
                <td colspan="4"><input id="horario_inicio" name="horario_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" style="height:24px"/>
                  <input id="horario_fim" name="horario_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" style="height:24px"/></td>
              </tr>

              <tr>
                <td  colspan="5"><label for="label">Deseja ter controle de presença dos participantes?
                <input type="radio" name="rd_presenca" id="rd_presenca_sim" class="presenca" value="1" /> Sim
                <input type="radio" name="rd_presenca" id="rd_presenca_nao" class="presenca" value="0" checked="checked" /> Não
                </label>
                </td>
              </tr>

              <tr id="tr_qt_presenca" style="display:none">
                <td colspan="5"><label for="label">Quantidade&nbsp;de Participantes:</label>
                <input name="qtd_participantes" type="text" class="form-field" id="qtd_participantes" size="2" maxlength="3"/>
                </td>
              </tr>

<!--
              <tr>
                <td><label for="label">Quantidade<br/>
                  &nbsp;de Participantes:</label></td>
                <td width="86" colspan="4"><input name="qtd_participantes" type="text" class="form-field" id="qtd_participantes" size="2" maxlength="3"/></td>
              </tr>
    -->          
              <tr>
                <td width="120" colspan="5"><label for="label"> Descrição dos &nbsp;participantes:</label>
<input name="desc_participantes" type="text" class="form-field" id="desc_participantes" style="width:429px;" size="30" maxlength="100"/></td>
              </tr>
            </table>
            <div id='variaveis'> </div>
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
              <div class="tabela" align="center">
                <table class="table" id="tabela_responsavel">
                  <tr>
                    <td style="width:20%"> Código/Matrícula </td>
                    <td> Nome </td>
                    <td style="width:5%"></td>
                  </tr>
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
              <div class="tabela" align="center">
                <table class="table" id="tabela_publico">
                  <tr>
                    <td style="width:20%"> Público </td>
                    <td style="width:0.8%"></td>
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
                <label style="margin-bottom:4px;" for="observacoes">Observações:</label>
              <p/>
              <textarea class="form-field" name="observacao_servico" id="observacao_servico" cols="60" rows="2" style="font-size:12px; margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
              <div class="tabela" align="center">
                <table class="table" id="tabela_servicos">
                  <tr>
                    <td> Tipo </td>
                    <td> Observação </td>
                    <td style="width:5%"></td>
                  </tr>
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
              <label for="observacoes">Observações sobre o empréstimo:</label>
              <p/>
              <textarea class="form-field" name="observacao_recurso" cols="60" rows="2"  id="observacao_recurso" style="font-size:12px; padding-top:5px;margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
              <p></p>
              <div class="tabela" align="center">
                <table class="table" id="tabela_recurso">
                  <tr>
                    <td> Descrição </td>
                    <td> Quantidade </td>
                    <td style="width:5%" id="remover"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="material">
              <label for="tipo">Material:</label>
              <select class="form-select" style="font-size:12px;" id="materiais">
                <!-- #INCLUDE FILE ="include/Conexao.asp" -->
                <%

					strQuery = "select CO_MATERIAL, NO_MATERIAL from TB_ESTOQUE_MATERIAL WHERE CO_UNIDADE_FGTS = "&request.Cookies("co_usuario_unidade_siiag")&" AND IC_ATIVO=1 ORDER BY NO_MATERIAL" 
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
              <div class="tabela" align="center">
                <table class="table" id="tabela_material">
                  <tr>
                    <td> Nome </td>
                    <td> Quantidade </td>
                    <td> Disponíveis </td>
                    <td style="width:5%"></td>
                  </tr>
                </table>
              </div>
            </div>
            <!--       <div id="arquivos">
              <label for="tipo">Tipo:</label>
              <input class="form-field" name="tipo" id="tipo_arquivo" type="text" size="35" maxlength="100" style="font-size:12px"/>
              <input  name="procurar" class="myButton" type="button"  value="Procurar" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <input  name="incluir" class="myButton" type="button"  value="Incluir" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p></p>
              <div class="tabela" align="center">
                <table >
                  <tr>
                    <td> Link </td>
                    <td> Nome </td>
                  </tr>
                  <tr>
                    <td>Linha 1</td>
                    <td>Linha 1</td>
                </table>
              </div>
            </div>-->
            <div id="observacoes"> <img src="imagens/info_16x16.png" /> <span style="font-size:12px;">Use este espaço para dar mais informações ao Apoio.</span>
              <p></p>
              <textarea class="form-field" id ="observacoes_gerais" name="observacoes_gerais" cols="70" rows="5" style="font-size:12px;margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
            </div>
          </div>
          <!-- Fim da div Tabs -->
          <p/>
          <div align="center">
            <input name="incluir" class="myButton" type="button" value="Salvar" id="salvar" />
          </div>
          </fieldset>
          </p>
          </fieldset>
          <script language="javascript">
</script>
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
<%
objConn.close
set objConn = nothing
%>