<%@LANGUAGE=VBSCRIPT CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/conexao_protocolo.asp" -->
<!--#INCLUDE FILE="clsUpload.asp"-->
<!-- #include file = "Upload_funcoes.asp" -->
<%

	' Parâmetros de Conexao ao Banco
	'SERVIDOR_DO_BANCO = "ce7180nt005"
	'NOME_DO_BANCO = "SIIAG"
	'USUARIO_DO_BANCO = "todos"
	'SENHA_DO_BANCO = "todosce"
	
	'Dim conexao
		
	' Cria objeto que gerencia os campos do Form recebido, incluindo os arquivos			
	Set objUpload = new clsUpload
	
	' Pegando os valores informados pelo usuário
	deProtocolo = objUpload("tipoProtocolo").Value
	'response.write deProtocolo
	areaProtocolo = cint(objUpload("areaProtocolo").Value)
	destinoProtocolo = objUpload("destinoProtocolo").Value
	conteudoProtocolo = objUpload("conteudoProtocolo").Value
	responsavelProtocolo = objUpload.Fields("responsavelProtocolo").Value
	unidade = "7180"
	codSeq = objUpload("codSeq").Value
	qtd_arquivo = objUpload("qtd_arquivo").Value
	data = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
	
	' Pega a matrícula do responsável pelo protocolo no banco GIFUG
	sql_co_responsavel_matricula = "SELECT CO_MATRICULA FROM siiag_web.dbo.TB_USUARIOS WHERE NO_NOME = '"& responsavelProtocolo & "'"
	consulta = objConn.execute(sql_co_responsavel_matricula)	
	co_responsavel_matricula = consulta("CO_MATRICULA")
	'Set conexao = nothing
	
	usuario = request.Cookies("co_usuario_siiag")
	' SQL de atualização na tabela protocolo	
	sql = "UPDATE TB_PROTOCOLO_ATUAL SET CO_MATRICULA_INCLUSAO='"& usuario &"', CO_RESPONSAVEL_MATRICULA='"& co_responsavel_matricula &"', NO_RESPONSAVEL='"& responsavelProtocolo &"',DE_CONTEUDO ='"& conteudoProtocolo & "',DE_DESTINO='"&destinoProtocolo&"' WHERE CO_SEQUENCIAL="&codSeq&""
	
	sql_codTipoProtocolo = "SELECT CO_TIPO FROM TB_PROTOCOLO_TIPO WHERE DE_TIPO ='"&deProtocolo&"'"
	Set queryCodTipoProtocolo = objConn.execute(sql_codTipoProtocolo)
	codTipoProtocolo = queryCodTipoProtocolo("CO_TIPO")
	
	Set query = objConn.execute(sql)
	
	' Pega o número do protocolo usando o código sequencial, para ser inserido na tabela de arquivos
	sql2 = "SELECT NO_PROTOCOLO FROM TB_PROTOCOLO_ATUAL WHERE CO_SEQUENCIAL ="&codSeq&""
	Set query2 = objConn.execute(sql2)
	numeroProtocolo = query2("NO_PROTOCOLO")

	'Upload de arquivos
	for i=1 to qtd_arquivo
	
		' Pega as informações do arquivo
		Set arquivo = objUpload.Fields("arquivo"&i)
		nome_arquivo = arquivo.FileName 
		extensao =  "."&LCase(arquivo.FileExt)
		tamanho_arquivo = round(arquivo.Length / 1024)
		
		Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
			
		pastaData = "//ce7180nt005/Aplicativos/Programas/Relatório Protocolo"
		' Salva o arquivo na pasta
		'arquivo.SaveAs(Server.MapPath("Relatorios Protocolo/") & "\" & arquivo.FileName)
		
		prot = year(date()) & "-" & codTipoProtocolo & "-" & numeroProtocolo
		
		If Not ScriptObject.FolderExists("//ce7180nt005/Aplicativos/Programas/Relatório Protocolo/"& prot &"/") Then
	
			pastaProtocolo = ScriptObject.CreateFolder("//ce7180nt005/Aplicativos/Programas/Relatório Protocolo/"& prot &"/")
	
		Else
		
			pastaProtocolo = "//ce7180nt005/Aplicativos/Programas/Relatório Protocolo/"& prot &"/"
		
		End If
		
		arquivo.SaveAs(pastaProtocolo & "\" & arquivo.FileName)
		
		' Insere as informações no banco
		sql3 = "INSERT INTO TB_PROTOCOLO_ARQUIVOS (NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NO_ARQUIVO,SG_EXTENSAO,VR_TAMANHO_KB,CO_CRIADOR,DH_CRIACAO,CO_AREA) VALUES ("&	numeroProtocolo&",'" & year(date()) & "'," &codTipoProtocolo& ",'" & nome_arquivo & "','" & extensao & "',"& tamanho_arquivo & ",'" & co_responsavel_matricula & "','" & data & "'," & areaProtocolo & ")"
		
		Set query3 = objConn.execute(sql3)
	
	next	
	
	'Fechando conexão
	Set queryCodTipoProtocolo = Nothing
	Set query = Nothing
	Set query2 = Nothing
	Set query3 = Nothing
	Set conexao = Nothing
	
	'Redireciona para página anterior informando sucesso e o número do protocolo incluído	
	
	Response.Redirect("protocolo_edicao.asp?areaProtocolo="&areaProtocolo&"&tipoProtocolo="&deProtocolo&"&destino="&destinoProtocolo&"&conteudo="&conteudoProtocolo&"&responsavel="&responsavelProtocolo&"&codSeq="&codSeq&"&sucesso=true")
	
%>