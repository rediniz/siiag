<%@LANGUAGE=VBSCRIPT CODEPAGE="1252"%>
<!-- #include file = "Upload_funcoes.asp" -->
<%
	'Chamando Funções, que fazem o Upload funcionar
	byteCount = Request.TotalBytes
	RequestBin = Request.BinaryRead(byteCount)
	Set UploadRequest = CreateObject("Scripting.Dictionary")
	BuildUploadRequest RequestBin

	' "Tipo" do arquivo (entre ata e informativo)
	tipo = UploadRequest.Item("tipo").Item("Value")
	
	' Numero sequencial do arquivo
	numero = UploadRequest.Item("numero").Item("Value")
	numero = right("000"+cstr(numero),3)
	
	' Pega o titulo do informativo
	titulo = UploadRequest.Item("titulo").Item("Value")

	' Data selecionada no formulario
	data = UploadRequest.Item("data").Item("Value")
	data = cdate(data)
	ano = cstr(year(data))
	mes = right("0"+cstr(month(data)),2)
	dia = right("0"+cstr(day(data)),2)
	
	' Extensao de arquivo que esta sendo enviado
	arquivo = UploadRequest.Item("arquivo").Item("ContentType")
	
	' Caminho completo dos arquivos enviados
	caminho_arquivo = UploadRequest.Item("arquivo").Item("FileName")
	
	' Extensao do arquivo
	extensao = right(caminho_arquivo,4)	
	
	' Nome dos arquivos enviados (nome_arquivo e' o nome e a extensao sem o caminho completo)
	nome_arquivo = Right(caminho_arquivo,Len(caminho_arquivo)-InStrRev(caminho_arquivo,"\"))
	nome_bd_arquivo = nome_arquivo
	
	' Conteudo binario dos arquivos enviados
	arquivo = UploadRequest.Item("arquivo").Item("Value")
	
	' pasta onde os arquivos serao guardados
	if ( tipo =  "ata" ) then
			select case ano
				case "2006"
					pasta = Server.MapPath("arquivo/atas/2006/")
				case "2007"
					pasta = Server.MapPath("arquivo/atas/2007/")
				case "2008"
					pasta = Server.MapPath("arquivo/atas/2008/")
				case "2009"
					pasta = Server.MapPath("arquivo/atas/2009/")
				case "2010"
					pasta = Server.MapPath("arquivo/atas/2010/")
				case "2011"
					pasta = Server.MapPath("arquivo/atas/2011/")
				case "2012"
					pasta = Server.MapPath("arquivo/atas/2012/")
				case "2013"
					pasta = Server.MapPath("arquivo/atas/2013/")
				case "2014"
					pasta = Server.MapPath("arquivo/atas/2014/")
				case else
					pasta = Server.MapPath("arquivo/atas/")
			end select
	else if ( tipo = "informativo" ) then
			select case ano
				case "2006"
					pasta = Server.MapPath("arquivo/informativos/2006/")
				case "2007"
					pasta = Server.MapPath("arquivo/informativos/2007/")
				case "2008"
					pasta = Server.MapPath("arquivo/informativos/2008/")
				case "2009"
					pasta = Server.MapPath("arquivo/informativos/2009/")
				case "2010"
					pasta = Server.MapPath("arquivo/informativos/2010/")
				case "2011"
					pasta = Server.MapPath("arquivo/informativos/2011/")
				case "2012"
					pasta = Server.MapPath("arquivo/informativos/2012/")
				case "2013"
					pasta = Server.MapPath("arquivo/informativos/2013/")
				case "2014"
					pasta = Server.MapPath("arquivo/informativos/2014/")
				case else
					pasta = Server.MapPath("arquivo/informativos/")
			end select
		end if
	end if
	
	' Verifica o tipo do arquivo para renomear
	if ( tipo =  "ata" ) then
		nome_arquivo = "\Ata_"+ano+"_"+mes+"_"+dia+right(nome_arquivo,4)
	else if ( tipo = "informativo" ) then
		nome_arquivo = "\Informativo_"+ano+"_"+mes+"_"+dia+"_"+numero+right(nome_arquivo,4)
		end if
	end if
	
	' pasta + nome dos arquivos
	carquivo = "arquivo" + nome_arquivo

	' Salva titulo no banco
	if ( tipo = "informativo" ) then
		set conNT001 = server.CreateObject("adodb.connection")
		conNT001.open "Provider=SQLOLEDB.1;Password=todosce;Persist Security Info=True;User ID=todos;Initial Catalog=Inf_gerencia;Data Source=CE7180SR001"
		set rsTitulo = server.CreateObject("adodb.recordset")
		rsTitulo.open "SELECT * FROM TblInformativos WHERE codigo = '"&numero&"'",conNT001,3,3
		if rsTitulo.eof then
			sql = "INSERT INTO TblInformativos (codigo, titulo) VALUES ('"&numero&"', '"&titulo&"')"
			conNT001.execute sql
		else 'ele sobrescreva na tabela tambem jah que o arquivo eh sobrescrito na pasta! manter a "integridade"
			sql = "UPDATE TblInformativos SET titulo = '"&titulo&"' WHERE codigo = '"&numero&"'" 
			conNT001.execute sql
		end if
		rsTitulo.close
		rsTitulo.open "SELECT * FROM TblDadosRadar WHERE desc_processo = 'GIFUG Informa'",conNT001,3,3
		'atualizando os dados do radar
		if cdate(rsTitulo("data_atualizacao")) < data then
			rsTitulo("data_atualizacao") = data
			rsTitulo("usuario") = Session("matricula")
			rsTitulo.update
		end if
		rsTitulo.close
		conNT001.close
	end if
	
	' Grava o arquivo selecionado // permite apenas arquivos .pdf serem enivados
	if ( extensao = ".pdf" ) then
		Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
		Set MyFile = ScriptObject.CreateTextFile(pasta & nome_arquivo)
		For i = 1 to LenB(arquivo)
			MyFile.Write chr(AscB(MidB(arquivo,i,1)))
		Next
		MyFile.Close
		Response.Redirect("../estrategias.asp?areaMap=deliberacoes&opcao=incluir&msg=ok")
	else
		Response.Redirect("../estrategias.asp?areaMap=deliberacoes&opcao=incluir&msg=nok")
	end if

''	Protótipo do contador automatizado
''	Abortado para manter a integridade dos dados lancados retroativamente
''  local correto eh lah em cima
'	contador = 0
'	if ( tipo = "informativo" ) then
'	if true then
'		Dim objeto, pasta, arquivo
'		Set objeto = CreateObject("Scripting.FileSystemObject")
'		Set pasta = objeto.GetFolder("\\Ce7180nt005\caixanet\Intranet\SINCO2\Estrategias\arquivo\informativos\")
'		anos = ""
'		For Each arquivo IN pasta.Files
'			extensao = ucase(right(arquivo.name, 4))
'			tipo = ucase(left(arquivo.name, 11)) 
'			if extensao = ".PDF" and ucase(tipo) = "INFORMATIVO" then
'					anoAtual = mid(arquivo.name, 13,4)
'					if inStr(1,anos, anoAtual) = 0 then
'						anos = anos &  anoAtual & ","
'					end if
'			end if
'		next
'		anos = left(anos,len(anos) - 1)
'		matriz = split(anos,",")
'		if a = 0 then
'			For Each arquivo IN pasta.Files
'				extensao = ucase(right(arquivo.name, 4))
'				anoAtual = mid(arquivo.name, 13,4)
'				if extensao = ".PDF" and ucase(left(arquivo.name, 11)) = "INFORMATIVO" and ano = "2007" then
'					contador = contador + 1
'				end if
'				if extensao = ".PDF" and ucase(left(arquivo.name, 11)) = "INFORMATIVO" and ano = "2008" then
'					contador = contador + 1
'				end if
'
'			next
'		end if
'	end if
'	contador = contador + 1
'	contador = right ("0" + cstr(contador),2)
'	contador = contador & ""
%> 