<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>DundasUpload(Dundas.Upload.2) - Locaweb</title>
        <script language="JavaScript"> 
 function verifica_arquivo()
  { 
   if (document.upload.arquivo.value=="") 
     { 
      alert("Informe um arquivo para upload !") 
      document.upload.arquivo.focus() 
      return false 
     }
  } 
</script> 
	</head>
	<body>
		<center>
			<h1>Upload de arquivos via DundasUpload(Dundas.Upload.2)</h1>
 
			<form action="" method="post" enctype="multipart/form-data" name='upload' onSubmit="return verifica_arquivo()">
				Arquivo:  <input type="file" name="arquivo" size="60"><br>
				<input type='submit' value='Enviar'>
			</form>
 
			<a href='dundasupload.zip'>Donwload do Exemplo</a>
			<br>
			<a href='http://www.google.com.br/search?hl=pt-BR&q=Tutorial+Dundas+Upload&btnG=Pesquisa+Google&meta=' target='blank'>Mais informações sobre o Dundas Upload</a><br>
 
		</center>
		<hr>
		<%
		'Declara as variaveis utilizadas no script
		'DundasUpload, upload, caminho
 
		If Request.QueryString("upload") = "sim" Then
 
			'Define as variaveis a serem utilizadas no script
			Dim DundasUpload, caminho, nomeArquivo, tamanho, contentType
 
			'Determina o tempo máximo de execução do script em segundos
			Server.ScriptTimeOut = 90
 
			'Define o caminho onde o arquivo sera salvo. Exemplo: "e:\home\loginFtp\web\caminhoDaSuaAplicacao"
			caminho = Server.MapPath(".\upload\")
 
			'Instancia o objeto na memória
			Set DundasUpload = server.CreateObject("Dundas.Upload.2")
			
			
 
				'Determina o tamanho máximo do arquivo a ser carregado
				'DundasUpload.MaxFileSize = 1048576
 
				'Formata o nome do arquivo
				DundasUpload.UseUniqueNames = false
 
				'Salva o arquivo no local especificado
				DundasUpload.Save caminho
 
				'Obtem o nome do arquivo carregado
				nomeArquivo = DundasUpload.Files(0).OriginalPath
 
				'Obtem o tamanho do arquivo carregado
				tamanho = DundasUpload.Files(0).Size
 
				'Obtem o tipo de arquivo/Content-Type
				contentType = DundasUpload.Files(0).ContentType
		%>	
			<center>
				<h2><font color="blue">Upload realizado com sucesso.</font></h2>
				<table border='1'>
					<th>Arquivo</th> <th>Tamanho/Kbytes</th> <th>Content-Type</th>
					<tr>
						<td><a href="./upload/<%=nomeArquivo%>" target="blank"><%=nomeArquivo%></a></td>
						<td><%=tamanho%></td>
						<td><%=contentType%></td>
					</tr>
				</table>
		<%		'Remove a instancia do componente da memória
				Set DundasUpload = Nothing
		End if
		%>
 
			</center>
	</body>
</html>