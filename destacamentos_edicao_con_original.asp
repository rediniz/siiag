<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%	
	'INFORMAÇÕES GERAIS
	'-------------------------------------------------------
	usuario 				= request("usuario")
	nome					= request("nome")
	periodo_inicio			= request("periodo_inicio")
	periodo_fim 			= request("periodo_fim")
	projeto					= request("projeto")
	cidade					= request("cidade")	
	uf						= request("uf")
	diaria		 			= request("diaria")
	sugestao_hospedagem		= request("sugestao_hospedagem")
	observacoes		 		= request("observacoes")
	situacao				= request("v_situacao")	
	co_destacamento			= request("co_destacamento")
	
	'#ALTERADO em 30/11/2015 (adicionado)=============#
	dt_ini_atdmt = Request("dt_ini_atdmt")
	dt_prev_conc = Request("dt_prev_conc")
	'==================================================
	
	'response.write "situação:"&situacao
	
'	response.write "INFORMAÇÕES GERAIS:"							& "<br>"
'	response.write "<br>"
'	response.write "Usuário: " 				& usuario 				& "<br>"
'	response.write "Nome: "    				& nome 					& "<br>"
'	response.write "Período Inicio: " 		& periodo_inicio 		& "<br>"
'	response.write "Período Fim: " 			& periodo_fim 			& "<br>"
'	response.write "Projeto: " 				& projeto 				& "<br>"
'	response.write "Cidade: " 				& cidade 				& "<br>"
'	response.write "UF: " 					& uf 					& "<br>"
'	response.write "Diária: " 				& diaria 			    & "<br>"
'	response.write "Sugestão Hospedagem: " 	& sugestao_hospedagem   & "<br>"
'	response.write "Observações: " 			& observacoes 			& "<br>"
'	response.write "<br>"
	
	'INFORMAÇÕES DE CRIAÇÃO
	'---------------------------------------------------------
	data_criacao			= day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	co_criador				= session("v_Usuario_Matricula")
	co_unidade 				= request.Cookies("co_usuario_unidade_siiag")
	sql_co_gs = "SELECT CO_GS FROM VW_USUARIOS WHERE CO_MATRICULA = '"&usuario&"'"
	resultado = objConn.execute(sql_co_gs)
	co_gs = resultado("CO_GS")
	
	'INSERÇÃO DO DESTACAMENTO
	'---------------------------------------------------------
	sql_destacamento = "UPDATE TB_DESTACAMENTOS SET NO_CIDADE='"&cidade&"', SG_UF='"&uf&"', DE_PROJETO='"&projeto&"', CO_TIPO_DIARIA="&diaria&", CO_SITUACAO="&situacao&", DE_OBS='"&observacoes&"', DE_SUGESTAO_HOSPEDAGEM='"&sugestao_hospedagem&"', DT_INICIO='"&periodo_inicio&"', DT_FIM='"&periodo_fim&"' WHERE CO_DESTACAMENTO="&co_destacamento
	
	'response.write sql_destacamento
	objConn.execute(sql_destacamento)
	
	sql_delecao_trecho = "DELETE FROM TB_TRECHOS WHERE CO_DESTACAMENTO="&co_destacamento&" and co_unidade = "&co_unidade
	
	objConn.execute(sql_delecao_trecho)
	
	
	'#ALTERADO em 30/11/2015 (adicionado)===================#
	'INFORMAÇÕES DE ATENDIMENTO DA DEMANDA
	sql_atendimento = "UPDATE TB_DESTACAMENTOS SET DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"' WHERE CO_DESTACAMENTO="&co_destacamento&""
	
	objConn.execute(sql_atendimento)
	
	'#Alterado em 08/12/2015 (inclusão da checagem de situação pendente)
	'Atualiza as datas da demanda de acordo com o código da situação =============================
		
	tabela = "tb_destacamentos"
	where = "co_destacamento = " & co_destacamento
	
	select case situacao
	
		'Se a demanda estiver sendo finalizada
		case "2", "7"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			query_dt_conclusao = "UPDATE "& tabela &" SET DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"' WHERE " & where
			objConn.execute(query_dt_conclusao)
	
		case "3"
		
			dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			query_dt_conclusao = "UPDATE "& tabela &" SET DT_PENDENTE = '"&dt_pendencia&"',  MT_CONCLUSAO = '"&mt_conclusao&"' WHERE " & where
			objConn.execute(query_dt_conclusao)
	
	end select
	
	'=============================================================================================
		
	'SUGESTÕES DE TRANSPORTE
	'---------------------------------------------------------	
	qtd_sugestoes			= request("qtd_sugestoes")
	
	for i=1 to qtd_sugestoes
	
	'response.write "Sugestão "& i & "<br>"
	
	
		for each trecho in request.form("v_trecho"&i)
		
			 valores 					= split(trecho,"::")
			 
			 trecho 					= valores(0)
			 tipo_transporte 			= valores(1)
			 cidade						= valores(2)
			 data						= valores(3)
			 hora						= valores(4)
			 cia_transporte				= valores(5)
			 n_voo 						= valores(6)
			 
			 hora = data & " " & hora
			 			 
			 'response.write trecho & ":"  &tipo_transporte &":"&cidade&":"&data&":"&hora&":"&cia_transporte&":" & n_voo & "<br>"
			 
			 if(tipo_transporte = 1) then
			 	sql_trecho = "INSERT INTO TB_TRECHOS (CO_DESTACAMENTO, CO_SUGESTAO, CO_TRECHO, CO_TIPO_TRANSPORTE, NO_CIDADE, DH_HORARIO, NO_CIA_TRANSPORTE, NU_VOO, CO_UNIDADE) VALUES ("&co_destacamento&","&i&","&trecho&", "&tipo_transporte&",'"&cidade&"','"&hora&"','"&cia_transporte&"','"&n_voo&"',"&co_unidade&")"
					response.write sql_trecho
				objConn.execute(sql_trecho)
			 else
			 	sql_trecho = "INSERT INTO TB_TRECHOS (CO_DESTACAMENTO, CO_SUGESTAO, CO_TRECHO, CO_TIPO_TRANSPORTE, NO_CIDADE, DH_HORARIO, CO_UNIDADE) VALUES ("&co_destacamento&","&i&","&trecho&", "&tipo_transporte&",'"&cidade&"','"&hora&"',"&co_unidade&")"
			
				objConn.execute(sql_trecho)
			 end if			 			
		next
			
	'response.write "<br>"
	
	next
	
	set objConn = nothing
	
	response.write ("<script language=""javascript"">  window.history.go(-2); alert('Destacamento editado com sucesso.');</script>")

%>