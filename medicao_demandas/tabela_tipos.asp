<!-- #INCLUDE file ="../include/conexao.asp" -->
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

'data_inicial = "16/01/2016"
'data_final = "31/01/2016"
	 
	 dim totalQtdPrazo
	 dim totalPorcentagemPrazo
	 dim totalQtdAtraso
	 dim totalPorcentagemAtraso
	 dim totalDemandasTotal
	 
	 totalQtdPrazo = 0
	 totalPorcentagemPrazo = 0
	 totalQtdAtraso = 0
	 totalPorcentagemAtraso = 0
	 totalDemandasTotal = 0

	Set oRs = Server.CreateObject("ADODB.Recordset")
	
	'#Alterado em 05/12/2015 (consultas melhoradas para o caso de demandas pendentes)
	'Data de conclusão estava dentro do prazo
	where1 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0)) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0))"
	where2 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0)))"

	'Data de conclusão ultrapassou o prazo, porém a data de pendência estava no prazo
	'where2 = "(dt_conclusao > dt_prev_conc) and (dt_pendente between dt_ini_atdmt and dt_prev_conc)"
	'Demanda ainda não foi concluída, porém a data de pendência está dentro do prazo
	'where3 = "(dt_conclusao is null) and (dt_pendente between dt_ini_atdmt and dt_prev_conc)"

	strQuery2 =  "select  count(tipo_demanda) as quantidade, tipo_demanda from vw_demanda_operacional  where (dt_ini_atdmt between '"&data_inicial&"' and '"&data_final&"') and (("&where1&") or ("&where2&")) group by tipo_demanda "
				
	oRs.Open strQuery2, dados_sys
	
	if not oRs.eof then
	%>
        <div align="center">
    <label>Informações detalhadas por tipo de demanda:</label>
    </div>
    <br />
    <table>
        <tr>
            <td>Atividade</td>
            <td>Qtd no prazo</td>
            <td>% no prazo</td>
            <td>Qtd em atraso</td>
            <td>% em atraso</td>
            <td>Total de demandas</td>
        </tr>
	<%
		do while not oRs.eof
			queryTotalDemanda =  "select count(*) as total_demanda from vw_demanda_operacional where tipo_demanda = '"&ors("tipo_demanda")&"' and (dt_ini_atdmt between '"&data_inicial&"' and '"&data_final&"') "
			Set oRs2 = Server.CreateObject("ADODB.Recordset")
			oRs2.Open queryTotalDemanda, dados_sys
			totalDemanda = int(oRs2("total_demanda"))
			qtdNoPrazo = int(ors("quantidade"))
			porcentagemNoPrazo = FormatPercent(qtdNoPrazo/totalDemanda, 1)
			qtdEmAtraso = totalDemanda - qtdNoPrazo
			porcentagemEmAtraso = FormatPercent(qtdEmAtraso/totalDemanda, 1)
			totalQtdPrazo = totalQtdPrazo + qtdNoPrazo		
	 		totalQtdAtraso = totalQtdAtraso + qtdEmAtraso	 		
			totalDemandasTotal = totalDemandasTotal + totalDemanda

			%>
			<tr>
            <td><%=ors("tipo_demanda")%></td>
            <td><%=qtdNoPrazo%></td>
            <td><%=porcentagemNoPrazo%></td>
            <td><%=qtdEmAtraso%></td>
            <td><%=porcentagemEmAtraso%></td>
            <td><%=totalDemanda%></td>
            </tr>
			<%
			oRs.movenext
		
		
		totalPorcentagemPrazo = (totalQtdPrazo/totalDemandasTotal)
		totalPorcentagemAtraso =(totalQtdAtraso/totalDemandasTotal)
		loop
		%>
			<tr>
            <td>Total</td>
            <td><%=totalQtdPrazo%></td>
            <td><%=FormatPercent(totalPorcentagemPrazo)%></td>
            <td><%=totalQtdAtraso%></td>
            <td><%=FormatPercent(totalPorcentagemAtraso)%></td>
            <td><%=totalDemandasTotal%></td>
            </tr>
			<%
		Set oRs = Nothing
	%>
    </table>
    <br />
	<%

	end if

end if

%>
