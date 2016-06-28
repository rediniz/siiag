<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%
	tipo = request("tipo")
	
	if tipo <> "" then
	
	Select case tipo
	
						'---------------------------------------------------------------------------------------------------------------------------
                        '[AFASTAMENTO]==============================================================================================================	
						'---------------------------------------------------------------------------------------------------------------------------	
					    Case 1 'Afastamento	
							
							%>
                            
                            	<table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field'   id="afastamento_descricao" name="afastamento_descricao" size="60" /></td>
                                </tr>
                                <tr>
                                <td><label>Código Caixa:</label></td>   
                                <td><input type='text' class='form-field'   id="afastamento_co_caixa" name="afastamento_co_caixa" size="5" /></td>
                                </tr>
                                <tr>
                                <td><label>Quantidade de Dias:</label></td>
                                <td><input type='text' class='form-field'   id="afastamento_qt_dias" name="afastamento_qt_dias" size="5" /></td>
                                </tr>
                                <tr>
                                <td><label>Descrição Pendência:</label></td>
                                <td><input type='text' class='form-field'   id="afastamento_de_pendencia" name="afastamento_de_pendencia" size="60"/>  </td>
                                </tr>
                                <tr>
                                <td><label>Pendência</label></td>
                                <td><input type='checkbox'  id="afastamento_pendencia" name="afastamento_pendencia" /></td>
                                </tr>
                                <tr>
                                <td><label>Ativo:</label></td>
                                <td><input type='checkbox'  id="afastamento_ativo" name="afastamento_ativo" /></td>
                                </tr>
   								</table>
                            
                            <%							
						'--------------------------------------------------------------------------------------------------------------------------
                        '[CONTATO]=================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
					    Case 2 'Contato
							%>
                            
                                <table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field'   id="contato_nome" name="contato_nome" size="60" /></td>
                                </tr>
                                <tr>
                                <td><label>Profissional:</label></td>
                                <td><input type='checkbox'  id="contato_profissional" name="contato_profissional" /></td>
                                </tr>
                                <tr>
                                <td><label>Ativo:</label></td>
                                <td><input type='checkbox'   id="contato_ativo" name="contato_ativo" /></td>
                                </tr>                        
                                </tr>
                                </table>
                            
                            <%
						'---------------------------------------------------------------------------------------------------------------------------
                        '[CONTRATAÇÃO]==============================================================================================================	
						'---------------------------------------------------------------------------------------------------------------------------	
					    Case 3 'Contratação
							
							%>
                            	<table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field'   id="contratacao_descricao" name="contratacao_descricao" size="60"  /></td>
                                </tr>
                                </table>
                            <%
					    '--------------------------------------------------------------------------------------------------------------------------
                        '[DIÁRIA]==================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
					    Case 4 'Diária

							%>
                            
                                <table>
                                <tr>
                                <td><label>Descrição:</label></td>
                                <td><input type='text' class='form-field'   id="diaria_descricao" name="diaria_descricao" size="60" /></td>
                                </tr>
                                <tr>
                                <td><label>Observação:</label></td>
                                <td><textarea class='form-field'   id="diaria_observacao" name="diaria_observacao" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px;"></textarea></td>
                                </tr>
                                </table>
     
                            <%
						'--------------------------------------------------------------------------------------------------------------------------
                        '[EMPRÉSTIMO]==============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------					
						Case 5 'Empréstimo
							%>
							<table>
							<tr>
							<td><label>Descrição:</label></td>
							<td><input type='text' class='form-field'   id="emprestimo_descricao" name="emprestimo_descricao" size="60" /></td>
							</tr>
							</table>
                            <%
							
						'--------------------------------------------------------------------------------------------------------------------------
                        '[EVENTO]==================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						Case 6 'Evento
						
							%>
                            <table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="evento_descricao" name="evento_descricao" size="60" /></td>
                            </tr>
                            </table>
                            <%	
						
						'--------------------------------------------------------------------------------------------------------------------------
                        '[RECURSOS]================================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------					
						Case 7 'Recursos	

							%>
                            <table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="recurso_descricao" name="recurso_descricao" size="60" /></td>
                            </tr>
                            <td><label>Quantidade:</label></td>
                            <td><input type='text' class='form-field'   id="recurso_quantidade" name="recurso_quantidade" size="5" /></td>
                            </tr>
                            </table>
                            <%
						
						'--------------------------------------------------------------------------------------------------------------------------
                        '[TRANSPORTE]==============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						Case 8 'Transporte

							%>
                            <table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="transporte_descricao" name="transporte_descricao" size="60" /></td>
                            </tr>
                            </table>
                            <%
						
						'--------------------------------------------------------------------------------------------------------------------------
                        '[TREINAMENTO]=============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						Case 9 'Treinamento							
							%>
                        	<table>
                            <tr>
                            <td><label>Nome:</label></td>
                            <td><input type='text' class='form-field'   id="treinamento_nome" name="treinamento_nome" size="60" /></td>
                            </tr>
                            <tr>
                            <td><label>Código Evento:</label></td>
                            <td><input type='text' class='form-field'   id="treinamento_co_evento" name="treinamento_co_evento" size="2" /></td>
                            </tr>
                            <tr>
                            <td><label>Ativo:</label></td>
                            <td><input type='checkbox'  id="treinamento_ativo" name="treinamento_ativo" /></td>
                            </tr>
                            </table>
                        	<%
						
						'--------------------------------------------------------------------------------------------------------------------------
                        '[LOCAL]=============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						
						Case 10 'Local						
							%>
                        	<table>
                            <tr>
                            <td><label>Descrição:</label></td>
                            <td><input type='text' class='form-field'   id="local_descricao" name="local_descricao" size="60" /></td>
                            </tr>
                            <td><label>Ativo:</label></td>
                            <td><input type='checkbox'  id="local_ativo" name="local_ativo" /></td>
                            </tr>
                            </table>
                        	<%
							
							'--------------------------------------------------------------------------------------------------------------------------
                        '[COORDENAÇÃO]=============================================================================================================	
						'--------------------------------------------------------------------------------------------------------------------------	
						
						Case 11 'Coordenação						
							%>
                        	<table>
                            <tr>
                            <td><label>Nome:</label></td>
                            <td><input type='text' class='form-field'   id="coordenacao_nome" name="coordenacao_nome" size="60" /></td>
                            </tr>
                            <tr>
                            <td><label>Matrícula Gerente:</label></td>
                            <td><input type='text' class='form-field'   id="coordenacao_gerente" name="coordenacao_gerente" size="60" /></td>
                            </tr>
                            <td><label>Ativo:</label></td>
                            <td><input type='checkbox'  id="coordenacao_ativo" name="coordenacao_ativo" /></td>
                            </tr>
                            </table>
                        	<%
						
						Case else
							
		End Select
		
		%>
           
          </p>
         <input  style="margin-top:7px;margin-left:5px;" name="cadastrar" id="cadastrar" class="myButton" type="button" value="Cadastrar"/>       
        <%
	
					
	end if
	

%>