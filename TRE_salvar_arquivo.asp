<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!--#INCLUDE FILE="clsUpload.asp"-->
<!-- #include file = "Upload_funcoes.asp" -->
<%
	' Cria objeto que gerencia os campos do Form recebido, incluindo os arquivos			
	Set objUpload = new clsUpload

	co_matricula = objUpload("co_matricula").Value
	matricula = request.Cookies("co_usuario_siiag")
	qt_modificada = objUpload("inputAddQtd").Value
	sequencial = objUpload("sequencial").Value	
	
	'response.write qtd_arquivo & "<br>"

		'***** VERIFICA SE TEM ARQUIVO PARA UPLOAD
		' Pega as informações do arquivo
		Set arquivo = objUpload.Fields("arquivo1")
		nome_arquivo = arquivo.FileName 
		extensao =  "."&LCase(arquivo.FileExt)
		tamanho_arquivo = round(arquivo.Length / 1024)
		'response.Write(i) & " é valor do i. <br>"
		'response.write nome_arquivo & "<BR>"
		
		
		if nome_arquivo <> "" then	
			Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
					
			pastaData = "//CE7180NT005/Aplicativos/Programas/SIIAG_WEB/arquivos/TRE/"
			' Salva o arquivo na pasta
			'arquivo.SaveAs(Server.MapPath("Relatorios Protocolo/") & "\" & arquivo.FileName)
			If Not ScriptObject.FolderExists("//CE7180NT005/Aplicativos/Programas/SIIAG_WEB/arquivos/TRE/" & co_matricula ) Then
				pasta = ScriptObject.CreateFolder("//CE7180NT005/Aplicativos/Programas/SIIAG_WEB/arquivos/TRE/"& co_matricula)
			Else
				pasta = "//CE7180NT005/Aplicativos/Programas/SIIAG_WEB/arquivos/TRE/"& co_matricula
			End If
			
			pasta = replace(pasta,"/","\")
			endereco_arquivo =  pasta & "\" & arquivo.FileName
			arquivo.SaveAs(pasta & "\" & arquivo.FileName)


			if sequencial = "" then				
				' Insere as informações no banco
				sql3 = "INSERT INTO TB_TRE_HISTORICO (CO_MATRICULA, CO_USUARIO_OPERACAO, DT_OPERACAO, TP_OPERACAO,QT_MODIFICADA, SALDO_ANTERIOR, SALDO_ESTOQUE, ARQUIVO, ARQUIVO_EXTENSAO) VALUES ('"&	co_matricula&"','" & matricula & "','" &now()& "',1," & qt_modificada & ",0,0,'" & endereco_arquivo & "','" & extensao & "')"

			else
				sql3 = "UPDATE A SET ARQUIVO = '" & endereco_arquivo & "', ARQUIVO_EXTENSAO = '" & extensao & "' FROM TB_TRE_HISTORICO WHERE SEQUENCIAL = " & sequencial & ""
			end if

			'response.write sql3
			Set query3 = objConn.execute(sql3)


		else
			' Insere as informações no banco
			sql3 = "INSERT INTO TB_TRE_HISTORICO (CO_MATRICULA, CO_USUARIO_OPERACAO, DT_OPERACAO, TP_OPERACAO,QT_MODIFICADA, SALDO_ANTERIOR, SALDO_ESTOQUE) VALUES ('"&	co_matricula&"','" & matricula & "','" &now()& "',1," & qt_modificada & ",0,0)"
			'response.write sql3
			Set query3 = objConn.execute(sql3)
		
		end if

		sql = "EXECUTE sp_atualiza_saldo_TRE '" & co_matricula & "'" 
		'response.write sql 
		objConn.execute(sql)
	
	if objConn.errors.count = 0 THEN
		Response.Write "<script>"
		Response.Write "alert('Inclusão realizada com sucesso!');"
		Response.Write "window.location.assign('tre_edicao.asp?co_usuario="& co_matricula &"');"
		Response.Write "</script>"

	ELSE
		Response.Write "<script>"
		Response.Write "alert('Erro na inclusão.');"
		'Response.Write "window.location.assign('demanda_manter_arquivos.asp?demanda="& co_demanda &"');"
		Response.Write "</script>"
	END IF
		
%>	