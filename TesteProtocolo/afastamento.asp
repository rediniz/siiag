<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Solicitar Afastamento</title>
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
<!-- efeito da janela de ajuda -->
<script>
	$(function() {
		$( "#dialog" ).dialog({
			autoOpen: false,
			show: {
				effect: "blind",
				duration: 1000
			},
			hide: {
				effect: "explode",
				duration: 500
			}
		});
		
		/*dialogo do solicitar*/
		$( "#dialog2" ).dialog({
			autoOpen: false,
			show: {
				effect: "blind",
				duration: 1000
			},
			hide: {
				effect: "explode",
				duration: 500
			}
		});/*dialogo do solicitar*/

		$( "#opener" ).click(function() {
			$( "#dialog" ).dialog( "open" );
		});
		
		/*dialogo do solicitar*/
		$( "#solicitar" ).click(function() {
			$( "#dialog2" ).dialog( "open" );
		});
		/*dialogo do solicitar*/
	});
	</script>
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='afastamento.asp'><span>Solicitar</span></a></li>
              <li ><a href='afastamento_consultar.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li id="opener"><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="testea"><span class="titulos">Solicitar Afastamento</span></legend>
          <p></p>
          <label>Usu&aacute;rio:</label>
          <input class="form-field" name="usuario" type="text" size="10" maxlength="7" />
          <label>Nome:</label>
          <input class="form-field" name="nome" type="text" size="50" maxlength="60" />
          <p>
<%
  
strQuery = 		"select CO_TIPO_AFASTAMENTO, DE_TIPO_AFASTAMENTO  from TB_TIPOS_AFASTAMENTO ORDER BY DE_TIPO_AFASTAMENTO; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
set objConn = 	server.CreateObject("ADODB.Connection") 
dados_sys = 	"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set Ls=			Server.CreateObject("ADODB.RecordSet")
Ls.Open strQuery, dados_sys

 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
 
 			response.Write "<label> Tipo de afastamento:</label>" 
    		response.Write "<select name='tipo_afastamento'>"
			
  DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
  
 'atribuindo os valores dos campos as variáveis
	  descricaoAfastamento=Ls("DE_TIPO_AFASTAMENTO")
	  codigoAfastamento=Ls("CO_TIPO_AFASTAMENTO")
	  
	  
                response.write "<option value='"& codigoAfastamento &"'>"& descricaoAfastamento &"</option>" 'imprimindo
               
            
  
  
  
    Ls.movenext 'passando para o proximo elemento da tabela
  
	LOOP
	
		response.Write "</select>&nbsp;&nbsp;&nbsp;&nbsp;" 'fechando o select

objConn.close 
set Ls = 		nothing
set objConn = 	nothing 
'fechando todas as conexoes
%>
         
        <p>
            <label>Data de início:</label>
            <input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write(Date) %>"/>
            
            <label>Data de fim&nbsp;:</label>
            <input  name="data_fim" id="data_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>

            &nbsp;&nbsp;<br/>
          <label></label>
             </p>
          <input name="Botao_Cancelar" class="myButton" type="button" value="Cancelar" />
          <input name="Botao_Solicitar" class="myButton" type="button" value="Solicitar" id="solicitar"/>
   

         
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
