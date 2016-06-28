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

	if qtd_participantes <> "" then
		sql_evento = "INSERT INTO TB_EVENTOS (CO_SITUACAO,DE_EVENTO,CO_TIPO_EVENTO, DE_OBS, DH_INICIO, DH_FIM, DH_CRIACAO, CO_LOCAL, CO_CRIADOR, CO_UNIDADE, CO_GS_INICIATIVA, QT_PARTICIPANTES, DT_INICIO_INSC, DT_FIM_INSC, DH_HORA_INICIO, DH_HORA_FIM, DE_PARTICIPANTES,CO_UNIDADE_FGTS) VALUES ("&situacao&",'"&descricao&"',"&tipo&",'"&observacoes&"','"&periodo_inicio&"', '"&periodo_fim&"','"&data_criacao&"',"&local&",'"&co_criador&"',"&co_unidade&","&iniciativa&","&qtd_participantes&",'"&data_criacao&"','"&data_criacao&"','"&horario_inicio&"', '"&horario_fim&"', '"&desc_participantes&"',"&co_unidade&")"
	else
		sql_evento = "INSERT INTO TB_EVENTOS (CO_SITUACAO,DE_EVENTO,CO_TIPO_EVENTO, DE_OBS, DH_INICIO, DH_FIM, DH_CRIACAO, CO_LOCAL, CO_CRIADOR, CO_UNIDADE, CO_GS_INICIATIVA, DT_INICIO_INSC, DT_FIM_INSC, DH_HORA_INICIO, DH_HORA_FIM, DE_PARTICIPANTES,CO_UNIDADE_FGTS) VALUES ("&situacao&",'"&descricao&"',"&tipo&",'"&observacoes&"','"&periodo_inicio&"', '"&periodo_fim&"','"&data_criacao&"',"&local&",'"&co_criador&"',"&co_unidade&","&iniciativa&",'"&data_criacao&"','"&data_criacao&"','"&horario_inicio&"', '"&horario_fim&"', '"&desc_participantes&"',"&co_unidade&")"

	end if
	objConn.execute(sql_evento)
	
	sql_cod_evento = "SELECT TOP 1 CO_EVENTO FROM TB_EVENTOS where co_unidade = " & request.Cookies("co_usuario_unidade_siiag") & " ORDER BY CO_EVENTO DESC"
	cod = objConn.execute(sql_cod_evento)
	cod_evento = cod("CO_EVENTO")
	
	sql_local = "SELECT DE_LOCAL FROM TB_LOCAL WHERE CO_LOCAL = "&local&" and co_unidade = "&co_unidade 
	de_local = objConn.execute(sql_local)("DE_LOCAL")
	
	  '==========================================================
	  '{RESPONSÁVEIS}
	  '==========================================================
	  For Each responsavel in request.form("v_responsavel")
		  valores = split(responsavel,":")
		  matricula = valores(0)
		  nome = valores(1)
		  responsavel_matricula = matricula
		  responsavel_nome = nome
		 ' response.write "Matrícula:" &matricula & "<br>"
		 ' response.write "Nome:" &nome & "<br>"
		  sql_responsavel = "INSERT INTO TB_EVENTO_ORGANIZADORES (CO_EVENTO, CO_MATRICULA) VALUES ("&cod_evento&", '"&matricula&"')"
		  objConn.execute(sql_responsavel)
	  next	  
	  '==========================================================
	  '{PÚBLICO}
	  '==========================================================
	  
	  
	  
	  For Each publico in request.form("v_publico")
		 ' response.write "Público:" & publico & "<br>"
		  sql_publico = "INSERT INTO TB_EVENTO_PUBLICO (CO_EVENTO, CO_PUBLICO_ALVO) VALUES ("&cod_evento&", "&publico&")"
		  objConn.execute(sql_publico)
	  next
	  '==========================================================	  
	  '{SERVIÇOS}
	  '==========================================================
	  For Each servico in request.form("v_servico")
		  valores = split(servico,":")
		  tipo = valores(0)
		  observacao = valores(1)
		  	  
		'  response.write "Tipo:" & tipo & "<br>"
		'  response.write "Observação:" & observacao & "<br>"
		  
		  sql_servico = "INSERT INTO TB_EVENTO_CONTRATACAO (CO_EVENTO, CO_TIPO_CONTRATACAO, DE_OBS) VALUES ("&cod_evento&", "&tipo&", '"&observacao&"')"
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
	  co_situacao = 1
	  data_hora_inicio = periodo_inicio & " " & horario_inicio
	  data_hora_fim = periodo_fim & " " & horario_fim
	  
	  sql_emprestimo = "INSERT INTO TB_EMPRESTIMO (CO_UNIDADE, CO_SITUACAO, DE_RESPONSAVEL, DE_OBS, DH_INICIO, DH_FIM, DH_CRIACAO, DE_LOCAL, CO_CRIADOR, CO_UNIDADE_FGTS, CO_TIPO_EMPRESTIMO, CO_EVENTO) VALUES ("&co_unidade&", "&co_situacao&", '"&responsavel_nome&"', '"&observacao_recurso&"', '"&data_hora_inicio&"', '"&data_hora_fim&"', '"&data_criacao&"','"&de_local&"', '"&co_criador&"',"&co_unidade&",1, "&cod_evento&")"
	
	  objConn.execute(sql_emprestimo)
	  
	  sql_cod_emprestimo = "SELECT TOP 1 CO_EMPRESTIMO FROM TB_EMPRESTIMO ORDER BY CO_EMPRESTIMO DESC"
	  cod = objConn.execute(sql_cod_emprestimo)
	  cod_emprestimo = cod("CO_EMPRESTIMO")
	  
	   
	  '----------------------------------------------------------
	  'Dados de cada recurso
	  '----------------------------------------------------------
	  For Each recurso in request.form("v_recurso")
		  valores = split(recurso,":")
		  cod_recurso = valores(0)
		  quantidade = valores(1)
		  		  
		'  response.write "Cod_Recurso:" & cod_recurso & "<br>"
		'  response.write "Quantidade:" & quantidade & "<br>"
		  
		  sql_recurso = "INSERT INTO TB_EMPRESTIMO_RECURSO (CO_EMPRESTIMO, CO_RECURSO, QT_RECURSO, CO_UNIDADE) VALUES ("&cod_emprestimo&", "&cod_recurso&", "&quantidade&", "&co_unidade&")"
	 	  objConn.execute(sql_recurso)
	  next
	  end if
	  '==========================================================  
	  '{MATERIAIS}
	  '==========================================================
	  'Dados gerais do pedido
	  '----------------------------------------------------------
	  contador = 0
	  For Each material in request.form("v_material")
		  contador = contador+1
		  
	  next
	   
	  if contador <> 0 then
	  query_co_gs = "SELECT CO_GS FROM VW_USUARIOS WHERE CO_MATRICULA = '" & responsavel_matricula & "'"
  	  consulta_co_gs = objConn.execute(query_co_gs)
      co_gs = consulta_co_gs("CO_GS")
	  
	  query_pedido = "INSERT INTO TB_ESTOQUE_PEDIDO (CO_MATRICULA, CO_GS, DT_PEDIDO, CO_UNIDADE) VALUES ('" & responsavel_matricula & "', "& co_gs &", '" & data_criacao &"', "& co_unidade &")"

	  objConn.execute(query_pedido)

	  sql_cod_pedido = "SELECT TOP 1 CO_PEDIDO FROM TB_ESTOQUE_PEDIDO ORDER BY CO_PEDIDO DESC"
	  cod = objConn.execute(sql_cod_pedido)
	  cod_pedido = cod("CO_PEDIDO")
	  
	  query_evento_pedido = "INSERT INTO TB_EVENTO_PEDIDOS (CO_PEDIDO, CO_EVENTO) VALUES ("&cod_pedido&", "&cod_evento&")"
	  objConn.execute(query_evento_pedido)
	  
	  '----------------------------------------------------------
	  'Dados de cada material
	  '----------------------------------------------------------
	  For Each material in request.form("v_material")
		  valores = split(material,":")
		  cod_material = valores(0)
		  quantidade = valores(1)
		  
		'  response.write "Cod_Material:" & cod_material & "<br>"
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
	  
	 	    response.write ("<script language=""javascript""> alert('Evento cadastrado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.location.assign('eventos_e_treinamentos.asp'); </script>")
		
	
%>