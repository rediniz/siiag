<!-- #INCLUDE FILE ="include/Conexao.asp" -->

<%
 				mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i)) 'pegando matricula
				End If

'daqui pra cima serve para pegar matricula do usuario logado


	'#ALTERADO EM 12/04/2016
	data_inicio = Request("data_inicio")
	data_final = Request("data_final")
	motivo = Request("motivo")
	substituto = Request("substituto")
	empregado = Request("empregado")
	
	'#ALTERADO EM 12/04/2016
	response.write data_inicio & "<br>"
	response.write data_final & "<br>"
	response.write motivo & "<br>"
	response.write empregado & "<br>"
	response.write substituto & "<br>"
	
	data  		= day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	co_unidade 	= request.Cookies("co_usuario_unidade_siiag")

	'#ALTERADO EM 12/04/2016
	sqlGS = "SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '"&empregado&"'"
	co_gs = objConn.execute(sqlGS)("CO_GS")
	
	'#ALTERADO EM 12/04/2016
	sql = "INSERT INTO TB_SUBSTITUICOES(CO_SUBSTITUTO, DT_INICIO, DT_FIM, CO_SITUACAO, CO_CRIADOR, CO_GS, CO_GERENTE, CO_TIPO_AFASTAMENTO, DH_CRIACAO, CO_UNIDADE) VALUES ('"&substituto&"', '"&data_inicio&"', '"&data_final&"', 1, '"&usuario&"', "&co_gs&", '"&empregado&"', "&motivo&", '"&data&"',"&co_unidade&")"

    response.write sql
	Set query = objConn.execute(sql)
	
	'Fechando conexão
	Set query = Nothing
	objConn.close

'	
'	'Redireciona para página anterior informando sucesso e o número do protocolo incluído
'	
'	
	'Response.Redirect("substituicao.asp?sucesso=true")
		    

%>