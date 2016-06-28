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
<link href="css/jquery.ui.all.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
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
</style>
<script>
    $(document).ready(function(e) {
		var tabs = $( "#tabs" ).tabs();
		
		$("#cadastrarConhecimento").dialog({
			autoOpen: false,
			title: "Novo tipo de conhecimento",
			modal: true,
			height: "auto",
			width: "auto",
			draggable: false
		});
		
		consultar();
		
		$(document).on("click", ".linhaConhecimento", function(){
			var idConhecimento = $(this).attr("idConhecimento");
			$(".conhecimento").hide();
			$(".setaConhecimento").attr("src", "imagens/setalado.png");
			$(".conhecimento"+idConhecimento).toggle();	
			$(".setaConhecimento"+idConhecimento).attr("src", "imagens/setalado.png");
			$("#setaConhecimento"+idConhecimento).attr("src", "imagens/setabaixo.png");
		});
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
		
		$("#adicionarConhecimento").click(function() {
			$("#cadastrarConhecimento").dialog("open");
		});
		
		$("#cadastrar").on("click", function(){
			
			if($("#empregado").val() == ""){
				alert("Informe o empregado");
				return false;
			}
			
			if($("#tipoConhecimento").val() == ""){
				alert("Informe o tipo de conhecimento.");
				return false;
			}
			
			$.ajax({	
       			data: $("#formularioSalvar").serialize(),
       			url: "colaboracao_conhecimento_con.asp?acao=salvar",
        		success: function(data) {
          			alert("Conhecimento cadastrado com sucesso.");	
					$("#formularioSalvar")[0].reset();
					$( "#tabs" ).tabs({ active: 1 });
					consultar();
        		},
		 		error: function(data){
					alert("Erro ao cadastrar conhecimento.");
					console.log(data.responseText);
 				}	
      		})
		});
		
		$("#adicionarNovoConhecimento").on("click", function(){
			
			if($("#descricaoNovoConhecimento").val() == ""){
				alert("Informe a descrição do conhecimento.");
				return false;
			}
			
			var descricaoNovoConhecimento = $("#descricaoNovoConhecimento").val();
			
			$.ajax({
       			data:{
					descricaoNovoConhecimento:descricaoNovoConhecimento
				},
       			url: "colaboracao_conhecimento_con.asp?acao=cadastrarNovoConhecimento",
        		success: function(data) {
          			alert("Novo tipo de conhecimento adicionado à lista com sucesso."); 
					$("#descricaoNovoConhecimento").val("");
					$("#cadastrarConhecimento").dialog("close"); 
					atualizarTiposConhecimento(descricaoNovoConhecimento);	  
        		},
		 		error: function(data){
					alert("Erro ao cadastrar novo tipo de conhecimento.");
					console.log(data.responseText);
 				}	
      		})
		});
		
		$("#consultar").on("click", function(){		
			consultar();
		});
		
		function atualizarTiposConhecimento(descricaoNovoConhecimento){
			$.ajax({
       			url: "colaboracao_conhecimento_con.asp?acao=atualizarTiposConhecimento",
				data: {
					descricaoNovoConhecimento:descricaoNovoConhecimento
				},
        		success: function(data) {
					$("#tipoConhecimento").html(data); 	
					$("#tipoConhecimentoConsulta").html(data); 
					$("#tipoConhecimentoConsulta").val("");
        		},
		 		error: function(data){
					alert("Erro ao atualizar tipos de conhecimento.");
					console.log(data.responseText);
 				}	
      		})
		}
		
		function consultar(){
			var coordenacao = $("#coordenacao").val();
			var tipoConhecimento = $("#tipoConhecimentoConsulta").val();
			
			$.ajax({
       			data: {
					coordenacao:coordenacao,
					conhecimento: tipoConhecimento
				},
       			url: "colaboracao_conhecimento_con.asp?acao=consultar",
        		success: function(data) {
					$("#tabelaResultados").html(data); 	  
        		},
		 		error: function(data){
					alert("Erro ao consultar conhecimento.");
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

	if (perfil <> 1 and perfil <> 5 and perfil <> 7) then
		response.Redirect("colaboracao_pedido.asp")
	end if
%>
<div class="teste2"> 
  <!--fundo azul do meio--> 
  <!-- #INCLUDE FILE ="topo.asp" -->
  
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos" ><span >GIFUG COLABORATIVA</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='colaboracao_conhecimento.asp'><span>Conhecimento</span></a></li>
              <li class='inactive'><a href='colaboracao_pedido.asp'><span>Pedido</span></a></li>
              <li class='inactive'><a href='colaboracao_indicacao.asp'><span>Indicação</span></a></li>
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
              <li><a class="nome_sugestao" href="#abaCadastrar" style="font-size:12px">Cadastrar</a></li>
              <li><a class="nome_sugestao" href="#abaConsultar" style="font-size:12px">Consultar</a></li>
            </ul>
            <br />
            <!--CADASTRAR================================================================================================================-->
            <div id="abaCadastrar">
              <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
                <p></p>
                <form action="colaboracao_conhecimento_con?acao=salvar.asp" method="post" name="formularioSalvar" id="formularioSalvar" target="_self" enctype="application/x-www-form-urlencoded">
                  <table>
                    <tr>
                      <td align="right"><label>Empregado</label></td>
                      <td><select name='empregado' id='empregado'   class='form-select' style="width:250px">
                          <option value=''>Selecione o empregado...</option>
                          <%
					  	  matriculaUsuario = Session("v_Usuario_Matricula") 
						  query = "SELECT CO_MATRICULA AS matricula_colaborador, NO_NOME AS nome_colaborador FROM VW_USUARIOS WHERE CO_GS = (SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '"&matriculaUsuario&"') AND IC_ATIVO=1 AND LETRA = 'C' ORDER BY NO_NOME"
						  set rs = Server.CreateObject("ADODB.RecordSet")
						  rs.Open query, dados_sys
	
						  DO UNTIL rs.eof
							  matriculaColaborador = rs("matricula_colaborador")
							  nomeColaborador = rs("nome_colaborador")
							  %>
                          <option value=<%=matriculaColaborador%>><%=nomeColaborador%></option>
                          <%
							  rs.movenext
						  LOOP
						  rs.close
						  set rs = nothing
						%>
                        </select></td>
                    </tr>
                    <tr>
                      <td align="right"><label>Tipo de<br/>
                          conhecimento</label></td>
                      <td><select name='tipoConhecimento' id='tipoConhecimento'   class='form-select' style="width:250px">
                          <option value=''>Selecione o tipo de conhecimento...</option>
                          <%
						  query = "SELECT * from TB_TIPO_CONHECIMENTO order by descricao"
						  set rs = Server.CreateObject("ADODB.RecordSet")
						  rs.Open query, dados_sys
	
						  DO UNTIL rs.eof
							  idConhecimento = rs("id")
							  descricaoConhecimento = rs("descricao")
							  %>
                          <option value=<%=idConhecimento%>><%=descricaoConhecimento%></option>
                          <%
							  rs.movenext
						  LOOP
	
						  rs.close 
						  set rs = nothing
						%>
                        </select>
                        <button class="myButton" id="adicionarConhecimento" name="adicionarConhecimento" type="button" style="vertical-align:bottom; width:18px; padding-left:7px" title="Adicionar Conhecimento"><img src="imagens/add_16x16.png" /></button></td>
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
            
            <!--CONSULTAR================================================================================================================-->
            <div id="abaConsultar">
              <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
                <br />
                <table>
                  <tr>
                    <td align="right"><label>Coordenação</label></td>
                    <td><select name='coordenacao' id='coordenacao'   class='form-select' style="width:250px">
                        <option value=''>Todas</option>
                        <%
					  	  matriculaUsuario   = Session("v_Usuario_Matricula") 
						  coordenacaoUsuario = objConn.execute("select co_gs from vw_usuarios where co_matricula = '"&matriculaUsuario&"'")("co_gs")
						  query  			 = "select CO_GS, NO_GS  from VW_GS where co_unidade = 7180 and ic_ativo=1 ORDER BY NO_GS"
						  set rs 			 = Server.CreateObject("ADODB.RecordSet")
						  rs.Open query, dados_sys
	
						  DO UNTIL rs.eof
							  nomeCoordenacao=rs("NO_GS")
							  codigoCoordenacao=rs("CO_GS")
							  %>
                        <option value=<%=codigoCoordenacao%> <%if coordenacaoUsuario = codigoCoordenacao then %> selected="selected" <% end if %>><%=nomeCoordenacao%></option>
                        <%
							  rs.movenext
                          LOOP
                          rs.close
                          set rs = nothing
                          %>
                      </select></td>
                  </tr>
                  <tr>
                    <td align="right"><label>Tipo de<br/>
                        conhecimento</label></td>
                    <td><select name='tipoConhecimentoConsulta' id='tipoConhecimentoConsulta'  class='form-select' style="width:250px">
                        <option value=''>Todos</option>
                        <%
						  query = "SELECT * from TB_TIPO_CONHECIMENTO"
						  set rs = Server.CreateObject("ADODB.RecordSet")
						  rs.Open query, dados_sys
	
						  DO UNTIL rs.eof
							  idConhecimento = rs("id")
							  descricaoConhecimento = rs("descricao")
							  %>
                        <option value=<%=idConhecimento%>><%=descricaoConhecimento%></option>
                        <%
							  rs.movenext
						  LOOP
	
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
                    <td><button id="consultar" name="consultar" class="myButton">Consultar</button></td>
                  </tr>
                </table>
                <br />
                <div class="tabela" id="tabelaResultados"> </div>
              </fieldset>
            </div>
            <!-- CADASTRAR CONHECIMENTO =============================================================================================================================-->
            <div id="cadastrarConhecimento">
              <label for="novoTipoConhecimento"> Descrição:
                <input type="text" class="form-field" id="descricaoNovoConhecimento" name="descricaoNovoConhecimento"  size="80"/>
              </label>
              <br />
              <br />
              <div align="center">
                <button id="adicionarNovoConhecimento" name="adicionarNovoConhecimento" class="myButton">Adicionar</button>
              </div>
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
