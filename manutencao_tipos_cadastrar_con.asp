<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%
	tipo = request("tipos_cadastrar")
	
	Select case tipo	
						
					    Case 1 'Afastamento	
							de_tipo_afastamento = request("afastamento_descricao")
					
							if request("afastamento_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if
							if request("afastamento_pendencia") = "on" then ic_pendencia = 1 else ic_pendencia = 0 end if
							
					  		query = "INSERT INTO TB_TIPOS_AFASTAMENTO (DE_TIPO_AFASTAMENTO, IC_PENDENCIA, IC_ATIVO"
											
							if request("afastamento_qt_dias") 		<> "" then query = query & ", QT_DIAS " 	 end if
							if request("afastamento_co_caixa") 		<> "" then query = query & ", CO_CAIXA " 	 end if	
							if request("afastamento_de_pendencia") 	<> "" then query = query & ", DE_PENDENCIA " end if	
							
							query = query & ")"	
							
							query = query & " VALUES ('"&de_tipo_afastamento&"', "&ic_pendencia&", "&ic_ativo&""	
							
							if request("afastamento_qt_dias") 		<> "" then query = query & ", "&request("afastamento_qt_dias") 		end if
							if request("afastamento_co_caixa") 		<> "" then query = query & ", "&request("afastamento_co_caixa") 	end if	
							if request("afastamento_de_pendencia") 	<> "" then query = query & ", '"&request("afastamento_de_pendencia")&"'" end if	
							
							query = query & ")"	
							
							objConn.execute(query)
						
					    Case 2 'Contato
							no_tipo = request("contato_nome")					
							if request("contato_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if
							if request("contato_profissional") = "on" then ic_profissional = 1 else ic_profissional = 0 end if
							
					  		query = "INSERT INTO TB_TIPOS_CONTATOS (NO_TIPO,ic_profissional,ic_ativo) VALUES('"&no_tipo&"',"&ic_profissional&","&ic_ativo&")"
							objConn.execute(query)
						
					    Case 3 'Contratação
							de_tipo = request("contratacao_descricao")					
							
					  		query = "INSERT INTO TB_TIPOS_CONTRATACAO (DE_TIPO) VALUES ('"&de_tipo&"')"
							objConn.execute(query)
					  
					    Case 4 'Diária
							de_tipo_diaria = request("diaria_descricao")
							response.write de_tipo_diaria
							de_obs = request("diaria_observacao")					
							
					  		query = "INSERT INTO TB_TIPOS_DIARIA (DE_TIPO_DIARIA, DE_OBS) VALUES ('"&de_tipo_diaria&"', '"&de_obs&"')"
							objConn.execute(query)
						
						Case 5 'Empréstimo
							de_tipo_emprestimo= request("emprestimo_descricao")					
							
					  		query = "INSERT TB_TIPOS_EMPRESTIMO (DE_TIPO_EMPRESTIMO) VALUES ('"&de_tipo_emprestimo&"')"
							objConn.execute(query)
						
						Case 6 'Evento
							de_tipo_evento= request("evento_descricao")					
							
					  		query = "INSERT INTO TB_TIPOS_EVENTO (DE_TIPO_EVENTO) VALUES ('"&de_tipo_evento&"')"
							objConn.execute(query)	
										
						Case 7 'Recursos	
							de_recurso= request("recurso_descricao")		
							qt_recurso= request("recurso_quantidade")				
							
					  		query = "INSERT INTO TB_TIPOS_RECURSOS (DE_TIPO_EVENTO, QT_RECURSO) VALUES  ('"&de_recurso&"', "&qt_recurso&" )"
							objConn.execute(query)	
						
						Case 8 'Transporte
							de_tipo_transporte= request("transporte_descricao")					
							
					  		query = "INSERT INTO TB_TIPOS_TRANSPORTE (DE_TIPO_TRANSPORTE) VALUES ('"&de_tipo_transporte&"')"
							objConn.execute(query)	
						
						Case 9 'Treinamento	
							no_tipo_treinamento= request("treinamento_nome")
							co_tipo_evento = request("treinamento_co_evento")		
							if request("treinamento_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if			
							
					  		query = "INSERT INTO TB_TIPOS_TREINAMENTO (NO_TIPO_TREINAMENTO,IC_ATIVO,CO_TIPO_EVENTO) VALUES ('"&de_tipo_transporte&"',"&ic_ativo&","& co_tipo_evento&") "
							objConn.execute(query)
							
						Case 10 'Local		
							de_local= request("local_descricao")	
							if request("local_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if			
							
					  		query = "INSERT INTO TB_LOCAL (DE_LOCAL,ATIVO) VALUES ('"&de_local&"',"&ic_ativo&") "
							objConn.execute(query)
							
						Case 11 'Coordenação	
							no_gs= request("coordenacao_nome")
							co_gerente = request("coordenacao_gerente")		
							co_substituto = request("coordenacao_substituto")							
							if request("coordenacao_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if	
							co_gs = request("codigo")
							
							queryUpdateGerente = "UPDATE TB_USUARIOS SET IC_GERENTE = 1 WHERE CO_MATRICULA = '" & co_gerente & "'"
							objConn.execute(queryUpdateGerente)
							
							queryUpdateSubstituto = "UPDATE TB_USUARIOS SET IC_GERENTE = 1 WHERE CO_MATRICULA = '" & co_substituto & "'"
							objConn.execute(queryUpdateSubstituto)		
							
					  		query = "INSERT INTO TB_GS (NO_GS,CO_GERENTE, CO_SUBSTITUTO, IC_ATIVO, CO_UNIDADE, CO_MACRO_PROCESSO) VALUES ('"&no_gs&"','"&co_gerente&"','"&co_substituto&"',"&ic_ativo&", '" & request.Cookies("co_usuario_unidade_siiag") & "', 0) "
							objConn.execute(query)
						
						Case else
							
End Select
	

%>