<!--Utilizado como INCLUDE para colocar campos de data de início e previsão de término em todas as demandas do SIIAG-->
<%
	'NOVA PAGINA 08/12/2015	
	'PARAR ALTERAR UM PRAZO, MUDAR O SEGUNDO VALOR PASSADO NA FUNÇÃO DATEADD()
	'EX: 1 = 24 HORAS, 2 = 48 HORAS
	
	set res = Server.CreateObject("ADODB.RecordSet")

	
	'OBSERVAÇÃO = VARIÁVEL "D" É A DATA DE SOLICITAÇÃO
	
	'AFASTAMENTO (TIPO 1)
	if(tipo_prazo_demanda = 1) then
	
	
		query_solicitacao = "SELECT DH_CRIACAO FROM TB_AFASTAMENTOS WHERE CO_AFASTAMENTO = " & request("co_afastamento")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = dateadd("d", 2, D)
	
	'DESTACAMENTO (TIPO 2)
	elseif (tipo_prazo_demanda = 2) then

		query_solicitacao = "SELECT DH_CRIACAO FROM TB_DESTACAMENTOS WHERE CO_DESTACAMENTO = " & request("co_destacamento")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = dateadd("d", 1, D)
	
	'FÉRIAS (TIPO 3)
	elseif (tipo_prazo_demanda = 3) then
		
		'(O PRAZO É CALCULADO NA PRÓPRIA PÁGINA A PARTIR DO 1º DIA DE GOZO INFORMADO)
		query_solicitacao = "SELECT DH_CRIACAO FROM TB_FERIAS WHERE CO_FERIAS = " & co_ferias
		res.Open query_solicitacao, dados_sys
		inicio = formatdatetime(res("DH_CRIACAO"), 2)
	
	'JORNADA (TIPO 4)
	elseif (tipo_prazo_demanda = 4) then

		query_solicitacao = "SELECT DH_CRIACAO FROM TB_JORNADA WHERE CO_JORNADA = " & CO_JORNADA
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo= dateadd("d", 1, D)
	
	'SUBSTITUICAO (TIPO 5)
	elseif (tipo_prazo_demanda = 5) then
	
		query_solicitacao = "SELECT DH_CRIACAO FROM TB_SUBSTITUICOES WHERE CO_SUBSTITUICAO = " & request("co_substituicao")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)

		inicio = D
		prazo = dateadd("d", 1, D)
	
	'EMPRÉSTIMO (TIPO 6)
	elseif (tipo_prazo_demanda = 6) then

		query_solicitacao = "SELECT DH_CRIACAO FROM TB_EMPRESTIMO WHERE CO_EMPRESTIMO = " & co_emprestimo 
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = dateadd("d", 1, D)
	
		'EVENTO (TIPO 7)
	elseif (tipo_prazo_demanda = 7) then
	
		query_solicitacao = "SELECT DH_CRIACAO FROM TB_EVENTOS WHERE CO_EVENTO = " & request("co_evento")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = dateadd("d", 1, D)
	
	
	'ESTOQUE (TIPO 8) CÓDIGO NÃO NECESSÁRIO
'	elseif (tipo_prazo_demanda = 8) then
'	
'		query_solicitacao = "SELECT DT_PEDIDO FROM TB_ESTOQUE_PEDIDO WHERE CO_PEDIDO = " & request("co_evento")
'		res.Open query_solicitacao, dados_sys
'		D = formatdatetime(res("DH_CRIACAO"), 2)
'		
'		inicio = D
'		prazo = dateadd("d", 1, D)
'	
'	end if
	
	'REPARO (TIPO 9)
	elseif (tipo_prazo_demanda = 9) then
	
		query_solicitacao = "SELECT DH_CRIACAO FROM TB_REPAROS WHERE CO_REPARO = " & request("co_reparo")
		res.Open query_solicitacao, dados_sys
		D = formatdatetime(res("DH_CRIACAO"), 2)
		
		inicio = D
		prazo = dateadd("d", 1, D)
	
	end if

	set res = nothing
%>



<tr>
  <td align="left"><label>Início do atendimento:</label></td>
  <td align="left"><input  type="text" size="10" maxlength="10"  id="dt_ini_atdmt" name="dt_ini_atdmt" class="datepicker" value="<%=inicio%>"/></td>
</tr>
<tr>
  <td align="left"><label>Previsão de conclusão:</label></td>
  <td align="left"><input type="text" size="10" maxlength="10"  id="dt_prev_conc" name="dt_prev_conc" class="datepicker" readonly="true" value="<%=prazo%>" /></td>
</tr>


