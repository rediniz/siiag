<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<%
	response.Expires = 0
	Dim coordenacao
	Dim cargo
	Dim output
	
	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("9")
	'Verifica_Perfil "1"  ' Verifica se o usuário tem o perfil 1 - Admin Sistema e grava o resultado na variavel eh_perfil
	
	'Set conexao = Server.CreateObject("ADODB.Connection")
	'conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 'Efetua a Conex�o

	'response.write matricula
	valor = Request.QueryString("term")

	'if  not (request.Cookies("usuario_admin_siiag") or (request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = matricula )) then
	'	valor = request.Cookies("co_usuario_siiag")
	'end if
	'if eh_perfil then
	'	sql = "SELECT * FROM VW_USUARIOS where CO_MATRICULA like '" & valor & "%' AND IC_ATIVO = 1  ORDER BY CO_MATRICULA;"
	'else	
		if  not (perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = matricula ) or (not perfil_acesso_admin_siiag and not request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = matricula) then
			valor = request.Cookies("co_usuario_siiag")
			
			' SQL de pesquisa
			sql = "SELECT * FROM VW_USUARIOS where CO_MATRICULA like '" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY CO_MATRICULA;"
	
		'elseif request.Cookies("ic_gerente_siiag") and not perfil_acesso_admin_siiag  then
			' SQL de pesquisa
		'	sql = "SELECT * FROM VW_USUARIOS where CO_MATRICULA like '" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' AND CO_GS = '" & request.Cookies("co_usuario_gs_siiag") & "' ORDER BY CO_MATRICULA;"
		elseif perfil_acesso_admin_siiag then	

			if request.Cookies("co_usuario_co_visao") = "2" then
					sql = "SELECT * FROM VW_USUARIOS where CO_MATRICULA like '" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' AND CO_GS = '" & request.Cookies("co_usuario_gs_siiag") & "' ORDER BY CO_MATRICULA;"
			elseif request.Cookies("co_usuario_co_visao") = "3" then
				sql = "SELECT * FROM VW_USUARIOS where CO_MATRICULA like '" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY CO_MATRICULA;"
			end if

		end if	
	'end if	
	' SQL de pesquisa
	'sql = "SELECT * FROM TB_USUARIOS where CO_MATRICULA like '" & valor & "%' AND IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY CO_MATRICULA;"


	Set query = objConn.execute(sql)
		output = "["
	While Not query.eof
		' Lista o nome	
		
				'Select case query("CO_GS")
   				'		Case 0
				'	  		coordenacao = "GIFUG/FO"						
				'	    Case 1
				'	  		coordenacao = "Arrecadação e Repasse"
				'	    Case 2
				'	  		coordenacao = "Recuperação de Crédito"						
				'	    Case 3
				'	  		coordenacao = "Cadastro"					  
				'	    Case 4
				'	  		coordenacao = "Pagamento"					
				'		Case 5
				'	  		coordenacao = "Aplicação"					
				'		Case 6
				'	  		coordenacao = "Informações e Apoio à Gestão"										
				'		Case 7
				'	  		coordenacao = "Gerência"					
				'		Case 8
				'	  		coordenacao = "Ações Judiciais"						
				'		Case 9
				'	  		coordenacao = "Monitoramento e Avaliação da Gestão"						
				'		Case 10
				'	  		coordenacao = "Manutenção"						
				'		Case 13
				'	  		coordenacao = "@GS Padrão"					
				'		Case 16
				'	  		coordenacao = "Relacionamento com Clientes"					
				'		Case 17
				'	  		coordenacao = "CGP"						
				'		Case else
				'			coordenacao = ""
				'End Select
				coordenacao = query("CO_GS")
				cargo = query("CO_CARGO")

				'Select case query("CO_CARGO")
   				'		Case 1
				'	  		cargo = "Gerente de Filial"
				'		Case 2
				'	  		cargo = "Coordenador"
				'		Case 3
				'	  		cargo = "Administrador"	
				'		Case 4
				'	  		cargo = "Assistente Senior"	
				'		Case 5
				'	  		cargo = "Assistente Pleno"
				'		Case 6
				'	  		cargo = "Assistente Junior"	
				'		Case 7
				'	  		cargo = "Auxiliar Operacional"	
				'	    Case 8
				'		    cargo = "Técnico Bancário Novo"
				'		Case 9
				'		    cargo = "Escriturário"	
				'		Case 10
				'		    cargo = "Auxiliar de Serviços Gerais"
				'		Case 11
				'		    cargo = "Estagiário"
				'		Case 12
				'		    cargo = "Secretário Executivo"
				'		Case 13
				'		    cargo = "Adolescente Aprendiz"
				'		Case 14
				'		    cargo = "Terceirizado(a)"														
				'		Case else
				'			cargo = ""
							
				'End Select					
			
		 output = output & "{""nome"":""" & ucase(query("no_nome")) & """,""matricula"":""" & query("co_matricula") & """,""value"":""" & query("co_matricula") & """,""dt_nascimento"":""" & query("dt_nascimento") & """,""dt_admissao"":""" & query("dt_admissao") & """,""dt_inicio"":""" & query("DT_INICIO_GIFUG") & """,""nu_jornada"":""" & query("NU_JORNADA") & """,""coordenacao"":""" & coordenacao & """,""cargo"":""" & cargo & """,""foto"":""" & query("im_foto") & """,""ic_ativo"":""" & query("ic_ativo") & """,""ic_gerente"":""" & query("ic_gerente") & """,""nao_aniver"":""" & query("ic_nao_exibir_aniv") & """,""co_unidade"":""" & query("co_unidade") & """,""sg_unidade"":""" & query("sg_unidade") & """,""digito"":""" & query("co_digito") & """,""sexo"":""" & query("sexo") & """},"
		 
		 'output = output & "{""nome"":""" & query("no_nome") & """,""matricula"":""" & query("co_matricula") & """,""value"":""" & query("co_matricula") & """},"
																
		'response.write query("CO_MATRICULA")&"|"&query("NO_NOME")&"|"&coordenacao&"|"&cargo&"|"&query("DT_NASCIMENTO")&"|"&query("DT_ADMISSAO")&"|"&query("DT_INICIO_GIFUG")&"|"&query("NU_JORNADA")&"|"&query("IC_ATIVO")&"|"&query("IC_GERENTE")&"|"&query("IM_FOTO")&vbCrLf
		query.movenext
	Wend
	
	Set query = 	Nothing
	
	output=Left(output,Len(output)-1)
	output = output & "]"
	response.write output
%>
