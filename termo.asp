<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->

<%
responsavel = Session("v_Usuario_Nome" )
co_responsavel =  Session("v_Usuario_Matricula")
data = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>AUPG</title>
<!--CSS -->
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<link href="botao_azul.css" rel="stylesheet" type="text/css" />

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
<!-- efeito da janela de ajuda -->


</head>

<body>

<div id="texto">
<textarea id="texto"  readonly="readonly" wrap="hard" style="width:640px; height:200px; font-family: 'Bookman Old Style', Arial;">

TERMO DE RESPONSABILIDADE

Eu, <%=responsavel%> - <%=co_responsavel%>, comprometo-me a devolver o(s) recurso(s), ora tomado(s) como empréstimo dessa GIFUG/FO, em perfeitas condições de uso.
Comprometo-me, ainda, a sanar eventuais prejuízos que por ventura venham a ocorrer durante o transporte e/ou permanência do referido equipamento, nesta unidade.

Fortaleza, <%=data%>
</textarea>
</div>

<div align="center">

</div>
</body>
</html>
