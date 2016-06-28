<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Auto Complete - Exemplo 3</title>

      <script type="text/javascript" src="jquery-1.9.1.js" ></script>
<script type="text/javascript" src="jquery-ui-1.10.3.custom.js" ></script>
<link rel="stylesheet" type="text/css" href="jquery-ui-1.10.3.custom.css"/>

  <script type="text/javascript" language="javascript">
	$(document).ready(function(){
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete({
					source: "exemplo03_nomes.asp",
					select: function( event, ui ) {
					$( "#codigo" ).val( ui.item.value);
					$( "#nascimento" ).val( ui.item.nascimento);
					return false;
					
}
				  });
 
			});
</script>
    </head>

    <body>
    	<h1>Autocomplete com Jquery em ASP - Exemplo 3</h1>
    	Nome: <input name="nome" id="nome" type="text" autocomplete="off" />
        <br/>
        <br/>
        Código: <input name="codigo" id="codigo" type="text" disabled="disabled" />
        Código: <input name="nascimento" id="nascimento" type="text" disabled="disabled" />
    </body>
</html>