<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Log</title>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
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
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}

</style>
</head>
<body>
<%
tipoTabela = request("tipoTabela")
valorChave = request("valorChave")
%>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <!-- #INCLUDE FILE ="include/Conexao.asp" -->
   <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >LOG</span> </div>
        <div class="usuariodiv">
            <div id='cssmenu'>
                 <%if valorChave <> "" then %>
                <ul>			
                	<li><a href='log.asp?tipoTabela=<%=tipoTabela%>&valorChave=<%=valorChave%>'><span><%=ucase(tipoTabela) & ":" & valorChave %></span></a></li>
                    <li class='active'><a href='log.asp'><span>Detalhes</span></a></li>			  
                </ul>
            <%else%>
            	<ul>			
                	<li><a href='log.asp'><span>Geral</span></a></li>	
                    <li class='active'><a href='log.asp'><span>Detalhes</span></a></li>		  
                </ul>
            <%end if%>
            </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:430px;" >
          <legend ><span class="titulos" >Detalhes do log</span></legend>
          
          </legend>
          <p></p>
 			  <!-- #INCLUDE FILE ="log_detalhes_con.asp" -->
          </fieldset>
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