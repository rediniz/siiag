<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Substitui&ccedil;&atilde;o</title>
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
				tipo:"substituicao",
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

			var co_situacao = $(this).parent().parent().find("#co_situacao").val();

			if($("#perfil_substituicao_editar").val()=="False"){
				alert("Você não tem permissão para editar.");
				return false;
			}

			if(co_situacao != "1" && $("#perfil_controle").val()=="False" ){
				alert("Situação do pedido não permite edição.");
				return false;
			}
				

								
			var co_substituicao = $(this).parent().parent().find("#codigo").html()
	
			/*alert(matricula + nome + data+descricao+dtcriacao+empregadosolicitante+dias);*/
			

			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			//#ALTERADO em 01/12/2015 (height passou de 280 para 360)#
			//#ALTERADO EM 11/04/2016(height passou de 360 para 420)
			window.open("substituicao_edicao.asp?co_substituicao="+co_substituicao, "Teste", "height=480, width=500, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
						
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

 var situacao 		= document.getElementById("situacoes").value;
// var coordenacao 	= document.getElementById("coordenacao").value;
 var data_inicio 	= document.getElementById("data_inicio").value;
 var data_final 	= document.getElementById("data_final").value;
 var coordenador    = document.getElementById("coordenador").value;

 /*alert(situacao);
 alert(coordenacao);
 alert(data_inicio);
 alert(data_final);*/
 
 //window.location.assign("consultar_substituicao.asp?situacao="+situacao+"&coordenacao="+coordenacao+"&data_inicio="+data_inicio+"&data_final="+data_final+"");
 window.location.assign("consultar_substituicao.asp?situacao="+situacao+"&coordenador="+coordenador+"&data_inicio="+data_inicio+"&data_final="+data_final+"");
 
}

</script>

</head>
<body>

<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
<%
  
	Perfil_Acesso("24") 
	if not perfil_acesso_siiag then
		response.Redirect ("acesso_negado.asp")
	end if
	'response.write "<input type='hidden' id = 'perfil_substituicao_consultar' value='" & perfil_acesso_siiag & "'>"
	response.write "<input type='hidden' id = 'perfil_substituicao_editar' value='" & tem_acesso("25")  & "'>"
	
	if tem_acesso_admin_cookie("24") then ' VISAO UNIDADE
		consultaTodos = true
		consultaGS = false
	elseif request.Cookies("co_usuario_co_visao") = "2" then ' VISAO COORDENACAO
		consultaGS = true
		consultaTodos = false
	elseif request.Cookies("co_usuario_co_visao") = "1" then ' VISAO USUARIO
		consultaGS = false
		consultaTodos = false
	end if  
	
	response.write "<input type='hidden' id = 'perfil_controle' value=" & consultaTodos  & ">"

%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >SUBSTITUIÇÃO</span> </div>
        <div class="usuariodiv" style="min-height:540px">
          <div id='cssmenu'>
            <ul>
              <%			
				if tem_acesso_cookie("5") then
					response.write "<li><a href='substituicao.asp'><span>Solicitar</span></a></li>"
				end if
				response.write "<li class='active'><a href='consultar_substituicao.asp'><span>Consultar</span></a></li>"			  

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
          <legend><span class="titulos">Consultar Substitui&ccedil;&otilde;es</span></legend>
          <p class="paragrafoteste">
           <%
			situacao = Request("situacao")
			data_inicio =  Request("data_inicio")
			data_final =  Request("data_final")
			coordenacao = Request("coordenacao")
			coordenador = Request("coordenador")			
			
			%>
            
          <table width="995" height="48">
            <tr>
            
          
            <td><label>Situação:</label>
           
             <select name="exibir_apenas" id="situacoes" class="form-select" style="width:100px;">
             <option value="" >Todas</option>
            <%
			
				query_situacao = "SELECT * FROM TB_SITUACOES ORDER BY CO_SITUACAO"
				set rs=Server.CreateObject("ADODB.RecordSet")
                rs.Open query_situacao, dados_sys 
				
				DO UNTIL rs.eof
				
			%>
              <option <% if cstr(rs("CO_SITUACAO"))=cstr(situacao) Then Response.Write "selected='selected'" END IF%> value=<%=rs("CO_SITUACAO")%>><%=rs("DE_SITUACAO")%></option>	
              
            <%
				rs.movenext
			    LOOP
			%>

            </select></td>
            
            <%if consultaTodos then%>
                <td><label>Coordenador:</label>
                <!--<select name="coordenador" id="coordenacao" class="form-select" style="width:250px;"> -->
                <select name="coordenador" id="coordenador" class="form-select" style="width:250px;">
                    <option value="" >Todos</option>
                  <%
                
                    query_coordenadores = "SELECT GS.CO_GS, GS.CO_GERENTE, USUARIO.NO_NOME FROM VW_GS AS GS JOIN TB_USUARIOS AS USUARIO ON GS.CO_GERENTE=USUARIO.CO_MATRICULA WHERE GS.IC_ATIVO = 1 AND GS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")
                    
                    set ds=Server.CreateObject("ADODB.RecordSet")
                    ds.Open query_coordenadores, dados_sys 
                    
                    DO UNTIL ds.eof
                    
                %>
                 <!-- <option <% if ds("CO_GS")=coordenacao Then Response.Write "selected='selected'" END IF%> value=<%=ds("CO_GS")%>><%=ds("NO_NOME")%></option>	-->
                  <option <% if ds("CO_GERENTE")=coordenador Then Response.Write "selected='selected'" END IF%> value=<%=ds("CO_GERENTE")%>><%=ds("NO_NOME")%></option>	
                  
                <%
                    ds.movenext
                    LOOP
                %>
                
                </select></td>
           
           <%end if%>
           
           <td><label>Per&iacute;odo :</label>
            <label>de</label>
            <input <% if data_inicio <> "" Then Response.Write "value= '"&data_inicio&"' " End If %> name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" style="width:67px;"/>
            <label>a</label>
            
            <input <% if data_final <> "" Then Response.Write "value= '"&data_final&"' " End If %>  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8" style="width:67px;"/> </td>
            
            
            <td><input type="submit" name="button" id="button" class="myButton" value="Pesquisar" onclick="Pesquisar();" /></td>
            
            
            
            </tr>
          </table>
            
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
            
            <!-- #INCLUDE FILE ="consulta_substituicao_con.asp" -->
            
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
