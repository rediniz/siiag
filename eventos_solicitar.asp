 <%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
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
	
'====================================================================================================
'CHECA SE JÁ EXISTE UM EVENTO CADASTRADO NO MESMO HORÁRIO E LOCAL
	
'	sql_consulta = "SELECT * FROM TB_EVENTOS WHERE CO_LOCAL = "&local&" AND '"&periodo_inicio&"' BETWEEN DH_INICIO AND DH_FIM AND '"&horario_inicio&"' BETWEEN DH_HORA_INICIO AND DH_HORA_FIM AND CO_SITUACAO IN(1,2) AND CO_UNIDADE = "&co_unidade
'	
'	set ds=Server.CreateObject("ADODB.RecordSet")
'	ds.Open sql_consulta, dados_sys 
'	
'if(ds.eof) then
		
'===================================================================================================
		
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
				  lista_recursos = ""
				  
				  For Each recurso in request.form("v_recurso")
					  valores = split(recurso,":")
					  cod_recurso = valores(0)
					  quantidade = valores(1)
							  
					  query_nome_recurso = "SELECT DE_RECURSO FROM TB_TIPOS_RECURSOS WHERE CO_RECURSO = " & cod_recurso 
					  set rsNomeRecurso=Server.CreateObject("ADODB.RecordSet")
					  rsNomeRecurso.Open query_nome_recurso, dados_sys
					  de_recurso = rsNomeRecurso("DE_RECURSO")
					  lista_recursos = lista_recursos & quantidade & " " & de_recurso & ","
					  
					  sql_recurso = "INSERT INTO TB_EMPRESTIMO_RECURSO (CO_EMPRESTIMO, CO_RECURSO, QT_RECURSO, CO_UNIDADE,CO_STATUS) VALUES ("&cod_emprestimo&", "&cod_recurso&", "&quantidade&","&co_unidade&",0)"
	
					  objConn.execute(sql_recurso)
				  next
				  lista_recursos = left(lista_recursos, len(lista_recursos)-1)			
				  call Envia_Email_GIFUG(co_criador, data_criacao, lista_recursos)
				
			  end if
			  
			  sql_cod_emprestimo = "SELECT TOP 1 CO_EMPRESTIMO FROM TB_EMPRESTIMO ORDER BY CO_EMPRESTIMO DESC"
			  cod = objConn.execute(sql_cod_emprestimo)
			  cod_emprestimo = cod("CO_EMPRESTIMO")
				
			  set sql_emprestimo = nothing
			  set sql_cod_emprestimo = nothing
			  set sql_recursos = nothing
			  
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
		

			  
					response.write ("<script language=""javascript""> alert('Evento cadastrado com sucesso.'); </script>")
					response.write ("<script language=""javascript""> window.location.assign('eventos_e_treinamentos.asp'); </script>")
%>

<%

Sub Envia_Email_GIFUG (co_criador, data_criacao, lista_recursos)

	queryNomeCriador = "SELECT NO_NOME FROM TB_USUARIOS WHERE CO_MATRICULA = '"&co_criador&"'"
	responsavel = objConn.execute(queryNomeCriador)("no_nome")
	
	 vTexto = "<html><head><head>"
	 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
	 vTexto = vTexto & "<p><font  color=""#000080""  size =""2"" face=""Verdana"" ><b>"
	 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"
	 vTexto = vTexto & "Ao<br> Apoio <br><br>"
	 vTexto = vTexto & "1	Registramos que " & responsavel & " solicitou no dia " & data_criacao & " o(s) seguinte(s) recurso(s):<br><br>"
	 vTexto = vTexto & lista_recursos & "<br><br>"
	 vTexto = vTexto & "2	No ato da soliciação o usuário concordou com o termo de responsabilidade pelo uso do(s) recurso(s) citado(s).<br><br>"
	 vTexto = vTexto & "<br>**** Encaminhada pelo SIIAG - Solicitação de Empréstimo *****"
	 vTexto = vTexto & "</body></html>"
	 
	 If Err.Number<>0 Then
	  Response.Write("Erro: " & Err.Description & "<BR>")
	  Response.end	
	 Else
	 
	  If Err.Number<>0 Then
	   Response.Write("Erro: " & Err.Description & "<BR>")
	   Response.end
	  Else
	   vDe =  "gifugfo@mail.caixa"
	   vPara = "gifugfo01@mail.caixa;"
	   vCC = co_criador & "@mail.caixa;"
	   vCCO = "C097105@mail.caixa;C054423@mail.caixa;"
	   vAssunto = "SIIAG WEB - Solicitação de Empréstimo "
	   vUsuario = co_criador
	   
			email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)

  	   End If
 	End If
End Sub	

%>