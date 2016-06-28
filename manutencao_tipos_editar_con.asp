<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%
	tipo = request("tipo")
	
	Select case tipo
							
					    Case 1 'Afastamento	
							codigo = request("codigo")
							response.write codigo
							 de_tipo_afastamento = request("afastamento_descricao")
							 response.write de_tipo_afastamento
					
							if request("afastamento_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if
							if request("afastamento_pendencia") = "on" then ic_pendencia = 1 else ic_pendencia = 0 end if
							
					  		query = "UPDATE TB_TIPOS_AFASTAMENTO SET DE_TIPO_AFASTAMENTO = '"&de_tipo_afastamento&"', ic_pendencia = "&ic_pendencia&", ic_ativo = "&ic_ativo&" "
														
							if request("afastamento_qt_dias") <> "" then query = query & ", QT_DIAS = "&request("afastamento_qt_dias") end if							
							if request("afastamento_co_caixa") <> "" then query = query & ", CO_CAIXA = "&request("afastamento_co_caixa") end if						
							if request("afastamento_de_pendencia") <> "" then query = query & ", DE_PENDENCIA = '"&request("afastamento_de_pendencia")&"'" end if
							
							query = query & " where co_tipo_afastamento = "&codigo
							objConn.execute(query)
						
					    Case 2 'Contato
					  		codigo = request("codigo")
							no_tipo = request("contato_nome")					
							if request("contato_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if
							if request("contato_profissional") = "on" then ic_profissional = 1 else ic_profissional = 0 end if
							
					  		query = "UPDATE TB_TIPOS_CONTATOS SET NO_TIPO = '"&no_tipo&"', ic_profissional = "&ic_profissional&", ic_ativo = "&ic_ativo&" where co_tipo = "&codigo
							objConn.execute(query)
						
					    Case 3 'Contratação
					  		codigo = request("codigo")
							de_tipo = request("contratacao_descricao")					
							
					  		query = "UPDATE TB_TIPOS_CONTRATACAO SET DE_TIPO = '"& de_tipo &"' where co_tipo_contratacao = "&codigo
							objConn.execute(query)
					  
					    Case 4 'Diária
					  		codigo = request("codigo")
							de_tipo_diaria = request("diaria_descricao")	
							de_obs = request("diaria_observacao")					
							
					  		query = "UPDATE TB_TIPOS_DIARIA SET DE_TIPO_DIARIA = '"& de_tipo_diaria &"', DE_OBS = '"&de_obs&"' where co_tipo_diaria = "&codigo
							objConn.execute(query)
						
						Case 5 'Empréstimo
					  		codigo = request("codigo")
							de_tipo_emprestimo= request("emprestimo_descricao")					
							
					  		query = "UPDATE TB_TIPOS_EMPRESTIMO SET DE_TIPO_EMPRESTIMO = '"& de_tipo_emprestimo &"' where co_tipo_emprestimo = "&codigo
							objConn.execute(query)
						
						Case 6 'Evento
					  		codigo = request("codigo")
							de_tipo_evento= request("evento_descricao")					
							
					  		query = "UPDATE TB_TIPOS_EVENTO SET DE_TIPO_EVENTO = '"& de_tipo_evento &"' where co_tipo_evento = " & codigo
							objConn.execute(query)	
										
						Case 7 'Recursos	
					  		codigo = request("codigo")
							de_recurso= request("recurso_descricao")		
							qt_recurso= request("recurso_quantidade")				
							
					  		query = "UPDATE TB_TIPOS_RECURSOS SET DE_TIPO_EVENTO = '"& de_recurso &"', QT_RECURSO = "&qt_recurso&" where co_recurso = "&codigo
							objConn.execute(query)	
						
						Case 8 'Transporte
					  		codigo = request("codigo")
							de_tipo_transporte= request("transporte_descricao")					
							
					  		query = "UPDATE TB_TIPOS_TRANSPORTE SET DE_TIPO_TRANSPORTE = '"& de_tipo_transporte &"' where co_tipo_transporte = "&codigo
							objConn.execute(query)	
						
						Case 9 'Treinamento	
					  		codigo = request("codigo")
							no_tipo_treinamento= request("treinamento_nome")
							co_tipo_evento = request("treinamento_co_evento")		
							if request("treinamento_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if			
							
					  		query = "UPDATE TB_TIPOS_TREINAMENTO SET NO_TIPO_TREINAMENTO = '"&de_tipo_transporte&"', IC_ATIVO = "&ic_ativo&", CO_TIPO_EVENTO = "& co_tipo_evento&" where co_tipo_treinamento = "&codigo
							objConn.execute(query)	
							
						Case 10 'Local		
							de_local= request("local_descricao")	
							if request("local_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if			
							
					  		query = "INSERT INTO TB_LOCAL (DE_LOCAL,ATIVO) VALUES ('"&de_local&"',"&ic_ativo&") "
							objConn.execute(query)
							
						Case 11 'Coordenação	
							no_gs 			= request("coordenacao_nome")
							co_gerente  	= request("coordenacao_gerente")	
							co_substituto   = request("coordenacao_substituto")
							
							co_gs = request("codigo")
			
							if request("coordenacao_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if			
													
					  		queryZeraIC = "UPDATE TB_USUARIOS SET IC_GERENTE = 0 WHERE CO_GS = " & co_gs & " AND CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "'"
							response.write queryZeraIC 
							objConn.execute(queryZeraIC)
							
							queryUpdateGerente = "UPDATE TB_USUARIOS SET IC_GERENTE = 1 WHERE CO_MATRICULA = '" & co_gerente & "' AND CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "'"
							response.write queryUpdateGerente 						
							objConn.execute(queryUpdateGerente)
							
							queryUpdateSubstituto = "UPDATE TB_USUARIOS SET IC_GERENTE = 1 WHERE CO_MATRICULA = '" & co_substituto & "' AND CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "'"
							response.write queryUpdateSubstituto
							objConn.execute(queryUpdateSubstituto)
							
							query = "UPDATE TB_GS SET NO_GS = '"&no_gs&"', CO_GERENTE = '"&co_gerente&"', CO_SUBSTITUTO = '"&co_substituto&"', IC_ATIVO = "&ic_ativo&" WHERE CO_GS = " & co_gs &" AND CO_UNIDADE  = '" & request.Cookies("co_usuario_unidade_siiag") & "'"

							objConn.execute(query)
							response.write query
						Case else							
End Select
	
%>