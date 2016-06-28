<script>
	function enviarAgenda(){
		
		confirmacao = window.confirm("Deseja enviar Agenda?");
		
		var texto = $("#corpo_email").html();
		var remetente = $("#matricula").val();
		var destinatario = $("#destinatarios").val();
		
		alert(destinatario);
		
			if(confirmacao){
				//enviar_mensagem(texto);
				//window.location.assign("apoio/enviar_email.asp?texto="+texto);
			} else {
						
			return false;
			
			}	
	}	
</script>   

<script language="VBScript" type="text/vbscript">
	sub imprimir(texto)
		msgbox texto
	end sub
	
	sub enviar_mensagem(remetente, destinatario, mensagem, titulo)
			on error resume next
			texto_mensagem = texto
			
			Set OutApl = CreateObject("Outlook.Application")
			Set OutSes = OutApl.GetNameSpace("MAPI")
			OutSes.Logon remetente ,"" , False, False
			erro = 0
			sucesso = 0
		
			err.clear
			Set OutMsg = OutApl.CreateItem(olMailItem)
			//OutMsg.Attachments.Add "\\ce7180nt005\cartoesSUFUG$\<%=tema%>"
			//OutMsg.Attachments.Add "\\ce7180nt005\Intranet\aniversarioSUFUG\cartoesSUFUG\<%=tema%>"
	
			OutMsg.Subject = titulo
			OutMsg.HtmlBody = mensagem
			OutMsg.Recipients.Add  destinatario
			OutMsg.Send
			
			if err.number <> 0 then 
				msgbox "Erro no envio do cartão: " & vbnewline & "DE: <%= de %>" & vbnewline & "<%= data %>  Nome: <%= nome %> Matrícula: <%=matricula%> " & vbnewline & err.description & vbnewline & vbnewline & "Continuando envio de cartões."
				erro = erro + 1
			else
				sucesso = sucesso + 1
			End if
			
			Set OutMsg = Nothing
			Set OutApl = Nothing
			
	
			msgbox "Cartões enviados: " & sucesso & " sucesso(s) / " & erro & " erro(s)"
			
	end sub
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
font-style:italic;
/*border:#000000 solid 1px;*/}

.topoFrase{
border:#aed7e4 solid 1px; 
height:auto;
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
<div id="corpo_email">
<!-- height tem que ser auto para que se ajuste ai tamanho do conteudo da tela -->
<div class="fundoAzul" style="background:#e8fbff; height:auto;width:900px;margin:auto;"> <!-- fundo azul, atras do funco branco -->
<!-- Titulo da Agenda -->
<div style="background:#ffffff; height:auto;width:598px;margin-left:50px;margin-bottom:0px;border:#aed7e4 solid 1px;border-bottom:none">
<img src="imagens/agendagifug_01.jpg"  style="width:100%;height:100%;"  />
</div>
<!-- Fim do título da Agenda-->
<div class="fundoBranco" style="background:#ffffff; height:auto;width:600px;margin-left:50px;"> <!-- fundo branco -->

<div style="border:#aed7e4 solid 1px;height:auto;margin:0px;padding:0px;"><!-- topo, onde fica a frase -->

<!-- #INCLUDE FILE="agenda_PegaFrase.asp" -->

</div><!-- Fecha topo, onde fica a frase -->


<div class="conteudos" style="border-bottom:#aed7e4 solid 1px; height:auto;border-left:#aed7e4 solid 1px;border-right:#aed7e4 solid 1px;"> <!-- demais conteudos, exceto a frase -->
<%
 response.write "&nbsp;"
 
if request("data") <> "" then

dataTotal = request("data")

else

dataTotal = (DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)

end if

%>

<%

'começa aqui o aniversariantes, somente aparecera na agenda caso haja realmente aniversariantes
aniversariantesQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM VW_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"') AND IC_ATIVO=1 AND CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"" 


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


	
Response.Write "<p style='font-size:12px; line-height:18px;color:#000000;letter-spacing:0px;font-family:Arial, Helvetica,sans-serif;font-style:italic;'><strong>Nome: </strong>"& Nome  &"<br/><strong>Data: </strong> " & DAY(dataBanco)&"/"&MONTH(dataBanco) &"</p>"
	
	'END IF

	 
	rs.movenext
	LOOP
	
End If

set rs = nothing
set objConn = nothing

'fim dos aniversariantes

%>

<%
'=======================COMEÇO ANIVERSARIANTES FIM DE SEMANA=============================================
'começa aqui o aniversariantes, somente aparecera na agenda caso haja realmente aniversariantes
aniversariantesQuery = "SELECT TB.DT_NASCIMENTO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_NASCIMENTO))+'/'+STR(MONTH(DT_NASCIMENTO))+'/'+ STR(YEAR('"&dataTotal&"')),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ((DATEPART(DW,'"&dataTotal&"') = 6 AND ANIV BETWEEN '"&dataTotal&"' AND DATEADD(D,2,'"&dataTotal&"')) OR (DATEPART(DW,'"&dataTotal&"') = 2 AND ANIV BETWEEN DATEADD(D,-2,'"&dataTotal&"') AND '"&dataTotal&"' )) ORDER BY NO_NOME"


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

	response.Write "<h3 style='color:#248fc5;font-size:16px;font-weight:bold;'>Aniversariantes Fim de Semana</h3>"

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)


	
Response.Write "<p style='font-size:12px; line-height:18px;color:#000000;letter-spacing:0px;font-family:Arial, Helvetica,sans-serif;font-style:italic;'><strong>Nome: </strong>"& Nome  &"<br/><strong>Data: </strong> " & DAY(dataBanco)&"/"&MONTH(dataBanco) &"</p>"
	
	'END IF

	 
	rs.movenext
	LOOP
	
End If

set rs = nothing
set objConn = nothing

'======================= FIM ANIVERSARIANTES FIM DE SEMANA=============================================

%>


<%
'=======================COMEÇO ANIVERSARIANTES FIM DE SEMANA=============================================
'começa aqui o aniversariantes, somente aparecera na agenda caso haja realmente aniversariantes
aniversariantesQuery = "SELECT TB.DT_ADMISSAO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_ADMISSAO))+'/'+STR(MONTH(DT_ADMISSAO))+'/'+ STR(YEAR(getdate())),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ( aniv = convert(datetime, STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate())), 103) or (DATEPART(DW,getdate()) = 6 AND ANIV BETWEEN getdate() AND DATEADD(D,2,getdate())) OR (DATEPART(DW,getdate()) = 2 AND ANIV BETWEEN DATEADD(D,-2,getdate()) AND getdate() )) ORDER BY NO_NOME"


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

	response.Write "<h3 style='color:#248fc5;font-size:16px;font-weight:bold;'>Aniversariantes de Caixa</h3>"

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	DATA_ADMISSAO=rs("DT_ADMISSAO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)


	
Response.Write "<p style='font-size:12px; line-height:18px;color:#000000;letter-spacing:0px;font-family:Arial, Helvetica,sans-serif;font-style:italic;'><strong>Nome: </strong>"& Nome  &"<br/><strong>Data: </strong> " & DAY(DATA_ADMISSAO)&"/"&MONTH(DATA_ADMISSAO) &"</p>"
	
	'END IF

	 
	rs.movenext
	LOOP
	
End If

set rs = nothing
set objConn = nothing

'======================= FIM ANIVERSARIANTES FIM DE SEMANA=============================================

%>


<%

'começo dos eventos, tambem so aparecera caso haja algum evento
eventosQuery = "SELECT EVENTOS.DE_EVENTO, EVENTOS.DE_PARTICIPANTES, EVENTOS.DE_OBS, GS.NO_GS, LOCAL.DE_LOCAL FROM TB_EVENTOS EVENTOS INNER JOIN VW_GS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA INNER JOIN TB_LOCAL LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL WHERE(LOCAL.ATIVO = 1) AND ('"&dataTotal&"' BETWEEN EVENTOS.DH_INICIO AND EVENTOS.DH_FIM) AND EVENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"; " 

set objConn = server.CreateObject("ADODB.Connection") 

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
	
   
    Response.Write "<p style='font-size:12px; line-height:18px;color:#000000;letter-spacing:0px;font-family:Arial, Helvetica, sans-serif;font-style:italic;'><strong>Ger&ecirc;ncia:</strong>"& NO_GS  &"<br/><strong>Tipo:</strong> " & DE_EVENTO &"<br/><strong>Evento/Motivo:</strong> " & DE_EVENTO & "<br/><strong>Participantes:</strong> " & DE_PARTICIPANTES & "<br/><strong>Local/Per&iacute;odo:</strong> " & DE_LOCAL &"</p>"

	rs.movenext
	LOOP
	
End If


set rs = nothing
set objConn = nothing

'FIM dos eventos, tambem so aparecera caso haja algum evento
%>




<%
'começo dos destacamentos
destacamentosQuery = "SELECT DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME FROM TB_DESTACAMENTOS AS DESTACAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA WHERE DESTACAMENTOS.CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND (DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND ('"& dataTotal &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM) OR(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataTotal &"') "


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

			response.Write "<p style='font-size:12px;line-height:18px;color:#000000;letter-spacing:0px;font-family:Verdana,Helvetica,sans-serif;font-style:italic;'><strong>Empregado:</strong>"& NO_NOME  &"<br/><strong>Evento/Motivo:</strong> " & projeto &"<br/><strong>Local/Per&iacute;odo:</strong> " & cidade &" - " &data_inicio_total& " &agrave; " &data_final_total& "</p>"
			
			rs.movenext
		LOOP
	
END IF			


set rs = nothing
set objConn = nothing

'FIM DOS destacamentos
%>



<%
'COMEÇO FERIAS
QueryFerias = "DECLARE @DATA DATETIME SET @DATA = CONVERT(DATETIME, '"&dataTotal&"', 103) select DISTINCT FERIAS.DT_INICIO,FERIAS.CO_MATRICULA, FERIAS.QT_DIAS, USUARIOS.NO_NOME, USUARIOS.CO_UNIDADE, CONVERT(datetime, DATEADD(day, FERIAS.QT_DIAS, FERIAS.DT_INICIO), 103)-1 AS DATA_FINAL from TB_FERIAS AS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE CO_SITUACAO=2 AND USUARIOS.IC_ATIVO=1 AND USUARIOS.co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&" AND @DATA BETWEEN (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1 AND DATEADD(DAY, FERIAS.QT_DIAS, (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1) AND FERIAS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY USUARIOS.NO_NOME"


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
			
			response.Write "<p class='agendaFerias' style='font-size:12px; line-height:18px;font-family:Verdana,Helvetica,sans-serif;font-style:italic;'><strong>"& NO_NOME &"</strong>  - " &dataInicialBanco& "                     &agrave;          "&dataFinal&"</p>"
		
	


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

QueryAusencias ="SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO = 2) AND ('"&dataTotal&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM) AND AFASTAMENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY USUARIOS.NO_NOME"


	
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
	
		
response.Write "<pstyle='font-size:12px; line-height:18px;color:#000000;letter-spacing:0px;font-family:Arial, Helvetica,sans-serif;font-style:italic;'><strong>Empregado:</strong>"& NO_NOME  &"  -  "&DT_INICIO&"  &agrave;  "&DT_FIM&"<br/><strong>Motivo:</strong>"& DE_TIPO_AFASTAMENTO &"</p>"					
		
		ausencias.movenext
		
	LOOP
	END IF
	
set ausencias = 	nothing
set objConn = 		nothing 

'FIM DAS AUSENCIAS
%>


</div><!-- Fecha demais conteudos, exceto a frase -->




</div><!-- Fecha fundo branco -->
<!-- Rodapé da Agenda-->
<div class="fundoBranco" style="background:#ffffff; height:100;width:579px;margin-left:50px;">
<img src="imagens/agendagifug_09.jpg" style="width:600px;height:auto;"  />
</div>

</div> <!-- Fecha fundo azul, atras do funco branco -->

<%
'query_destinatarios = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE CO_UNIDADE = " &  request.Cookies("co_usuario_unidade_siiag")  & " AND IC_ATIVO = 1 ORDER BY NO_NOME"
'set rs = Server.CreateObject("ADODB.RecordSet")
'rs.Open query_destinatarios, dados_sys

destinatarios = "e711000;e000000"

'if rs.eof Then
  	
  	'else
	
	'destinatarios = destinatarios & rs("CO_MATRICULA") & ";"
	
'end if

response.write "<input type='hidden' id='destinatarios' value='"&destinatarios&"' >"

%>

</div>

<input type="submit" class='myButton' name="btnEnviarAgenda" id="btnEnviarAgenda" value="Enviar Agenda" onclick="enviarAgenda();" style="margin-left:37.8%;margin-top:3%;width:auto;"/>
