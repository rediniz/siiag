<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Controle de Demandas</title>
<!--CSS -->

<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<style>

body{
background-color:#FFFFFF;

}
	.ui-datepicker {
		font-size:12px;
	}
	.datepicker {
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
		font-family: Arial, sans-serif;
		font-size: 0.8em;
	}
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	.ui-menu .ui-menu-item a {
		height:14px;
		font-size:13px;
	}
	.ui-autocomplete {
		height:200px;
		overflow-y:scroll;
		overflow-x:hidden;
	}
</style>

<script>
	$(document).ready(function() {
		$("#salvarArquivo").hide();
		var qtde = 0;	
	
		$( document ).on("click", "#addArquivo", function(){
			var confirma = window.confirm("Deseja adicionar um arquivo?")
			
			if(confirma){
				qtde++;
				$("#arquivos").append("<p style='padding-bottom:0px'/><input type='file' class='arquivo' id='arquivo"+qtde+"' name='arquivo"+qtde+"' style='margin-left:0px'/>")
		//$("#arquivo"+qtde).trigger("click")
				$("#qtd_arquivo").val(qtde);
				$("#salvarArquivo").show();
			}
			else
			{
				return false
			}
			//alert($("#arquivo2").val());
		});
		
		$(document).on("click", "#salvarArquivo", function(){
			var co_demanda = $("#co_demanda_arq").val();
			//alert(co_demanda);
			$("#formArquivos").submit();
			
		});
	
	});

</script>

<br/>
<div style="margin-top:-5px">
	<span id='addArquivo' style="cursor:pointer"><img src="imagens/add_16x16.png" /><label style="margin-left:2px; font-size:14px">Adicionar arquivo</label></span>     
</div>

<form id='formArquivos' name='formArquivos' method="post" enctype="multipart/form-data" action="demanda_salvar_arquivo.asp">
    <input type="hidden" id='co_demanda_arq' name='co_demanda_arq' value="<%=request("demanda")%>"  />
    <input type="hidden" name="qtd_arquivo" id="qtd_arquivo" value="0" />
    
    <div id="arquivos" style="margin-bottom:5px; margin-left:0px; border:#000 solid 0px;">
    </div>
    
</form>
<button id='salvarArquivo' class="myButton" type="button">Carregar arquivo</button>