<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%	
	local = request("local")
	responsavel = request("responsavel")
	co_responsavel = request("co_responsavel")
	periodo_inicio = request("periodo_inicio")
	horario_inicio = request("horario_inicio")
	inicio = periodo_inicio & " " & horario_inicio
	periodo_fim = request("periodo_fim")
	horario_fim = request("horario_fim")
	fim = periodo_fim & " " & horario_fim
	observacoes = request("observacoes")
	co_criador = session("v_Usuario_Matricula")
	co_unidade = request.Cookies("co_usuario_unidade_siiag")
	co_tipo_emprestimo = 1
	co_situacao = request("situacao")
	data_criacao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	co_emprestimo = request("co_emprestimo")
	
	'#ALTERADO em 01/12/2015 (adicionado)===============
	dt_ini_atdmt = request("dt_ini_atdmt")
	dt_prev_conc = request("dt_prev_conc")
	'==================================================
	'#ALTERADO EM 11/04/2016
	observacaoEdicao = request("observacaoEdicao")
	
	'#ALTERADO EM 11/04/2016
	sql_emprestimo = "UPDATE  TB_EMPRESTIMO SET CO_UNIDADE="&co_unidade&", CO_SITUACAO="&co_situacao&", DE_RESPONSAVEL='"&responsavel&"', DE_OBS='"&observacoes&"', DH_INICIO='"&inicio&"', DH_FIM='"&fim&"', DH_CRIACAO='"&data_criacao&"', DE_LOCAL='"&local&"', CO_CRIADOR='"&co_criador&"', CO_UNIDADE_FGTS="&co_unidade&", CO_TIPO_EMPRESTIMO="&co_tipo_emprestimo&", CO_MATRICULA_RESPONSAVEL = '" & co_responsavel & "', DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"'"
	
	select case co_situacao
	
		'Se a demanda estiver sendo finalizada
		case "2","6"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			sql_emprestimo = sql_emprestimo & ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_EMPRESTIMO WHERE CO_EMPRESTIMO="&co_emprestimo&""
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				sql_emprestimo = sql_emprestimo & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
		
		case "7"
		
			sql_emprestimo = sql_emprestimo & ", IC_CANCELAMENTO = 0"
	
	end select
	
	 sql_emprestimo = sql_emprestimo & ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"' WHERE CO_EMPRESTIMO="&co_emprestimo&""
	 objConn.execute(sql_emprestimo)
	
	'CODIGO ANTIGO 22/02/2016
	'sql_emprestimo = "UPDATE  TB_EMPRESTIMO SET CO_UNIDADE="&co_unidade&", CO_SITUACAO="&co_situacao&", DE_RESPONSAVEL='"&responsavel&"', DE_OBS='"&observacoes&"', DH_INICIO='"&inicio&"', DH_FIM='"&fim&"', DH_CRIACAO='"&data_criacao&"', DE_LOCAL='"&local&"', CO_CRIADOR='"&co_criador&"', CO_UNIDADE_FGTS="&co_unidade&", CO_TIPO_EMPRESTIMO="&co_tipo_emprestimo&", CO_MATRICULA_RESPONSAVEL = '" & co_responsavel & "' WHERE CO_EMPRESTIMO="&co_emprestimo&""
'	
'	
'	response.write sql_emprestimo
'	objConn.execute(sql_emprestimo)
'	
'	'#ALTERADO em 01/12/2015 (adicionado as datas de demanda e checagem se foi finalizada)===========================
'	'INFORMAÇÕES DE ATENDIMENTO DA DEMANDA
'	sql_atendimento = "UPDATE TB_EMPRESTIMO SET DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"' WHERE CO_EMPRESTIMO="&co_emprestimo&""
'	
'	objConn.execute(sql_atendimento)
'	
'	'#Alterado em 07/12/2015 (inclusão da checagem de situação pendente)
'	'Atualiza as datas da demanda de acordo com o código da situação =============================
'		
'	tabela = "TB_EMPRESTIMO"
'	where = "CO_EMPRESTIMO="&co_emprestimo
'	
'	select case co_situacao
'	
'		'Se a demanda estiver sendo finalizada
'		case "2", "7"
'		
'			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
'			mt_conclusao = request.Cookies("co_usuario_siiag")
'			
'			query_dt_conclusao = "UPDATE "& tabela &" SET DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"' WHERE " & where
'			objConn.execute(query_dt_conclusao)
'	
'		case "3"
'		
'			dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
'			mt_conclusao = request.Cookies("co_usuario_siiag")
'			
'			query_dt_conclusao = "UPDATE "& tabela &" SET DT_PENDENTE = '"&dt_pendencia&"',  MT_CONCLUSAO = '"&mt_conclusao&"' WHERE " & where
'			objConn.execute(query_dt_conclusao)
'	
'	end select
	
	'=============================================================================================
	
	'sql_cod_emprestimo = "SELECT TOP 1 CO_EMPRESTIMO FROM TB_EMPRESTIMO ORDER BY CO_EMPRESTIMO DESC"
	'cod = objConn.execute(sql_cod_emprestimo)
	'cod_emprestimo = cod("CO_EMPRESTIMO")
	
	sql_apagar_recursos = "DELETE FROM TB_EMPRESTIMO_RECURSO WHERE CO_EMPRESTIMO ="&co_emprestimo
	
	objConn.execute(sql_apagar_recursos)
	
	For Each userVal in request.form("recurso_quantidade")

	  qtd = mid(userVal,  instr(userVal, ":")+1, len(userVal) )
	  cod = left(userVal, instr(userVal, ":")-1)
	  response.write "Quantidade:" &qtd & "<br>"
	  response.write "Código:" &cod & "<br>"
	  sql_recursos = "INSERT INTO TB_EMPRESTIMO_RECURSO (CO_EMPRESTIMO, CO_RECURSO, QT_RECURSO, CO_UNIDADE) VALUES ("&co_emprestimo&", "&cod&", "&qtd&",'" & co_unidade & "')"
	  objConn.execute(sql_recursos)
	  
	Next
	  
	  set sql_emprestimo = nothing
	  set sql_cod_emprestimo = nothing
	  set sql_recursos = nothing
	  set objConn = nothing
		
%>