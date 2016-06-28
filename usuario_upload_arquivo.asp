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
	pasta_guardar_2 = "." & UploadRequest.Item("pasta_guardar").Item("Value")
	'response.Write("pasta:" & pasta_guardar_2)
   	pasta=Server.MapPath(pasta_guardar_2)
	
   	'pasta=Server.MapPath("./imagens/usuarios/temp/")

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
	matricula = UploadRequest.Item("f_matricula_2").Item("Value")
	nome = UploadRequest.Item("f_nome_2").Item("Value")
	coordenacao = UploadRequest.Item("f_coordenacao_2").Item("Value")
	cargo = UploadRequest.Item("f_cargo_2").Item("Value")
	nascimento = UploadRequest.Item("f_nascimento_2").Item("Value")
	admissao = UploadRequest.Item("f_admissao_2").Item("Value")
	inicio = UploadRequest.Item("f_inicio_2").Item("Value")
	jornada = UploadRequest.Item("f_jornada_2").Item("Value")
	ativo = UploadRequest.Item("f_ativo_2").Item("Value")
	gerente = UploadRequest.Item("f_gerente_2").Item("Value")
	
	if ( UCASE(extensao) = ".JPG" or ucase(extensao) = ".PNG") then
		'response.write(nome_arquivo)
		'cria o arquivo
		if not ScriptObject.FileExists(pasta & "/" & nome_arquivo) then
			nome_arquivo = matricula & "_temp" & extensao
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
		Response.Redirect("usuario_cadastrar.asp?sucesso=true&arquivo=" & nome_arquivo & "&f_matricula=" & matricula & "&f_nome=" & nome & "&f_coordenacao=" & coordenacao & "&f_cargo="& cargo & "&f_nascimento=" & nascimento & "&f_admissao=" & admissao & "&f_inicio=" & inicio & "&f_jornada=" & jornada & "&f_ativo=" & ativo & "&f_gerente=" & gerente)
		
	else
		'redireciona para a página inicial informando erro
		Response.Write "Arquivo não era .jpg"
		response.End()
		Response.Redirect("usuario_cadastrar.asp?sucesso=false")
		
	end if
	
%>