<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%
	response.Expires = 0
	tipo = request("tipo")
	codigo = request("codigo")
	
	if tipo <> "" then
	
	Select case tipo
	
						'---------------------------------------------------------------------------------------------------------------------------
                        '[AFASTAMENTO]==============================================================================================================	
						'---------------------------------------------------------------------------------------------------------------------------	
					    Case 1 'Afastamento	
					  		query = "SELECT * FROM TB_TIPOS_AFASTAMENTO WHERE CO_TIPO_AFASTAMENTO = "&codigo
							resultado = objConn.execute(query)
							
							%>
                            
                            	<table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field bloqueio'   id="afastamento_descricao" name="afastamento_descricao" size="60" value="<%=resultado("DE_TIPO_AFASTAMENTO")%>"/></td>
                                </tr>
                                <tr>
                                <td><label>Código Caixa:</label></td>   
                                <td><input type='text' class='form-field bloqueio'   id="afastamento_co_caixa" name="afastamento_co_caixa" size="5" value="<%=resultado("CO_CAIXA")%>"/></td>
                                </tr>
                                <tr>
                                <td><label>Quantidade de Dias:</label></td>
                                <td><input type='text' class='form-field bloqueio'   id="afastamento_qt_dias" name="afastamento_qt_dias" size="5" value="<%=resultado("QT_DIAS")%>"/></td>
                                </tr>
                                <tr>
                                <td><label>Descrição Pendência:</label></td>
                                <td><input type='text' class='form-field bloqueio'   id="afastamento_de_pendencia" name="afastamento_de_pendencia" size="60" value="<%=resultado("DE_PENDENCIA")%>"/>  </td>
                                </tr>
                                <tr>
                                <td><label>Pendência</label></td>
                                <td><input type='checkbox'  class='bloqueio' <% if resultado("ic_pendencia") = "True" then response.write "checked=checked" end if %> id="afastamento_pendencia" name="afastamento_pendencia" /></td>
                                </tr>
                                <tr>
                                <td><label>Ativo:</label></td>
                                <td><input type='checkbox'  class='bloqueio' <% if resultado("ic_ativo") = "True" then response.write "checked=checked" end if %> id="afastamento_ativo" name="afastamento_ativo" /></td>
                                </tr>
   								</table>
                            
                            <%							
						'--------------------------------------------------------------------------------------------------------------------------
                        '[CONTATO]=================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
					    Case 2 'Contato
							query = "SELECT * FROM TB_TIPOS_CONTATOS WHERE CO_TIPO = "&codigo
							resultado = objConn.execute(query)
							
							%>
                            
                                <table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field'   id="contato_nome" name="contato_nome" size="60" value="<%=resultado("NO_TIPO")%>"/></td>
                                </tr>
                                <tr>
                                <td><label>Profissional:</label></td>
                                <td><input type='checkbox'  <% if resultado("ic_ativo") = "True" then response.write "checked=checked" end if %> id="contato_profissional" name="contato_profissional" /></td>
                                </tr>
                                <tr>
                                <td><label>Ativo:</label></td>
                                <td><input type='checkbox'  <% if resultado("ic_profissional") = "True" then response.write "checked=checked" end if %> id="contato_ativo" name="contato_ativo" /></td>
                                </tr>                        
                                </tr>
                                </table>
                            
                            <%
						'---------------------------------------------------------------------------------------------------------------------------
                        '[CONTRATAÇÃO]==============================================================================================================	
						'---------------------------------------------------------------------------------------------------------------------------	
					    Case 3 'Contratação
							query = "SELECT * FROM TB_TIPOS_CONTRATACAO WHERE CO_TIPO_CONTRATACAO = "&codigo
							resultado = objConn.execute(query)
							
							%>
                            	<table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field'   id="contratacao_descricao" name="contratacao_descricao" size="60" value="<%=resultado("DE_TIPO")%>" /></td>
                                </tr>
                                </table>
                            <%
					    '--------------------------------------------------------------------------------------------------------------------------
                        '[DIÁRIA]==================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
					    Case 4 'Diária
							query = "SELECT * FROM TB_TIPOS_DIARIA WHERE CO_TIPO_DIARIA = "&codigo
							resultado = objConn.execute(query)
							
							%>
                            
                                <table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field'   id="diaria_descricao" name="diaria_descricao" size="60" value="<%=resultado("DE_TIPO_DIARIA")%>"/></td>
                                </tr>
                                <tr>
                                <td><label>Observação:</label></td>
                                <td><textarea class='form-field'   id="diaria_observacao" name="diaria_observacao" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px;"><%=resultado("DE_OBS")%></textarea></td>
                                </tr>
                                </table>
     
                            <%
						'--------------------------------------------------------------------------------------------------------------------------
                        '[EMPRÉSTIMO]==============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------					
						Case 5 'Empréstimo
					  		query = "SELECT * FROM TB_TIPO_EMPRESTIMO WHERE CO_TIPO_EMPRESTIMO = "& codigo
							resultado = objConn.execute(query)
							%>
							<table>
							<tr>
							<td><label>Descrição:</label></td>
							<td><input type='text' class='form-field'   id="emprestimo_descricao" name="emprestimo_descricao" size="60" value="<%=resultado("DE_TIPO_EMPRESTIMO")%>"/></td>
							</tr>
							</table>
                            <%
							
						'--------------------------------------------------------------------------------------------------------------------------
                        '[EVENTO]==================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						Case 6 'Evento
							query = "SELECT * FROM TB_TIPOS_EVENTO WHERE CO_TIPO_EVENTO = "& codigo
							resultado = objConn.execute(query)							
							%>
                            <table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="evento_descricao" name="evento_descricao" size="60" value="<%=resultado("DE_TIPO_EVENTO")%>"/></td>
                            </tr>
                            </table>
                            <%	
						
						'--------------------------------------------------------------------------------------------------------------------------
                        '[RECURSOS]================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------					
						Case 7 'Recursos	
							query = "SELECT * FROM TB_TIPOS_RECURSOS WHERE CO_RECURSO = "& codigo
							resultado = objConn.execute(query)
							%>
                            <table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="recurso_descricao" name="recurso_descricao" size="60" value="<%=resultado("DE_RECURSO")%>"/></td>
                            </tr>
                            <td><label>Quantidade:</label></td>
                            <td><input type='text' class='form-field'   id="recurso_quantidade" name="recurso_quantidade" size="5" value="<%=resultado("QT_RECURSO")%>"/></td>
                            </tr>
                            </table>
                            <%
						
						'--------------------------------------------------------------------------------------------------------------------------
                        '[TRANSPORTE]==============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						Case 8 'Transporte
							query = "SELECT * FROM TB_TIPOS_TRANSPORTE WHERE CO_TIPO_TRANSPORTE = "& codigo
							resultado = objConn.execute(query)
							
							%>
                            <table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="transporte_descricao" name="transporte_descricao" size="60" value="<%=resultado("DE_TIPO_TRANSPORTE")%>"/></td>
                            </tr>
                            </table>
                            <%
						
						'--------------------------------------------------------------------------------------------------------------------------
                        '[TREINAMENTO]=============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						Case 9 'Treinamento							
							query = "SELECT * FROM TB_TIPOS_TREINAMENTO WHERE CO_TIPO_TREINAMENTO = "& codigo
							resultado = objConn.execute(query)
							%>
                        	<table>
                            <tr>
                            <td><label>Nome:</label></td>
                            <td><input type='text' class='form-field'   id="treinamento_nome" name="treinamento_nome" size="60" value="<%=resultado("NO_TIPO_TREINAMENTO")%>"/></td>
                            </tr>
                            <tr>
                            <td><label>Código Evento:</label></td>
                            <td><input type='text' class='form-field'   id="treinamento_co_evento" name="treinamento_co_evento" size="2" value="<%=resultado("CO_TIPO_EVENTO")%>"/></td>
                            </tr>
                            <tr>
                            <td><label>Ativo:</label></td>
                            <td><input type='checkbox'  <% if resultado("ic_ativo") = "True" then response.write "checked=checked" end if %>  id="treinamento_ativo" name="treinamento_ativo" /></td>
                            </tr>
                            </table>
                        	<%
						'--------------------------------------------------------------------------------------------------------------------------
                        '[LOCAL]===================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						
						Case 10 'Local	
							query = "SELECT * FROM TB_LOCAL WHERE CO_LOCAL = "& codigo
							resultado = objConn.execute(query)					
							%>
                        	<table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="local_descricao" name="local_descricao" size="60" value="<%=resultado("DE_LOCAL")%>"/></td>
                            </tr>
                            <td><label>Ativo:</label></td>
                            <td><input type='checkbox'  id="local_ativo" name="local_ativo"  <% if resultado("ativo") = "True" then response.write "checked=checked" end if %>/></td>
                            </tr>
                            </table>
                        	<%
							
						'--------------------------------------------------------------------------------------------------------------------------
                        '[COORDENAÇÃO]=============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						
						Case 11 'Coordenação	
						
							query = "SELECT * FROM VW_GS WHERE CO_GS = "& codigo
							resultado = objConn.execute(query)					
							%>
                        	<table>
                            <tr>
                            <td><label>Nome:</label></td>
                            <td><input type='text' class='form-field'   id="coordenacao_nome" name="coordenacao_nome" size="60" value="<%=resultado("NO_GS")%>"/></td>
                            </tr>
                            <tr>
                            <td><label>Matrícula Coordenador:</label></td>
                            <td><input type='text' class='form-field'   id="coordenacao_gerente" name="coordenacao_gerente" size="10" value="<%=resultado("CO_GERENTE")%>"/><LABEL id="no_coordenador"> - <%=resultado("no_coordenador")%></LABEL></td>
                            </tr>
                            <tr>
                            <td><label>Matrícula Substituto:</label></td>
                            <td><input type='text' class='form-field'   id="coordenacao_substituto" name="coordenacao_substituto" size="10" value="<%=resultado("CO_SUBSTITUTO")%>"/><LABEL id="no_substituto"> - <%=resultado("no_substituto")%></LABEL></td>
                            </tr>

                            <td><label>Ativo:</label></td>
                            <td><input type='checkbox'  id="coordenacao_ativo" name="coordenacao_ativo" <% if resultado("ic_ativo") = "True" then response.write "checked=checked" end if %>/></td>
                            </tr>
                            </table>
                        	<%
						
						Case else
							
		End Select
	
					
	end if
	

%>