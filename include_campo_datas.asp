<!--Utilizado como INCLUDE para colocar campos de data de início e previsão de término em todas as demandas do SIIAG-->
<%
		
	'PARAR ALTERAR UM PRAZO, MUDAR O SEGUNDO VALOR PASSADO NA FUNÇÃO DATEADD()
	'EX: 1 = 24 HORAS, 2 = 48 HORAS
	
	set res = Server.CreateObject("ADODB.RecordSet")

	
	'OBSERVAÇÃO = VARIÁVEL "D" É A DATA DE SOLICITAÇÃO
	
	'AFASTAMENTO (TIPO 1)
	if(tipo_prazo_demanda = 1) then
	
		'#Alterado em 21/03/2016 ------------------------------------------------------------------------
		query_solicitacao = "SELECT DH_CRIACAO, DT_INICIO, CO_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS WHERE CO_AFASTAMENTO = " & request("co_afastamento")
		res.Open query_solicitacao, dados_sys
		
		solicitacao = cdate(formatdatetime(res("DH_CRIACAO"), 2))
		gozo = cdate(formatdatetime(res("DT_INICIO"),2))

		select case res("CO_TIPO_AFASTAMENTO")
		
			'APIP
			case 1
					mesSolicitacao = month(solicitacao)
					mesGozo =  month(gozo)
			'Caso 1 - Contar data da solicitação: M-1, M e M+1
				if (mesSolicitacao = mesGozo-1) or (mesSolicitacao = mesGozo) or (mesSolicitacao = mesGozo+1) then
					inicio = solicitacao
					prazo = adicionaDiasUteis(inicio, 2) 
			'Caso 2 - Contar 1º dia útil de M-1 para início do prazo, quando solicitação for m+2 em diante 
				elseif (mesGozo >= mesSolicitacao + 2) then
					inicio = primeiroDiaUtilMes(dateadd("m", -1, gozo))
					prazo = adicionaDiasUteis(inicio, 2) 
				end if
							
			'TRE  ENTENDIMENTO FECHADO EM 18/03/2016 TATIANA E RÚBIA
			case 13
				'Se a data da solicitação for anterior a gozo-30
				if solicitacao < cdate(dateadd("d", -30, gozo)) then
					inicio = cdate(dateadd("d", -30, gozo))'subtraiDiasUteis(gozo, 30) 'se for corrido >>> cdate(dateadd("d", -30, gozo))
					prazo = adicionaDiasUteis(inicio, 2)	
				'Se a data da solicitação for entre gozo-30 e gozo-2:
				else
					inicio = solicitacao
					prazo = adicionaDiasUteis(inicio, 2)					
				end if
			'Qualquer outro tipo
			case else
				inicio = solicitacao
				prazo = adicionaDiasUteis(inicio, 2)	
			
		end select
		'-----------------------------------------------------------------------------------------------------
	
	'DESTACAMENTO (TIPO 2)ENTENDIMENTO FECHADO EM 18/03/2016 TATIANA E RÚBIA
	elseif (tipo_prazo_demanda = 2) then
		'#Alterado em 21/03/2016 -----------------------------------------------------------------------------
		query_solicitacao = "SELECT DH_CRIACAO, DT_INICIO FROM TB_DESTACAMENTOS WHERE CO_DESTACAMENTO = " & request("co_destacamento")
		res.Open query_solicitacao, dados_sys
		
		solicitacao = cdate(formatdatetime(res("DH_CRIACAO"), 2))
		gozo = cdate(formatdatetime(res("DT_INICIO"),2))	
		'inicio = subtraiDiasUteis(gozo,9)
		'prazo = adicionaDiasUteis(inicio, 2)	
		
		'if solicitacao > inicio then
			inicio = solicitacao
			prazo = adicionaDiasUteis(inicio, 2)	
		'end if
		'-----------------------------------------------------------------------------------------------------
		
	
	'FÉRIAS (TIPO 3)
	elseif (tipo_prazo_demanda = 3) then

		query_solicitacao = "SELECT DH_CRIACAO, DT_INICIO FROM TB_FERIAS WHERE CO_FERIAS = " & co_ferias
		res.Open query_solicitacao, dados_sys

		'#Alterado em 21/03/2016-------------------------------------------
		gozo = cdate(formatdatetime(res("DT_INICIO"), 2))
		inicio = cdate(formatdatetime(res("DH_CRIACAO"), 2))

		diferenca = datediff("d", inicio, gozo) 'contaDiasUteis(inicio, gozo)
		
		if(diferenca > 32) then
			inicio = cdate(dateadd("d", -32, gozo))' subtraiDiasUteis(gozo, 32)
		end if
		
		prazo = adicionaDiasUteis(inicio, 2)
		
		'------------------------------------------------------------------
	
	'JORNADA (TIPO 4) ENTENDIMENTO FECHADO EM 18/03/2016 TATIANA E RÚBIA
	elseif (tipo_prazo_demanda = 4) then

		query_solicitacao = "SELECT DH_CRIACAO FROM TB_JORNADA WHERE CO_JORNADA = " & CO_JORNADA
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo= adicionaDiasUteis(inicio, 2) 'dateadd("d", 2, D)
	
	''SUBSTITUICAO (TIPO 5)
'	elseif (tipo_prazo_demanda = 5) then
'	
'		query_solicitacao = "SELECT DH_CRIACAO FROM TB_SUBSTITUICOES WHERE CO_SUBSTITUICAO = " & request("co_substituicao")
'		res.Open query_solicitacao, dados_sys
'		D = formatdatetime(res("DH_CRIACAO"), 2)
'
'		inicio = D
'		prazo = dateadd("d", 1, D)
	
	'EMPRÉSTIMO (TIPO 6)  ENTENDIMENTO FECHADO EM 18/03/2016 TATIANA 
	elseif (tipo_prazo_demanda = 6) then

		query_solicitacao = "SELECT DH_CRIACAO FROM TB_EMPRESTIMO WHERE CO_EMPRESTIMO = " & co_emprestimo 
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = adicionaDiasUteis(inicio, 2)'dateadd("d", 1, D)
	
		'EVENTO (TIPO 7) ENTENDIMENTO FECHADO EM 18/03/2016 TATIANA E CRIS
	elseif (tipo_prazo_demanda = 7) then
	
		query_solicitacao = "SELECT DH_CRIACAO FROM TB_EVENTOS WHERE CO_EVENTO = " & request("co_evento")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = adicionaDiasUteis(inicio, 2)'dateadd("d", 1, D)
	
	
	'ESTOQUE (TIPO 8) ENTENDIMENTO FECHADO EM 18/03/2016 TATIANA E CRIS
	elseif (tipo_prazo_demanda = 8) then
	
		query_solicitacao = "SELECT DT_PEDIDO FROM TB_ESTOQUE_PEDIDO WHERE CO_PEDIDO = " & request("co_evento")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = adicionaDiasUteis(inicio, 2)'dateadd("d", 1, D)
	
	'REPARO (TIPO 9) ENTENDIMENTO FECHADO EM 18/03/2016 TATIANA
	elseif (tipo_prazo_demanda = 9) then
	
		query_solicitacao = "SELECT DH_CRIACAO FROM TB_REPAROS WHERE CO_REPARO = " & request("co_reparo")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = adicionaDiasUteis(inicio, 1)'dateadd("d", 1, D)
	
	end if
	
	'res.close
	set res = nothing
	
	'#Alterado em 21/03/2016 ---------------------------------------------	
	Function primeiroDiaUtilMes(data)
		
		d = CDATE(month(data)&"/"&year(data))
		
		do while Weekday(d) = 1 or Weekday(d) = 7
			d = DateAdd("d", 1, d)
		loop
		
		primeiroDiaUtilMes = d
		
	End Function
	
	Function primeiroDiaUtilMesAnterior(data)
		
		data = dateadd("m", -1, data)
		d = CDATE(month(data)&"/"&year(data))
		
		do while Weekday(d) = 1 or Weekday(d) = 7
			d = DateAdd("d", 1, d)
		loop
		
		primeiroDiaUtilMesAnterior = d
		
	End Function
	
	Function primeiroDiaUtilMesSeguinte(data)
		
		data = dateadd("m", +1, data)
		d = CDATE(month(data)&"/"&year(data))
		
		do while Weekday(d) = 1 or Weekday(d) = 7
			d = DateAdd("d", 1, d)
		loop
		
		primeiroDiaUtilMesSeguinte = d
		
	End Function
	'---------------------------------------------------------------------
	
	'#Alterado em 16/03/2016 ---------------------------------------------
	Function adicionaDiasUteis(data, dias)
		d = data
		do While dias > 0
			If Weekday(d) > 1 And Weekday(d) < 7 Then
				dias = dias - 1
			End If
			d = DateAdd("d", 1, d)
		loop
		
		do while Weekday(d) = 1 or Weekday(d) = 7
			d = DateAdd("d", 1, d)
		loop
		
		adicionaDiasUteis = d
	End Function
	
	Function subtraiDiasUteis(data, dias)
		d = data
		do While dias > 0
			If Weekday(d) > 1 And Weekday(d) < 7 Then
				dias = dias - 1
			End If
			d = DateAdd("d", -1, d)
		loop
		
		do while Weekday(d) = 1 or Weekday(d) = 7
			d = DateAdd("d", -1, d)
		loop

		subtraiDiasUteis = d
		
	End Function
	
	Function contaDiasUteis(data1, data2)
		d1 = data1
		d2 = data2
		diasUteis = 0
		
		do while(cdate(d1) <> cdate(d2))
			If Weekday(d1) > 1 And Weekday(d1) < 7 Then
				diasUteis = diasUteis + 1
			End If
			d1 = DateAdd("d", 1, d1)
		loop
		
		contaDiasUteis = diasUteis
		
	End Function
	'----------------------------------------------
%>



<tr>
  <td align="left"><label>Previsão de início:</label></td>
  <td align="left"><input  type="text" size="10" maxlength="10"  id="dt_ini_atdmt" name="dt_ini_atdmt" class="datepicker" value="<%=inicio%>"/></td>
</tr>
<tr>
  <td align="left"><label>Previsão de conclusão:</label></td>
  <td align="left"><input type="text" size="10" maxlength="10"  id="dt_prev_conc" name="dt_prev_conc" class="datepicker" readonly="true" value="<%=prazo%>" /></td>
</tr>


