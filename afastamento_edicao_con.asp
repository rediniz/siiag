<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
 				
data_inicio = Request("data_inicio")
data_fim = Request("data_fim")
nome = Request("nome")
matricula = Request("matricula")
tipo_afastamento = Request("tipo_afastamento")
co_afastamento = Request("co_afastamento")
situacao = Request("situacao")

'#ALTERADO em 23/03/2016 (adicionado)=============#
	dt_ini_atdmt = Request("dt_ini_atdmt")
	dt_prev_conc = Request("dt_prev_conc")
	'==================================================
		
'#ALTERADO EM 11/04/2016
observacaoEdicao = request("observacaoEdicao")

set rs=Server.CreateObject("ADODB.RecordSet")
query = "SELECT USUARIO.CO_MATRICULA, USUARIO.CO_DIGITO, USUARIO.NO_NOME,  AFASTAMENTO.CO_TIPO_AFASTAMENTO, AFASTAMENTO.DT_INICIO, AFASTAMENTO.DT_FIM, AFASTAMENTO.CO_SITUACAO FROM TB_AFASTAMENTOS AS AFASTAMENTO JOIN VW_USUARIOS AS USUARIO ON USUARIO.CO_MATRICULA = AFASTAMENTO.CO_MATRICULA INNER JOIN TB_SITUACOES SIT ON AFASTAMENTO.CO_SITUACAO = SIT.CO_SITUACAO WHERE CO_AFASTAMENTO="& co_afastamento
rs.Open query, dados_sys, 3, ,32
if not rs.eof then
	dt_inicio_atual 					= rs("DT_INICIO")
	dt_fim_atual 						= rs("DT_FIM")
	co_situacao_atual					= rs("CO_SITUACAO")
end if
rs.close

' TRE E SITUACAO CONFIRMADA
if (tipo_afastamento = "37" or tipo_afastamento = "13") and situacao = "2" and co_situacao_atual <> "2" then
	qt_solicitada = datediff("d",data_inicio,data_fim) + 1

	' Insere as informações no banco
	sql3 = "INSERT INTO TB_TRE_HISTORICO (CO_MATRICULA, CO_USUARIO_OPERACAO, DT_OPERACAO, TP_OPERACAO,QT_MODIFICADA, SALDO_ANTERIOR, SALDO_ESTOQUE, CO_AFASTAMENTO) VALUES ('"&	matricula&"','" & request.Cookies("co_usuario_siiag") & "','" &now()& "',2," & qt_solicitada & ",0,0," & co_afastamento & ")"
	response.write sql3
	Set query3 = objConn.execute(sql3)
	sql = "EXECUTE sp_atualiza_saldo_TRE '" & matricula & "'" 
	objConn.execute(sql)
end if

' TRE E SITUACAO CANCELADA
if (tipo_afastamento = "37" or tipo_afastamento = "13") and situacao = "7" and co_situacao_atual <> "7" then
	qt_solicitada = datediff("d",data_inicio,data_fim) + 1
	sql3 = "SELECT * FROM TB_TRE_HISTORICO WHERE CO_AFASTAMENTO = " & co_afastamento & ""
	rs.Open sql3, dados_sys, 3, ,32
	if not rs.eof then
		' Insere as informações no banco
		sql3 = "UPDATE A SET EXCLUIDO_DT = '" & now() & "', EXCLUIDO = 1 FROM TB_TRE_HISTORICO A WHERE SEQUENCIAL = " & rs("SEQUENCIAL") & ""
		response.write sql3
		objConn.execute(sql3)
		sql = "EXECUTE sp_atualiza_saldo_TRE '" & matricula & "'" 
		objConn.execute(sql)

	end if
end if

	query = "UPDATE TB_AFASTAMENTOS SET CO_TIPO_AFASTAMENTO='"&tipo_afastamento&"', DT_INICIO='"&data_inicio&"', DT_FIM='"&data_fim&"', CO_SITUACAO="&situacao&", DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"'"

	select case situacao
	
		'Se a demanda estiver sendo finalizada
		case "2", "6"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			query =  query & ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_AFASTAMENTOS WHERE WHERE CO_AFASTAMENTO="&co_afastamento&""
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				query = query & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
			
		case "7"
		
			query = query & ", IC_CANCELAMENTO = 0"
	
	end select
	
  query = query & ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"' WHERE CO_AFASTAMENTO="&co_afastamento&""
  objConn.execute(query)
	
	'=============================================================================================
	
set query = nothing
objConn.close

%>
