<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE = "include/conexao.asp" -->
<!-- #INCLUDE FILE = "include/upload/clsUpload.asp" -->
<!-- #INCLUDE FILE = "include/f_Usuario.asp" -->
<%	
	
	tipo = request.Cookies("co_usuario_unidade_siiag")
	usuario = request.Cookies("co_usuario_siiag")
	co_unidade 	= request.Cookies("co_usuario_unidade_siiag")
	
	matricula = request("matricula")
	nome = request("nome")
	data_inicio = request("data_inicio")
	data_fim = request("data_fim")
	tipo_afast = request("tipo_afastamento")
	
	qtdHorasAcompanhamento = request("quantidadeHoras")

	data = day(date()) & "/" & month(date()) & "/" & year(date())
	
	'data = "26/01/2016"
	
	SQL = "SELECT CO_GS FROM VW_USUARIOS WHERE NO_NOME = '" & nome & "'"
	'response.write SQL
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open SQL, dados_sys, 3, ,32
	if rs.eof then
		co_gs = ""
	else 
		co_gs = rs("CO_GS")
	end if
			
	SQL = "INSERT INTO TB_AFASTAMENTOS (co_unidade, co_matricula, co_tipo_afastamento, dt_inicio, dt_fim, co_situacao, de_obs, dh_criacao, co_criador, co_gs, co_criador_final, QTD_HORAS_ACOMPANHAMENTO) VALUES(" & co_unidade & ",'" & matricula & "'," & tipo_afast & ",'" & data_inicio & "','" & data_fim & "',1,'','" & data & "','" & usuario & "'," & co_gs & ", NULL, "&qtdHorasAcompanhamento&")"
	
	response.write SQL
	
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open SQL, dados_sys, 3, ,32
	
	co_afastamento = objConn.execute("SELECT TOP 1 CO_AFASTAMENTO FROM TB_AFASTAMENTOS ORDER BY CO_AFASTAMENTO DESC")("co_afastamento")
	
	'ENVIO DE DOCUMENTO
	Set upload = New clsUpload
	
	For i = 0 To upload.Count - 1
		if upload(i).name = "documento" then
			nomeArquivo = upload(i).FileName
			
			'response.write nomeArquivo
			
			'pasta = Server.MapPath("upload/afastamento") & "\"
			pasta = "//ce7180nt005/Atestados/arquivos" & "\"
			
			caminhoCompleto = pasta & nomeArquivo
			
			upload(i).SaveAs caminhoCompleto
			
			sqlnovo = "INSERT INTO TB_AFASTAMENTOS_DOCUMENTOS (CO_AFASTAMENTO, CO_TIPO, CAMINHO, DT_INCLUSAO, MT_INCLUSAO) VALUES ("&co_afastamento&", "&tipo_afast&", '"&caminhoCompleto&"', '"&data&"', '"&usuario&"')"
			
			'response.write sqlnovo	
			objConn.execute(sqlnovo)
		end if
		
	next
%>