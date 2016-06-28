<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<script>
	function enviarAgenda(){
	
	
		confirmacao = window.confirm("Deseja enviar a agenda?");
		
		
			if(confirmacao == true){
				
				/*window.alert("verdadeiro");*/
				
				
				/*window.location.assign("apoio.asp?data_inicio="+data_inicio+"&grupo="+grupo+"");*/
			}
	}
</script>   

<style>

.titulos{

color:#248fc5;
font-size:16px;
font-weight:bold;

}

.eventos{
color:#000000;
letter-spacing:0px;
font-family:Arial, Helvetica, sans-serif;
/*border:#000000 solid 1px;*/}

.topoFrase{
border:#aed7e4 solid 1px; 
height:50px;
margin:0px;
padding:0px;
}

.agendaFerias{

margin:0px;
padding:0px;
max-height:5px;
min-height:5px;
}

</style>
<!-- height tem que ser auto para que se ajuste ai tamanho do conteudo da tela -->
<div class="fundoAzul" style="background:#e8fbff; height:auto;width:900px;margin:auto;"> <!-- fundo azul, atras do funco branco -->
<div class="fundoBranco" style="background:#ffffff; height:auto;width:800px;margin:auto;"> <!-- fundo branco -->

<div class="topoFrase"><!-- topo, onde fica a frase -->

<!-- #INCLUDE FILE="agenda_PegaFrase.asp" -->

</div><!-- Fecha topo, onde fica a frase -->


<div class="conteudos" style="border-bottom:#aed7e4 solid 1px; height:auto;border-left:#aed7e4 solid 1px;border-right:#aed7e4 solid 1px;"> <!-- demais conteudos, exceto a frase -->
<%

dataTotal = (DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)

%>

<%

'começa aqui o aniversariantes, somente aparecera na agenda caso haja realmente aniversariantes
aniversariantesQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM VW_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"') AND IC_ATIVO=1" 

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

	response.Write "<h3 style='color:#248fc5;font-size:16px;font-weight:bold;'>Aniversariantes</h3>"

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)

	
	Response.Write "<p class='eventos' style='font-size:12px; line-height:18px;'><strong>Nome: </strong>"& Nome  &"<br/><strong>Data: </strong> " & DAY(dataBanco)&"/"&MONTH(dataBanco) &"</p>"
	
	'END IF

	 
	rs.movenext
	LOOP
	
End If


set rs = nothing
set objConn = nothing

'fim dos aniversariantes

%>




<%

'começo dos eventos, tambem so aparecera caso haja algum evento
eventosQuery = "SELECT EVENTOS.DE_EVENTO, EVENTOS.DE_PARTICIPANTES, EVENTOS.DE_OBS, GS.NO_GS, LOCAL.DE_LOCAL FROM TB_EVENTOS EVENTOS INNER JOIN VW_GS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA INNER JOIN TB_LOCAL LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL WHERE(LOCAL.ATIVO = 1) AND ('"&dataTotal&"' BETWEEN EVENTOS.DH_INICIO AND EVENTOS.DH_FIM); " 


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open eventosQuery, dados_sys


IF rs.eof Then
		response.Write ""
ELSE
	
	response.Write "<h3 style='color:#248fc5;font-size:16px;font-weight:bold;'>Eventos</h3>"

	DO UNTIL rs.eof

	DE_EVENTO = rs("DE_EVENTO")
	DE_PARTICIPANTES = rs("DE_PARTICIPANTES")
	DE_OBS = " - "
	NO_GS = rs("NO_GS")
	DE_LOCAL = rs("DE_LOCAL")
	

    Response.Write "<p class='eventos' style='font-size:12px; line-height:18px;'><strong>Ger&ecirc;ncia:</strong>"& NO_GS  &"<br/><strong>Tipo:</strong> " & DE_EVENTO &"<br/><strong>Evento/Motivo:</strong> " & DE_EVENTO & "<br/><strong>Participantes:</strong> " & DE_PARTICIPANTES & "<br/><strong>Local/Per&iacute;odo:</strong> " & DE_LOCAL &"</p>"

	rs.movenext
	LOOP
	
End If

set rs = nothing
set objConn = nothing

'FIM dos eventos, tambem so aparecera caso haja algum evento
%>




<%
'começo dos destacamentos
destacamentosQuery = "SELECT DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME FROM TB_DESTACAMENTOS AS DESTACAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA WHERE(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND ('"& dataTotal &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM) OR(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataTotal &"')"


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open destacamentosQuery, dados_sys

if rs.eof THEN

response.Write ""

ELSE

	response.Write "<h3 style='color:#248fc5;font-size:16px;font-weight:bold;'>Destacamentos</h3>"
	
DO UNTIL rs.eof
	
			
			matricula = rs("CO_MATRICULA")
			projeto=rs("DE_PROJETO")
			cidade=rs("NO_CIDADE")
			NO_NOME = rs("NO_NOME")
			data_inicio_banco = rs("DT_INICIO")
			data_final_banco = rs("DT_FIM")
			DE_OBS = " - "
			
			data_inicio_total = DAY(data_inicio_banco)&"/"&MONTH(data_inicio_banco)&"/"&YEAR(data_inicio_banco)
			data_final_total =  DAY(data_final_banco)&"/"&MONTH(data_final_banco)&"/"&YEAR(data_final_banco)

			response.Write "<p class='eventos' style='font-size:12px; line-height:18px;'><strong>Empregado:</strong>"& NO_NOME  &"<br/><strong>Evento/Motivo:</strong> " & projeto &"<br/><strong>Local/Per&iacute;odo:</strong> " & cidade &" - " &data_inicio_total& " &agrave; " &data_final_total& "</p>"
			
			rs.movenext
		LOOP
	
END IF			

set rs = nothing
set objConn = nothing

'FIM DOS destacamentos
%>



<%
'COMEÇO FERIAS
QueryFerias = "DECLARE @DATA DATETIME SET @DATA = CONVERT(DATETIME, '"&dataTotal&"', 103) select DISTINCT FERIAS.DT_INICIO,FERIAS.CO_MATRICULA, FERIAS.QT_DIAS, USUARIOS.NO_NOME, USUARIOS.CO_UNIDADE, CONVERT(datetime, DATEADD(day, FERIAS.QT_DIAS, FERIAS.DT_INICIO), 103)-1 AS DATA_FINAL from TB_FERIAS AS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE CO_SITUACAO=2 AND USUARIOS.IC_ATIVO=1 AND USUARIOS.CO_UNIDADE = 7180 AND @DATA BETWEEN (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1 AND DATEADD(DAY, FERIAS.QT_DIAS, (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1) ORDER BY USUARIOS.NO_NOME"


set ferias=Server.CreateObject("ADODB.RecordSet")
ferias.Open QueryFerias, dados_sys


if ferias.eof THEN


ELSE

	Response.Write "<h3 style='color:#248fc5;font-size:16px;font-weight:bold;'>F&eacute;rias</h3>"

	DO UNTIL ferias.eof
		
		dataInicialBanco = ferias("DT_INICIO")
		dataFinal = ferias("DATA_FINAL")
		NO_NOME = ferias("NO_NOME")
	
	
'		
			
			response.Write "<p class='agendaFerias' style='font-size:12px; line-height:18px;'><strong>"& NO_NOME &"</strong>  - " &dataInicialBanco& "                     &agrave;          "&dataFinal&"</p>"
		
	


	ferias.movenext
	LOOP
END IF	
'	

set ferias = nothing
set objConn = nothing 



'FIM DAS FERIAS
%>





<%

'COMEÇO DAS AUSENCIAS

QueryAusencias ="SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO = 2) AND ('"&dataTotal&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM)ORDER BY USUARIOS.NO_NOME"


	set ausencias =	Server.CreateObject("ADODB.RecordSet")
	ausencias.Open QueryAusencias, dados_sys
	
	if ausencias.eof Then
  	
  	else	
				response.Write "<h3 style='color:#248fc5;font-size:16px;font-weight:bold;'>Aus&ecirc;ncias</h3>"
			   
	DO UNTIL ausencias.eof
	
	
		NO_NOME = ausencias("NO_NOME")
		DE_TIPO_AFASTAMENTO = ausencias("DE_TIPO_AFASTAMENTO")
		DT_INICIO=ausencias("DT_INICIO")
		DT_FIM=ausencias("DT_FIM")
		
		IF DT_FIM ="" Then
		
			DT_FIM = " "
			
		END IF	
		
		
		
		
		response.Write "<p class='eventos' style='font-size:12px; line-height:18px;'><strong>Empregado:</strong>"& NO_NOME  &"  -  "&DT_INICIO&"  &agrave;  "&DT_FIM&"<br/><strong>Motivo:</strong>"& DE_TIPO_AFASTAMENTO &"</p>"		
			
		
		
		

		ausencias.movenext
		
	LOOP
	END IF
	
set ausencias = 	nothing
set objConn = 		nothing 

'FIM DAS AUSENCIAS
%>


</div><!-- Fecha demais conteudos, exceto a frase -->




</div><!-- Fecha fundo branco -->
</div> <!-- Fecha fundo azul, atras do funco branco -->

<input type="submit" class='myButton' name="btnEnviarAgenda" id="btnEnviarAgenda" value="Enviar Agenda" onclick="enviarAgenda();" style="margin-left:37.8%;margin-top:3%;width:auto;"/>
