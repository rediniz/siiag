<%@LANGUAGE=VBSCRIPT CODEPAGE="1252"%>

<!-- #include file = "Upload_funcoes.asp" -->
<%
	'Chamando Funções, que fazem o Upload funcionar
	byteCount = Request.TotalBytes
	RequestBin = Request.BinaryRead(byteCount)
	Set UploadRequest = CreateObject("Scripting.Dictionary")
	BuildUploadRequest RequestBin

	' Parametros de Conexao ao Banco
	SERVIDOR_DO_BANCO = "ce7180nt005"
	NOME_DO_BANCO = "SIIAG"
	USUARIO_DO_BANCO = "todos"
	SENHA_DO_BANCO = "todosce"
	
	Dim conexao
	
	' Efetua a Conexão
	Set conexao = Server.CreateObject("ADODB.Connection")
	conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 		    
	' Pegando os valores	
	tipoProtocolo = CInt(UploadRequest.Item("tipoProtocolo").Item("Value"))
	areaProtocolo = CInt(UploadRequest.Item("areaProtocolo").Item("Value"))
	destinoProtocolo = UploadRequest.Item("destinoProtocolo").Item("Value")
	conteudoProtocolo = UploadRequest.Item("conteudoProtocolo").Item("Value")
	responsavelProtocolo = UploadRequest.Item("responsavelProtocolo").Item("Value")
	qtd_arquivo = CInt(UploadRequest.Item("qtd_arquivo").Item("Value"))
	arquivo = request("arquivo")
	
	response.write tipoProtocolo & "<p/>"
	response.write areaProtocolo & "<p/>"
	response.write destinoProtocolo & "<p/>"
	response.write conteudoProtocolo & "<p/>"
	response.write responsavelProtocolo & "<p/>"
	
	' Dados do arquivo
	caminho_arquivo = UploadRequest.Item("arquivo"&i).Item("FileName")
	nome_arquivo = Right(caminho_arquivo,Len(caminho_arquivo)-InStrRev(caminho_arquivo,"\"))
	extensao = right(caminho_arquivo,4)
	arquivo = UploadRequest.Item("arquivo"&i).Item("Value")
	
	pasta = ""
	
			for i = 1 to qtd_arquivo
	
				caminho_arquivo = UploadRequest.Item("arquivo"&i).Item("FileName")
				nome_arquivo = Right(caminho_arquivo,Len(caminho_arquivo)-InStrRev(caminho_arquivo,"\"))
				extensao = right(caminho_arquivo,4)
				arquivo = UploadRequest.Item("arquivo"&i).Item("Value")
							
				'response.write(nome_arquivo)
	
				'cria o arquivo
				if not ScriptObject.FileExists(pasta & "/" & nome_arquivo) then
					Set MyFile = ScriptObject.CreateTextFile(pasta2 & "/" & nome_arquivo)
					For j = 1 to LenB(arquivo)
						MyFile.Write chr(AscB(MidB(arquivo,j,1)))
					Next
						MyFile.Close					
				end if
			
			next
		
	' SQL de inserção na tabela protocolo	
	sql = "INSERT INTO TB_PROTOCOLO
           (NO_PROTOCOLO
           ,AA_PROTOCOLO
           ,DH_ENVIO
           ,NO_RESPONSAVEL
           ,DE_CONTEUDO
           ,DE_DESTINO
           ,CO_TIPO
           ,CO_AREA
           ,CO_UNIDADE_FGTS)
     VALUES
           (<NO_PROTOCOLO, int,> 
           ," & year() &"
           ," & date() &"
           ," & responsavelProtocolo &"
           ," & conteudoProtocolo &"
           ," & destinoProtocolo &"
           ," & tipoProtocolo &"
           ," & areaProtocolo &"
           ,7180)"
		
	   
	'Set query = conexao.execute(sql)
	
	'Se foi adicionado AR ao ofício, insere  na tabela ARS
	if request("numeroAR") <> "" then
	
	sql2 = "INSERT INTO TB_PROTOCOLO_ARS
           (NO_PROTOCOLO
           ,AA_PROTOCOLO
           ,CO_TIPO
           ,NU_AR
           ,CHECKED)
     VALUES
           (<NO_PROTOCOLO, int,>
           ,<AA_PROTOCOLO, decimal(18,0),>
           ,<CO_TIPO, tinyint,>
           ,<NU_AR, varchar(50),>
           ,<CHECKED, bit,>)"
	
	end if
	
	'SQL de inserção na tabela ARS
	
	'Set query2 = conexao.execute(sql2)
	
	'Fechando conexão
	Set query = Nothing
	Set query2 = Nothing
	Set conexao = Nothing
	
	'Redireciona para página anterior informando sucesso
	Response.Redirect("protocolo.asp?sucesso=true")

%>