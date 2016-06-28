<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Empr&eacute;stimo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

<style>

#X {
cursor:pointer
}

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

<script>


	$(document).ready(function() {
	
		// Remover linha da tabela
		$('#tabela').on('click', '#X', function(){
		$(this).parent().parent().remove(); 
		});
		
		// Spinner
		var spinner = $( "#spinner" ).spinner({
		spin: function( event, ui ) {
				if ( ui.value < 0 ) {
					$( this ).spinner( "value", 0 );
					return false;
				}
				}			
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

		$( "#opener" ).click(function() {
			$( "#dialog" ).dialog( "open" );
		});
		
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
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='estoque.asp'><span>Solicitar</span></a></li>
              <li ><a href='consultar_emprestimos.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li><a href='index.html'><span>Termo de Responsabilidade</span></a></li>
              <li id="opener"><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <div id="dialog" title="Caixa de Ajuda">
            <p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
          <legend><span class="titulos">Solicitar Empr&eacute;stimo</span></legend>
          <p class="paragrafoteste">
            <%
  
strQuery = "select DE_RECURSO  from TB_TIPOS_RECURSOS ORDER BY DE_RECURSO; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
 
 			response.Write "<label> Recursos:</label>" 
    		response.Write "<select name='recursos' id='recursos'>"
			
  DO UNTIL rs.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
  
 'atribuindo os valores dos campos as variáveis
	  tipoRecurso=rs("DE_RECURSO")	  
	  
                response.write "<option value='"& tipoRecurso &"'>"& tipoRecurso &"</option>" 'imprimindo     
  
    rs.movenext 'passando para o proximo elemento da tabela
  
	LOOP
	
		response.Write "</select>&nbsp; &nbsp;" 'fechando o select

objConn.close 
set rs = nothing
set objConn = nothing 
'fechando todas as conexoes
%>
            <script language="javascript" type="text/javascript">
  
  $(function() {
  	 var header = false;
	 
  	$( "#adicionarRecurso" ).click(function() {
	
	   var recurso = $("#recursos").val();
	   var quantidade = $("#spinner").val();

	   if(quantidade == 0){
	   
	   alert("A quantidade de recursos não pode ser zero.");
	    
	   } else { 
	  			if(header===false){
					$( "#tabela" ).append( "<tr> <td>Recurso</td> <td >Quantidade</td> <td width='5%'> </td></tr>");
					header=true;
				} 

				$( "#tabela" ).append(
							"<tr>" +
							"<td class='recurso'>" + recurso + "</td>" +
							"<td class='quantidade'>" + quantidade + "</td>" +
							"<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>" +
							"</tr>");	
							}			
				});				
	});

	
  </script>
            <label for="spinner">Quantidade: </label>
            <input style="width:20px;height:20px;font-size:14px;" id="spinner" name="value" value=0>
            <input  name="incluir_material" class="myButton" type="button"  value="Adicionar Recurso" id="adicionarRecurso" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
            <table  name="tabela" id="tabela">
            </table>
          </div>
          <%
  
strQuery = "select CO_LOCAL, DE_LOCAL  from TB_LOCAL ORDER BY DE_LOCAL; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set Ls=Server.CreateObject("ADODB.RecordSet")
Ls.Open strQuery, dados_sys

 			response.Write "<label> Local:</label>" 
    		response.Write "<select name='locais'>"
			
  DO UNTIL Ls.eof 
  
	  descricaoLocal=Ls("DE_LOCAL")
	  codigoLocal=Ls("CO_LOCAL")
	  
                response.write "<option value='"& codigoLocal &"'>"& descricaoLocal &"</option>" 
   				Ls.movenext 
	LOOP
				response.Write "</select>&nbsp;&nbsp;&nbsp;&nbsp;" 

objConn.close 
set Ls = nothing
set objConn = nothing 

%>
          <br/>
          <br/>
          <label>Respons&aacute;vel:</label>
          <input name="nomeResponsavel" class="form-field" id="nome" type="text" size="50" maxlength="100" />
          <br/>
          <br/>
          <label>Per&iacute;odo:</label>
           <input  name="periodo_de" id="periodo_de" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>

          &nbsp;&agrave;&nbsp;
           <input  name="periodo_a" id="periodo_a" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>

          &nbsp;&nbsp; <br/>
          <br/>
          <label>Observa&ccedil;&otilde;es:</label>
          <p></p>
          <textarea name="observacoes" cols="50" rows="5" style="max-width:500px;min-width:500px;max-height:100px;min-height:100px;"></textarea>
          <br/>
          <br/>
          <label>Situa&ccedil;&atilde;o:</label>
          <select name="situacao">
            <option value="todos" selected="selected">Todos</option>
            <option value="solicitado">Socilitado</option>
            <option value="confirmado">Confirmado</option>
            <option value="pendente">Pendente</option>
            <option value="gozado">Gozado</option>
            <option value="natendido">Não Atendido</option>
            <option value="cancelado">Cancelado</option>
            <option value="emandamento">Em Andamento</option>
          </select>
          <p></p>
          <input name="incluir" class="myButton" type="button" value="Incluir" id="incluir"/>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
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
