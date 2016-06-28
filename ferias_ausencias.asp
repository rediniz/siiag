<!-- #INCLUDE FILE ="include/Conexao.asp" -->		
<!-- essa pagina so mostra as ferias...as ausencias foram transferidas para a pagina agenda_do_dia -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<h3 class="subtitulosAgenda">F&eacute;rias</h3>
<%
if data <> "" Then

dataTotal = data

else

dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

END IF 

QueryQT_dias = "DECLARE @DATA DATETIME SET @DATA = CONVERT(DATETIME, '"&dataTotal&"', 103) select DISTINCT FERIAS.DT_INICIO,FERIAS.CO_MATRICULA, FERIAS.QT_DIAS, USUARIOS.NO_NOME, USUARIOS.CO_UNIDADE, CONVERT(datetime, DATEADD(day, FERIAS.QT_DIAS, FERIAS.DT_INICIO), 103)-1 AS DATA_FINAL from TB_FERIAS AS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE CO_SITUACAO=2 AND USUARIOS.IC_ATIVO=1 AND USUARIOS.CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND @DATA BETWEEN (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1 AND DATEADD(DAY, FERIAS.QT_DIAS, (CONVERT(DATETIME, cast(day(FERIAS.DT_INICIO) as varchar) + '/' + cast(month(FERIAS.DT_INICIO) as varchar) + '/' + cast(year(FERIAS.DT_INICIO) as varchar) + ' 00:00:01', 103))-1) ORDER BY USUARIOS.NO_NOME"


set dias=Server.CreateObject("ADODB.RecordSet")
dias.Open QueryQT_dias, dados_sys

 if dias.eof Then
  response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atilde;o h&aacute; F&eacute;rias.<p>"
  else

	DO UNTIL dias.eof
		
		dataInicialBanco = dias("DT_INICIO")
		
		codigoMatricula = dias("CO_MATRICULA")
		quantidadeDias = dias("QT_DIAS")
		
		dataFinal = dias("DATA_FINAL")
		nomeUsuario = dias("NO_NOME")
	

	response.write "<p style='font-size:12px;font-family:Arial, Verdana;'><strong>"&nomeUsuario&"</strong></p><p style='font-size:12px;font-family:Arial,Verdana'>"& Formatar_data(DAY(dataInicialBanco)&"/"&MONTH(dataInicialBanco)&"/"&YEAR(dataInicialBanco))&" a  "& formatar_data(DAY(dataFinal)&"/"&MONTH(dataFinal)&"/"&YEAR(dataFinal))&"</p>"

	dias.movenext
	LOOP
	
	end if
	
'	

set dias = nothing
set objConn = nothing 

%>