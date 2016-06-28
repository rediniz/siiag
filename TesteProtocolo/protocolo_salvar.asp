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
	numeroAR = request("numeroAR")
	unidade = "7180"
	
	'Seleciona o maior número de protocolo atual e soma 1	
	sql_protocoloAtual = "SELECT MAX(NO_PROTOCOLO) AS CODIGO FROM TB_PROTOCOLO_ATUAL WHERE AA_PROTOCOLO ="&year(date())&"  AND CO_TIPO = " & tipoProtocolo & " AND CO_UNIDADE_FGTS = " & unidade & " "	
	consulta_protocoloAtual = conexao.execute(sql_protocoloAtual)	
	numeroProtocolo = consulta_protocoloAtual("CODIGO") + 1				
	data = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	
	' SQL de inserção na tabela protocolo	
	sql = "INSERT INTO TB_PROTOCOLO_ATUAL (NO_PROTOCOLO,AA_PROTOCOLO,DH_ENVIO,NO_RESPONSAVEL,DE_CONTEUDO,DE_DESTINO,CO_TIPO,CO_AREA,CO_UNIDADE_FGTS) VALUES (" & numeroProtocolo &" ," & 	year(date()) &",'" & data & "','" & responsavelProtocolo &"','" & conteudoProtocolo &"','" & destinoProtocolo &"'," & tipoProtocolo &"," & areaProtocolo &",7180)"
	
	Set query = conexao.execute(sql)
	
	'Se foi adicionado AR ao ofício, insere  na tabela ARS
	if numeroAR <> "" then
	
		sql2 = "INSERT INTO TB_PROTOCOLO_ARS(NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NU_AR,CHECKED) VALUES("&numeroProtocolo&","&year(Date())&","&tipoProtocolo&","&numeroAR&",1)"
	
		'SQL de inserção na tabela ARS	
		Set query2 = conexao.execute(sql2)
	
	else
	
		sql2 = "INSERT INTO TB_PROTOCOLO_ARS(NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NU_AR,CHECKED) VALUES("&numeroProtocolo&","&year(Date())&","&tipoProtocolo&", null, 0)"
	
		Set query2 = conexao.execute(sql2)
	
	end if
	
	'Fechando conexão
	Set query = Nothing
	Set query2 = Nothing
	Set conexao = Nothing
	
	'Redireciona para página anterior informando sucesso e o número do protocolo incluído
	Response.Redirect("protocolo.asp?sucesso=true&nu_prot=" & numeroProtocolo & "&area=" & CsTR(areaProtocolo) & "")
	
%>