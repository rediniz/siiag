<%@LANGUAGE=VBSCRIPT CODEPAGE="1252"%>

<!-- #include file = "upload/Upload_funcoes.asp" -->
<%
	'Chamando Funções, que fazem o Upload funcionar
	byteCount = Request.TotalBytes
	RequestBin = Request.BinaryRead(byteCount)
	Set UploadRequest = CreateObject("Scripting.Dictionary")
	BuildUploadRequest RequestBin
	
	'data atual
	data = date()
	
	sucesso=true
		
	'qtd_arquivo = CInt(UploadRequest.Item("qtd_arquivo").Item("Value"))
	'cpfgts = UploadRequest.Item("cpfgts").Item("Value")
		
	' pasta onde os arquivos serao guardados
   	pasta=Server.MapPath("./imagens/usuarios/temp/")

	' Grava o arquivo selecionado // permite apenas arquivos .pdf serem enivados
	Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
	
	'cria pasta com a data
	'If Not ScriptObject.FolderExists(Server.MapPath("upload/"&data&"/")) Then
	'	pasta1 = ScriptObject.CreateFolder(Server.MapPath("upload/"&data&"/") )
	'else
	'	pasta1 = Server.MapPath("upload/"&data&"/")
	'End If
	 
	'cria pasta com o cpfgts
	'If Not ScriptObject.FolderExists(Server.MapPath("upload/"&data&"/"&cpfgts&"/")) Then
	'	pasta2 = ScriptObject.CreateFolder(Server.MapPath("upload/"&data&"/"&cpfgts&"/"))
	'else 
	'	pasta2 = Server.MapPath("upload/"&data&"/"&cpfgts&"/")
	'End If	
	
	'cria todos os arquivos selecionados pelo usuário

	caminho_arquivo = UploadRequest.Item("arquivo1").Item("FileName")
	response.Write(caminho_arquivo)
	nome_arquivo = Right(caminho_arquivo,Len(caminho_arquivo)-InStrRev(caminho_arquivo,"\"))
	extensao = right(caminho_arquivo,4)
	arquivo = UploadRequest.Item("arquivo1").Item("Value")
	
	if ( UCASE(extensao) = ".JPG" or extensao = ".PNG") then
		'response.write(nome_arquivo)
		'cria o arquivo
		if not ScriptObject.FileExists(pasta & "/" & nome_arquivo) then
			Set MyFile = ScriptObject.CreateTextFile(pasta & "/" & nome_arquivo)
			For j = 1 to LenB(arquivo)
			MyFile.Write chr(AscB(MidB(arquivo,j,1)))
			Next
			MyFile.Close
			Response.Write "Arquivo <strong>'"&nome_arquivo&"'</strong> enviado com sucesso para a pasta '"&pasta&"\'<p/>"
		else 
			Response.Write "Arquivo <strong>'"&nome_arquivo&"'</strong> já existe<p/>"
		end if
	else
		sucesso = false
	end if


	
	if (sucesso = true) then
	'redireciona para a página inicial informando sucesso
		'Response.Write "Arquivo enviado com sucesso para a pasta '"&pasta2&"'"
		Response.Redirect("usuario_cadastrar.asp?sucesso=true&arquivo=" & nome_arquivo & "&request.")
		
	else
		'redireciona para a página inicial informando erro
		Response.Write "Arquivo não era .jpg"
		response.End()
		Response.Redirect("usuario_cadastrar.asp?sucesso=false")
		
	end if
	
%>