
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

 <script>
    $(function() {
    $( "#datepicker" ).datepicker({
	onSelect: function(dateText, inst ){	
	/*alert("Dia selecionado: " + dateText);*/	
	window.location.assign("principal.asp?data="+dateText+"");
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
 
<div id="datepicker" style="font-size:12px;"></div>

<!--TRYING 

<script>
var currentDate = $( "#datepicker" ).datepicker( "getDate" );

document.writeln(currentDate);

</script> -->



<div class="linksRapidos">

<h3 class="tituloAniversariantesDia"> Aniversariantes do Dia</h3>
<% 
dataTotal = Date() 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)

strQuery = "select NO_NOME,DT_NASCIMENTO from TB_USUARIOS WHERE IC_ATIVO=1 ORDER BY NO_NOME; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

		DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)
	
	'if mesCorrente = mesdoBanco AND diaCorrente=diaBanco  Then
	
	'RESPONSE.Write "<p>"&Nome&"</p>"
	'response.Write diaCorrente&"/"&mesCorrente&"<br/>"
	'response.Write diaBanco&"/"&mesBanco&"<br/>"
	
	if mesCorrente = mesBanco Then
		if diaCorrente=diaBanco Then
	response.Write "<p class='nomeDia'>"&Nome&"</p>"
	End IF
	End IF
	'END IF

	 
	rs.movenext
	LOOP

objConn.close 
set rs = nothing
set objConn = nothing

%>

<br/><br/><h3 class="tituloAniversariantesDia"> Aniversariantes de Caixa </h3>

<%

consultaAniversariantesCaixa = "select DT_INICIO_GIFUG, NO_NOME from TB_USUARIOS WHERE IC_ATIVO=1 ORDER BY NO_NOME; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set AniversarioCaixa=Server.CreateObject("ADODB.RecordSet")
AniversarioCaixa.Open consultaAniversariantesCaixa, dados_sys

DO UNTIL AniversarioCaixa.eof
	
	Nome=AniversarioCaixa("NO_NOME")
	
	dataBanco=AniversarioCaixa("DT_INICIO_GIFUG")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)
	
	if mesCorrente = mesBanco Then
		if diaCorrente=diaBanco Then
	response.Write "<p class='nomeDia'>"&Nome&"</p>"
	End IF
	End IF
	'END IF

	AniversarioCaixa.movenext
	LOOP

objConn.close 
set AniversarioCaixa = nothing
set objConn = nothing

%>

</div>