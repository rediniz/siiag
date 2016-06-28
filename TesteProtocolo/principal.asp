<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<title>SIIAG-WEB</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<link type="text/css" rel="stylesheet" href="css/rcarousel.css" />
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- fazendo o include do topo aqui -->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container2">
      <div class="conteudo">
      
<%
data = Request("data")

%>
        <h3 class="titulos" style="width:100%;text-align:center;margin-top:7%;">Agenda do Dia  
		
		
		<% 
		
		if data <> "" Then
		
			Response.Write data
		
		else
		
			Response.write DAY(DATE()) & "/"& MONTH(DATE())& "/"& YEAR(DATE())
		END IF
		 %></h3>
        <div class="divAgenda">
          <!--SETANDO O DIA,O MES E O ANO DE ACORDO COM A DATA ATUAL E COLOCANDO O SEPARADOR "/" -->
          <!-- #INCLUDE FILE ="agenda_do_dia.asp" -->
        </div>
        <img src="imagens/linhahorizontal.png" class="linhavertical" />
        <div class="divFeriasAusencias">
          <!-- #INCLUDE FILE ="ferias_ausencias.asp" -->
        </div>
        <div class="aniversariantes">
          <!-- #INCLUDE FILE="aniversariantes.asp" -->
        </div>
      </div>
      <!-- #INCLUDE FILE ="calendario.asp" -->
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
