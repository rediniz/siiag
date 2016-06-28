<%@LANGUAGE="VBScript" CODEPAGE="65001"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Eventos/Treinamentos</title>
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


 <style>
	.ui-datepicker {
	font-size:12px;
}

.dialogo{

font-size:14px;
text-align:center;

}

.dialogo button{

vertical-align:middle;
}

.ui-dialog .ui-dialog-buttonpane .ui-dialog-buttonset {
	float: right;
	margin-right:20px;
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


<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

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
var tipo = document.getElementById("tipo").value;
//var situacao = document.getElementById("");

//alert(data_inicial);
//alert(data_final);
//alert(situacao);
//alert(Recurso);

window.location.assign("consultar_eventos_e_treinamentos.asp?situacao="+situacao+"&data_inicio="+data_inicial+"&data_final="+data_final+"&tipo="+tipo+"");
}


function FormatarData(campo,e) 
{
	 if (campo.value=="Data")
	 {
		campo.value="";
	 }
	 var cod="";
	 if(document.all) {cod=event.keyCode;} else {cod=e.which;} 
	 if(cod == 08) return;
	 if (cod < 48 || cod > 57)
	 {
	  if (cod < 45 || cod > 57) alert("Digite somente Caracteres Numéricos!");
	  cod=0;
	  campo.focus(); return false;
	 }
	 tam=campo.value.length; 
	 if(tam > 9) return false;
	 var caract = String.fromCharCode(cod);
	 if(tam == 2 || tam == 5) {campo.value+="/"+caract; return false;};  
	 campo.value+=caract; return false; 
}




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
	$("#codigoCancelamento").val($(this).parent().parent().find("#co_evento").val());
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
				tipo:"evento",
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
			var co_criador = $(this).parent().parent().find("#CO_CRIADOR").html();
			var co_usuario = $("#usuario").val();
			var co_situacao = $(this).parent().parent().find("#co_situacao").val();
			
			var perfil_evento_editar = $("#perfil_evento_editar").val();
			var perfil_evento_editar_admin = $("#perfil_evento_editar_admin").val();			
			
			if (perfil_evento_editar != "True"){
				alert("Você não tem permissão para editar.");
				return false;
			}
			
			if (perfil_evento_editar_admin !="True"){
				if (co_situacao != 1)
				{
					alert("Você não tem permissão para editar este evento. Edição é permitida somente para a situação 'Solicitado'.");	
					return false;
				}
				
			}
			
			/*if( (perfil_evento_editar=="True") || (co_criador == co_usuario &&  co_situacao == 1   ) )  {
			
			}
			else
			{
				if (co_situacao != 1)
				{
					alert("Você não tem permissão para editar este evento. Edição é permitida somente para a situação 'Solicitado'.");	
					return false;
				}
				else
				{
					alert("Você não tem permissão para editar.");
					return false;
				}
			}*/
								
			var co_evento = $(this).parent().parent().find("#co_evento").val();

			/*alert(matricula + nome + data+descricao+dtcriacao+empregadosolicitante+dias);*/
			
			window.location.assign("eventos_e_treinamentos_editar.asp?co_evento="+co_evento)
						
	});

	$('.lista').on('click',function(){
			var co_evento = $(this).parent().parent().find("#co_evento").val();
			//window.open("lista_frequencia_branca.asp?co_evento="+co_evento);
		//============================================[DIÁLOGO]===========================
		// A div com o conteúdo da janela está lá embaixo

		$( "#dialog-message" ).dialog({
			modal: false, // Escurecer o fundo ou não
			dialogClass: "dialogo", //classe para formatar via CSS
			closeText: "Fechar",
			buttons: { // Botões e suas funções
				"Em branco": function() {
					window.open("lista_frequencia_branca.asp?co_evento="+co_evento);
					$( this ).dialog( "close" );
				},
				"Empregados": function() {
					window.open("usuario_lista_frequencia.asp?co_evento="+co_evento);
					$( this ).dialog( "close" );
				}
			}
		});			
		//================================================================================			
			
	});

});
	
	
</script>

</head>
<body>

<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
<%
  
  Perfil_Acesso("26") 
  response.write "<input type='hidden' id = 'perfil_evento_editar_admin' value=" & tem_acesso_admin("29") & ">"
  response.write "<input type='hidden' id = 'perfil_evento_editar' value=" & tem_acesso("29")  & ">"
  response.write "<input type='hidden' id = 'usuario' value=" & request.Cookies("co_usuario_siiag")  & ">"  

  if not perfil_acesso_siiag then
	  response.Redirect ("acesso_negado.asp")
  end if


	' VERIFICA SE HÁ ALGUMA PRESTAÇÃO DE CONTAS PENDENTE PARA O USUARIO
	strQuery = "SELECT  " 
	strQuery = strQuery &  " EVENTOS.CO_EVENTO, EVENTOS.DE_EVENTO,  EVENTOS.DH_INICIO, EVENTOS.DH_FIM,  EVENTOS.DH_CRIACAO, EVENTOS.CO_CRIADOR, EVENTOS.QT_PARTICIPANTES,TIPO.DE_TIPO_EVENTO,SITUACOES.DE_SITUACAO,GS.NO_GS,LOCAL.DE_LOCAL "
	strQuery = strQuery &  " FROM TB_EVENTOS AS  EVENTOS "
	strQuery = strQuery &  " INNER JOIN TB_TIPOS_EVENTO AS TIPO ON TIPO.CO_TIPO_EVENTO = EVENTOS.CO_TIPO_EVENTO "
	strQuery = strQuery &  " INNER JOIN TB_SITUACOES AS SITUACOES ON SITUACOES.CO_SITUACAO = EVENTOS.CO_SITUACAO "
	strQuery = strQuery &  " INNER JOIN VW_GS AS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA "
	strQuery = strQuery &  " INNER JOIN TB_LOCAL AS LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL  "
	strQuery = strQuery &  "  WHERE ('" & date() & "' > DH_FIM AND QT_PARTICIPANTES_PRESENTES IS NULL AND EVENTOS.CO_SITUACAO IN (2) ) "	
	strQuery = strQuery &  "  AND ( EVENTOS.CO_EVENTO IN (SELECT CO_EVENTO FROM TB_EVENTO_ORGANIZADORES WHERE CO_MATRICULA = '" & REQUEST.Cookies("co_usuario_siiag") & "') )"
	set ds=Server.CreateObject("ADODB.RecordSet")
	ds.Open strQuery, dados_sys
	if not ds.eof then
		libera_link = true
	else
		libera_link = false
	end if
	set ds = nothing

%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv" style="min-height:540px;">
       	<div class="titulosModulos" ><span >EVENTOS E TREINAMENTOS</span> </div>
          <div id='cssmenu'>
            <ul>
              <%			
			  if tem_acesso("7") then
              	response.write "<li ><a href='eventos_e_treinamentos.asp'><span>Solicitar</span></a></li>"
			  end if
			  	response.write "<li class='active'><a href='consultar_eventos_e_treinamentos.asp'><span>Consultar</span></a></li>"						  
			  if libera_link then
				  response.write "<li class='inactive'><a href='eventos_treinamentos_pendencia.asp'><span>Prestação de Contas</span></a></li>"	
			  end if

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
          <legend><span class="titulos">Consultar Eventos e Treinamentos</span></legend>
          <p class="paragrafoteste">
            <label>Tipo:</label>
            <%
			situacao = Request("situacao")
			data_inicio= Request("data_inicio")
			data_final=Request("data_final")
			tipo = Request("tipo")
			
			%>
            
            <%
			
				strQuery = "select CO_TIPO_EVENTO, DE_TIPO_EVENTO  from TB_TIPOS_EVENTO ORDER BY DE_TIPO_EVENTO; " 
				set rs=Server.CreateObject("ADODB.RecordSet")
				rs.Open strQuery, dados_sys
			%>

            
            <select name"tipo" id="tipo" class="form-select">
              <option  <% if tipo="" Then Response.Write "selected='selected'" END IF%> value="">Todos</option>
              
              <% do while not rs.eof%>              
	              <option <% if cstr(tipo)=cStr(rs("CO_TIPO_EVENTO")) Then Response.Write "selected='selected'" END IF%> value="<%=rs("CO_TIPO_EVENTO")%>"><%=RS("DE_TIPO_EVENTO")%></option>	 
			<%
					rs.movenext
			  loop
			%>
 <!--             <option <% 'if tipo="5" Then Response.Write "selected='selected'" END IF%> value="5">Audiconfer&ecirc;ncia</option>
              <option <% 'if tipo="13" Then Response.Write "selected='selected'" END IF%> value="13">Confraterniza&ccedil;&atilde;o</option>
              <option <% 'if tipo="14" Then Response.Write "selected='selected'" END IF%> value="14">Evento Externo</option>
              <option <% 'if tipo="4" Then Response.Write "selected='selected'" END IF%> value="4">Palestra</option>
              <option <% 'if tipo="3" Then Response.Write "selected='selected'" END IF%> value="3">Reuni&atilde;o</option>
              <option <% 'if tipo="2" Then Response.Write "selected='selected'" END IF%> value="2">Treinamento</option>
              <option <% 'if tipo="1" Then Response.Write "selected='selected'" END IF%> value="1">Visita Externa</option>
              <option <% 'if tipo="6" Then Response.Write "selected='selected'" END IF%> value="6">Visita Interna</option>  -->
            </select>
            &nbsp;&nbsp;
            <label>Situa&ccedil;&atilde;o:</label>
            
             <%
			
				strQuery = "select CO_SITUACAO, DE_SITUACAO  from TB_SITUACOES ORDER BY DE_SITUACAO; " 
				set rs=Server.CreateObject("ADODB.RecordSet")
				rs.Open strQuery, dados_sys
			%>


            <select name="exibir_apenas" id="situacoes" class="form-select" style="width:100px;"> 
              <option <% if situacao="" Then Response.Write "selected='selected'" END IF%> value="">Todos</option>
              
              	<% do while not rs.eof%>              
	              <option <% if cstr(situacao)=cStr(rs("CO_SITUACAO")) Then Response.Write "selected='selected'" END IF%> value="<%=rs("CO_SITUACAO")%>"><%=RS("DE_SITUACAO")%></option>	 
			<%
					rs.movenext
			  loop
			%>
	 
            </select>
            &nbsp;&nbsp;
            <label>Por Per&iacute;odo: </label>
             <input <% if data_inicio <> "" Then Response.Write "value= '"&data_inicio&"' " End If %> name="data_inicio" id="data_inicio" class="datepicker" type="text" size="10" maxlength="10" OnKeyPress="return(FormatarData(this,event))"  />
            <label>a</label>
            <input <% if data_final <> "" Then Response.Write "value= '"&data_final&"' " End If %>  name="data_final" id="data_final" class="datepicker" type="text" size="10" maxlength="10" OnKeyPress="return(FormatarData(this,event))"  />
            &nbsp;&nbsp;
            <input name="incluir" class="myButton" type="button" value="Pesquisar" onclick="Pesquisar();" />
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
          
           <!-- #INCLUDE FILE ="consulta_eventos_e_treinamentos_con.asp" -->
           
          </div>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
          </fieldset>
          
          <!-- DIV QUE VIRA DIALOG -->
          <div  align="center" id="dialog-message" title="Gerar lista de frequência" class="msg-dialog" style="display:none">
            <p><img src="imagens/edit-paste_003.png"  /></p>
			<p>Que tipo de lista você deseja?</p>
		  </div>
        <!-- FIM DIV QUE VIRA DIALOG -->
        
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
