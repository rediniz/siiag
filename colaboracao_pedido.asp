<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Colaboração</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link href="css/ui-lightness/jquery.ui.all.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.mousewheel.js"></script>
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
	height: 14px;
	font-size: 13px;
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
	height: 14px;
	font-size: 13px;
}
.ui-datepicker {
	font-size: 12px;
}
.datepicker {
	height: 15px;
	border: 1px solid #b5cce2;
	background: #edf4fc;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	color: #666;
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
	padding: 6px;
	width: auto;
}
.datepicker:focus {
	background: #fff;
	color: #000000;
	outline: none;
	padding: 6px;
	box-shadow: 0 0 5px #9ecaed;
}
</style>
<script>
    $(document).ready(function(e) {
		
		// Paginação com Ajax -------------------------------------
		$(document).on("click", ".paginacao", function(){
			var pagina = $("#pag").val();
			if($(this).prop("id") == "anterior"){
				pagina = parseInt($("#pag").val())-1;
			}
			if($(this).prop("id") == "proxima"){
				pagina = parseInt($("#pag").val())+1;
			}
			if($(this).prop("id") == "ultima"){
				pagina = 1 + (Math.round(parseInt($("#ultimaPagina").val()) /2 + 0.5)-1)*pagina;
			}
			if(pagina == 2){
				pagina = 1;
			}
			consultar(pagina);
		});
		
		$(document).on("keypress", "#inputPagina", function(e){
			if(window.event.keyCode==13){
				if($.isNumeric($(this).val()) && $(this).val() != 0 ){
				var paginaAtual = $("#pag").val();
				var ultimaPagina = 1 + (Math.round(parseInt($("#ultimaPagina").val()) /2 + 0.5)-1)*paginaAtual;
				var pagina = 1 + (parseInt($(this).val()) - 1) * $("#pag").val();

				if(pagina > ultimaPagina){
					pagina = ultimaPagina;
				}
				
				consultar(pagina);
				
				}else{
					alert("Página inválida.");
					return false;
				}
			}
		});
		// ------------------------------------------------------------
	
		function inicializarWidgets(){
			$(".datepicker").datepicker({
					dateFormat: 'dd/mm/yy',
					dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
					dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
					dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
					monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
					monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
					nextText: 'Próximo',
					prevText: 'Anterior'
			   });
		   
			var spinner = $( ".spinner" ).spinner({
				spin: function( event, ui ) {
					if ( ui.value < 0 ) {
						$( this ).spinner( "value", 0 );
						return false;
					}
				}			
			});
			
			var tabs = $("#tabs").tabs();
		}
		
		inicializarWidgets();
		consultar(1);
		
		$("#divEditarPedido").dialog({
			autoOpen: false,
			title: "Editar pedido",
			modal: true,
			height: "auto",
			width: "auto",
			draggable: false
		});
		
		$(document).on("click",".editarPedido",function() {
			var criador = $(this).parent().parent().find("#criador").val().toUpperCase();
			var matriculaUsuario = $("#matriculaUsuario").val().toUpperCase();
			var perfil = parseInt($("#perfil").val());
			
			if(((matriculaUsuario == criador) && (perfil == 5)) || (perfil == 1 || perfil == 7)){
				$.ajax({	
					data:{
						id: $(this).parent().parent().find("#idPedido").val()
					},
					url: "colaboracao_pedido_con.asp?acao=carregarEdicao",
					success: function(data) {
						$("#divEditarPedido").html(data);  
						inicializarWidgets();
						$(".datepicker").datepicker("disable");
						$("#divEditarPedido").dialog("open");
						$(".datepicker").datepicker("enable");
					},
					error: function(data){
						alert("Erro ao carregar dados para edição.");
						console.log(data.responseText);
					}	
				})
			}else{
				alert("Você não possui permissão para editar este pedido de colaboração.");
				return false;
			}
		});
		
		$(document).on("mouseover", ".colaboradores", function(){
			var pedido = $(this).parent().parent().find("#idPedido").val();
			
			$.ajax({	
				data:{
					pedido: pedido
				},
				url: "colaboracao_pedido_con.asp?acao=carregarColaboradores",
				success: function(data) {
					var elemento = $(document).find("#colaboradores"+pedido);
					 elemento.tooltip({
						 items: "[colaboradores]",
						 content: data,
						 track: true,
						 tooltipClass: "tooltip-colaboradores"
					 }).on("mouseout focusout", function(){
						 $(this).tooltip("close");
					 }).tooltip("open");
				},
				error: function(data){
					alert("Erro ao carregar colaboradores.");
					console.log(data.responseText);
				}	
			})		
		});
		
	//	$(document).on("mouseleave", ".colaboradores", function(){
//
//			$(document).tooltip("destroy");
//	
//		});
		
		$(document).on("change","#statusEdicao",function() {
			if($(this).val() == 3){
				$("#linhaMensagemReconhecimento").show();
			} else {
				$("#linhaMensagemReconhecimento").hide();
			}		
		});
		$("#cadastrar").on("click", function(){
			
			if($("#dataInicial").val() == "" || $("#dataFinal").val() == ""){
				alert("Informe a data inicial e final.");
				return false;
			}
			
			if($("#atividade").val() == ""){
				alert("Informe a atividade.");
				return false;
			}
			
			if($("#quantidadeHoras").val() == ""){
				alert("Informe a quantidade de horas.");
				return false;
			}
			
			$.ajax({	
       			data: $("#formularioSalvar").serialize(),
       			url: "colaboracao_pedido_con.asp?acao=salvar",
        		success: function(data) {
          			alert("Pedido de colaboração cadastrado com sucesso.");	 
					$("#formularioSalvar")[0].reset();
					$( "#tabs" ).tabs({ active: 1 });
					consultar(0);
        		},
		 		error: function(data){
					alert("Erro ao cadastrar pedido de colaboração.");
					console.log(data.responseText);
 				}	
      		})
		});
		
		$(document).on("click","#editar", function(){
			
			if($("#dataInicialEdicao").val() == "" || $("#dataFinalEdicao").val() == ""){
				alert("Informe a data inicial e final.");
				return false;
			}
			
			if($("#atividadeEdicao").val() == ""){
				alert("Informe a atividade.");
				return false;
			}
			
			if($("#quantidadeHorasEdicao").val() == ""){
				alert("Informe a quantidade de horas.");
				return false;
			}
			
			if($("#statusEdicao").val() == ""){
				alert("Informe o status.");
				return false;
			}
			
			$.ajax({	
       			data: $("#formularioEditar").serialize(),
       			url: "colaboracao_pedido_con.asp?acao=editar",
        		success: function(data) {
					if($("#statusEdicao").val() == 3){
						alert("Pedido de colaboração editado com sucesso. A mensagem de reconhecimento será exibida na agenda.");
					}else{
						alert("Pedido de colaboração editado com sucesso.");
					}
					consultar(0);	  
					$("#divEditarPedido").dialog("close");
        		},
		 		error: function(data){
					alert("Erro ao editar pedido de colaboração.");
					console.log(data.responseText);
 				}	
      		})
		});
		
		$("#consultar").on("click", function(){
			consultar(0);
		});
		
		function consultar(pag){
			var dataInicial = $("#dataInicialConsulta").val();
			var dataFinal = $("#dataFinalConsulta").val();
			var atividade = $("#atividadeConsulta").val();
			var status = $("#statusConsulta").val();
			
			$.ajax({
       			data: {
					dataInicial : dataInicial,
					dataFinal : dataFinal,
					atividade : atividade,
					status : status,
					pag: pag
				},
       			url: "colaboracao_pedido_con.asp?acao=consultar",
        		success: function(data) {
					$("#tabelaResultados").html(data); 	  
        		},
		 		error: function(data){
					alert("Erro ao consultar pedido.");
					console.log(data.responseText);
 				}	
      		})	
		}
   	});
</script>
</head>
<body>
<%
	matriculaUsuario = Session("v_Usuario_Matricula")
	queryChecaPerfil = "SELECT CO_PERFIL FROM TB_USUARIOS_PERFIS WHERE CO_MATRICULA = '"&matriculaUsuario&"'"
	perfil = objConn.execute(queryChecaPerfil)("CO_PERFIL")
%>
<input type="hidden" id="perfil" name="perfil" value="<%=perfil%>" />
<input type="hidden" id="matriculaUsuario" name="matriculaUsuario" value="<%=matriculaUsuario%>" />


<div class="teste2"> 
  <!--fundo azul do meio--> 
  <!-- #INCLUDE FILE ="topo.asp" -->
<style>
.tooltip-colaboradores{
	width: auto;	
	padding:4px;
}
</style>
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos" ><span >GIFUG COLABORATIVA</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <%
				if (perfil = 1 or perfil = 5 or perfil = 7) then
			  %>
              <li class='inactive'><a href='colaboracao_conhecimento.asp'><span>Conhecimento</span></a></li>
              <%
				end if
              %>
              <li class='active'><a href='colaboracao_pedido.asp'><span>Pedido</span></a></li>
                            <%
				if (perfil = 1 or perfil = 5 or perfil = 7) then
			  %>
              <li class='inactive'><a href='colaboracao_indicacao.asp'><span>Indicação</span></a></li>
              <%
				end if
              %>
              <!--<li class='inactive'><a href='colaboracao_reconhecimento.asp'><span>Reconhecimento</span></a></li>-->
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
          		  <li><a target="_blank" href='\\ce7180nt005\CaixaNet\Intranet\SIIAG_WEB\Arquivos\Manual_GIFUG_Colaborativa.pdf'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <div id="tabs">
            <ul>
			   <%
				if (perfil = 1 or perfil = 5 or perfil = 7) then
					%>
                    	<li><a class="nome_sugestao" href="#abaCadastrar" style="font-size:12px">Cadastrar</a></li>
                    <%
				end if
               %>
              <li><a class="nome_sugestao" href="#abaConsultar" style="font-size:12px">Consultar</a></li>
            </ul>
            <br />
            <%
				if (perfil = 1 or perfil = 5 or perfil = 7) then
			%>
            <!--CADASTRAR================================================================================================================-->
            <div id="abaCadastrar">
              <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
                <p></p>
                <form action="colaboracao_pedido_con?acao=salvar.asp" method="post" name="formularioSalvar" id="formularioSalvar" target="_self" enctype="application/x-www-form-urlencoded">
                  <table>
                    <tr>
                      <td align="right"><label>De</label></td>
                      <td><input name="dataInicial" id="dataInicial" class="datepicker" type="text" size="10" maxlength="10"/>
                        <label>Até</label>
                        <input name="dataFinal" id="dataFinal" class="datepicker" type="text" size="10" maxlength="10"/></td>
                    </tr>
                    <tr>
                      <td align="right"><label>Atividade</label></td>
                      <td align="left"><input type="text" class="form-field" id="atividade" name="atividade"  size="80"/></td>
                    </tr>
                    <tr>
                      <td align="right"><label>Quantidade<br/>
                          de horas</label></td>
                      <td><input style="width:20px;height:20px;font-size:14px;" class = "spinner" id="quantidadeHoras" name="quantidadeHoras" value=0></td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                    <tr>
                      <td></td>
                      <td><input name="cadastrar" class="myButton" type="button" value="Cadastrar" id="cadastrar" /></td>
                    </tr>
                  </table>
                </form>
              </fieldset>
            </div>
            <%
				end if
             %>
            <!--CONSULTAR================================================================================================================-->
            <div id="abaConsultar">
              <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
                <br />
                <table>
                  <tr>
                    <td align="right"><label>De</label></td>
                    <td><input name="dataInicialConsulta" id="dataInicialConsulta" class="datepicker" type="text" size="10" maxlength="10"/>
                      <label>Até</label>
                      <input name="dataFinalConsulta" id="dataFinalConsulta" class="datepicker" type="text" size="10" maxlength="10"/></td>
                  </tr>
                  <tr>
                    <td align="right"><label>Atividade</label></td>
                    <td align="left"><input type="text" class="form-field" id="atividadeConsulta" name="atividadeConsulta"  size="80"/></td>
                  </tr>
                  <tr>
                    <td align="right"><label>Status</label></td>
                    <td><select class="form-select" id="statusConsulta" name="statusConsulta">
                        <option value="">Todos</option>
                        <%
							queryStatus = "select * from TB_STATUS_COLABORACAO ORDER BY descricao;" 
							set rs=Server.CreateObject("ADODB.RecordSet")
							rs.Open queryStatus, dados_sys
							
							do while not rs.eof 
						%>
                        <option value="<%=rs("id")%>"><%=rs("descricao")%></option>
                        <%
								rs.movenext
			  				loop
							rs.close
							set rs = nothing
						%>
                      </select></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td><input name="consultar" class="myButton" type="button" value="Consultar" id="consultar" /></td>
                  </tr>
                </table>
                <br />
                <div class="tabela" id="tabelaResultados"> </div>
              </fieldset>
            </div>
            <!-- EDITAR PEDIDO =============================================================================================================================-->
            <div id="divEditarPedido">
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo--> 
  <!-- #INCLUDE FILE ="rodape.asp" --> 
</div>
<!--teste-->
</body>
</html>
