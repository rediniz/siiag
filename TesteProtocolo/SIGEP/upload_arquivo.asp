<%@LANGUAGE=VBSCRIPT CODEPAGE="1252"%>

<!-- #include file = "Upload_funcoes.asp" -->
<%
	'Chamando Funções, que fazem o Upload funcionar
	byteCount = Request.TotalBytes
	RequestBin = Request.BinaryRead(byteCount)
	Set UploadRequest = CreateObject("Scripting.Dictionary")
	BuildUploadRequest RequestBin
	
	'data atual
	data = date()
	
	sucesso=true
		
	qtd_arquivo = CInt(UploadRequest.Item("qtd_arquivo").Item("Value"))
	cpfgts = UploadRequest.Item("cpfgts").Item("Value")
		
	response.write "<strong>CPFGTS:</strong> "&cpfgts
	response.write "<p/><strong>Quantidade de documentos:</strong><p/>"
	
	for i= 1 to 18 
	
    quantidade = UploadRequest.Item("quantidade"&i).Item("Value")
	
	if(quantidade <> 0) then	

	Select case i
	
		Case 1
		tipo_documento = "TRCT"
		response.Write("<p>TRCT : "&quantidade&"</p>")
	
		Case 2
		tipo_documento = "THRCT"
		response.Write("<p>THRCT : "&quantidade&"</p>")
	
		Case 3
		tipo_documento = "TQRCT"
		response.Write("<p>TQRCT : "&quantidade&"</p>")
	
		Case 4
		tipo_documento = "SSFGTS"
		response.Write("<p>SSFGTS : "&quantidade&"</p>")
		
		Case 5
		tipo_documento = "EXTRATO com saque"
		response.Write("<p>EXTRATO com saque : "&quantidade&"</p>")
	
		Case 6
		tipo_documento = "Cópias da CTPS"
		response.Write("<p>Cópias da CTPS : "&quantidade&"</p>")
		
		Case 7
		tipo_documento = "Certidão aposentadoria/MEMÓRIA DE CÁLCULO"
		response.Write("<p>Certidão aposentadoria/MEMÓRIA DE CÁLCULO : "&quantidade&"</p>")
	
		Case 8
		tipo_documento = "Alvará"
		response.Write("<p>Alvará : "&quantidade&"</p>")
	
		Case 9
		tipo_documento = "Termo de audiência"
		response.Write("<p>Termo de audiência : "&quantidade&"</p>")
	
		Case 10
		tipo_documento = "Atestado médico"
		response.Write("<p>Atestado médico : "&quantidade&"</p>")
	
		Case 11
		tipo_documento = "Portaria/estatuto/ata de nomeação"
		response.Write("<p>Portaria/estatuto/ata de nomeação : "&quantidade&"</p>")
	
		Case 12
		tipo_documento = "Portaria/estatuto/ata portaria de exoneração"
	   	response.Write("<p>Portaria/estatuto/ata portaria de exoneração : "&quantidade&"</p>")
	
		Case 13
		tipo_documento = "Contrato de trabalho"
		response.Write("<p>Contrato de trabalho : "&quantidade&"</p>")
	
		Case 14
		tipo_documento = "Declaração do OGMO"
		response.Write("<p>Declaração do OGMO : "&quantidade&"</p>")
	
		Case 15
		tipo_documento = "Comprovante de residência"
		response.Write("<p>Comprovante de residência : "&quantidade&"</p>")
	
		Case 16
		tipo_documento = "Declaração de dependetes"
		response.Write("<p>Declaração de dependetes : "&quantidade&"</p>")
	
		Case 17
		tipo_documento = "Documento de identificação do trabalhador"
		response.Write("<p>Documento de identificação do trabalhador : "&quantidade&"</p>")
	
		Case 18
		tipo_documento = "Outros"
		response.Write("<p>Outros : "&quantidade&"</p>")
	
	End Select
	
	End If
	
	next 
		
	' pasta onde os arquivos serao guardados
   	pasta=Server.MapPath("./upload/"&data&"/")
	
	' pasta + nome dos arquivos
	carquivo = "arquivo" + nome_arquivo
	
	' Grava o arquivo selecionado // permite apenas arquivos .pdf serem enivados
		Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
		
		'cria pasta com a data
		If Not ScriptObject.FolderExists(Server.MapPath("upload/"&data&"/")) Then
		 pasta1 = ScriptObject.CreateFolder(Server.MapPath("upload/"&data&"/") )
		 
		 else
		 
		 pasta1 = Server.MapPath("upload/"&data&"/")
		 
		 End If
		 
		'cria pasta com o cpfgts
		If Not ScriptObject.FolderExists(Server.MapPath("upload/"&data&"/"&cpfgts&"/")) Then
	     pasta2 = ScriptObject.CreateFolder(Server.MapPath("upload/"&data&"/"&cpfgts&"/"))
		 
		 else 
		 
		 pasta2 = Server.MapPath("upload/"&data&"/"&cpfgts&"/")
		 
		 End If	
	
		'cria todos os arquivos selecionados pelo usuário
		for i = 1 to qtd_arquivo
	
			caminho_arquivo = UploadRequest.Item("arquivo"&i).Item("FileName")
			nome_arquivo = Right(caminho_arquivo,Len(caminho_arquivo)-InStrRev(caminho_arquivo,"\"))
			extensao = right(caminho_arquivo,4)
			arquivo = UploadRequest.Item("arquivo"&i).Item("Value")
			
				if ( extensao = ".pdf" or extensao = ".PDF") then
				
	'response.write(nome_arquivo)
	
	'cria o arquivo
	if not ScriptObject.FileExists(pasta2 & "/" & nome_arquivo) then
		Set MyFile = ScriptObject.CreateTextFile(pasta2 & "/" & nome_arquivo)
		For j = 1 to LenB(arquivo)
			MyFile.Write chr(AscB(MidB(arquivo,j,1)))
		Next
		MyFile.Close
		
		Response.Write "Arquivo <strong>'"&nome_arquivo&"'</strong> enviado com sucesso para a pasta '"&pasta2&"\'<p/>"
		
		else 
		Response.Write "Arquivo <strong>'"&nome_arquivo&"'</strong> já existe<p/>"
		
		end if
		
		else
		
		sucesso = false
		
		end if
		
	next
	
	if (sucesso = true) then
	'redireciona para a página inicial informando sucesso
		'Response.Write "Arquivo enviado com sucesso para a pasta '"&pasta2&"'"
		'Response.Redirect("sigep.asp?sucesso=true&cpfgts="&cpfgts&"")
		
	else
		'redireciona para a página inicial informando erro
		Response.Write "Arquivo não era .pdf"
		Response.Redirect("sigep.asp?sucesso=false")
		
	end if
	
%>