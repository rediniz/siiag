<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Adicionar Local</title>
<!--CSS -->

<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>


<script>
$(function() {

$("#cadastrar").click(function(){

//window.location.assign("estoque_pendentes.asp");
	$("#formulario").submit();
	
});

});

</script>

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">

</head>
<body>

          <fieldset class="testess" style="border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:15px; margin-bottom:0px;margin-right:10px;">
      
          <legend class="style2 style3">Adicionar Local de Evento</legend>
          
 <form id='formulario' action="eventos_cadastrar_local_con.asp"  enctype="application/x-www-form-urlencoded" method="post">         
<table>
    <tr>
        <td><label>Descrição:</label></td>
        <td><input type='text' class='form-field'   id="local_descricao" name="local_descricao" size="60" width="30px;" /></td>
    </tr>
        <td><label>Ativo:</label></td>
        <td><input type='checkbox'  id="local_ativo" name="local_ativo" /></td>
    </tr>
    
    <tr>
    <td colspan="2"><input style="margin-top:10px;margin-left:37%;" name="cadastrar" id="cadastrar" class="myButton" type="button" value="Cadastrar"/></td>
    </tr>
</table>
</form>
</body>
</html>