<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	' Conexao com o Banco de dados
	Dim conexao
	Dim coordenacao
	Dim cargo

%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
	' SQL de pesquisa
	matricula = request("matricula")
	sql = "SELECT * FROM VW_USUARIOS where CO_MATRICULA = '" & matricula & "';"
	'response.Write(sql)
	
	Set query = objConn.execute(sql)
	'response.Write(query("co_matricula"))
	
	if not query.eof then
	output =  "[{""nome"":""" & ucase(query("no_nome")) & """,""matricula"":""" & query("co_matricula") & """,""value"":""" & query("co_matricula") & """,""dt_nascimento"":""" & query("dt_nascimento") & """,""dt_admissao"":""" & query("dt_admissao") & """,""dt_inicio"":""" & query("DT_INICIO_GIFUG") & """,""nu_jornada"":""" & query("NU_JORNADA") & """,""coordenacao"":""" & coordenacao & """,""cargo"":""" & cargo & """,""foto"":""" & query("im_foto") & """,""ic_ativo"":""" & query("ic_ativo") & """,""ic_gerente"":""" & query("ic_gerente") & """,""nao_aniver"":""" & query("ic_nao_exibir_aniv") & """,""co_unidade"":""" & query("co_unidade") & """,""sg_unidade"":""" & query("sg_unidade") & """,""digito"":""" & query("co_digito") & """},]"
		response.write output
	end if
	
	Set query = 	Nothing
	set objConn = nothing
%>
