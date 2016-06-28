<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	Dim coordenacao
	Dim cargo
	Dim output
	
	'Set conexao = Server.CreateObject("ADODB.Connection")
	'conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 'Efetua a Conexão
%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<% 
	response.Expires = 0

	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("9")
	
	valor = Request.QueryString("term")

	'valor = Replace(Request.QueryString("q"),"'","") 'Valor que vem como parâmetro 
	modulo = Replace(Request.QueryString("m"),"'","") 'Valor que vem como parâmetro 
	

		'if  Eh_Perfil_Verificado("1") then
		'	sql = "SELECT * FROM VW_USUARIOS where NO_NOME like '%" & valor & "%' AND IC_ATIVO = 1 ORDER BY NO_NOME;"
		'else
			if  not (perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = matricula ) or (NOT perfil_acesso_admin_siiag and not request.Cookies("ic_gerente_siiag") and request.Cookies("co_usuario_siiag") = matricula) or request.Cookies("co_usuario_co_visao") = "1" then
				valor = request.Cookies("co_usuario_siiag")
				sql = "SELECT * FROM VW_USUARIOS where CO_MATRICULA like '%" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY NO_NOME;"
			elseif perfil_acesso_admin_siiag then	
				if request.Cookies("co_usuario_co_visao") = "2" then
					sql = "SELECT * FROM VW_USUARIOS where NO_NOME like '%" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' AND CO_GS = '" & request.Cookies("co_usuario_gs_siiag") & "' ORDER BY NO_NOME;"
				elseif request.Cookies("co_usuario_co_visao") = "3" then
					sql = "SELECT * FROM VW_USUARIOS where NO_NOME like '%" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY NO_NOME;"
				end if
			
			end if
		'end if
	'response.write "sql:" & sql
	Set query = objConn.execute(sql)
		output = "["
	While Not query.eof
		' Lista o nome
				coordenacao =  query("CO_GS")
				cargo = query("CO_CARGO")
				output = output & "{""nome"":""" & ucase(query("no_nome")) & """,""matricula"":""" & query("co_matricula") & """,""value"":""" & ucase(query("no_nome")) & """,""dt_nascimento"":""" & query("dt_nascimento") & """,""dt_admissao"":""" & query("dt_admissao") & """,""dt_inicio"":""" & query("DT_INICIO_GIFUG") & """,""nu_jornada"":""" & query("NU_JORNADA") & """,""coordenacao"":""" & coordenacao & """,""cargo"":""" & cargo & """,""foto"":""" & query("im_foto") & """,""ic_ativo"":""" & query("ic_ativo") & """,""ic_gerente"":""" & query("ic_gerente") & """,""nao_aniver"":""" & query("ic_nao_exibir_aniv") & """,""co_unidade"":""" & query("co_unidade") & """,""sg_unidade"":""" & query("sg_unidade") & """,""digito"":""" & query("co_digito") & """,""sexo"":""" & query("sexo") & """},"
		query.movenext
	Wend
	
	Set query = 	Nothing
	
	output=Left(output,Len(output)-1)
	output = output & "]"
	response.write output
%>
