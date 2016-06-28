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
		
		$("#colaborar").on("click", function(){
			
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
       			url: "colaboracao_colaborar_con.asp?acao=colaborar",
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
<div class="teste2"> 
  <!--fundo azul do meio--> 
  <!-- #INCLUDE FILE ="topo.asp" -->
  
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos" ><span >COLABORAÇÃO</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='colaboracao_conhecimento.asp'><span>Colaborar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!-- <li class='active'><a href='#'><span>Cadastrar</span></a></li>
              <li><a href='#'><span>Consultar</span></a></li>-->
            </ul>
          </div>
          <!--COLABORAR================================================================================================================-->
          <div id="abaColaborar">
            <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
              <p></p>
              <form action="colaboracao_colaborar_con?acao=colaborar.asp" method="post" name="formularioSalvar" id="formularioSalvar" target="_self" enctype="application/x-www-form-urlencoded">
                <table>
                  <tr style="display:none;">
                    <td colspan="2"><input type="hidden" id="idPedido" name = "pedido" value="<%=request("pedido")%>" /></td>
                  </tr>
                  <tr>
                    <td align="right"><label>Indicado</label></td>
                    <td><select name='indicado' id='indicado'   class='form-select' style="width:250px">
                        <option value=''>Indique um empregado...</option>
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
                    <td align="right"><label>Quantidade<br/>
                        de horas/dia</label></td>
                    <td><input style="width:20px;height:20px;font-size:14px;" class = "spinner" id="quantidadeHoras" name="quantidadeHoras" value=0></td>
                  </tr>
                  <tr>
                    <td></td>
                  </tr>
                  <tr>
                    <td></td>
                    <td><input name="colaborar" class="myButton" type="button" value="Colaborar" id="colaborar" /></td>
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
