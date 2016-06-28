<%@LANGUAGE=VBSCRIPT CODEPAGE="1252"%>
<!-- #include file = "upload_protocolo_funcoes.asp" -->
<%
	'Chamando Funções, que fazem o Upload funcionar
	byteCount = Request.TotalBytes
	RequestBin = Request.BinaryRead(byteCount)
	Set UploadRequest = CreateObject("Scripting.Dictionary")
	BuildUploadRequest RequestBin
		
	' Data selecionada no formulario
	data = UploadRequest.Item("data").Item("Value")
	
	' Extensao de arquivo que esta sendo enviado
	arquivo = UploadRequest.Item("arquivo").Item("ContentType")
	cpfgts = UploadRequest.Item("cpfgts").Item("Value")
	
	' Caminho completo dos arquivos enviados
	caminho_arquivo = UploadRequest.Item("arquivo").Item("FileName")
	
	' Extensao do arquivo
	extensao = right(caminho_arquivo,4)	
	
	' Nome dos arquivos enviados (nome_arquivo e' o nome e a extensao sem o caminho completo)
	nome_arquivo = Right(caminho_arquivo,Len(caminho_arquivo)-InStrRev(caminho_arquivo,"\"))
	
	' Conteudo binario dos arquivos enviados
	arquivo = UploadRequest.Item("arquivo").Item("Value")
	
	' pasta onde os arquivos serao guardados
   	pasta=Server.MapPath("./upload/"&data&"/&")
	
	' pasta + nome dos arquivos
	carquivo = "arquivo" + nome_arquivo
	
	' Grava o arquivo selecionado // permite apenas arquivos .pdf serem enivados
	if ( extensao = ".pdf" ) then
		Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
		
		'cria pasta com a data
		If Not ScriptObject.FolderExists(Server.MapPath("upload/"&data&"/")) Then
		 pasta1 = ScriptObject.CreateFolder(Server.MapPath("upload/"&data&"/") )
		 response.write(pasta1)
		 End If
		 
		'cria pasta com o cpfgts
		If Not ScriptObject.FolderExists(pasta1&"/"&cpfgts&"/") Then
	     pasta2 = ScriptObject.CreateFolder(pasta1&"/"&cpfgts&"/") 
		 End If

		'cria o arquivo
		Set MyFile = ScriptObject.CreateTextFile(pasta2 & "/" & nome_arquivo)
		For i = 1 to LenB(arquivo)
			MyFile.Write chr(AscB(MidB(arquivo,i,1)))
		Next
		MyFile.Close
		
		'redireciona para a página inicial informando sucesso
		Response.Write "Arquivo enviado com sucesso para a pasta '"&pasta2&"'"
		Response.Redirect("protocolo.asp?sucesso=true")
	else
		'redireciona para a página inicial informando erro
		Response.Write "Arquivo não era .pdf"
		Response.Redirect("protocolo.asp?sucesso=false")
	end if
	
%> 