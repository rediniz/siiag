<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE file ="include/Conexao.asp" -->
<!-- #INCLUDE file ="f_usuario.asp" -->
<%
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Medição de Demandas Atendidas</title>
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
      <SCRIPT LANGUAGE="Javascript" SRC="FusionCharts.js"></SCRIPT>
<style>
.ui-datepicker {
	font-size: 12px;
}
.datepicker {
	height: 15px;
	border: 1px solid #b5cce2;
	background: #edf4fc;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	color: #666;
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
	padding: 6px;
	width: auto;
		z-index:40;
}
.datepicker:focus {
	background: #fff;
	color: #000000;
	outline: none;
	padding: 6px;
	box-shadow: 0 0 5px #9ecaed;
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
.ui-autocomplete {
	height: 200px;
	overflow-y: scroll;
	overflow-x: hidden;
}
.grafico{
	z-index:-40;
}
</style>
<script>
    $(function() {
    	$( ".datepicker" ).datepicker({
    		dateFormat: 'mm/yy',
    		dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    		dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    		dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    		monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    		monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    		nextText: 'Próximo',
    		prevText: 'Anterior'
  		});
   	});
	
	$(document).on("click","#gerara", function(){
		
		$.ajax({
		

       			url: "medicao_demandas/monta_grafico.asp", 
				data: $("#formulario").serialize(), 
        		success: function(data) { 
          			$("#grafico").html(data); 	  
        		},
		 		error: function(data){
					alert("Erro ao gerar gráfico.");
 				}
		
      		})
	});
</script>
</head>

<body>
<%
	Perfil_Acesso("3") 
	response.write "<input type='hidden' id = 'perfil_afastamento_consultar' value=" & perfil_acesso_siiag & ">"
  	response.write "<input type='hidden' id = 'perfil_afastamento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
   
  	if not perfil_acesso_siiag then
  		response.Redirect ("afastamento_consultar.asp")
  	end if
%>
<div class="teste2"> 
  <!--fundo azul do meio--> 
  <!-- #INCLUDE file ="topo.asp" -->
  
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos" ><span >MEDIÇÃO DE DEMANDAS ATENDIDAS</span> </div>
        <div style="margin:10px">
          <form id="formulario" >
            <table>
              <tr>
              <!--
                <td><label>Situação:</label></td>-->
                <td><span style="margin-right:10px"></span></td>
                <td><label>Período:</label></td>
              </tr>
              <tr>
              <!--
                <td><select name="situacao" id='situacao' class='form-select' style="margin-bottom:5px;" >
                    <option value=''>Todas</option>
                    <%
                            strQuery = "select CO_SITUACAO, DE_SITUACAO from TB_SITUACOES ORDER BY CO_SITUACAO"
                            set Ls=Server.CreateObject("ADODB.RecordSet")
                            Ls.Open strQuery, dados_sys
                                        
                            DO UNTIL Ls.eof 
                                  
                                response.write "<option value="& Ls("CO_SITUACAO") &" >"& Ls("DE_SITUACAO") &"</option>" 'imprimindo									
                                Ls.movenext 
                              
                            LOOP
                        %>
                  </select></td>-->
                <td></td>
                <td><label>de:</label>
                  <input  name="data_inicial" id="data_inicial" class="datepicker" type="text" size="8" maxlength="8" value="<%=request("data_inicial")%>"/>
                  <label>até:</label>
                  <input  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8" value="<%=request("data_final")%>"/></td>
                  <td><button id="gerar" name="gerar" style="margin-left=10px" class="myButton" type="submit">Gerar Gráfico</button></td>
              </tr>
            </table>
            <div id="grafico_percentual" class="grafico"  align="center">
            <!-- #INCLUDE file ="medicao_demandas/monta_grafico.asp" --> 
            </div>
            <div id="grafico_quantidade_tipo" class="grafico"  align="center">
            <!-- #INCLUDE file ="medicao_demandas/grafico_tipos.asp" --> 
            </div>
              <div id="tabela_info_tipo" class="tabela"  align="center">
            <!-- #INCLUDE file ="medicao_demandas/tabela_tipos.asp" --> 
            </div>
            <div align="center">
            <!-- #INCLUDE file ="medicao_demandas/monta_tabela.asp" --> 
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo--> 
  <!-- #INCLUDE file ="rodape.asp" --> 
</div>
<!--teste-->
</body>
</html>
