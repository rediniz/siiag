<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Reparos</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">

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

<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
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

.ui-mask ui-spinner-input {

font-size:16px;

}
</style>

</style>

<style>
.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce;
	font-weight: bold;
	color: #c77405;
}
.ui-widget {
	font-family: Arial,sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}

.ui-menu .ui-menu-item a{
    height:14px;
    font-size:13px;
}

.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce;
	font-weight: bold;
	color: #c77405;
}
.ui-widget {
	font-family: Arial,sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}
.ui-menu .ui-menu-item a{
    height:14px;
    font-size:13px;
}


</style>
 
<script type="text/javascript">
	$(document).ready(function() {
		
		$(document).on("click", "#solicitar", function() {
		
	if($("#descricao").val()=="" || $("#local").val()=="" || $("#tipo").val()==""){
		alert("Informe todos os dados.");
		return false;
	}
		
		//alert("teste");
		//$("#formulario").submit();
		
      		$.ajax({
       			data: $("#formulario").serialize(), // DADOS A SEREM PASSADOS PARA O SERVIDOR
       			url: "reparos_solicitar.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        			//$("#carregando").show(); 
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		//$("#carregando").hide();  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			alert("Reparo solicitado com sucesso.");
					window.location.assign("reparos.asp"); 	  
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao solicitar reparo.");
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
      <div class="titulosModulos" ><span >REPAROS</span> </div>
        <div class="usuariodiv" style="min-height:540px;">
          <div id='cssmenu'>
            <ul>
             <%			
			 	response.write "<li class='active'><a href='reparos.asp'><span>Solicitar</span></a></li>"

				 response.write "<li><a href='reparos_consultar.asp'><span>Consultar</span></a></li>"			  

			 %>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Solicitar Reparo </span></legend>
          <p class="paragrafoteste">
          <form  id="formulario" name="formulario" action="reparos_solicitar.asp"  >
          <table>
             <tr>
              	<td><label>Tipo do reparo:</label></td>
              </tr>
          <td width="">
                                    <select class="form-select" style="max-width:150px; min-width:150px;" id="tipo" name="tipo">
                                    <option value="">Selecione...</option>
                     
                                            <%  
                                                Query4 ="SELECT * FROM TB_TIPO_REPAROS" 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set ds=Server.CreateObject("ADODB.RecordSet")
                                                ds.Open Query4, dados_sys
                                                DO UNTIL ds.eof
                                                    co_tipo=ds("CO_TIPO")
                                                    de_tipo=ds("DE_TIPO")						
                                                    response.write "<option value='" & co_tipo  & "'   "
									
                                                    response.write " > " & de_tipo & "</option>"							
                                                    ds.movenext
                                                LOOP
                                                set ds = nothing
             
                                            %> 
              
                                        </select>
                                   </td>
              <tr>
              	<td><label>Descrição:</label></td>
              </tr>
              <tr>
              	<td><textarea class="form-field" name="descricao" id="descricao" style="width:400px; height:100px"></textarea></td>
              </tr>
              <tr>
              	<td><label>Local:</label></td>
              </tr>
              <tr>
              	<td><input type="text" id="local" name="local" class="form-field" size="63"></td>
              </tr>
          </table>
          </form>
          </p>
         <button class="myButton" id="solicitar" name="solicitar" style="margin-left:8px"  type="button">Solicitar</button>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
          
          </fieldset>
        </div>
        
        <%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Reparo solicitado com sucesso.'); </script>")
	
		end if
		
		%>
      </div>
       <!--include do calendario-->
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
