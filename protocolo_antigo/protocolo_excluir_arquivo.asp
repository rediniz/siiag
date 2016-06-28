<%@LANGUAGE=VBSCRIPT CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%

		' Parâmetros de Conexao ao Banco
	SERVIDOR_DO_BANCO = "ce7180nt005"
	NOME_DO_BANCO = "SIIAG"
	USUARIO_DO_BANCO = "todos"
	SENHA_DO_BANCO = "todosce"
	
	Dim conexao
	
	' Efetua a Conexão
	Set conexao = Server.CreateObject("ADODB.Connection")
	conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 
	
	arquivo = request("arquivo")
	nome_arquivo = request("nome_arquivo")
	aa_protocolo = request("aa_protocolo")
	cod_tipo = request("cod_tipo")
	url = request("url")

	dim fs
	Set fs=Server.CreateObject("Scripting.FileSystemObject")
	if fs.FileExists(arquivo) then
  		fs.DeleteFile(arquivo)
	end if
	set fs=nothing
	
	sql = "DELETE FROM TB_PROTOCOLO_ARQUIVOS WHERE AA_PROTOCOLO = "&aa_protocolo&" AND CO_TIPO = "&cod_tipo&" AND NO_ARQUIVO = '"&nome_arquivo&"' "
	'response.write sql
	conexao.execute(sql)
  
  	set query = nothing
  	set conexao = nothing

	response.write ("<script language=""javascript""> alert('Arquivo excluído com sucesso.');window.close();</script>")

%>