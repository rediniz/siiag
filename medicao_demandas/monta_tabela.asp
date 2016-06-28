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


	Set oRs2 = Server.CreateObject("ADODB.Recordset")

	'#Alterado em 05/12/2015 (consultas melhoradas para o caso de demandas pendentes)
	'Data de conclusão estava dentro do prazo
		where1 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0)) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) >= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) and DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_prev_conc), 0))"
		where2 = "(DateAdd(Day, DateDiff(Day, 0, dt_conclusao), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) or (DateAdd(Day, DateDiff(Day, 0, dt_pendente), 0) <= DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0)))"

	'Data de conclusão ultrapassou o prazo, porém a data de pendência estava no prazo
	'where2 = "(dt_conclusao > dt_prev_conc) and (dt_pendente between dt_ini_atdmt and dt_prev_conc)"
	'Demanda ainda não foi concluída, porém a data de pendência está dentro do prazo
	'where3 = "(dt_conclusao is null) and (dt_pendente between dt_ini_atdmt and dt_prev_conc)"
	
	strQueryMatriculas = "select mt_conclusao, count(mt_conclusao) as qtd from vw_demanda_operacional where (DateAdd(Day, DateDiff(Day, 0, dt_ini_atdmt), 0) between '"&data_inicial&"' and '"&data_final&"') and (("&where1&") or("&where2&")) group by mt_conclusao"
				
	oRs2.Open strQueryMatriculas, dados_sys
	
	if not oRs2.eof then
	
	%>
    <div align="center">
    <label>Quantidade de demandas atendidas no prazo por matrícula:</label>
    </div>
    <br />
    
	<div class='tabela' style="width:60%"  align="center">
		<table>
    
    		<tr><td>Matrícula</td><td>Total de demandas</td><td>Atendidas no prazo</td><td>% atendidas no prazo</td></tr>
			<%
            do while not oRs2.eof
            queryTotalMatricula = "select count(*) as total from vw_demanda_operacional where (dt_ini_atdmt between '"&data_inicial&" 00:00:00' and '"&data_final&" 00:00:00') and mt_conclusao = '"&oRs2("mt_conclusao")&"'"
            totalDemandasMatricula = objConn.execute(queryTotalMatricula)("total")
            if oRs2("mt_conclusao") <> "" then
            %>
                        
                        <tr><td><%=oRs2("mt_conclusao")%></td><td><%=totalDemandasMatricula%></td><td><%=oRs2("qtd")%></td><td><%if totalDemandasMatricula = 0 then response.write "0%"else response.write FormatPercent(oRs2("qtd")/totalDemandasMatricula, 1) end if%></td></tr>
                        <%
            end if
            oRs2.movenext
            loop
            Set oRs2 = Nothing
            %>
       </table>
    </div>
        <%
	
	end if

end if

%>
