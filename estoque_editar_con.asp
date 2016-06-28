<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%
  	codigo =  request("codigo")
	'response.write codigo
	nome = request("nome")
	valor = request("valor")
	qtd = CInt(request("qtd"))
	qtd_min =request("qtd_min")
	unidade = request("unidade")
	ativo = request("ativo")

	nome_simac = request("nome_simac")
	cod_simac = request("cod_simac")
	qtd_simac = request("qtd_simac")

  	data_pedido = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
  	matricula = request.Cookies("co_usuario_siiag")
  	cod_unidade = request.Cookies("co_usuario_unidade_siiag")
	
	
	
	IF request("inputAddQtd") <> "" OR request("inputSubQtd") <> "" then
	
		if(request("inputAddQtd") <> "") then
		
			qtd_nova = qtd + CInt(request("inputAddQtd"))
			qt_modificada = CInt(request("inputAddQtd"))	
			tp_oper = 1 'ADICAO
		else
		
			if (request("inputSubQtd") <> "") then
			
				qtd_nova =  qtd - CInt(request("inputSubQtd"))
				qt_modificada =  CInt(request("inputSubQtd"))
				tp_oper = 2 ' subtracao
			else
			
				qtd_nova = qtd
			
			end if
		
		end if


		query = "INSERT INTO TB_ESTOQUE_HISTORICO (CO_MATERIAL, DT_OPERACAO, MATRICULA, TP_OPERACAO, QT_MODIFICADA, SALDO_ANTERIOR, SALDO_ESTOQUE) VALUES (" & codigo & ",'" & now() & "','" & matricula &"'," & tp_oper & "," & qt_modificada  & ","& qtd &","& qtd_nova &")"
		objConn.execute(query)

		objConn.execute("EXECUTE sp_atualiza_saldo_material_ATUAL " & codigo)
		
		
		
		'**** Verifica se h� solicita��o de reserva para o material. caso positivo envia um email informando ao usuario da disponibilidade do item
		strQuery = " SELECT A.QT_QUANTIDADE AS QT_RESERVADA, a.CO_MATRICULA, B.NO_MATERIAL, b.no_material, B.QT_QUANTIDADE FROM TB_ESTOQUE_ITEM_INDISP A INNER JOIN TB_ESTOQUE_MATERIAL B ON A.CO_MATERIAL = B.CO_MATERIAL  WHERE A.CO_MATERIAL = " & codigo  & " AND IC_STATUS = 1 AND A.CO_UNIDADE = '" & cod_unidade & "'" 
		set rs=Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys, 3, , 32
		do while not rs.eof
			if rs("qt_quantidade") > rs("QT_RESERVADA") THEN
				Envia_Email_GIFUG rs("no_material"), rs("CO_MATRICULA")
			query = "UPDATE TB_ESTOQUE_ITEM_INDISP SET IC_STATUS = 5, DT_RESPOSTA = '" & now() & "' WHERE IC_STATUS = 1 AND  CO_MATERIAL = " & CODIGO & ""
				objConn.execute(query)
			end if
			rs.movenext
		loop
		'****

	else
		qtd_nova = qtd
	end if


	if ativo = "on" then
		ativo = 1
	else
		ativo = 0
	end if
	
	'response.write ativo & "<br>"
	

	
	query = "UPDATE TB_ESTOQUE_MATERIAL SET NO_MATERIAL = '" & nome & "', co_simac="&cod_simac&",de_simac = '" & nome_simac & "', co_unidade = " & unidade & ", qt_quantidade = " & qtd_nova & ", qt_qtde_minima = " & qtd_min & ", qt_qtde_simac = " & qtd_simac & ", vr_valor_unit = " & valor & ", ic_ativo = "& ativo &" where CO_MATERIAL = "& codigo &" and co_unidade_fgts = "& cod_unidade

	'RESPONSE.Write query
	objConn.execute(query)
	
  	set query = nothing
  	set objConn = nothing



Sub Envia_Email_GIFUG(nome_material, destinatario)
	IF no_aplicativo = "" then
		no_aplicativo = AplicativoNovo
	END IF
	
	 vTexto = "<html><head><head>"
	 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
	 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
	 vTexto = vTexto & "**** MENSAGEM AUTOM&Aacute;TICA - N&Atilde;O RESPONDER *****" & "<br><br>"
	 vTexto = vTexto & " Comunicamos que o material <U>" & nome_material & "</U> solicitado por voc&ecirc; est&aacute; dispon&iacute;vel para solicita��o no SIIAG. <br><br>"
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
	   vUsuario = matricula
	   
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