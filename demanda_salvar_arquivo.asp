<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!--#INCLUDE FILE="clsUpload.asp"-->
<!-- #include file = "Upload_funcoes.asp" -->
<%
	' Cria objeto que gerencia os campos do Form recebido, incluindo os arquivos			
	Set objUpload = new clsUpload

	co_demanda = objUpload("co_demanda_arq").Value
	qtd_arquivo =  objUpload("qtd_arquivo").Value
	matricula = request.Cookies("co_usuario_siiag")
	
	'response.write qtd_arquivo & "<br>"
	for i=1 to qtd_arquivo
		'***** VERIFICA SE TEM ARQUIVO PARA UPLOAD
		' Pega as informações do arquivo
		Set arquivo = objUpload.Fields("arquivo"&i)
		nome_arquivo = arquivo.FileName 
		extensao =  "."&LCase(arquivo.FileExt)
		tamanho_arquivo = round(arquivo.Length / 1024)
		'response.Write(i) & " é valor do i. <br>"
		'response.write nome_arquivo & "<BR>"
		
		if nome_arquivo <> "" then	
			Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
					
			pastaData = "//ce7180nt005/Aplicativos/Programas/Relatório Protocolo"
			' Salva o arquivo na pasta
			'arquivo.SaveAs(Server.MapPath("Relatorios Protocolo/") & "\" & arquivo.FileName)
			If Not ScriptObject.FolderExists("//CE7180NT005/Aplicativos/Programas/Demandas_TI/arquivos_hom/"& co_demanda &"/") Then
				pasta = ScriptObject.CreateFolder("//CE7180NT005/Aplicativos/Programas/Demandas_TI/arquivos_hom/"& co_demanda &"/")
			Else
				pasta = "//CE7180NT005/Aplicativos/Programas/Demandas_TI/arquivos_hom/"& co_demanda &"/"
			End If
			
			endereco_arquivo =  pasta & "\" & arquivo.FileName
			arquivo.SaveAs(pasta & "\" & arquivo.FileName)
				
			' Insere as informações no banco
			sql3 = "INSERT INTO TB_DEMANDAS_ARQUIVOS (CO_DEMANDA,CO_MATRICULA,DT_INCLUSAO,NO_ARQUIVO,ENDERECO_ARQUIVO) VALUES ("&	co_demanda&",'" & matricula & "','" &date()& "','" & nome_arquivo & "','" & endereco_arquivo & "')"
			'response.write sql3
			Set query3 = objConn.execute(sql3)
		end if
		'*******************
	next
	
	
	if objConn.errors.count = 0 THEN
		Response.Write "<script>"
		Response.Write "alert('Arquivo enviado com sucesso!');"
		Response.Write "parent.location.assign('demanda_manter.asp?demanda="& co_demanda &"','_blank');"
		Response.Write "</script>"

	ELSE
		Response.Write "<script>"
		Response.Write "alert('Não foi possível enviar o arquivo.');"
		Response.Write "window.location.assign('demanda_manter.asp?demanda="& co_demanda &"');"
		Response.Write "</script>"
	END IF
		
%>	