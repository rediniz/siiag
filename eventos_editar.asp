<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%	
	descricao 				= request("descricao")
	iniciativa 				= request("iniciativa")
	periodo_inicio			= request("periodo_inicio")
	periodo_fim 			= request("periodo_fim")
	local 					= request("local")
	situacao 				= request("situacao")	
	
	tipo 					= request("tipo_evento")
	horario_inicio 			= request("horario_inicio")
	horario_fim				= request("horario_fim")
	qtd_participantes 		= request("qtd_participantes")
	desc_participantes 		= request("desc_participantes")
	co_criador 				= session("v_Usuario_Matricula")
	co_unidade				= request.Cookies("co_usuario_unidade_siiag")
	observacoes 			= request("v_observacoes")
	data_criacao 			= day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	observacao_recurso 		= request("v_observacao_recurso")
	cod_evento = request("co_evento")

	dt_ini_atdmt = request("dt_ini_atdmt_v")
	dt_prev_conc = request("dt_prev_conc_v")
	observacaoEdicao = request("observacaoEdicao")

	if qtd_participantes <> "" then
		sql_evento = "UPDATE TB_EVENTOS SET CO_SITUACAO ="&situacao&", DE_EVENTO='"&descricao&"', CO_TIPO_EVENTO="&tipo&", DE_OBS='"&observacoes&"', DH_INICIO='"&periodo_inicio&"', DH_FIM='"&periodo_fim&"', DH_CRIACAO='"&data_criacao&"', CO_LOCAL="&local&", CO_UNIDADE="&co_unidade&", CO_GS_INICIATIVA="&iniciativa&", QT_PARTICIPANTES="&qtd_participantes&", DT_INICIO_INSC='"&data_criacao&"',DT_FIM_INSC='"&data_criacao&"', DH_HORA_INICIO='"&horario_inicio&"',DH_HORA_FIM='"&horario_fim&"', DE_PARTICIPANTES='"&desc_participantes&"', CO_UNIDADE_FGTS="&co_unidade&", CO_EDITOR = '" & co_criador &  "', DT_EDICAO= '" & NOW() & "',DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"'"
	else

		sql_evento = "UPDATE TB_EVENTOS SET CO_SITUACAO ="&situacao&", DE_EVENTO='"&descricao&"', CO_TIPO_EVENTO="&tipo&", DE_OBS='"&observacoes&"', DH_INICIO='"&periodo_inicio&"', DH_FIM='"&periodo_fim&"', DH_CRIACAO='"&data_criacao&"', CO_LOCAL="&local&", CO_UNIDADE="&co_unidade&", CO_GS_INICIATIVA="&iniciativa&", DT_INICIO_INSC='"&data_criacao&"',DT_FIM_INSC='"&data_criacao&"', DH_HORA_INICIO='"&horario_inicio&"',DH_HORA_FIM='"&horario_fim&"', DE_PARTICIPANTES='"&desc_participantes&"', CO_UNIDADE_FGTS="&co_unidade&", CO_EDITOR = '" & co_criador &  "', DT_EDICAO= '" & NOW() & "', DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"'"

	end if
	
	select case situacao
	
		'Se a demanda estiver sendo finalizada
		case "2","6"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			sql_evento = sql_evento & ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_EVENTOS WHERE CO_EVENTO ="&request("co_evento")
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				sql_evento = sql_evento & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
		
		case "7"
		
			sql_evento = sql_evento & ", IC_CANCELAMENTO = 0"
	
	end select
	
	sql_evento = sql_evento & ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"' WHERE CO_EVENTO ="&request("co_evento")
	objConn.execute(sql_evento)
	
	  '==========================================================
	  '{RESPONSÁVEIS}
	  '==========================================================
	  For Each responsavel in request.form("v_responsavel")
		  valores = split(responsavel,":")
		  matricula = valores(0)
		  responsavel_emprestimo = matricula
		  nome = valores(1)
		 ' response.write "Matrícula:" &matricula & "<br>"
		 ' response.write "Nome:" &nome & "<br>"
		  sql_delete_responsavel = "DELETE FROM TB_EVENTO_ORGANIZADORES WHERE CO_EVENTO = "&request("co_evento")
		  objConn.execute(sql_delete_responsavel)
		  sql_responsavel = "INSERT INTO TB_EVENTO_ORGANIZADORES (CO_EVENTO, CO_MATRICULA) VALUES ("&cod_evento&", '"&matricula&"')"
		  objConn.execute(sql_responsavel)
	  next	  
	  '==========================================================
	  '{PÚBLICO}
	  '==========================================================
	  sql_delete = "DELETE FROM TB_EVENTO_PUBLICO WHERE CO_EVENTO = " & cod_evento
	  objConn.execute(sql_delete)
	  
	  For Each publico in request.form("v_publico")
		 ' response.write "Público:" & publico & "<br>"
		  
		  sql_publico = "INSERT INTO TB_EVENTO_PUBLICO (CO_EVENTO, CO_PUBLICO_ALVO) VALUES ("&cod_evento&", "&publico&")"
		  objConn.execute(sql_publico)
	  next
	  '==========================================================	  
	  '{SERVIÇOS}
	  '==========================================================
	  
	  sql_delete = "DELETE FROM TB_EVENTO_CONTRATACAO WHERE CO_EVENTO = " & cod_evento
	  objConn.execute(sql_delete)
	  
	  For Each servico in request.form("v_servico")
		  valores = split(servico,":")
		  tipo = valores(0)
		  observacao = valores(1)
		  	  
		 ' response.write "Tipo:" & tipo & "<br>"
		 ' response.write "Observação:" & observacao & "<br>"
		  
		  sql_servico = "INSERT INTO TB_EVENTO_CONTRATACAO (CO_EVENTO, CO_TIPO_CONTRATACAO, DE_OBS) VALUES ("&cod_evento&", "&tipo&", '"&observacao&"')"
		  'response.write sql_servico
		  objConn.execute(sql_servico)
	  next
	 '==========================================================  
	  '{RECURSOS}
	  '==========================================================
	  'Dados gerais do empréstimo
	  '----------------------------------------------------------
	  contador = 0
	   For Each recurso in request.form("v_recurso")
	   
	   contador = contador+1
	   next
	   
	   if contador <> 0 then
	   
		  data_hora_inicio = periodo_inicio & " " & horario_inicio
		  data_hora_fim = periodo_fim & " " & horario_fim
		  
		'  response.write request("co_evento")
		'  response.write request("situacao")
		  
		  query_local = "SELECT DE_LOCAL FROM TB_LOCAL WHERE CO_LOCAL = " & local & " and co_unidade = " & request.Cookies("co_usuario_unidade_siiag") 
		  de_local = objConn.execute(query_local)("DE_LOCAL")
		  
		  sql_emprestimo = "UPDATE TB_EMPRESTIMO SET CO_SITUACAO = "&request("situacao")&", DE_OBS = '"&observacao_recurso&"', DH_INICIO = '"&data_hora_inicio&"', DH_FIM = '"&data_hora_fim&"', DE_LOCAL = '"&de_local&"' where co_evento = "&request("co_evento")&""
		  
		  'sql_emprestimo = "INSERT INTO TB_EMPRESTIMO (CO_UNIDADE, CO_SITUACAO, DE_RESPONSAVEL, DE_OBS, DH_INICIO, DH_FIM, DH_CRIACAO, DE_LOCAL, CO_CRIADOR, CO_UNIDADE_FGTS, CO_TIPO_EMPRESTIMO, CO_EVENTO) VALUES ("&co_unidade&", "&co_situacao&", '"&responsavel_emprestimo&"', '"&observacao_recurso&"', '"&data_hora_inicio&"', '"&data_hora_fim&"', '"&data_criacao&"','"&local&"', '"&co_criador&"',"&co_unidade&",1, "&request("co_evento")&")"
		
		  objConn.execute(sql_emprestimo)
		  
		  sql_cod_emprestimo = "SELECT CO_EMPRESTIMO FROM TB_EMPRESTIMO where co_evento = "&request("co_evento")&""
		 
		  
		   set ds=Server.CreateObject("ADODB.RecordSet")
		    ds.Open sql_cod_emprestimo, dados_sys 
		  
		  if not ds.eof then
	
			  cod_emprestimo = ds("CO_EMPRESTIMO")	 
			   
			  '----------------------------------------------------------
			  'Dados de cada recurso
			  '----------------------------------------------------------
			  
			  sql_deleta_recurso = "DELETE FROM TB_EMPRESTIMO_RECURSO WHERE CO_EMPRESTIMO = " & cod_emprestimo
			  objConn.execute(sql_deleta_recurso)
			  
			For Each recurso in request.form("v_recurso")
			  valores = split(recurso,":")
			  cod_recurso = valores(0)
			  quantidade = valores(1)
					  
			'  response.write "Cod_Recurso:" & cod_recurso & "<br>"
			'  response.write "Quantidade:" & quantidade & "<br>"
			  
			  sql_recurso = "INSERT INTO TB_EMPRESTIMO_RECURSO (CO_EMPRESTIMO, CO_RECURSO, QT_RECURSO, CO_UNIDADE) VALUES ("&cod_emprestimo&", "&cod_recurso&", "&quantidade&", "&co_unidade&")"
			  objConn.execute(sql_recurso)
		  	next
		  
		  else
		 
		  ''''''''''''''''''''''''''''''''''''''''''''''
		  sql_emprestimo = "INSERT INTO TB_EMPRESTIMO (CO_UNIDADE, CO_SITUACAO, DE_RESPONSAVEL, DE_OBS, DH_INICIO, DH_FIM, DH_CRIACAO, DE_LOCAL, CO_CRIADOR, CO_UNIDADE_FGTS, CO_TIPO_EMPRESTIMO, CO_EVENTO) VALUES ("&co_unidade&", "&request("situacao")&", '"&responsavel_nome&"', '"&observacao_recurso&"', '"&data_hora_inicio&"', '"&data_hora_fim&"', '"&data_criacao&"','"&de_local&"', '"&co_criador&"',"&co_unidade&",1, "&cod_evento&")"
			
		      'response.write sql_emprestimo
			  objConn.execute(sql_emprestimo)
			  
			  sql_cod_emprestimo = "SELECT TOP 1 CO_EMPRESTIMO FROM TB_EMPRESTIMO ORDER BY CO_EMPRESTIMO DESC"
			  cod = objConn.execute(sql_cod_emprestimo)
			  cod_emprestimo = cod("CO_EMPRESTIMO")
		  '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
		  
		  For Each recurso in request.form("v_recurso")
			  valores = split(recurso,":")
			  cod_recurso = valores(0)
			  quantidade = valores(1)
					  
			'  response.write "Cod_Recurso:" & cod_recurso & "<br>"
			'  response.write "Quantidade:" & quantidade & "<br>"
			  
			  sql_recurso = "INSERT INTO TB_EMPRESTIMO_RECURSO (CO_EMPRESTIMO, CO_RECURSO, QT_RECURSO,  CO_UNIDADE) VALUES ("&cod_emprestimo&", "&cod_recurso&", "&quantidade&", "&co_unidade&")"
			  objConn.execute(sql_recurso)
		  next
		  
		   end if
	  
	  end if
	  '==========================================================  
	  '{MATERIAIS}
	  '==========================================================
	  'Dados gerais do pedido
	  '----------------------------------------------------------
	  
	    contador = 0
	   For Each recurso in request.form("v_material")
	   
	   contador = contador+1
	   next
	   
	   if contador <> 0 then
	  
	  
		  sql_cod_pedido = "SELECT CO_PEDIDO FROM TB_EVENTO_PEDIDOS WHERE CO_EVENTO = "&request("co_evento")
	'	response.Write(	sql_cod_pedido)
		  cod = objConn.execute(sql_cod_pedido)
		  cod_pedido = cod("CO_PEDIDO")
		  
		  query_co_gs = "SELECT CO_GS FROM VW_USUARIOS WHERE CO_MATRICULA = '" & responsavel_emprestimo & "'"
		  consulta_co_gs = objConn.execute(query_co_gs)
		  co_gs = consulta_co_gs("CO_GS")
		  
		  query_pedido = "UPDATE TB_ESTOQUE_PEDIDO SET CO_MATRICULA='" & responsavel_emprestimo & "', CO_GS="& co_gs &", DT_PEDIDO='" & data_criacao &"', CO_UNIDADE="& co_unidade&" WHERE CO_PEDIDO ="&cod_pedido
		  objConn.execute(query_pedido)
	
			
		  
		  '----------------------------------------------------------
		  'Dados de cada material
		  '----------------------------------------------------------
		  query_deleta_item_pedido = "DELETE FROM TB_ESTOQUE_ITEM_PEDIDO WHERE CO_PEDIDO = " & cod_pedido
			'response.Write(query_deleta_item_pedido)
		  objConn.execute(query_deleta_item_pedido)
		  
		  For Each material in request.form("v_material")
			  valores = split(material,":")
			  cod_material = valores(0)
			  quantidade = valores(1)
			  
			  
			 ' response.write "Cod_Material:" & cod_material & "<br>"
			 ' response.write "Quantidade:" & quantidade & "<br>"
			  
			  query_item_pedido = "INSERT INTO TB_ESTOQUE_ITEM_PEDIDO (CO_PEDIDO, CO_MATERIAL, QT_SOLICITADA) VALUES ("&cod_pedido&", "&cod_material&","&quantidade&")"
			  objConn.execute(query_item_pedido)
	
		  next
		  
	   
	  end if
	  '==========================================================  
	  '{ARQUIVOS}
	  '==========================================================
'	  For Each arquivo in request.form("v_arquivo")
'		  valores = split(arquivo,":")
'		  link = valores(0)
'		  nome = valores(1)
'		  
'		  response.write "Link:" & link & "<br>"
'		  response.write "Nome:" & nome & "<br>"
'		  
'		  sql_recursos = "INSERT INTO TB_EMPRESTIMO_RECURSO (CO_EMPRESTIMO, CO_RECURSO, QT_RECURSO) VALUES ("&cod_emprestimo&", "&cod&", "&qtd&")"
'		  objConn.execute(sql_recursos)
'	  next

	  set objConn = nothing
	  
	 		response.write ("<script language=""javascript""> alert('Evento editado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.location.assign('consultar_eventos_e_treinamentos.asp'); </script>")
	
%>