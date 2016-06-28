<!-- #INCLUDE file ="FusionCharts.asp" -->
<SCRIPT LANGUAGE="Javascript" SRC="medicao_demandas/FusionCharts.js"></SCRIPT>
<%
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
if request("data_inicial") <> "" then
	
data_inicial = CDate(request("data_inicial"))
data_final 	= DateSerial(Year(CDate(request("data_final"))), _
Month(CDate(request("data_final"))) + 1, 0)

data = data_inicial

Dim strXML
'Generate the chart element
   strXML = "<graph caption='Demandas atendidas no prazo entre "&monthname(month(data_inicial))&" e "&monthname(month(data_final))&" de "&year(data_final)&"' decimalPrecision='2' showNames='1'  formatNumberScale='0' inDecimalSeparator=','  numberSuffix=' %25' inThousandSeparator='.' yAxisMaxValue='100' yAxisMinValue='0'  >"
do 

	Set oRs2 = Server.CreateObject("ADODB.Recordset")
	
	'#Alterado em 05/12/2015 (consultas melhoradas para o caso de demandas pendentes)
	
		where1 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0)) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0))"
		where2 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0)))"

	'Data de conclusão ultrapassou o prazo, porém a data de pendência estava no prazo
	'where_pendente1 = "(month(CAST('"&data&"' AS DATETIME)) = month(dt_ini_atdmt)) and (year(CAST('"&data&"' AS DATETIME)) = year(dt_ini_atdmt)) and ((dt_conclusao > dt_prev_conc) and (dt_pendente between dt_ini_atdmt and dt_prev_conc))"
	
	'Demanda ainda não foi concluída, porém a data de pendência está dentro do prazo
	'where_pendente2 = "(month(CAST('"&data&"' AS DATETIME)) = month(dt_ini_atdmt)) and (year(CAST('"&data&"' AS DATETIME)) = year(dt_ini_atdmt)) and ((dt_conclusao is null) and (dt_pendente between dt_ini_atdmt and dt_prev_conc))"
	
	
	strQuery =  "declare @total as int;" &_
				"declare @atendidas as int;" &_
				"declare @porcentagem as float;" &_
				
				"SET @total = (select count(*) from vw_demanda_operacional where (month(CAST('"&data&"' AS DATETIME)) = month(dt_ini_atdmt)) and year(CAST('"&data&"' AS DATETIME)) = year(dt_ini_atdmt)) " &_
				"SET @atendidas = (select count(*) from vw_demanda_operacional where (month(CAST('"&data&"' AS DATETIME)) = month(dt_ini_atdmt)) and (year(CAST('"&data&"' AS DATETIME)) = year(dt_ini_atdmt)) and (("&where1&") or ("&where2&")))" &_
								
				"if @total <> 0 begin set @porcentagem = (CAST(@atendidas AS float) / CAST(@total AS float)*100) end else set @porcentagem=0" &_
				
				"select @total as total, @atendidas as atendidas, CAST(@porcentagem AS DECIMAL(18,2)) as porcentagem"
				
	
	Set oRs2 = objConn.Execute(strQuery) 
	


	if CDbl(ors2("porcentagem")) < 50 then		
		color = "FF8E46"
	elseif CDbl(ors2("porcentagem")) >= 50 and CDbl(ors2("porcentagem")) < 70 then
		color = "F6BD0F"
	elseif CDbl(ors2("porcentagem")) >= 70 then
		color = "8BBA00"
	end if
	
	if CDbl(ors2("porcentagem")) <> "0" then
	
		strXML = strXML & "<set name='" & monthname(month(data), true) & "' value='" & replace(ors2("porcentagem"), ",", ".") & "' color='"&color&"'/>"
	
	end if
	
		data = DateAdd("m", 1, data)

loop until datediff("m", data, data_final) = -1

 strXML = strXML & "</graph>"
 
 	Call renderChartHTML("medicao_demandas/Charts/FCF_Line.swf", "", strXML, "myNext", 800, 300)
		'Close recordset
	Set oRs2 = Nothing

end if

%>
