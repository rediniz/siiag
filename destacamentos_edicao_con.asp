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
	sugestao_aceita 		= request("sugestao_aceita")

	dt_ini_atdmt = Request("dt_ini_atdmt")
	dt_prev_conc = Request("dt_prev_conc")
	observacaoEdicao = request("observacaoEdicao")
	
	response.write "situação: " & situacao
		
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
	sql_destacamento = "UPDATE TB_DESTACAMENTOS SET NO_CIDADE='"&cidade&"', SG_UF='"&uf&"', DE_PROJETO='"&projeto&"', CO_TIPO_DIARIA="&diaria&", CO_SITUACAO="&situacao&", DE_OBS='"&observacoes&"', DE_SUGESTAO_HOSPEDAGEM='"&sugestao_hospedagem&"', DT_INICIO='"&periodo_inicio&"', DT_FIM='"&periodo_fim&"', DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"', CO_SUGESTAO = " & sugestao_aceita & ""

	
	'Atualiza as datas da demanda de acordo com o código da situação =============================
	select case situacao
	
		'Se a demanda estiver sendo finalizada
		case "2","6"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			sql_destacamento = sql_destacamento & ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_DESTACAMENTOS WHERE CO_DESTACAMENTO="&co_destacamento
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				sql_destacamento = sql_destacamento & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
			
		case "7"
		
			sql_destacamento = sql_destacamento & ", IC_CANCELAMENTO = 0"
	
	end select
	
	sql_destacamento = sql_destacamento &  ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"'  WHERE CO_DESTACAMENTO="&co_destacamento
	response.write sql_destacamento
	objConn.execute(sql_destacamento)
	
	sql_delecao_trecho = "DELETE FROM TB_TRECHOS WHERE CO_DESTACAMENTO="&co_destacamento&" and co_unidade = "&co_unidade
	
	objConn.execute(sql_delecao_trecho)
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