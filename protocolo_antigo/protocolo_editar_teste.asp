<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<%

	' Parâmetros de Conexao ao Banco
	SERVIDOR_DO_BANCO = "ce7180nt005"
	NOME_DO_BANCO = "SIIAG"
	USUARIO_DO_BANCO = "todos"
	SENHA_DO_BANCO = "todosce"
	
	Dim conexao
	
	' Efetua a Conexão
	Set conexao = Server.CreateObject("ADODB.Connection")
	conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 		    
	' Pegando os valores informados pelo usuário
	tipoProtocolo = CInt(request("tipoProtocolo"))
	areaProtocolo = CInt(request("areaProtocolo"))
	destinoProtocolo = request("destinoProtocolo")
	conteudoProtocolo = request("conteudoProtocolo")
	responsavelProtocolo = request("responsavelProtocolo")
	co_responsavel_matricula = request("f_responsavel_matricula")
	numeroAR = request("numeroAR")
	unidade = "7180"
	codSeq = request("codSeq")
	
	' SQL de atualização na tabela protocolo	
	sql = "UPDATE TB_PROTOCOLO_ATUAL SET CO_MATRICULA_INCLUSAO='"&request.Cookies("co_usuario_protocolo")&"', CO_RESPONSAVEL_MATRICULA='"& co_responsavel_matricula &"', NO_RESPONSAVEL='"& responsavelProtocolo &"',DE_CONTEUDO ='"& conteudoProtocolo & "',DE_DESTINO='"&destinoProtocolo&"' WHERE CO_SEQUENCIAL="&codSeq&""
	
	Set query = conexao.execute(sql)
	
'	'Se foi adicionado AR ao ofício, insere  na tabela ARS
'	if numeroAR <> "" then
'		
'		sql2 = "UPDATE TB_PROTOCOLO_ARS SET CO_TIPO="&tipoProtocolo&", NU_AR="&numeroAR&"" 
'		sql2 = "INSERT INTO TB_PROTOCOLO_ARS(NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NU_AR,CHECKED) VALUES("&numeroProtocolo&","&year(Date())&","&tipoProtocolo&","&numeroAR&",1)"
'	
'		'SQL de inserção na tabela ARS	
'		'Set query2 = conexao.execute(sql2)
'	
'	else
'	
'		sql2 = "INSERT INTO TB_PROTOCOLO_ARS(NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NU_AR,CHECKED) VALUES("&numeroProtocolo&","&year(Date())&","&tipoProtocolo&", null, 0)"
'	
'		'Set query2 = conexao.execute(sql2)
'	
'	end if
	
	'Fechando conexão
	Set query = Nothing
	'Set query2 = Nothing
	Set conexao = Nothing
	
	'Redireciona para página anterior informando sucesso e o número do protocolo incluído
	
	
	Response.Redirect("protocolo_edicao.asp?sucesso=true")
	
	
%>