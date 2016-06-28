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



Dim strXML2
'Generate the chart element
   strXML2 = "<graph caption='Quantidade de demandas por tipo, no período informado acima' decimalPrecision='0' showNames='1'  formatNumberScale='0' inDecimalSeparator=','  numberSuffix=' ' inThousandSeparator='.' margintop='0'>"


	Set oRs = Server.CreateObject("ADODB.Recordset")
	
	'#Alterado em 05/12/2015 (consultas melhoradas para o caso de demandas pendentes)
	'Data de conclusão estava dentro do prazo
		where1 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0)) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0))"
		where2 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0)))"

	'Data de conclusão ultrapassou o prazo, porém a data de pendência estava no prazo
	'where2 = "(dt_conclusao > dt_prev_conc) and (dt_pendente between dt_ini_atdmt and dt_prev_conc)"
	'Demanda ainda não foi concluída, porém a data de pendência está dentro do prazo
	'where3 = "(dt_conclusao is null) and (dt_pendente between dt_ini_atdmt and dt_prev_conc)"
	
strQuery2 =  "select tipo_demanda, count(tipo_demanda) as quantidade from vw_demanda_operacional  where (DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) between '"&data_inicial&"' and '"&data_final&"') and (("&where1&") or ("&where2&")) group by tipo_demanda "
				
	oRs.Open strQuery2, dados_sys
	
	if not oRs.eof then
	
		do while not oRs.eof
	
			strXML2 = strXML2 & "<set name='" & ors("tipo_demanda") & "' value='" & ors("quantidade") & "' />"
		
			oRs.movenext
		
		loop
		
		Set oRs = Nothing
		
		strXML2 = strXML2 & "</graph>"
		
		Call renderChartHTML("medicao_demandas/Charts/FCF_Pie3d.swf", "", strXML2, "myNext", 600, 300)
	
	end if

end if

%>
