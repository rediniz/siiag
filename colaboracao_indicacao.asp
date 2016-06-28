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
</style>
<script>
    $(document).ready(function(e) {
		
		var spinner = $( ".spinner" ).spinner({
			spin: function( event, ui ) {
				if ( ui.value < 0 ) {
					$( this ).spinner( "value", 0 );
					return false;
				}
			}			
		});
		
		$("#indicar").on("click", function(){
			
			if($("#indicado").val() == ""){
				alert("Informe o empregado indicado.");
				return false;
			}
			
			if($("#quantidadeHoras").val() == ""){
				alert("Informe a quantidade de horas.");
				return false;
			}
			
			$.ajax({	
       			data: $("#formularioSalvar").serialize(),
       			url: "colaboracao_indicacao_con.asp?acao=indicar",
        		success: function(data) {
          			alert("Colaboração registrada com sucesso.");	  
        		},
		 		error: function(data){
					alert("Erro ao registrar colaboração.");
					console.log(data.responseText);
 				}	
      		})
		});
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
<input type="hidden" id="perfil" name="perfil" value="<%=perfil%>" />
<input type="hidden" id="matriculaUsuario" name="matriculaUsuario" value="<%=matriculaUsuario%>" />
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
              <li class='inactive'><a href='colaboracao_conhecimento.asp'><span>Conhecimento</span></a></li>
              <li class='inactive'><a href='colaboracao_pedido.asp'><span>Pedido</span></a></li>
              <li class='active'><a href='colaboracao_indicacao.asp'><span>Indicação</span></a></li>
              <!--<li class='inactive'><a href='colaboracao_reconhecimento.asp'><span>Reconhecimento</span></a></li>-->
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
             	<li><a target="_blank" href='\\ce7180nt005\CaixaNet\Intranet\SIIAG_WEB\Arquivos\Manual_GIFUG_Colaborativa.pdf'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <!--COLABORAR================================================================================================================-->
          <div id="abaIndicar">
            <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
              <p></p>
              <form action="colaboracao_indicacao_con?acao=indicar.asp" method="post" name="formularioSalvar" id="formularioSalvar" target="_self" enctype="application/x-www-form-urlencoded">
                <table>
                  <tr>
                    <td align="right"><label>Pedido</label></td>
                    <td><select name='pedido' id='pedido'   class='form-select'>
                        <option value=''>Informe o pedido para a indicação...</option>
                        <%
							query = "select coordenacao.apelido_coordenacao, pedido.quantidade_horas, pedido.coordenacao, pedido.atividade, pedido.id as idPedido from tb_colaboracao_pedido as pedido join tb_status_colaboracao as status on pedido.status = status.id join tb_gs as coordenacao on pedido.coordenacao = coordenacao.co_gs where pedido.status = 1 or status = 2 order by pedido.atividade"				
							set rs = Server.CreateObject("ADODB.RecordSet")
							rs.Open query, dados_sys
							
								if not rs.eof then
									do while (not rs.eof)
										%>
										<option value="<%=rs("idPedido")%>"><%=rs("apelido_coordenacao")%> - <%=rs("atividade")%> (<%=rs("quantidade_horas")%> horas)</option>
                                        <%
										rs.movenext
									loop
								end if
							
							rs.close
							set rs = nothing
						%>
                      </select></td>
                  </tr>
                  <tr>
                    <td align="right"><label>Indicado</label></td>
                    <td><select name='indicado' id='indicado'   class='form-select'>
                        <option value=''>Indique um empregado...</option>
                        <%
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
                    <td align="right"><label>Quantidade<br/>
                        de horas/dia</label></td>
                    <td><input style="width:20px;height:20px;font-size:14px;" class = "spinner" id="quantidadeHoras" name="quantidadeHoras" value=0></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td><input name="indicar" class="myButton" type="button" value="Indicar" id="indicar" /></td>
                  </tr>
                </table>
              </form>
            </fieldset>
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
