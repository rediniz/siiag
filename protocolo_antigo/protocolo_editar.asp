<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Editar Protocolo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/query.ui.tabs.js"></script>j
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

<!--CSS-->
    <style type="text/css">
    <!--
        .style2 {
            font-size: 14
        }
        .style3 {
            color: #5683C4
        }
		
		.inputsBotoes{/*border:#000000 solid 1px;*/}
		
.inputPesquisar{

margin-left:8px;
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

.inputSalvar{
margin-left:25px;
height:15px;
border: 1px solid #b5cce2;
background: #edf4fc;
-webkit-border-radius: 4px;
-moz-border-radius: 4px;
border-radius: 4px;
color: #666;
box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
padding:6px;
width:auto
}

.inputSalvar:focus {
	background: #fff;
	color: #000000;
	outline:none;
	padding:6px;
	box-shadow: 0 0 5px #9ecaed;
   

   }
   
.inputPesquisar:focus {
	background: #fff;
	color: #000000;
	outline:none;
	padding:6px;
	box-shadow: 0 0 5px #9ecaed;
   

   }   
-->
    </style>


</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo_protocolo.asp" -->
 
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='protocolo.asp'><span>Inclus&atilde;o</span></a></li>
              <li><a href='protocolo_consultar.asp'><span>Consulta</span></a></li>
              <li  class='active'><a href='protocolo_editar.asp'><span>Editar AR - Oficio</span></a></li>
              <!--<li><a href='protocolo_relatorio.asp'><span>Relat&oacute;rios</span></a></li>-->
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Editar Protocolo</legend>
          <p class="paragrafoteste style2"> <span class="style4 style2">
          
          
          
           <%
		noficio = Request("noficio")
		
		if noficio <> "" Then
		
		Query4 ="select NU_AR from TB_PROTOCOLO_ARS WHERE NO_PROTOCOLO = '"&noficio&"'"
		set objConn = server.CreateObject("ADODB.Connection") 
		dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
		objConn.open dados_sys
		set ds=Server.CreateObject("ADODB.RecordSet")
		ds.Open Query4, dados_sys 
	
 			if ds.eof Then
  				response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Protocolos com esse N&uacute;mero, Tente De novo.<p>"
 			 else	
 			DO UNTIL ds.eof

			nuAR =		ds("NU_AR")
			
			ds.movenext
			
			
		  	LOOP
			END IF
			
		END IF	
		  %>
          
          <div class="inputsBotoes">
          <label> N&deg; do Of&iacute;cio: </label>
          <input class="inputPesquisar" name="nOficio" type="text" id="nOficio" value="<%Response.Write noficio%>" />
          <input class="myButton" style="margin-left:10px;height:25px;width:100px;padding:2px;" type="button" value="Pesquisar" onclick="pesquisar()">
          
          
          <br/><br/>
          
          <script type="text/javascript">
      		function pesquisar()
     		 {
        		rec = document.getElementById("nOficio").value;
        		/*alert(rec);*/
				
				
				window.location.assign("protocolo_editar.asp?noficio="+rec+"");
				
				
			/*document.getElementById("receberLink").innerHTML = "<label>N&deg; da AR</label> <input name='nAR' type='text' id='nAR' /><br/><input type='button' value='Salvar' id='addSugestao' onclick='salvar()'>";*/
			
			
     		 }
			 
			function salvar(){
			 
			 nOficio = document.getElementById("nOficio").value;
			 nAR= document.getElementById("nAR").value;
			 
			 alert("O numero do Oficio = "+nOficio+" e o numero da AR = "+nAR);
			 
			 
			 }
			 
			 
			 
  		</script>
          
         
          
          
          <%
		  
		  numeroficio = Request("numeroficio")
		  numeroAR = Request("nAR")
		
		'if numeroficio <> "" & numeroAR <> "" Then
		
		'Query4 ="UPDATE NU_AR from TB_PROTOCOLO_ARS WHERE NO_PROTOCOLO = '"&numeroAR&"'"
		'set objConn = server.CreateObject("ADODB.Connection") 
		'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
		'objConn.open dados_sys
		'set ds=Server.CreateObject("ADODB.RecordSet")
		'ds.Open Query4, dados_sys 
	
 		
		'Response.Write "AR Atualizada"	
		
			
		'END IF	
		  
		  
		  
		  %>
          
          
            
            <div id="receberLink">
            
           <label>N&deg; da AR:</label>
          <input class="inputSalvar" name="nAR" type="text" id="nAR" value="<%Response.Write nuAR%>"  />
          <p/>
          <input class="myButton" type="button"  value="Salvar" onclick="salvar()">
          
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
