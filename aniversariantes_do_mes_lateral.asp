
<style>

.aniversariantesMes{
background:#FFFFFF;
float:right;
margin-top:25px;
width:230px;
margin-right:2.1%;
border-radius: 10px;
height: auto;
min-height: 427px;
}


</style>

<script type="text/javascript">

	function enter(event){
		var chCode = ('charCode' in event) ? event.charCode : event.keyCode;

		if(chCode == "13"){
			if($("#mesAnivRelat").val() != ""){
				window.open("aniversariantes_relatorio.asp?mes=" + $("#mesAnivRelat").val());
				$("#mesAnivRelat").val("");
				$("#dialog-message-relat").dialog("close");
			}
		}
	}

</script>

<script language="javascript">
	$(document).ready(function(e) {
		$("#relat").on("click", function(){
			$("#dialog-message-relat").dialog({
				modal: false, // Escurecer o fundo ou não
				closeText: "Fechar",
				height:100,
				width:475
			});
		});
		$("#geraRelat").on("click", function(){
			if($("#mesAnivRelat").val() != "" || parseInt($("#mesAnivRelat").val()) > 0 ){
				window.open("aniversariantes_relatorio.asp?mes=" + $("#mesAnivRelat").val());
				$("#mesAnivRelat").val("");
				$("#dialog-message-relat").dialog("close");
			}
		});
	});
</script>

<div class="aniversariantesMes" >

<%

data = Request("data")

if data <> "" Then
	dataTotal = data
	mes = MONTH(dataTotal)
else
	mes = MONTH(DATE())
END IF 

'RESPONSE.Write mes

SELECT CASE mes
	
	case 1
		nomeMes="Janeiro"
	case 2
		nomeMes="Fevereiro"
	case 3
		nomeMes="Março"
	case 4
		nomeMes="Abril"
	case 5
		nomeMes="Maio"
	case 6
		nomeMes="Junho"
	case 7
		nomeMes="Julho"
	case 8
		nomeMes="Agosto"
	case 9
		nomeMes="Setembro"
	case 10
		nomeMes="Outubro"
	case 11
		nomeMes="Novembro"
	case 12
		nomeMes="Dezembro"	
	case else
		nomeMes = ""

END SELECT



Response.Write "<h3 class='subtitulosAgenda' style='text-align:center'><i class='fa fa-birthday-cake' style='color:#039'></i> Aniversariantes de "&nomeMes&" </h3>"


QueryAniversariantesMesLateral = "select NO_NOME,DT_NASCIMENTO from VW_USUARIOS WHERE month(dt_nascimento) = '"&mes&"' and IC_ATIVO=1 AND CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" AND IC_NAO_EXIBIR_ANIV = 0  ORDER BY day(DT_NASCIMENTO)" 

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open QueryAniversariantesMesLateral, dados_sys


DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	Data_Nascimento=rs("DT_NASCIMENTO")
	
	
	temp = Split(Nome,chr(32))

	NomeFormatado =  temp(0)&" "&temp(1)

	
	response.Write "<p class='titulos' style='font-size:14px;font-family:Futura, Arial, Verdana;margin-left:4px;'>"
	'response.Write "<img src='imagens/email_2.png' style='margin-top:1px;' />"
	'response.Write "<img src='imagens/email_2.png' style='margin-top:1px;' onclick='window.open(""aniversariantes_email.asp"",""_blank"", ""toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=400,height=400"")'/>"
	response.Write("-")
	response.Write Capitalize(NomeFormatado)&" - <strong>"&Formatar_Dia(DAY(Data_Nascimento))&"/"& Formatar_Mes(MONTH(Data_Nascimento))&"</strong></p>"
		
rs.movenext
 
LOOP
set rs = nothing
set objConn = nothing 


%>

<input type="button" class="myButton"  id="relat" value="Relatório" style="margin-left:25%;margin-top:5%;margin-bottom:3%;"/>

</div>

<div align="center" id="dialog-message-relat" title="Relatório dos Aniversariantes" class="msg-dialog" style="display:none;">
    Insira o mês do relatório: &ensp;
    <input id="mesAnivRelat" class="form-field" type="number" onkeypress="enter(event)" style="width:80px; height:auto; display:inline"></input>
    <input type="button" class="myButton"  id="geraRelat" value="Gerar" />
</div>