<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>


<title>Consultar F&eacute;rias</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->


<%
 mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i))
				End If
                %>



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


.ui-autocomplete {

height:120px;
overflow-y:scroll;
overflow-x:hidden;
font-size:12px;
}
</style>


<script>

function ChamarLink(){
	   
	   var situacaoFerias = document.getElementById("situacaoFerias").value;
	   //#ALTERADO EM 15/05/2016
	   var data_inicial = document.getElementById("data_inicial").value;
	   var data_final = document.getElementById("data_final").value;
	   var ic_requerimento = $("#ic_requerimento").prop("checked") ? 1:0;
	   var ic_aviso_assinado = $("#ic_aviso_assinado").prop("checked") ? 1:0;
	   var ic_substituicao = $("#ic_substituicao").prop("checked") ? 1:0;
	   //--------------------------
	   
	   var nome = document.getElementById("nome").value;
	   

	   
	   /*alert(situacaoFerias);
	   alert(data);
	   alert(nome);*/
	   
	   if ((situacaoFerias=="") && (data=="") && (nome=="")){
	   
	   alert("Escolha pelo menos um critério de busca");
	   
	   }else{
	   //#ALTERADO EM 14/05/2016
	   window.location.assign("consultar_ferias.asp?situacao="+situacaoFerias+"&data_inicial="+data_inicial+"&data_final="+data_final+"&nome="+nome+"&ic_requerimento="+ic_requerimento+"&ic_aviso_assinado="+ic_aviso_assinado+"&ic_substituicao="+ic_substituicao);
	   }
	   
	   
	   
	   
	  
	    } 



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
$(document).ready(function() {
	
$('.cancelar').on("click", function(){
	$("#divCancelamento" ).dialog({
		modal: true,
		dialogClass: "dialogo",
		closeText: "Fechar",
		width:'auto'
	});
	$("#codigoCancelamento").val($(this).parent().parent().find("#co_ferias").val());
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
				tipo:"ferias",
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

$('.X').on('click',function(){


			
			if($("#perfil_ferias_editar").val()=="False"){
				alert("Você não tem permissão para cancelar.");
				return false;
			}

			var co_situacao = $(this).parent().parent().find("#co_situacao").val()		
			if(co_situacao != "1" && $("#perfil_controle").val()=="False" ){
				alert("Situação do pedido não permite cancelamento. Contatar o RH de sua unidade.");
				return false;
			}

			var IC_GERENTE = $("#ic_gerente").val()
			var matricula_a_excluir = $(this).parent().parent().find("#matricula").html()
			var matricula_logado = $("#mat_usuario").val()
			
			
			var situacao = $(this).parent().parent().find("#situacao").val()

			var confirmacao = window.confirm("Tem certeza que desejar cancelar?");
			
			if (confirmacao == true){ 
				window.location.assign("ferias_cancelamento.asp?matriculaaexcluir="+matricula_a_excluir+"&situacao="+situacao+"");
				//alert("Deu Certo");
			} 			

			//alert(matricula_logado);
			//alert(IC_GERENTE);
			//alert(matricula_a_excluir);
			
			
			
/*			if (IC_GERENTE == 1 || matricula_logado == "E712237" || matricula_logado == "C054423" || matricula_logado == "C097105"){
			
			// MATRICULAS DE TESTE E71100 DO RENATO, E712237 DO BELMONDO
			
			var confirmacao = window.confirm("Tem certeza que desejar cancelar?");
			
			if (confirmacao == true){ 
			
			window.location.assign("ferias_cancelamento.asp?matriculaaexcluir="+matricula_a_excluir+"&situacao="+situacao+"");
			//alert("Deu Certo");
			
			} 
			
			
			
			}
			else{
			
			alert("Desculpe, mas somente coordenadores/substitutos tem autoridade para fazer esse pedido! ");
			
			}
	*/		
			
			

	});
	});
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

<script>
$(document).ready(function() {

$('.edit').on('click',function(){
			//alert($("#perfil_ferias_editar").val());
			
			if($("#perfil_ferias_editar").val()=="False"){
				alert("Você não tem permissão para editar.");
				return false;
			}

			var co_situacao = $(this).parent().parent().find("#co_situacao").val()		
			if(co_situacao != "1" && $("#perfil_controle").val()=="False" ){
				alert("Situação do pedido não permite edição.");
				return false;
			}
								
			var matricula = $(this).parent().parent().find("#matricula").html()
			var nome = $(this).parent().parent().find("#nome").html()
			var data = $(this).parent().parent().find("#data").html()
			var descricao = $(this).parent().parent().find("#descricao").html()
			var dtcriacao= $(this).parent().parent().find("#dtcriacao").html()
			var empregadosolicitante = $(this).parent().parent().find("#empregadosolicitante").html()
			var dias = $(this).parent().parent().find("#dias").html()
			var qt_parcelas = $(this).parent().parent().find("#qt_parcelas").val()
			var dias_gozo = $(this).parent().parent().find("#dias_gozo").val()
			
			var ic_abono = $(this).parent().parent().find("#ic_abono").val()
			
			var situacao = $(this).parent().parent().find("#situacao").val()
			
			var co_ferias = $(this).parent().parent().find("#co_ferias").val()
			
			
			
			/*alert(matricula + nome + data+descricao+dtcriacao+empregadosolicitante+dias);*/
			

			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			//#ALTERADO EM 14/05/2016(width passou de 400 para 500)	
			window.open("ferias_edicao.asp?matricula="+matricula+"&nome="+nome+"&data="+data+"&qt_parcelas="+qt_parcelas+"&gozo="+dias_gozo+"&ic_abono="+ic_abono+"&situacao="+situacao+"&diasdeabono="+dias+"&co_ferias="+co_ferias+"", "Teste", "height=480, width=520, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");

						
	});
	});
	
	
</script>  

<script>
$(document).ready(function() {


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



</head>
<body>

<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
<%

  Perfil_Acesso("20") 
  if not  perfil_acesso_siiag then
	  response.Redirect ("acesso_negado.asp")
  end if
  acesso_editar       = tem_acesso_cookie("21")	' ferias editar
  'response.write "<input type='hidden' id = 'perfil_ferias_consultar' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_ferias_editar' value=" & acesso_editar  & ">"

	if tem_acesso_admin_cookie("21") then ' VISAO UNIDADE
		consultaTodos = true
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
	'elseif perfil_acesso_admin_siiag then
	'	consultaGS = true
	'	consultaTodos = false
	'else
	'	consultaGS = false
	'	consultaTodos = false
	'end if
	response.write "<input type='hidden' id = 'perfil_controle' value=" & consultaTodos  & ">"
%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >FÉRIAS</span> </div>
        <div class="usuariodiv" style="min-height:540PX;">
          <div id='cssmenu'>
            <ul>
               <%			
			  if tem_acesso_cookie("2") then
              	response.write "<li><a href='ferias.asp'><span>Solicitar</span></a></li>"
			  	response.write "<li class='active'><a href='consultar_ferias.asp'><span>Consultar</span></a></li>"	  
			  else
			  	response.write "<li class='active'><a href='consultar_ferias.asp'><span>Consultar</span></a></li>"			  
			  end if			
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
              <ul>
              <!--<li id="opener"><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>
         <!-- <div id="dialog" title="Caixa de Ajuda">
            <p>Para fazer uma busca, preencha pelo menos um dos campos.</p>
          </div>-->
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos" > Consultar F&eacute;rias</span></legend>
          <p class="paragrafoteste">
            <label>Situa&ccedil;&atilde;o :</label>
            
<%

situacao = Request("situacao")

data =  Request("data")

nome = Request("nome")


'Response.Write nome
'if situacao = "" Then

'situacao = 1

'End If

	'#ALTERADO EM 15/05/2016
	queryChecaPerfil = "SELECT * FROM TB_USUARIOS_PERFIS WHERE CO_MATRICULA = '"&session("v_usuario_matricula")&"' AND CO_PERFIL = 2"
	set resultadoPerfil= Server.CreateObject("ADODB.RecordSet")
	resultadoPerfil.Open queryChecaPerfil, dados_sys
	rh = false
	
	if not resultadoPerfil.eof then
		rh = true
	end if

	   response.write "<input type='hidden' id='ic_gerente' value="&request.Cookies("ic_gerente_siiag")&" />"
	   response.write "<input type='hidden' id='mat_usuario' value="&MATRICULA&" />"
	   %>
            
            <select name"situacao" id="situacaoFerias"  style=" width:150px;max-width:150px;min-width:150px;" class="form-select" >
              <option <% if situacao="" Then Response.Write "selected='selected'" END IF%> value="">Todas</option>	 
              <option <% if situacao="1" Then Response.Write "selected='selected'" END IF%> value="1">Socilitado</option>
              <option <% if situacao="2" Then Response.Write "selected='selected'" END IF%> value="2" >Confirmado</option>
              <option <% if situacao="3" Then Response.Write "selected='selected'" END IF%> value="3">Pendente</option>
              <option <% if situacao="5" Then Response.Write "selected='selected'" END IF%> value="5">Gozado</option>
              <option <% if situacao="6" Then Response.Write "selected='selected'" END IF%> value="6">Não Atendido</option>
              <option <% if situacao="7" Then Response.Write "selected='selected'" END IF%> value="7">Cancelado</option>
              <option <% if situacao="8" Then Response.Write "selected='selected'" END IF%> value="8">Em Andamento</option>
            </select>
            &nbsp;&nbsp;
            <!-- #ALTERADO EM 14/05/2016 -->
           <label>Nome: </label><input style="margin-top:5px;" class="form-field" name="nome" id="nome" type="text" <% if nome <> "" Then Response.Write "value= '"&nome&"' " End If %> size="35" maxlength="100" />
            <label>De: </label>
            <input  name="data_inicial" type="text" size="8" maxlength="10"  id="data_inicial" class="datepicker" value="<%=request("data_inicial")%>"/>
            <label>a: </label>
            <input name="data_final" type="text" size="8" maxlength="10"  id="data_final" class="datepicker" value="<%=request("data_final")%>"/>
            
            <label>
            <input type="submit" name="button" id="button" class="myButton" value="Pesquisar" onclick="ChamarLink();" />
            </label>
            <!---------------------------->
            
             <%if rh then%>
            <!--#ALTERADO EM 18/05/2016------------------------>
            <table>
             <tr>
				<td><label>Pendências:</label></td>
              <td colspan="2"><input type="checkbox"  id="ic_aviso_assinado" name="ic_aviso_assinado"  value = "1" <% if request("ic_aviso_assinado") = "1" Then Response.Write "checked" END IF %>/><label for="ic_aviso_assinado">Aviso de férias</label>
                  <input type="checkbox"  id="ic_substituicao" name="ic_substituicao"  style="margin-right:-2px" value = "1" <% if request("ic_substituicao") = "1" Then Response.Write "checked" END IF %>/><label for"ic_substituicao" style="padding-left:6px">Substituição</label>
        
        <input type="checkbox"  id="ic_requerimento" name="ic_requerimento"  value = "1" <% if request("ic_requerimento") = "1" Then Response.Write "checked" END IF %>/><label for="ic_requerimento">Requerimento de parcelamento/pecúnia</label>
            </td>
            </tr>
            </table>
            <%end if%>
            <!------------------------------------------>
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
		 <!-- #INCLUDE FILE ="consulta_ferias_con.asp" -->
          </div>
          
          
          
          </fieldset>
          
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
  
</div>


<%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Cancelado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
		
				
		end if
		
		%>
<!--teste-->
<div id="divCancelamento" class="msg-dialog" style="display:none;" title="Cancelar">
	<input type="hidden" id="codigoCancelamento"/>
    <label>Motivo do cancelamento:</label><br />
    <textarea  class="form-field" name="motivoCancelamento" id="motivoCancelamento" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px; margin-left:5px"></textarea><br />
    <input  style="margin-top:7px;margin-left:5px;" name="botaoCancelar" id="botaoCancelar" class="myButton" type="button" value="Cancelar"/>
</div>
</body>
</html>





