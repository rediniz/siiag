<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="../include/funcoes.asp" -->
<script src="../scripts/jquery-1.9.1.js"></script>
<link rel="stylesheet" href="botao_azul.css" type="text/css" />
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
<script>
$(document).ready(function(){
	$(".gota").on("click", function(){
		window.open("http://fgts.caixa/gotasufug/");
	});
});
</script>
<div id="corpo_email">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.estilo1 {
	font-family: "Trebuchet MS", Verdana, Arial, sans-serif;
	font-size: 12px;
	color: #0b3e4f;
}
.estilo2, estilo2 li, estilo2 p, estilo2 strong {
	font-family: "Trebuchet MS", Verdana, Arial, sans-serif;
	font-size: 13px;
	color: #0b3e4f;
}
.estilo5 {
	font-family: "Trebuchet MS", Verdana, Arial, sans-serif;
	font-size: 15px;
	color: #248fc5;
	font-weight:bold;
}
.botao {
	      
        background-color:#3d94f6;
        
        -moz-border-radius:6px;
        -webkit-border-radius:6px;
        border-radius:14px;
        
        border:1px solid #337fed;
        
        display:inline-block;
        color:#ffffff;
        font-family:Arial,Verdana, Helvetica;
        font-size:9px;
        font-weight:normal;
        padding: 4px 4px 4px 4px;
        text-decoration:none;
        
        text-shadow:0px 1px 0px #1570cd;
        
    }
    .botao:hover {
        
        background-color:#1e62d0;
		
    }
    .botao:active {
        position:relative;
        top:1px;
    }


-->
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#E8FBFF">&nbsp;</td>
    <td width="600"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
          <td><img src="\\ce7180nt005\CaixaNet\Intranet\SIIAG_WEB_HOM\imagens\agendagifug_01.jpg" alt="Agenda GIFUG/FO" width="600" height="60" /></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr bgcolor="#FFFFFF">
                <td width="9" valign="top"><img src="\\ce7180nt005\CaixaNet\Intranet\SIIAG_WEB_HOM\imagens\agendagifug_04.jpg" width="10" height="55" /></td>
                <td valign="top" style="border:solid 1px #aed7e4; "><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <%
codFrase = Request("codFrase")

%>
                      <td bgcolor="f6fbff" style="border-bottom:solid 1px #aed7e4; padding:4px;"><span class="estilo1">
                        <!-- #INCLUDE FILE="agenda_PegaFrase.asp" -->
                        </i></span></td>
                      <%



%>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF" class="estilo2" style="padding:10px;"><!-- ANIVERSARIANTES -->
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
<!-- ==========================(GIFUG COLABORATIVA - INÍCIO)============================ -->
<%

	'##### PEDIDO ########
	pedidoQuery = "select *, pedido.id as idPedido from tb_colaboracao_pedido as pedido join tb_gs as coordenacao on pedido.coordenacao = coordenacao.co_gs WHERE ('"&dataTotal&"' BETWEEN data_inicial AND data_final) AND (status = 1 OR status = 2)"
	

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open pedidoQuery, dados_sys
	tituloJaExibido = false
	
	if rs.eof Then
		response.Write ""
	else

		do until rs.eof
			if rs("status") = 1 or (rs("status") = 2 and contaDiasUteis(rs("data_inicio_colaboracao"),dataTotal)) then 
		tituloJaExibido = true
%>
		<p class="estilo5">
			<br>
			GIFUG Colaborativa
		</p>
		<ul>
<%

				queryQuantidadeColaborando = "select count(*) as quantidade from tb_colaboracao where pedido = "&rs("id")&""
				set objConn = server.CreateObject("ADODB.Connection") 
				objConn.open(dados_sys)	
				quantidadeColaborando = objConn.execute(queryQuantidadeColaborando)("quantidade")
				
				if quantidadeColaborando = 0 then
					cor = "style='color:#C00'"
				end if
	%>
				<li class="estilo7"> 
					<span <%=cor%>>A coordenação <strong><%=rs("no_gs")%></strong> precisa de ajuda: <br/><br/></span>
					<strong>Atividade: </strong><%=rs("atividade")%><br>
					<strong>Período: </strong> <%=rs("data_inicial")%> a <%=rs("data_final")%><br>
					<strong>Quantidade de horas: </strong><%=rs("quantidade_horas")%><br>
					<br />
					<%
						'##### COLABORAÇÃO ########
						colaboracaoQuery = "select * from tb_colaboracao as colaboracao join vw_usuarios as usuario on usuario.co_matricula = colaboracao.indicado WHERE colaboracao.pedido = "&rs("idPedido")&""
							
						set objConn = server.CreateObject("ADODB.Connection") 	
						set rs2=Server.CreateObject("ADODB.RecordSet")
						rs2.Open colaboracaoQuery, dados_sys
						
						if rs2.eof Then
							response.Write ""
						else	
							do until rs2.eof
								'#ALTERADO EM 20/05/2016----------------
								'removido o IF daqui
									%>          					
									<span style="color:#090">> <strong><%=Capitalize(rs2("no_nome"))%></strong> está colaborando com essa atividade.</b><br/></span>
									<strong>Quantidade de horas: </strong><%=rs2("quantidade_horas")%><br>
									<br />
									<%
								'----------------------------------------
								rs2.movenext
							loop
						end if
					%>
				</li>
<%
			end if
			rs.movenext
		loop
%>
		</ul>
<%
	end if
	
	'##### RECONHECIMENTO ########
	reconhecimentoQuery = "select * from tb_colaboracao_pedido as pedido join tb_gs as coordenacao on pedido.coordenacao = coordenacao.co_gs WHERE ('"&dataTotal&"' BETWEEN data_conclusao AND DATEADD(day,1,data_conclusao)) AND status = 3"
	
	set objConn = server.CreateObject("ADODB.Connection") 	
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open reconhecimentoQuery, dados_sys
	
	if rs.eof Then
		response.Write ""
	else
		if tituloJaExibido = false then
			tituloJaExibido = true
%>		
            <p class="estilo5">
                <br>
                GIFUG Colaborativa
            </p>
<%
		end if

		do until rs.eof
		
%>      
        <ul>
<%
					
			queryColaboradores = "select * from tb_colaboracao as colaboracao join vw_usuarios as usuario on usuario.co_matricula = colaboracao.indicado where colaboracao.pedido = "&rs("id")&""
			
			set rs2=Server.CreateObject("ADODB.RecordSet")
			rs2.cursorlocation = 3
			rs2.Open queryColaboradores, dados_sys

			redim colaboradores(cint(rs2.recordcount))
			dim contador
			contador = 0
			
			do until rs2.eof
				contador = contador + 1
				colaboradores(contador) = Capitalize(rs2("no_nome"))
				rs2.movenext
			loop
			
			stringColaboradores = ""
			stringAjuda = "do(a) colaborador(a)"
			
			if(contador > 1) then
				stringAjuda = "dos(as) colaboradores(as)"
			end if
			for i = 1 to contador
				if(contador > 1 and i = contador-1) then
					stringColaboradores = stringColaboradores & colaboradores(i) & " e "
				elseif i < contador then
					stringColaboradores = stringColaboradores & colaboradores(i) & ","
				else
					stringColaboradores = stringColaboradores & colaboradores(i)	
				end if	
			next
%>
				<li class="estilo7"> 
					<span style="color:#069">A coordenação <%=rs("no_gs")%> agradece a ajuda <%=stringAjuda%> <strong><%=stringColaboradores%></strong> na atividade <b><%=rs("atividade")%></b> (<%=rs("data_inicial")%> a <%=rs("data_final")%>):<br/></span>
                    <% if rs("mensagem_reconhecimento") <> "" then %>
					<blockquote><i>"<%=rs("mensagem_reconhecimento")%>"</i></blockquote>
                    <% else %><br /><%end if %>
				</li>        
			</ul>
<%
				rs.movenext
		loop
	end if
	
	set rs = nothing
	set objConn = nothing
%>
<!-- ===========================(GIFUG COLABORATIVA - FIM)========================================= -->
<%
dataPesquisada=Request("data")

'começa aqui o aniversariantes, somente aparecera na agenda caso haja realmente aniversariantes
aniversariantesQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM VW_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"') AND IC_ATIVO=1 AND IC_NAO_EXIBIR_ANIV = 0 AND CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"" 

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

	%>
                        <p class="estilo5"><br>
                          Aniversariantes <a href="http://fgts.caixa/gotasufug/"  target="_blank" class="button botao" style="">ENVIAR GOTA</a></p>
                        <ul>
                          <%

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	Nome = Capitalize(Nome)
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)


%>
                          <li class="estilo8"><strong>Nome: </strong><%=Nome%><br>
                          <strong>Data: </strong><%=Formatar_Dia(diaBanco) & "/" & Formatar_Mes(mesBanco)%><br>
                          <br />
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
aniversariantesQuery = "SELECT TB.DT_NASCIMENTO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_NASCIMENTO))+'/'+STR(MONTH(DT_NASCIMENTO))+'/'+ STR(YEAR('"&dataTotal&"')),103) as aniv from tb_usuarios where ic_ativo = 1 AND IC_NAO_EXIBIR_ANIV = 0 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ((DATEPART(DW,'"&dataTotal&"') = 6 AND ANIV BETWEEN DATEADD(D,1,'"&dataTotal&"') AND DATEADD(D,2,'"&dataTotal&"')) OR (DATEPART(DW,'"&dataTotal&"') = 2 AND ANIV BETWEEN DATEADD(D,-2,'"&dataTotal&"') AND DATEADD(D,-1,'"&dataTotal&"') )) ORDER BY NO_NOME"





set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

		%>
                        <p class="estilo5"><br>
                          Aniversariantes Fim de Semana <a href="http://fgts.caixa/gotasufug/"  target="_blank" class="button botao" style="">ENVIAR GOTA</a></p>
                        <ul>
                          <%

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	Nome = Capitalize(Nome)
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)


%>
                          <li class="estilo8"><strong>Nome: </strong><%=Nome%><br>
                          </li>
                          <strong>Data: </strong><%=Formatar_Dia(diaBanco) & "/" & Formatar_Mes(mesBanco)%><br>
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
aniversariantesQuery = "SELECT TB.DT_ADMISSAO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_ADMISSAO))+'/'+STR(MONTH(DT_ADMISSAO))+'/'+ STR(YEAR('"&dataTotal&"')),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ( aniv = convert(datetime, STR(day('"&dataTotal&"'))+'/'+str(month('"&dataTotal&"'))+'/'+str(year('"&dataTotal&"')), 103) or (DATEPART(DW,'"&dataTotal&"') = 6 AND ANIV BETWEEN '"&dataTotal&"' AND DATEADD(D,2,'"&dataTotal&"')) OR (DATEPART(DW,'"&dataTotal&"') = 2 AND ANIV BETWEEN DATEADD(D,-2,'"&dataTotal&"') AND '"&dataTotal&"' )) ORDER BY NO_NOME"


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesQuery, dados_sys

IF rs.eof Then
		response.Write ""
ELSE

		%>
                        <p class="estilo5"><br>
                          Aniversariantes de CAIXA <a href="http://fgts.caixa/gotasufug/"  target="_blank" class="button botao" style="">ENVIAR GOTA</a></p>
                        <ul>
                          <%

DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	Nome = Capitalize(Nome)
	DATA_ADMISSAO=rs("DT_ADMISSAO")
	
	diaBanco=DAY(DATA_ADMISSAO)
	mesBanco=MONTH(DATA_ADMISSAO)	
%>
                          <li class="estilo8"><strong>Nome: </strong><%=Nome%><br>
                          </li>
                          <strong>Data: </strong><%=Formatar_Dia(diaBanco) & "/" & Formatar_Mes(mesBanco)%><br>
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
eventosQuery = "SELECT EVENTOS.DE_EVENTO, EVENTOS.CO_SITUACAO, EVENTOS.DH_HORA_INICIO,EVENTOS.DH_HORA_FIM, EVENTOS.DE_PARTICIPANTES, EVENTOS.DE_OBS, GS.NO_GS, LOCAL.DE_LOCAL, EVENTOS.CO_TIPO_EVENTO, DE_TIPO_EVENTO FROM TB_EVENTOS EVENTOS INNER JOIN VW_GS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA INNER JOIN TB_LOCAL LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL INNER JOIN TB_TIPOS_EVENTO ON EVENTOS.CO_TIPO_EVENTO = TB_TIPOS_EVENTO.CO_TIPO_EVENTO WHERE(LOCAL.ATIVO = 1) AND ('"&dataTotal&"' BETWEEN EVENTOS.DH_INICIO AND EVENTOS.DH_FIM) AND EVENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" AND EVENTOS.CO_SITUACAO = 2" 

set objConn = server.CreateObject("ADODB.Connection") 

set rs=Server.CreateObject("ADODB.RecordSet")
'response.write eventosQuery
rs.Open eventosQuery, dados_sys


IF rs.eof Then
		response.Write ""
ELSE
	
	%>
                        <p class="estilo5"><br>
                          Eventos</p>
                        <ul>
                          <%

	DO UNTIL rs.eof

		TP_EVENTO = rs("DE_TIPO_EVENTO")
		DE_EVENTO = rs("DE_EVENTO")
		DE_PARTICIPANTES = rs("DE_PARTICIPANTES")
		DE_OBS = " - "
		NO_GS = rs("NO_GS")
		DE_LOCAL = rs("DE_LOCAL")
		DH_HORA_INICIO = rs("DH_HORA_INICIO")
		DH_HORA_FIM = rs("DH_HORA_FIM")
	
	
	%>
                          <li class="estilo7"> <strong>Coordenação: </strong><%=NO_GS%> <br>
                            <strong>Tipo: </strong><%=TP_EVENTO%><br>
                            <strong>Evento/Motivo: </strong><%=DE_EVENTO%><br>
                            <strong>Participantes: </strong><%=DE_PARTICIPANTES%><br>
                            <strong>Local/Per&iacute;odo: </strong><%=DE_LOCAL%> - <%=formatDateTime(DH_HORA_INICIO, 4)%>h às <%=formatDateTime(DH_HORA_FIM, 4)%>h<br>
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

'começo dos destacamentos
destacamentosQuery = "SELECT DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME FROM TB_DESTACAMENTOS AS DESTACAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA WHERE DESTACAMENTOS.CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND (DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND (('"& dataTotal &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM) OR (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataTotal &"') ) "


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open destacamentosQuery, dados_sys
'response.write destacamentosQuery
if rs.eof THEN

response.Write ""

ELSE
%>
                        <p class="estilo5"><br>
                          Destacamentos</p>
                        <ul>
                        <%
DO UNTIL rs.eof
	
			
			matricula = rs("CO_MATRICULA")
			projeto=rs("DE_PROJETO")
			cidade=rs("NO_CIDADE")
			NO_NOME = rs("NO_NOME")
			NO_NOME = Capitalize(NO_NOME)
			data_inicio_banco = rs("DT_INICIO")
			data_final_banco = rs("DT_FIM")
			DE_OBS = " - "
			
			data_inicio_total = DAY(data_inicio_banco)&"/"&MONTH(data_inicio_banco)&"/"&YEAR(data_inicio_banco)
			data_final_total =  DAY(data_final_banco)&"/"&MONTH(data_final_banco)&"/"&YEAR(data_final_banco)

			
			%>
                        <li class="estilo7"><strong>Empregado: </strong><%=no_nome%><br>
                          <strong>Evento/Motivo: </strong><%=projeto%><br>
                          <strong>Local/Per&iacute;odo:</strong> <%=cidade%> - <%=Formatar_Data(data_inicio_total)%> a <%=Formatar_Data(data_final_total)%><br>
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
                        <p class="estilo5"><br>
                          F&eacute;rias</p>
                        <ul>
                          <%

	DO UNTIL ferias.eof
		
		dataInicialBanco = ferias("DT_INICIO")
		dataFinal = ferias("DATA_FINAL")
		NO_NOME = ferias("NO_NOME")
		NO_NOME = Capitalize(NO_NOME)
	
	
			%>
                          <li class="estilo7"><strong><%=NO_NOME%> - </strong> <%=dataInicialBanco%> a <%=dataFinal%> </li>
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

QueryAusencias ="SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO in (2,3) ) AND ('"&dataTotal&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM) AND AFASTAMENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY USUARIOS.NO_NOME"


	
	set ausencias =	Server.CreateObject("ADODB.RecordSet")
	ausencias.Open QueryAusencias, dados_sys
	
	if ausencias.eof Then
  	
  	else	
				%>
                        <p class="estilo5"><br>
                          Aus&ecirc;ncias</p>
                        <ul>
                          <%
	
			   
	DO UNTIL ausencias.eof
	
	
		NO_NOME = ausencias("NO_NOME")
		NO_NOME = Capitalize(NO_NOME)
		DE_TIPO_AFASTAMENTO = ausencias("DE_TIPO_AFASTAMENTO")
		DT_INICIO=ausencias("DT_INICIO")
		DT_FIM=ausencias("DT_FIM")
		
		IF DT_FIM ="" Then
		
			DT_FIM = " "
			
		END IF	

	%>
                          <li class="estilo7"><strong>Empregado:</strong> <%=NO_NOME%> - <%=DT_INICIO%> a <%=DT_FIM%><br>
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

<br />
                      </td>
                    </tr>
                  </table></td>
                <td width="9" valign="top" ><img src="\\ce7180nt005\CaixaNet\Intranet\SIIAG_WEB_HOM\imagens\agendagifug_03.jpg" width="9" height="56" /></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td>&nbsp;</td>
                <td style="border:solid 1px #aed7e4; border-top:none;"><img src="\\ce7180nt005\CaixaNet\Intranet\SIIAG_WEB_HOM\imagens\agendagifug_10.png" width="579" height="67" /></td>
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
	Function contaDiasUteis(data1, data2)
		d1 = data1
		d2 = data2
		diasUteis = 0
		
		if not isnull(data1) then
		
			do while(cdate(d1) <> cdate(d2))
				If Weekday(d1) > 1 And Weekday(d1) < 7 Then
					diasUteis = diasUteis + 1
				End If
				d1 = DateAdd("d", 1, d1)
			loop
			contaDiasUteis = diasUteis < 3
		else
			contaDiasUteis = true
		end if
		
		
		
	End Function
%>

<%
'************ DESTINATÁRIOS *********************************
query_destinatarios = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE CO_UNIDADE = " &  request.Cookies("co_usuario_unidade_siiag")  & "  AND LEFT(CO_MATRICULA,1) IN ('C','E') AND IC_ATIVO = 1 AND NOT CO_MATRICULA='E734188'"
'response.write query_destinatarios
set rs = Server.CreateObject("ADODB.RecordSet")
rs.Open query_destinatarios, dados_sys

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
</div>
<div align="center">
  <input type="hidden" name="matricula" id="matricula" value="<%=request.Cookies("co_usuario_siiag")%>"/>
  <input type="hidden" name="titulo" id="titulo" value="<%=titulo%>"/>
  <input type="submit" class='myButton' name="btnEnviarAgenda" id="btnEnviarAgenda" value="Enviar Agenda" onclick="enviarAgenda();" />
</div>
