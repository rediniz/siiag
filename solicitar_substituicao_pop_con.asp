<!-- #INCLUDE FILE ="include/Conexao.asp" -->

<%
 				mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i)) 'pegando matricula
				End If

'daqui pra cima serve para pegar matricula do usuario logado


	data_inicio = Request("data_inicio")
	data_final = Request("data_final")
	motivo = Request("motivo")
	substituto = Request("substituto")
	gerencia_gerente = Request("gerencia_gerente")
	mat_gerente = Request("mat_gerente")
	
	response.write data_inicio & "<br>"
	response.write data_final & "<br>"
	response.write motivo & "<br>"
	response.write substituto & "<br>"
	response.write gerencia_gerente & "<br>"
	response.write mat_gerente & "<br>"

	sql_cod_gerencia = "SELECT CO_GS FROM VW_GS WHERE CO_GERENTE = '"&gerencia_gerente&"'"
	co_gs = objConn.execute(sql_cod_gerencia)("CO_GS")
	
	
	data  		= day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	co_unidade 	= request.Cookies("co_usuario_unidade_siiag")
	
	sql = "INSERT INTO TB_SUBSTITUICOES(CO_SUBSTITUTO, DT_INICIO, DT_FIM, CO_SITUACAO, CO_CRIADOR, CO_GS, CO_GERENTE, CO_TIPO_AFASTAMENTO, DH_CRIACAO, CO_UNIDADE) VALUES ('"&substituto&"', '"&data_inicio&"', '"&data_final&"', 1, '"&usuario&"', "&co_gs&", '"&mat_gerente&"', "&motivo&", '"&data&"',"&co_unidade&")"

    response.write sql
	Set query = objConn.execute(sql)
	
	'Fechando conexão
	Set query = Nothing
	objConn.close

'	
'	'Redireciona para página anterior informando sucesso e o número do protocolo incluído
'	
'	
	Response.Redirect("solicitar_substituicao_pop.asp?sucesso=true")
		    

%>