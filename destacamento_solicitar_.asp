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
	
	'response.write "INFORMAÇÕES GERAIS:"							& "<br>"
	'response.write "<br>"
	'response.write "Usuário: " 				& usuario 				& "<br>"
	'response.write "Nome: "    				& nome 					& "<br>"
	'response.write "Período Inicio: " 		& periodo_inicio 		& "<br>"
	'response.write "Período Fim: " 			& periodo_fim 			& "<br>"
	'response.write "Projeto: " 				& projeto 				& "<br>"
	'response.write "Cidade: " 				& cidade 				& "<br>"
	'response.write "UF: " 					& uf 					& "<br>"
	'response.write "Diária: " 				& diaria 			    & "<br>"
	'response.write "Sugestão Hospedagem: " 	& sugestao_hospedagem   & "<br>"
	'response.write "Observações: " 			& observacoes 			& "<br>"
	'response.write "<br>"
	
	'INFORMAÇÕES DE CRIAÇÃO
	'---------------------------------------------------------
	data_criacao			= day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	co_criador				= session("v_Usuario_Matricula")
	co_unidade 				= request.Cookies("co_usuario_unidade_siiag")
	
	sql_co_gs = "SELECT CO_GS, IC_GERENTE FROM VW_USUARIOS WHERE CO_MATRICULA = '"&usuario&"'"
	resultado = objConn.execute(sql_co_gs)
	co_gs = resultado("CO_GS")
	
	e_gerente = resultado("IC_GERENTE")
	
	
	
	
	
	
	
	'INSERÇÃO DO DESTACAMENTO
	'---------------------------------------------------------
	sql_destacamento = "INSERT INTO TB_DESTACAMENTOS (CO_MATRICULA, CO_CRIADOR, DH_CRIACAO, NO_CIDADE, SG_UF, DE_PROJETO, CO_TIPO_DIARIA, CO_SITUACAO, DE_OBS, CO_GS, DE_SUGESTAO_HOSPEDAGEM, DT_INICIO, DT_FIM, CO_UNIDADE) VALUES "
	
	sql_destacamento = sql_destacamento & "('"&usuario&"','"&co_criador&"','"&data_criacao&"','"&cidade&"','"&uf&"', '"&projeto&"',"&diaria&",1,'"&observacoes&"',"&co_gs&",'"&sugestao_hospedagem&"','"&periodo_inicio&"','"&periodo_fim&"',"&co_unidade&")"
	
	objConn.execute(sql_destacamento)
	
	sql_cod_destacamento = "SELECT TOP 1 CO_DESTACAMENTO FROM TB_DESTACAMENTOS WHERE CO_UNIDADE="&co_unidade&" ORDER BY CO_DESTACAMENTO DESC"
	cod = objConn.execute(sql_cod_destacamento)
	cod_destacamento = cod("CO_DESTACAMENTO")
	
	'response.write cod_destacamento
		
	'SUGESTÕES DE TRANSPORTE
	'---------------------------------------------------------	
	qtd_sugestoes			= request("qtd_sugestoes")
	
	for i=1 to qtd_sugestoes
	
	'response.write "Sugestão "& i & "<br>"
	
		for each trecho in request.form("v_trecho"&i)
		
		'response.write "entrou"
		
			 valores 					= split(trecho,"::")
			 
			 trecho 					= valores(0)
			 tipo_transporte 			= valores(1)
			 cidade						= valores(2)
			 data						= valores(3)
			 hora						= valores(4)
			 cia_transporte				= valores(5)
			 n_voo 						= valores(6)
			 
			 hora = data & " " & hora
			 
			' response.write hora & "<br>"
			 			 
			 'response.write trecho & ":"  &tipo_transporte &":"&cidade&":"&data&":"&hora&":"&cia_transporte&":" & n_voo & "<br>"
			 
			 if(tipo_transporte = "1") then
			 'response.write "entrou no tipo de transporte 1"
			 
			 	sql_trecho = "INSERT INTO TB_TRECHOS (CO_DESTACAMENTO, CO_SUGESTAO, CO_TRECHO, CO_TIPO_TRANSPORTE, NO_CIDADE, DH_HORARIO, NO_CIA_TRANSPORTE, NU_VOO, CO_UNIDADE) VALUES ("&cod_destacamento&","&i&","&trecho&", "&tipo_transporte&",'"&cidade&"','"&hora&"','"&cia_transporte&"','"&n_voo&"',"&co_unidade&")"
				'response.write sql_trecho
			 end if
			 
			  if(tipo_transporte = "2" or tipo_transporte = "3" or tipo_transporte = "4" or tipo_transporte = "5") then
			  'response.write "entrou no tipo de transporte qualquer"
			 	sql_trecho = "INSERT INTO TB_TRECHOS (CO_DESTACAMENTO, CO_SUGESTAO, CO_TRECHO, CO_TIPO_TRANSPORTE, NO_CIDADE, DH_HORARIO,CO_UNIDADE) VALUES ("&cod_destacamento&","&i&","&trecho&", "&tipo_transporte&",'"&cidade&"','"&hora&"',"&co_unidade&")"				
				
			 end if		
			 
			 objConn.execute(sql_trecho)	 			
		next
				
	'response.write "<br>"
	
	next

	set objConn = nothing
	
		
	
	
	
	
	if e_gerente = True Then
		response.write "<script>"
		'response.Write "var top = (window.innerHeight / 4) +80;"
		'response.Write "var left = (window.innerWidth / 4) -60;"
		'window.open("solicitar_substituicao_pop.asp", "Solicitar Substituicao", "height=280, width=400, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes");
		response.write " subs = window.confirm('Deseja solicitar substituto para o coordenador?');"
		response.Write "if (subs == true){window.open('solicitar_substituicao_pop.asp?matricula="&request("usuario")&"&dataInicio="&periodo_inicio&"&dataFim="&periodo_fim&"', 'Substituto', 'height=400, width=600, toolbar=no, resizable=no');} else{window.location.assign('destacamento_consultar.asp');}" ' window.location.assign('destacamento_consultar.asp'); 
		response.write "</script>"
	
	else		'matricula='"&usuario&"'&dataInicio='"&periodo_inicio&"'&dataFim='"&periodo_fim&"'
		
	response.redirect "destacamento_consultar.asp"
	
	END IF
%>