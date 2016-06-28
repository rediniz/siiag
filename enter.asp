<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
<script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
$( ".campo" ).keypress(function( event ) {


  if ( event.which == 13 ) {

   alert("teste");

  }


});

});
 


</script>

</head>

<body>

<input type="text" id="teste" class="campo"/>
<input type="text" id="teste" class="campo"  />
<input type="button"id="botao" value="Click" />



</body>
</html>
