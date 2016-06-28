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
		
		$("#enviar").on("click", function(){
			
			if($("#pedido").val() == ""){
				alert("Informe o pedido.");
				return false;
			}
			
			if($("#mensagem").val() == ""){
				alert("Informe uma mensagem.");
				return false;
			}
			
			$.ajax({	
       			data: $("#formularioSalvar").serialize(),
       			url: "colaboracao_reconhecimento_con.asp?acao=reconhecer",
        		success: function(data) {
          			alert("Reconhecimento registrado com sucesso.");	  
        		},
		 		error: function(data){
					alert("Erro ao enviar reconhecimento.");
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
	queryChecaCoordenador = "SELECT IC_GERENTE FROM TB_USUARIOS WHERE CO_MATRICULA = '"&matriculaUsuario&"'"
	isCoordenador = objConn.execute(queryChecaCoordenador)("IC_GERENTE")
%>
<input type="hidden" id="isCoordenador" name="isCoordenador" value="<%=isCoordenador%>" />
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
              <li class='inactive'><a href='colaboracao_indicacao.asp'><span>Indicação</span></a></li>
              <li class='active'><a href='colaboracao_reconhecimento.asp'><span>Reconhecimento</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!-- <li class='active'><a href='#'><span>Cadastrar</span></a></li>
              <li><a href='#'><span>Consultar</span></a></li>-->
            </ul>
          </div>
          <%
		  	if (isCoordenador = false) then
		  %>
          <div align="center">
            <p>Acesso somente para coordenadores e substitutos.</p>
          </div>
          <%
		  	else
          %>
          <!--COLABORAR================================================================================================================-->
          <div id="abaColaborar">
            <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
              <p></p>
              <form action="colaboracao_indicacao_con?acao=colaborar.asp" method="post" name="formularioSalvar" id="formularioSalvar" target="_self" enctype="application/x-www-form-urlencoded">
                <table>
                  <tr>
                    <td align="right"><label>Pedido</label></td>
                    <td><select name='pedido' id='pedido'   class='form-select'>
                        <option value=''>Informe o pedido...</option>
                        <%
							query = "select coordenacao.apelido_coordenacao, pedido.quantidade_horas, pedido.coordenacao, pedido.atividade, pedido.id as idPedido from tb_colaboracao_pedido as pedido join tb_status_colaboracao as status on pedido.status = status.id join tb_gs as coordenacao on pedido.coordenacao = coordenacao.co_gs where pedido.status = 3 and pedido.coordenacao = (select co_gs from vw_usuarios where co_matricula = '"&matriculaUsuario&"') order by pedido.atividade"				
							set rs = Server.CreateObject("ADODB.RecordSet")
							rs.Open query, dados_sys

								if not rs.eof then
									do while (not rs.eof)
										%>
                        <option value="<%=rs("idPedido")%>" <%if cint(request("pedido")) = cint(rs("idPedido")) then%> selected="selected"<%end if%>><%=rs("apelido_coordenacao")%> - <%=rs("atividade")%> (<%=rs("quantidade_horas")%> horas)</option>
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
                    <td align="right"><label>Mensagem</label></td>
                    <td><textarea  class="form-field" name="mensagem" id="mensagem" cols="50" rows="7" style="max-width:470px;min-width:470px;max-height:100px;min-height:100px;"></textarea></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td><input name="enviar" class="myButton" type="button" value="Enviar" id="enviar" /></td>
                  </tr>
                </table>
              </form>
            </fieldset>
          </div>
          <%
		  	end if
          %>
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
