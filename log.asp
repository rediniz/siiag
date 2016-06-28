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

.ui-autocomplete {

	height:120px;
	overflow-y:scroll;
	overflow-x:hidden;
	font-size:12px;
}

</style>

<script>
$(document).ready(function() {

	$('.detalhe').on('click',function(){
									
		var coLog = $(this).parent().parent().find("#coLog").html();
		var tipoTabela = $(this).parent().parent().find("#tipoTabela").html();
		var valorChave = $(this).parent().parent().find("#valorChave").html();
		
		window.location.assign("log_detalhes.asp?tipoTabela="+tipoTabela+"&coLog="+coLog+"&valorChave="+valorChave);
							
	});
	
	$('#exibir').on('click',function(){

		var tipoTabela = $("#tiposTabela").val();
		
		window.location.assign("log.asp?tipoTabela="+tipoTabela);
							
	});
});
	
	
</script> 

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

</head>
<body>
<%
	valorChave = request("valorChave")
	tipoTabela = request("tipoTabela")
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
                	<li class='active'><a href='log.asp'><span><%=ucase(tipoTabela) & ":" & valorChave %></span></a></li>		  
                </ul>
            <%else%>
            	<ul>			
                	<li class='active'><a href='log.asp'><span>Geral</span></a></li>		  
                </ul>
            <%end if%>
            </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:430px;" >
          <legend ><span class="titulos" >Log</span></legend>
          
         <%if valorChave = "" then %>
		  <form  method="get" target="_self">
              <table border="0" width="100%">
                  <tr>               
                      <td width="20%"><label for="tiposTabela" style="padding-top:10px">Tabela: </label>
              				<select name="tiposTabela" id='tiposTabela' class='form-select'  >
                            <option>Selecione ...</option>
                                <option value="afastamento" <%if tipoTabela="afastamento" then response.write "selected=selected" end if%>>Afastamentos</option>
                                <option value="destacamento" <%if tipoTabela="destacamento" then response.write "selected=selected" end if%>>Destacamentos</option>
                                <option value="ferias" <%if tipoTabela="ferias" then response.write "selected=selected" end if%>>Férias</option>
                                <option value="jornada" <%if tipoTabela="jornada" then response.write "selected=selected" end if%>>Jornadas</option>
                                <option value="substituicao" <%if tipoTabela="substituicao" then response.write "selected=selected" end if%>>Substituições</option>
                                <option value="emprestimo" <%if tipoTabela="emprestimo" then response.write "selected=selected" end if%>>Empréstimos</option>
                                <option value="evento" <%if tipoTabela="evento" then response.write "selected=selected" end if%>>Eventos e Treinamentos</option>
                               <!-- <option value="estoque" <%if tipoTabela="estoque" then response.write "selected=selected" end if%>>Estoque</option>-->
                                <option value="reparo" <%if tipoTabela="reparo" then response.write "selected=selected" end if%>>Reparos</option>
                             <!--   <option value="demandaTI" <%if tipoTabela="demandaTI" then response.write "selected=selected" end if%>>Demandas TI</option>-->
                       		</select>
                      </td>
                      <td><input type="button" class='myButton' name="exibir" id="exibir" value="Exibir"/></td>
                  </tr>
              </table>
		  </form>
           <%end if%>
          </legend>
          <p></p>
 			  <!-- #INCLUDE FILE ="log_con.asp" -->
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