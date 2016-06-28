<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%
  	data_entrega 	= 	day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
  	mat_entregador 	= 	request.Cookies("co_usuario_siiag")
  	cod_unidade 	= 	request.Cookies("co_usuario_unidade_siiag")
'ATENDER PEDIDO



if request("acao") = "atender" then
	pedido = split(request("pedido"), ":")
	
	co_pedido = pedido(0)
	co_material = pedido(1)
	qtd_liberar = cInt(pedido(2))
	
	query_disponivel = "SELECT QT_SOLICITADA, SEQUENCIAL FROM TB_ESTOQUE_ITEM_PEDIDO WHERE CO_PEDIDO = " & co_pedido & " and co_material = " & co_material & " "
	resultado = objConn.execute(query_disponivel)
	qtd_solicitada = resultado("qt_solicitada")
	co_sequencial_item_pedido = resultado("sequencial")

	query_disponivel = "SELECT QT_QUANTIDADE FROM TB_ESTOQUE_MATERIAL WHERE CO_MATERIAL = " & co_material & " "
	resultado = objConn.execute(query_disponivel)
	qtd_ESTOQUE = cInt(resultado("QT_QUANTIDADE"))
	qtd_nova = cInt(qtd_ESTOQUE - qtd_liberar)

	response.write "qtd_liberar:" & qtd_liberar
	response.write "qtd_solicitada:" & qtd_solicitada		
	response.write "qtd_nova:" & qtd_nova
	
	query2 = "UPDATE TB_ESTOQUE_ITEM_PEDIDO SET QT_LIBERADA = "&qtd_liberar&" where co_pedido = " & co_pedido & " and co_material = " & co_material & ""
	
	objConn.execute(query2)
	
	if qtd_liberar < qtd_solicitada then
		query3 = "UPDATE TB_ESTOQUE_MATERIAL SET QT_QUANTIDADE = " & qtd_nova & ", QT_DISPONIVEL_SOLICITACAO = QT_DISPONIVEL_SOLICITACAO + " & (qtd_solicitada - qtd_liberar)   & " where co_material = " & co_material & ""
		objConn.execute(query3)
		response.write query3
	elseIF qtd_liberar = qtd_solicitada then
		query3 = "UPDATE TB_ESTOQUE_MATERIAL SET QT_QUANTIDADE = " & qtd_nova & " where co_material = " & co_material & ""
		objConn.execute(query3)
		response.write query3
	end if


	'****  PRIMEIRO: FAZ O UPDATE DA SITUAÇÃO
	query1 = "UPDATE TB_ESTOQUE_PEDIDO SET CO_ENTREGADOR = '"& mat_entregador &"', DT_ENTREGA='"& data_entrega & "', ic_status = 2 where co_pedido = " & co_pedido & ""
	objConn.execute(query1)
	

	
	'**** SEGUNDO: INCLUI A INFORMAÇÃO NO EXTRATO DO MATERIAL
	query = "INSERT INTO TB_ESTOQUE_HISTORICO (CO_MATERIAL, DT_OPERACAO, MATRICULA, TP_OPERACAO, QT_MODIFICADA, SALDO_ANTERIOR, SALDO_ESTOQUE, co_sequencial_item_pedido) VALUES (" & co_material & ",'" & data_entrega & "','" & mat_entregador &"',2," & qtd_liberar  & ","& qtd_ESTOQUE &","& qtd_nova &","& co_sequencial_item_pedido &")"
	objConn.execute(query)
	
	'**** TERCEIRO: 
	objConn.execute("EXECUTE sp_atualiza_saldo_material_ATUAL " & co_material)
	'****


end if

'REJEITAR PEDIDO


if request("acao") = "rejeitar" then
	
	pedido = split(request("pedido"), ":")
	
	co_pedido = pedido(0)
	co_material = pedido(1)
	qtd_liberar = 0
	
	query1 = "UPDATE TB_ESTOQUE_PEDIDO SET CO_ENTREGADOR='" & mat_entregador & "', DT_ENTREGA='"& data_entrega & "', ic_status = 3 where co_pedido = " & co_pedido & ""
	
	objConn.execute(query1)
	
	query2 = "UPDATE TB_ESTOQUE_ITEM_PEDIDO SET QT_LIBERADA=" & qtd_liberar & " where co_pedido = " & co_pedido & " and co_material = " & co_material & ""
	objConn.execute(query2)

	objConn.execute("EXECUTE sp_atualiza_saldo_material_ATUAL " & co_material)
	
	'*** Verifica se h� solicita��o de reserva para o material. caso positivo envia um email informando ao usuario da disponibilidade do item
	strQuery = " SELECT A.QT_QUANTIDADE AS QT_RESERVADA, a.CO_MATRICULA, B.NO_MATERIAL, b.no_material, B.QT_QUANTIDADE FROM TB_ESTOQUE_ITEM_INDISP A INNER JOIN TB_ESTOQUE_MATERIAL B ON A.CO_MATERIAL = B.CO_MATERIAL  WHERE A.CO_MATERIAL = " & co_material  & " AND IC_STATUS = 1 AND A.CO_UNIDADE = '" & cod_unidade & "'" 
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	do while not rs.eof
		if rs("qt_quantidade") > rs("QT_RESERVADA") THEN
			Envia_Email_GIFUG rs("no_material"), rs("CO_MATRICULA")
			query = "UPDATE TB_ESTOQUE_ITEM_INDISP SET IC_STATUS = 5, DT_RESPOSTA = '" & now() & "' WHERE IC_STATUS = 1 AND  CO_MATERIAL = " & co_material & ""
			objConn.execute(query)
		end if
		rs.movenext
	loop
	'****
	
end if

'RESTAURAR

if request("acao") = "restaurar" then

	co_pedido = pedido(0)
	co_material = pedido(1)
	
	query1 = "UPDATE TB_ESTOQUE_PEDIDO SET CO_ENTREGADOR='" & mat_entregador & "', DT_ENTREGA='"& data_entrega & "' where co_pedido = " & co_pedido & ""
	
	objConn.execute(query1)
	
	query2 = "UPDATE TB_ESTOQUE_ITEM_PEDIDO SET QT_LIBERADA= null where co_pedido = " & co_pedido & " and co_material = " & co_material & ""
	
	objConn.execute(query2)

end if

objConn.close 
set objConn = nothing 



Sub Envia_Email_GIFUG(nome_material, destinatario)
	IF no_aplicativo = "" then
		no_aplicativo = AplicativoNovo
	END IF
	
	 vTexto = "<html><head><head>"
	 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
	 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
	 vTexto = vTexto & "**** MENSAGEM AUTOM&Aacute;TICA - N&Atilde;O RESPONDER *****" & "<br><br>"
	 vTexto = vTexto & " Comunicamos que o material <U>" & nome_material & "</U> solicitado por voc&ecirc; est&aacute; dispon&iacute;vel para solicita&ccedil;&atilde;oo no SIIAG. <br><br>"
	 vTexto = vTexto & " Caso queira solicitar o material clique <a href=""http://ce7180nt005/SIIAG_WEB/estoque_requisicao.asp"">aqui</a></font></td>"
	 'vTexto = vTexto & "2. Clique <a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>aqui</a> para visualizar a demanda." & "<br><br>"
	 vTexto = vTexto & "<BR><br>**** Encaminhada pelo SIIAG - Estoque *****"
	 vTexto = vTexto & "</body></html>"
	 
	 If Err.Number<>0 Then
	  Response.Write("Erro: " & Err.Description & "<BR>")
	  Response.end	
	 Else
	  'SQL3 = "EXECUTE usp_ADM_Inclui_Email_Enviado 1,'" & vDe & "','" & vPara & "','" & vAssunto & "','" & vTexto & "','" & vUsuario & "'"
	  'Set rs3 = DB_Administrativo.Execute(SQL3)
	  'vCodEmail = rs3("Cod")
	 
	  If Err.Number<>0 Then
	   Response.Write("Erro: " & Err.Description & "<BR>")
	   Response.end
	  Else
	   vDe =  "gifugfo@mail.caixa"
	   vPara = destinatario & "@mail.caixa;"
	   vAssunto = "Disponibilidade de material: " & nome_material
	   vUsuario = mat_entregador
	   
	   'response.write vTexto
	   'response.write "DE " & vDE & "<br>"
	   'response.write "PARA " & vPara & "<br>"
	   'response.write "ASSUNTO " & vAssunto & "<br>"
	   'response.write "RETORNO " & vRetorno & "<br>"
	   'response.write "USUARIO " & vUsuario & "<br>"
	   
	   'if enviar = "1" then
			email = f_Envia_Email(vDe,vPara,vAssunto,vTexto,vRetorno,vUsuario)
			'email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
			response.write email
	   'end if
	
	  End If
	 End If
End Sub	

%>
  
