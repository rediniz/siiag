	<!-- #INCLUDE FILE ="include/conexao_protocolo.asp" -->
<%

	' Parâmetros de Conexao ao Banco
	'SERVIDOR_DO_BANCO = "ce7180nt005"
	'NOME_DO_BANCO = "SIIAG"
	'USUARIO_DO_BANCO = "todos"
	'SENHA_DO_BANCO = "todosce"
	
	'Dim conexao
	
	' Efetua a Conexão
	'Set conexao = Server.CreateObject("ADODB.Connection")
	'conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 		    
	
	' Pegando os valores informados pelo usuário
	numeroOficio = request("nOficio")
	numeroAR = trim(request("nAR"))
	anoOficio = request("anoOficio")
	
	Set query2 = objConn.execute("select NU_AR from TB_PROTOCOLO_ARS WHERE NO_PROTOCOLO = '"&numeroOficio&"' AND CO_TIPO = 2 AND AA_PROTOCOLO = '" & request("anoOficio") & "'")
	if query2.eof then

		' SQL de inclusao da tabela 
		sql2 = "INSERT INTO TB_PROTOCOLO_ARS(NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NU_AR,CHECKED) VALUES("&numeroOficio&","&anoOficio&",'2','"&numeroAR&"',1)"
		response.write sql2
		'Set query = conexao.execute(sql2)
		Set query = objConn.execute(sql2)
		

	else
		' SQL de update da tabela 
		sql = "UPDATE TB_PROTOCOLO_ARS SET NU_AR ='" & numeroAR & "' FROM TB_PROTOCOLO_ARS  WHERE NO_PROTOCOLO= " & numeroOficio & " AND CO_TIPO = 2 AND AA_PROTOCOLO = '" & anoOficio & "'"
		response.write sql
		'Set query = conexao.execute(sql)
		Set query = objConn.execute(sql)
	end if
	
	
	'Fechando conexão
	Set query = Nothing
	'Set conexao = Nothing
	'response.End()
	'Redireciona para página anterior informando sucesso e o número do protocolo incluído (alterar valores)
	Response.Redirect("protocolo_editar.asp?sucesso=true&noficio=" & numeroOficio & "&anoOficio="& anoOficio & "")
	
%>