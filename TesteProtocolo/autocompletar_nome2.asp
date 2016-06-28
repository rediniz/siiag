<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
	' Parametros de Conexao ao Banco
	SERVIDOR_DO_BANCO = "ce7180nt005"
	NOME_DO_BANCO = "GIFUG"
	USUARIO_DO_BANCO = "todos"
	SENHA_DO_BANCO = "todosce"

	' Conexao com o Banco de dados
	Dim conexao
	Dim coordenacao
	Dim cargo
	Dim output
	
	Set conexao = Server.CreateObject("ADODB.Connection")
	conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 'Efetua a Conexão
	
	valor = Request.QueryString("term")
	
	
	' SQL de pesquisa
	sql = "SELECT * FROM TB_USUARIOS where NO_NOME like '%" & valor & "%' AND IC_ATIVO = 1 ORDER BY NO_NOME;"
	Set query = conexao.execute(sql)
	output = "["
	While Not query.eof
		' Lista o nome
		
				Select case query("CO_GS")
   						Case 0
					  		coordenacao = "GIFUG/FO"
						
					    Case 1
					  		coordenacao = "Arrecadação e Repasse"
						
					    Case 2
					  		coordenacao = "Recuperação de Crédito"
						
					    Case 3
					  		coordenacao = "Cadastro"
					  
					    Case 4
					  		coordenacao = "Pagamento"
						
						Case 5
					  		coordenacao = "Aplicação"
						
						Case 6
					  		coordenacao = "Informações e Apoio à Gestão"	
										
						Case 7
					  		coordenacao = "Gerência"
						
						Case 8
					  		coordenacao = "Ações Judiciais"
						
						Case 9
					  		coordenacao = "Monitoramento e Avaliação da Gestão"
						
						Case 10
					  		coordenacao = "Manutenção"
						
						Case 13
					  		coordenacao = "@GS Padrão"
						
						Case 16
					  		coordenacao = "Relacionamento com Clientes"
						
						Case 17
					  		coordenacao = "CGP"
						
						Case else
							coordenacao = ""
End Select


				Select case query("CO_CARGO")
   						Case 1
					  		cargo = "Gerente de Filial"
						Case 2
					  		cargo = "Coordenador"
						Case 3
					  		cargo = "Administrador"	
						Case 4
					  		cargo = "Assistente Senior"	
						Case 5
					  		cargo = "Assistente Pleno"
						Case 6
					  		cargo = "Assistente Junior"	
						Case 7
					  		cargo = "Auxiliar Operacional"	
					    Case 8
						    cargo = "Técnico Bancário Novo"
						Case 9
						    cargo = "Escriturário"	
						Case 10
						    cargo = "Auxiliar de Serviços Gerais"
						Case 11
						    cargo = "Estagiário"
						Case 12
						    cargo = "Secretário Executivo"
						Case 13
						    cargo = "Adolescente Aprendiz"
						Case 14
						    cargo = "Terceirizado(a)"
																				
						Case else
							cargo = ""
							
	End Select			
		
		'response.write query("NO_NOME")&"|"&query("CO_MATRICULA")&"|"&coordenacao&"|"&cargo&"|"&query("DT_NASCIMENTO")&"|"&query(-"DT_ADMISSAO")&"|"&query("DT_INICIO_GIFUG")&"|"&query("NU_JORNADA")&"|"&query("IC_ATIVO")&"|"&query("IC_GERENTE")&"|"&query("IM_FOTO")&vbCrLf
		
	    output = output & "{""nome"":""" & query("no_nome") & """,""nascimento"":""" & query("dt_nascimento") & """,""value"":""" & query("no_nome") & """},"
		
		query.movenext
		
	Wend
	
	Set query = Nothing
	Set conexao = Nothing
	
	output=Left(output,Len(output)-1)
	output = output & "]"
	response.write output
%>
