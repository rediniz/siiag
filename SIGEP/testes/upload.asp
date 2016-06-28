<html>
	<head> 
		<title> SaFileUp </title>
	</head>
	<body>


		<% 
		
		Dim SaFileUp
		'Instancia o componente
		SET SaFileUp = Server.CreateObject("Scripting.Dictionary") 
		
 
			'Configura o caminho onde arquivo será salvo
				SaFileUp.Path = Server.MapPath("./upload/")
			'SaFileUp.Path = "e:\home\LoginFTP\Web\upload\"
                        'Para Revenda substitua o caminho físico para E:\vhosts\SEU_DOMINIO_COMPLETO\httpdocs\
 
			'Você pode usar também o caminho relativo se preferir
			'SaFileUp.Path = Server.MapPath("./upload/")
 
                        '## ATIVA O TRATAMENTO DE ERRO ##
			'Caso o usuário não indique um arquivo para upload, informa erro.
			If SaFileUp.IsEmpty Then
					response.write "<center>Por favor, indique um arquivo para upload.</center><br>"
			Else
				'Salva o arquivo no servidor
				SaFileUp.Save
				response.write "<center>Total de Bytes Enviados: " & SaFileUp.TotalBytes & "</center>"
			End if
 
			'Gera um link html para retornar a pagina anterior
			response.write "<center><a href='javascript:history.go(-1)'>Voltar</a></center>"
 
		Set SaFileUp = Nothing 
		%>

	</body>
</html>
