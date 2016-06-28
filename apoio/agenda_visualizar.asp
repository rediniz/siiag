<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="../include/funcoes.asp" -->
<script src="../scripts/jquery-1.9.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script>
	function enviarAgenda(){
		
		var confirmacao = window.confirm("Deseja enviar a Agenda?");
		

		var texto = $("#corpo_email").html();
		var remetente = $("#matricula").val();
		var destinatario = $("#destinatarios").val();
		var titulo = $("#titulo").val();
		
			if(confirmacao){
				alert('enviando');
				enviar_mensagem(remetente,destinatario,texto,titulo);
				//window.location.assign("apoio/enviar_email.asp?texto="+texto);
			} else {
				alert('não enviou');
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
			dim dest
			
			Set OutApl = CreateObject("Outlook.Application")
			Set OutSes = OutApl.GetNameSpace("MAPI")

			OutSes.Logon remetente ,"" , False, False
			erro = 0
			sucesso = 0
		
			err.clear
			Set OutMsg = OutApl.CreateItem(olMailItem)
	
			OutMsg.Subject = titulo
			OutMsg.HtmlBody = mensagem
			
			//msgbox destinatario
			dest = split(destinatario,";")
			
			for each x in dest
				OutMsg.Recipients.Add  x
			next
			//OutMsg.Recipients.Add  destinatario
			
			OutMsg.Send
			
			if err.number <> 0 then 
				msgbox "Erro no envio do cartão: " & vbnewline & "DE: <%= remetente %>" & vbnewline & "<%= data %>  Nome: <%= nome %> Matrícula: <%=matricula%> " & vbnewline & err.description & vbnewline & vbnewline & "Continuando envio de cartões."
				erro = erro + 1
			else
				sucesso = sucesso + 1
			End if
			
			Set OutMsg = Nothing
			Set OutApl = Nothing
			
	
			msgbox "Cartões enviados: " & sucesso & " sucesso(s) / " & erro & " erro(s)"
			
	end sub
</script>

<style type="text/css">
<!--

body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
}
.style1 {
    font-family: "Trebuchet MS", Verdana, Arial, sans-serif;
    font-size: 12px;
    color: #0b3e4f;
}

.style2, style2 li, style2 p, style2 strong {
    font-family: "Trebuchet MS", Verdana, Arial, sans-serif;
    font-size: 13px;
    color: #0b3e4f;
	
}

.style5 {
    font-family: "Trebuchet MS", Verdana, Arial, sans-serif;
    font-size: 15px;
    color: #248fc5;
    font-weight:bold;
}
-->
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#E8FBFF">&nbsp;</td>
    <td width="600"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <tr>
        <td><img src="../imagens/agendagifug_01.jpg" alt="Agenda GIFUG/FO" width="600" height="60" /></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr bgcolor="#FFFFFF">
            <td width="9" valign="top"><img src="../imagens/agendagifug_04.jpg" width="10" height="55" /></td>
            <td valign="top" style="border:solid 1px #aed7e4; "><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
   
<%
codFrase = Request("codFrase")

%>          
              
	<td bgcolor="f6fbff" style="border-bottom:solid 1px #aed7e4; padding:4px;"><span class="style1"><!-- #INCLUDE FILE="agenda_PegaFrase.asp" --> </i></span></td>
<%



%>
              
                
              </tr>
              <tr>
                <td bgcolor="#FFFFFF" class="style2" style="padding:10px;">
                
                
                <!-- ANIVERSARIANTES -->
                
                <%
 
if request("data") <> "" then

dataPesquisada=Request("data")

dataTotal = dataPesquisada

mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)

else

dataTotal = (DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)

end if

%>

<%

dataPesquisada=Request("data")

'começa aqui o aniversariantes, somente aparecera na agenda caso haja realmente aniversariantes
aniversariantesQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM VW_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"') AND IC_ATIVO=1 AND CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"" 


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

	%>
    	 <p class="style5"><br>
                Aniversariantes</p>
                <ul>
    <%

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)


%>
	<li class="style8"><%=Nome%><BR>
    </li>
<%
	
	'END IF

	 
	rs.movenext
	LOOP
	%>
    	</ul>
    <%
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

		%>
    	 <p class="style5"><br>
                Aniversariantes Fim de Semana</p>
                <ul>
    <%

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)


%>
	<li class="style8"><%=Nome%><BR>
    </li>
<%
	
	'END IF

	 
	rs.movenext
	LOOP
		%>
    	</ul>
    <%
End If

set rs = nothing
set objConn = nothing

'======================= FIM ANIVERSARIANTES FIM DE SEMANA=============================================

%>

<%
'=======================COMEÇO ANIVERSARIANTES CAIXA=============================================
'começa aqui o aniversariantes, somente aparecera na agenda caso haja realmente aniversariantes
aniversariantesQuery = "SELECT TB.DT_ADMISSAO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_ADMISSAO))+'/'+STR(MONTH(DT_ADMISSAO))+'/'+ STR(YEAR(getdate())),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ( aniv = convert(datetime, STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate())), 103) or (DATEPART(DW,getdate()) = 6 AND ANIV BETWEEN getdate() AND DATEADD(D,2,getdate())) OR (DATEPART(DW,getdate()) = 2 AND ANIV BETWEEN DATEADD(D,-2,getdate()) AND getdate() )) ORDER BY NO_NOME"


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

		%>
    	 <p class="style5"><br>
                Aniversariantes de CAIXA</p>
                <ul>
    <%

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	
	DATA_ADMISSAO=rs("DT_ADMISSAO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)


	
%>
	<li class="style8"><%=Nome%><BR>
    </li>
<%
	
	'END IF

	 
	rs.movenext
	LOOP
		%>
    	</ul>
    <%
End If

set rs = nothing
set objConn = nothing

'======================= FIM ANIVERSARIANTES CAIXA=============================================

%>
                
                <!-- ==========================(EVENTOS - INÍCIO)============================ -->
               
               <%

'começo dos eventos, tambem so aparecera caso haja algum evento
eventosQuery = "SELECT EVENTOS.DE_EVENTO, EVENTOS.DE_PARTICIPANTES, EVENTOS.DE_OBS, GS.NO_GS, LOCAL.DE_LOCAL FROM TB_EVENTOS EVENTOS INNER JOIN VW_GS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA INNER JOIN TB_LOCAL LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL WHERE(LOCAL.ATIVO = 1) AND ('"&dataTotal&"' BETWEEN EVENTOS.DH_INICIO AND EVENTOS.DH_FIM) AND EVENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"; " 

set objConn = server.CreateObject("ADODB.Connection") 

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open eventosQuery, dados_sys


IF rs.eof Then
		response.Write ""
ELSE
	
	%>
    
    	  <p class="style5"><br>
                Eventos</p>
                <ul>
    
    <%

	DO UNTIL rs.eof

	DE_EVENTO = rs("DE_EVENTO")
	DE_PARTICIPANTES = rs("DE_PARTICIPANTES")
	DE_OBS = " - "
	NO_GS = rs("NO_GS")
	DE_LOCAL = rs("DE_LOCAL")
	
	
	%>
    	     <li class="style7">
             			<strong>Coordenação:</strong><%=NO_GS%> <BR>
	                    <strong>Tipo: </strong><%=DE_EVENTO%><BR>
	                    <strong>Evento/Motivo: </strong><%=DE_EVENTO%><BR>
	                    <strong>Participantes:</strong><%=DE_PARTICIPANTES%><BR>
	                    <strong>Local/Per&iacute;odo:</strong> <%=DE_LOCAL%> - 26/11/2013 - 9h às 17h <br>
	                    <br>
             </li>
    <%

	rs.movenext
	LOOP
	
	%>
    	  </ul>
    <%
	
End If


set rs = nothing
set objConn = nothing

'FIM dos eventos, tambem so aparecera caso haja algum evento
%>
<!-- ===========================(EVENTOS - FIM)========================================= -->
                
<!-- =================================================================== -->
<!-- --------------------------(DESTACAMENTOS - INÍCIO)----------------- -->
<!-- =================================================================== -->
                <%
dataTotal = (DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)

'começo dos destacamentos
destacamentosQuery = "SELECT DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME FROM TB_DESTACAMENTOS AS DESTACAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA WHERE DESTACAMENTOS.CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND (DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND ('"& dataTotal &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM) OR(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataTotal &"') "


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open destacamentosQuery, dados_sys

if rs.eof THEN

response.Write ""

ELSE
%>
	<p class="style5"><br>
                Destacamentos</p>
                 <ul>
	<%
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

			'response.Write "<p style='font-size:12px;line-height:18px;color:#000000;letter-spacing:0px;font-family:Verdana,Helvetica,sans-serif;font-style:italic;'><strong>Empregado:</strong>"& NO_NOME  &"<br/><strong>Evento/Motivo:</strong> " & projeto &"<br/><strong>Local/Per&iacute;odo:</strong> " & cidade &" - " &data_inicio_total& " &agrave; " &data_final_total& "</p>"
			
			%>
            
                 
                    <li class="style7"><strong>Empregado: </strong><%=no_nome%><BR>
	                    <strong>Evento/Motivo: </strong><%=projeto%><BR>
	                    <strong>Local/Per&iacute;odo:</strong> <%=cidade%> - <%=data_inicio_total%> a <%=data_final_total%><br>
	                    <br>
                    </li>
                
            
            <%
			
			rs.movenext
		LOOP
		
		response.write "</ul>"
	
END IF			


set rs = nothing
set objConn = nothing

'FIM DOS destacamentos
%>
                
                <!-- =================================================================== -->
				<!-- --------------------------(DESTACAMENTOS - FIM)-------------------- -->
                <!-- =================================================================== -->
                
                
                
				<!-- ==================================================================== -->
				<!-- --------------------------(FÉRIAS - INÍCIO)------------------------- -->
                <!-- ==================================================================== -->
                
                <%
'COMEÇO FERIAS
QueryFerias = "DECLARE @DATA DATETIME SET @DATA = CONVERT(DATETIME, '"&dataTotal&"', 103) select DISTINCT FERIAS.DT_INICIO,FERIAS.CO_MATRICULA, FERIAS.QT_DIAS, USUARIOS.NO_NOME, USUARIOS.CO_UNIDADE, CONVERT(datetime, DATEADD(day, FERIAS.QT_DIAS, FERIAS.DT_INICIO), 103)-1 AS DATA_FINAL from TB_FERIAS AS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE CO_SITUACAO=2 AND USUARIOS.IC_ATIVO=1 AND USUARIOS.co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&" AND @DATA BETWEEN (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1 AND DATEADD(DAY, FERIAS.QT_DIAS, (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1) AND FERIAS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY USUARIOS.NO_NOME"


set ferias=Server.CreateObject("ADODB.RecordSet")
ferias.Open QueryFerias, dados_sys


if ferias.eof THEN


ELSE

	%>
          <p class="style5"><br>
                    F&eacute;rias</p>
                <ul>
    <%

	DO UNTIL ferias.eof
		
		dataInicialBanco = ferias("DT_INICIO")
		dataFinal = ferias("DATA_FINAL")
		NO_NOME = ferias("NO_NOME")
	
	
			%>
			 <li class="style7"><strong><%=NO_NOME%> - </strong> <%=dataInicialBanco%> a <%=dataFinal%> 
                    </li>
		<%
	


	ferias.movenext
	LOOP
	
	%>
	 </ul>
	<%
	
END IF	
'	

set ferias = nothing
set objConn = nothing 



'FIM DAS FERIAS
%>
            
              
                <!-- ==================================================================== -->
				<!-- --------------------------(FÉRIAS - FIM)------------------------- -->
                <!-- ==================================================================== -->
                
                
     			<%

'COMEÇO DAS AUSENCIAS

QueryAusencias ="SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO = 2) AND ('"&dataTotal&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM) AND AFASTAMENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY USUARIOS.NO_NOME"


	
	set ausencias =	Server.CreateObject("ADODB.RecordSet")
	ausencias.Open QueryAusencias, dados_sys
	
	if ausencias.eof Then
  	
  	else	
				%>
                	   <p class="style5"><br>
                    Aus&ecirc;ncias</p>
                <ul>
                <%
	
			   
	DO UNTIL ausencias.eof
	
	
		NO_NOME = ausencias("NO_NOME")
		DE_TIPO_AFASTAMENTO = ausencias("DE_TIPO_AFASTAMENTO")
		DT_INICIO=ausencias("DT_INICIO")
		DT_FIM=ausencias("DT_FIM")
		
		IF DT_FIM ="" Then
		
			DT_FIM = " "
			
		END IF	
	
		
'response.Write "<pstyle='font-size:12px; line-height:18px;color:#000000;letter-spacing:0px;font-family:Arial, Helvetica,sans-serif;font-style:italic;'><strong>Empregado:</strong>"& NO_NOME  &"  -  "&DT_INICIO&"  &agrave;  "&DT_FIM&"<br/><strong>Motivo:</strong>"& DE_TIPO_AFASTAMENTO &"</p>"	

	%>
    	  <li class="style7"><strong>Empregado:</strong> <%=NO_NOME%> - <%=DT_INICIO%> a <%=DT_FIM%><br>
	                    <strong>Motivo:</strong> <%=DE_TIPO_AFASTAMENTO%> <br>
	                    <br>
                    </li>
    <%				
		
		ausencias.movenext
		
	LOOP
	%>
                </ul>
    <%
	END IF
	
set ausencias = 	nothing
set objConn = 		nothing 

'FIM DAS AUSENCIAS
%>

                </td>
              </tr>
            </table></td>
            <td width="9" valign="top" ><img src="../imagens/agendagifug_03.jpg" width="9" height="56" /></td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td>&nbsp;</td>
            <td style="border:solid 1px #aed7e4; border-top:none;"><img src="../imagens/agendagifug_10.png" width="579" height="67" /></td>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
    <td bgcolor="#E8FBFF">&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="#E8FBFF">&nbsp;</td>
    <td width="600" height="50" bgcolor="#FFFFFF">&nbsp;</td>
    <td bgcolor="#E8FBFF">&nbsp;</td>
  </tr>
</table>

<%
'************ DESTINATÁRIOS *********************************
query_destinatarios = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE CO_UNIDADE = " &  request.Cookies("co_usuario_unidade_siiag")  & "  AND LEFT(CO_MATRICULA,1) IN ('C','E') AND IC_ATIVO = 1"
'response.write query_destinatarios
set rs = Server.CreateObject("ADODB.RecordSet")
rs.Open query_destinatarios, dados_sys

'destinatarios = "C053498;e711000"
destinatarios = ""
do while not rs.eof
	if destinatarios = "" then
		destinatarios = rs("CO_MATRICULA")
	else
		destinatarios = destinatarios &";" & rs("CO_MATRICULA")
	end if
	rs.movenext
loop
'RESPONSE.WRITE destinatarios
response.write "<input type='hidden' id='destinatarios' value='"&destinatarios&"' >"

titulo = "Agenda da " & request.Cookies("co_usuario_sg_unidade_siiag") & " - " & formatar_data(dataTotal)
%>