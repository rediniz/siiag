
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

 <script>
    $(function() {
	$(document).ready(function(){
		$("#datepicker" ).datepicker('setDate', $("#data").val());
	});
    $("#datepicker" ).datepicker({
	onSelect: function(dateText, inst ){	
	/*alert("Dia selecionado: " + dateText);*/
	
	window.location.assign("principal.asp?data="+dateText+"&unidade="+$("#co_unidade").val()+"");
	},
    dateFormat: 'dd/mm/yy',
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    monthNames: ['Janeiro','Fevereiro','Mar&ccedil;o','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText: 'Próximo',		
    prevText: 'Anterior'
	
  });
   });
  </script>
 
 <div style="height: auto; width: auto; border:#000000 solid 0px;" >

	<div id="datepicker" style="font-size:12px; height: auto; border: #000000 solid 0px;"></div>
 </div>
<%
response.write "<input type='hidden' id='data' value="& request("data")&">"
response.Write "<input type='hidden' id='co_unidade' value='"&request.Cookies("co_usuario_unidade_siiag")&"'>"%>

<!--TRYING 

<script>
var currentDate = $( "#datepicker" ).datepicker( "getDate" );

document.writeln(currentDate);

</script> -->



