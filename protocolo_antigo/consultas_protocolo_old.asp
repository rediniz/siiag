 <%
	
	 tipoProtocolo = Request("tipoProtocolo")
	 areaProtocolo = Request("areaProtocolo")
	 diaInicial = Request("diaInicial")
	 dataInicial = Request("dataInicial")
	 dataFinal=Request("dataFinal")
	 mesFinal = Request("mesFinal")
	 numeroOficio = Request("numeroOficio")
	 
'	 todos = Request("todos")
	
	 
	
	 
	
	 
	 Response.Write "<br/>"
	 'Response.Write "Teste 1 "
	 
	 
	 
	
	 
	 
	 
	 
	 'consulta apenas por Tipo, Area e Numero do Protocolo
	if tipoProtocolo <> "" AND areaProtocolo <> "" AND numeroOficio <> ""   Then 
	 	
				
	'Response.Write "Teste 2 "			
				
						Query ="select * from TB_PROTOCOLO WHERE (DH_ENVIO BETWEEN '" &dataInicial& "' AND '" &dataFinal& "') AND (CO_TIPO = " &tipoProtocolo& ") AND (CO_AREA = " &areaProtocolo& ") AND (NO_PROTOCOLO = " &numeroOficio& " )" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set PC=Server.CreateObject("ADODB.RecordSet")
                        PC.Open Query, dados_sys
										 
										 
                        
                        	If PC.eof Then
							
							Response.Write "<p>N&atilde;o h&aacute; protocolos registrados com essas informa&ccedil;&otilde;es</p>"
							
							else
							
							
							
									Response.Write "<table>"
									Response.Write "<tr>"
									Response.Write "<td width='1%'>N&uacute;mero</td>"
									Response.Write " <td width='5%' >Tipo</td>"
									Response.Write "<td width='7%'>&Aacute;rea</td>"
									Response.Write "<td width='7%'>Data</td>"
									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
									Response.Write "<td width='15%'>Conte&uacute;do</td>"
									Response.Write "<td width='12%'>Destino</td>"
									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
									  
									Response.Write "</tr>"
									
										
							
                            DO UNTIL PC.eof
							
                            codigoTipoProtocolo=PC("CO_TIPO")
							
                           	AAProtocolo=PC("AA_PROTOCOLO")
							
							nomeResponsavel=PC("NO_RESPONSAVEL")
							
							conteudo=PC("DE_CONTEUDO")
							
							destino=PC("DE_DESTINO")
							
							dataEnvio=PC("DH_ENVIO")

							codigoArea=PC("CO_AREA")
							
							codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
							
							numeroOficio = PC("NO_PROTOCOLO")
							
							
									ConsultaSecundaria ="select DE_TIPO from TB_PROTOCOLO_TIPO WHERE CO_TIPO="&codigoTipoProtocolo&"" 
                       				 set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CS=Server.CreateObject("ADODB.RecordSet")
                        			CS.Open ConsultaSecundaria, dados_sys
									
									nomeTipoProtocolo = CS("DE_TIPO")
									
									
									ConsultaSecundariaDois ="select NO_AREA from TB_PROTOCOLO_AREAS WHERE CO_AREA="&codigoArea&"" 
                       				set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CSD=Server.CreateObject("ADODB.RecordSet")
                        			CSD.Open ConsultaSecundariaDois, dados_sys
									
									nomeCodigoArea = CSD("NO_AREA")
							
							
							
							
							
							'Response.Write "<p>"& codigoTipoProtocolo   &"</p>"
							'Response.Write "<p>"& AAProtocolo   &"</p>"
							'Response.Write "<p>"& nomeResponsavel   &"</p>"
							'Response.Write "<p>"& conteudo  &"</p>"
							'Response.Write "<p>"& destino   &"</p>"
							'Response.Write "<p>"& codigoArea   &"</p>"
							'Response.Write "<p>-------------------------</p>"
							
							
							response.write "<tr>"
							
							response.write "<td id='numOficio' value="&numeroOficio&">" & numeroOficio & "</td>"
							response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
							response.write "<td>" & nomeTipoProtocolo & "</td>"
							
							response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
							response.write "<td>" & nomeCodigoArea & "</td>"
							response.write "<td>" & dataEnvio & "</td>"
							response.write "<td>" & nomeResponsavel & "</td>"
							response.write "<td>" & conteudo & "</td>"
							response.write "<td>" & destino & "</td>"
							response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
							response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
							response.write "</tr>"
		
							PC.movenext
							
							LOOP
						Response.Write "</table>"
						CSD.Close
						CS.Close
						PC.Close	
	 	
	 
	 
	 
	 
	 
	 End If
	 
	 
	'Consulta so por Tipo de Protocolo 
	ELSE if tipoProtocolo <> "" AND areaProtocolo = "" AND numeroOficio = ""  Then 
	 	
				
	'Response.Write "Teste 2 "			
				
						Query ="select * from TB_PROTOCOLO WHERE CO_TIPO="&tipoProtocolo&"" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set PC=Server.CreateObject("ADODB.RecordSet")
                        PC.Open Query, dados_sys
										 
                        
                        	If PC.eof Then
							
							Response.Write "<p>N&atilde;o h&aacute; protocolos registrados com essas informa&ccedil;&otilde;es</p>"
							
							else
							
									Response.Write "<table>"
									Response.Write "<tr>"
									Response.Write "<td width='1%'>N&uacute;mero</td>"
									Response.Write " <td width='5%' >Tipo</td>"
									Response.Write "<td width='7%'>&Aacute;rea</td>"
									Response.Write "<td width='7%'>Data</td>"
									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
									Response.Write "<td width='15%'>Conte&uacute;do</td>"
									Response.Write "<td width='12%'>Destino</td>"
									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
									  
									Response.Write "</tr>"
									
										
							
                            DO UNTIL PC.eof
							
                            codigoTipoProtocolo=PC("CO_TIPO")
							
                           	AAProtocolo=PC("AA_PROTOCOLO")
							
							nomeResponsavel=PC("NO_RESPONSAVEL")
							
							conteudo=PC("DE_CONTEUDO")
							
							destino=PC("DE_DESTINO")
							
							dataEnvio=PC("DH_ENVIO")

							codigoArea=PC("CO_AREA")
							
							codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
							
							numeroOficio = PC("NO_PROTOCOLO")
							
							
									ConsultaSecundaria ="select DE_TIPO from TB_PROTOCOLO_TIPO WHERE CO_TIPO="&codigoTipoProtocolo&"" 
                       				 set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CS=Server.CreateObject("ADODB.RecordSet")
                        			CS.Open ConsultaSecundaria, dados_sys
									
									nomeTipoProtocolo = CS("DE_TIPO")
									
									
									ConsultaSecundariaDois ="select NO_AREA from TB_PROTOCOLO_AREAS WHERE CO_AREA="&codigoArea&"" 
                       				set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CSD=Server.CreateObject("ADODB.RecordSet")
                        			CSD.Open ConsultaSecundariaDois, dados_sys
									
									nomeCodigoArea = CSD("NO_AREA")
							
							
							
							
							
							'Response.Write "<p>"& codigoTipoProtocolo   &"</p>"
							'Response.Write "<p>"& AAProtocolo   &"</p>"
							'Response.Write "<p>"& nomeResponsavel   &"</p>"
							'Response.Write "<p>"& conteudo  &"</p>"
							'Response.Write "<p>"& destino   &"</p>"
							'Response.Write "<p>"& codigoArea   &"</p>"
							'Response.Write "<p>-------------------------</p>"
							
							
							response.write "<tr>"
							
							
							
							response.write "<td id='numOficio' value="&numeroOficio&">" & numeroOficio & "</td>"
							response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
							response.write "<td>" & nomeTipoProtocolo & "</td>"
							
							response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
							response.write "<td>" & nomeCodigoArea & "</td>"
							response.write "<td>" & dataEnvio & "</td>"
							response.write "<td>" & nomeResponsavel & "</td>"
							response.write "<td>" & conteudo & "</td>"
							response.write "<td>" & destino & "</td>"
							response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
							response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
							response.write "</tr>"
		
							PC.movenext
							
							LOOP
						Response.Write "</table>"
						CSD.Close
						CS.Close
						PC.Close	
	 	
	 	
	 
	 
	 
	 
	 
	 
	 End If 'end if do pc.eof
	 
	 END If 'end if do condicional
	 
	 
	 END If
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 'consulta por Tipo e Area do Protocolo
	 if tipoProtocolo <> "" AND areaProtocolo <> "" AND numeroOficio = ""  Then 
	 	
				
	'Response.Write "Teste 2 "			
				
						Query ="select * from TB_PROTOCOLO WHERE CO_TIPO="&tipoProtocolo&" AND CO_AREA="&areaProtocolo&"" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set PC=Server.CreateObject("ADODB.RecordSet")
                        PC.Open Query, dados_sys
										 
                        
                        	If PC.eof Then
							
							Response.Write "<p>N&atilde;o h&aacute; protocolos registrados com essas informa&ccedil;&otilde;es</p>"
							
							else
							
									Response.Write "<table>"
									Response.Write "<tr>"
									Response.Write "<td width='1%'>N&uacute;mero</td>"
									Response.Write " <td width='5%' >Tipo</td>"
									Response.Write "<td width='7%'>&Aacute;rea</td>"
									Response.Write "<td width='7%'>Data</td>"
									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
									Response.Write "<td width='15%'>Conte&uacute;do</td>"
									Response.Write "<td width='12%'>Destino</td>"
									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
									  
									Response.Write "</tr>"
									
										
							
                            DO UNTIL PC.eof
							
                            codigoTipoProtocolo=PC("CO_TIPO")
							
                           	AAProtocolo=PC("AA_PROTOCOLO")
							
							nomeResponsavel=PC("NO_RESPONSAVEL")
							
							conteudo=PC("DE_CONTEUDO")
							
							destino=PC("DE_DESTINO")
							
							dataEnvio=PC("DH_ENVIO")

							codigoArea=PC("CO_AREA")
							
							codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
							
							numeroOficio = PC("NO_PROTOCOLO")
							
							
									ConsultaSecundaria ="select DE_TIPO from TB_PROTOCOLO_TIPO WHERE CO_TIPO="&codigoTipoProtocolo&"" 
                       				 set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CS=Server.CreateObject("ADODB.RecordSet")
                        			CS.Open ConsultaSecundaria, dados_sys
									
									nomeTipoProtocolo = CS("DE_TIPO")
									
									
									ConsultaSecundariaDois ="select NO_AREA from TB_PROTOCOLO_AREAS WHERE CO_AREA="&codigoArea&"" 
                       				set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CSD=Server.CreateObject("ADODB.RecordSet")
                        			CSD.Open ConsultaSecundariaDois, dados_sys
									
									nomeCodigoArea = CSD("NO_AREA")
							
							
							
							
							
							'Response.Write "<p>"& codigoTipoProtocolo   &"</p>"
							'Response.Write "<p>"& AAProtocolo   &"</p>"
							'Response.Write "<p>"& nomeResponsavel   &"</p>"
							'Response.Write "<p>"& conteudo  &"</p>"
							'Response.Write "<p>"& destino   &"</p>"
							'Response.Write "<p>"& codigoArea   &"</p>"
							'Response.Write "<p>-------------------------</p>"
							
							
							response.write "<tr>"
							
							
							
							response.write "<td id='numOficio' value="&numeroOficio&">" & numeroOficio & "</td>"
							response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
							response.write "<td>" & nomeTipoProtocolo & "</td>"
							
							response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
							response.write "<td>" & nomeCodigoArea & "</td>"
							response.write "<td>" & dataEnvio & "</td>"
							response.write "<td>" & nomeResponsavel & "</td>"
							response.write "<td>" & conteudo & "</td>"
							response.write "<td>" & destino & "</td>"
							response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
							response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
							response.write "</tr>"
		
							PC.movenext
							
							LOOP
						Response.Write "</table>"
						CSD.Close
						CS.Close
						PC.Close	
	 		
	 	
	 
	 
	 
	 
	 
	 
	 End If 'end if do pc.eof
	 
	 END If 'end if do condicional
	 
	 
	 
	 
	 
	 'consulta apenas por numeroOficio
	 if tipoProtocolo = "" AND areaProtocolo = "" AND numeroOficio <> ""  Then 
	 	
				
	'Response.Write "Teste 2 "			
				
						Query ="select * from TB_PROTOCOLO WHERE NO_PROTOCOLO="&numeroOficio&"" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set PC=Server.CreateObject("ADODB.RecordSet")
                        PC.Open Query, dados_sys
										 
                        
                        	If PC.eof Then
							
							Response.Write "<p>N&atilde;o h&aacute; protocolos registrados com essas informa&ccedil;&otilde;es</p>"
							
							else
							
									Response.Write "<table>"
									Response.Write "<tr>"
									Response.Write "<td width='1%'>N&uacute;mero</td>"
									Response.Write " <td width='5%' >Tipo</td>"
									Response.Write "<td width='7%'>&Aacute;rea</td>"
									Response.Write "<td width='7%'>Data</td>"
									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
									Response.Write "<td width='15%'>Conte&uacute;do</td>"
									Response.Write "<td width='12%'>Destino</td>"
									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
									  
									Response.Write "</tr>"
									
										
							
                            DO UNTIL PC.eof
							
                            codigoTipoProtocolo=PC("CO_TIPO")
							
                           	AAProtocolo=PC("AA_PROTOCOLO")
							
							nomeResponsavel=PC("NO_RESPONSAVEL")
							
							conteudo=PC("DE_CONTEUDO")
							
							destino=PC("DE_DESTINO")
							
							dataEnvio=PC("DH_ENVIO")

							codigoArea=PC("CO_AREA")
							
							codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
							
							numeroOficio = PC("NO_PROTOCOLO")
							
							
									ConsultaSecundaria ="select DE_TIPO from TB_PROTOCOLO_TIPO WHERE CO_TIPO="&codigoTipoProtocolo&"" 
                       				 set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CS=Server.CreateObject("ADODB.RecordSet")
                        			CS.Open ConsultaSecundaria, dados_sys
									
									nomeTipoProtocolo = CS("DE_TIPO")
									
									
									ConsultaSecundariaDois ="select NO_AREA from TB_PROTOCOLO_AREAS WHERE CO_AREA="&codigoArea&"" 
                       				set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CSD=Server.CreateObject("ADODB.RecordSet")
                        			CSD.Open ConsultaSecundariaDois, dados_sys
									
									nomeCodigoArea = CSD("NO_AREA")
							
							
							
							
							
							'Response.Write "<p>"& codigoTipoProtocolo   &"</p>"
							'Response.Write "<p>"& AAProtocolo   &"</p>"
							'Response.Write "<p>"& nomeResponsavel   &"</p>"
							'Response.Write "<p>"& conteudo  &"</p>"
							'Response.Write "<p>"& destino   &"</p>"
							'Response.Write "<p>"& codigoArea   &"</p>"
							'Response.Write "<p>-------------------------</p>"
							
							
							response.write "<tr>"
							
							
							
							response.write "<td id='numOficio' value="&numeroOficio&">" & numeroOficio & "</td>"
							response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
							response.write "<td>" & nomeTipoProtocolo & "</td>"
							
							response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
							response.write "<td>" & nomeCodigoArea & "</td>"
							response.write "<td>" & dataEnvio & "</td>"
							response.write "<td>" & nomeResponsavel & "</td>"
							response.write "<td>" & conteudo & "</td>"
							response.write "<td>" & destino & "</td>"
							response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
							response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
							response.write "</tr>"
		
							PC.movenext
							
							LOOP
						Response.Write "</table>"
						CSD.Close
						CS.Close
						PC.Close	
	 		
	 	
	 
	 
	 
	 
	 
	 
	 End If 'end if do pc.eof
	 
	 END If 'end if do condicional
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 if tipoProtocolo = "" AND areaProtocolo <> "" AND numeroOficio <> ""  Then 
	 	
				
	'Response.Write "Teste 2 "			
				
						Query ="select * from TB_PROTOCOLO WHERE CO_AREA="&areaProtocolo&" AND NO_PROTOCOLO="&numeroOficio&"" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set PC=Server.CreateObject("ADODB.RecordSet")
                        PC.Open Query, dados_sys
										 
                        
                        	If PC.eof Then
							
							Response.Write "<p>N&atilde;o h&aacute; protocolos registrados com essas informa&ccedil;&otilde;es</p>"
							
							else
							
									Response.Write "<table>"
									Response.Write "<tr>"
									Response.Write "<td width='1%'>N&uacute;mero</td>"
									Response.Write " <td width='5%' >Tipo</td>"
									Response.Write "<td width='7%'>&Aacute;rea</td>"
									Response.Write "<td width='7%'>Data</td>"
									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
									Response.Write "<td width='15%'>Conte&uacute;do</td>"
									Response.Write "<td width='12%'>Destino</td>"
									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
									  
									Response.Write "</tr>"
									
										
							
                            DO UNTIL PC.eof
							
                            codigoTipoProtocolo=PC("CO_TIPO")
							
                           	AAProtocolo=PC("AA_PROTOCOLO")
							
							nomeResponsavel=PC("NO_RESPONSAVEL")
							
							conteudo=PC("DE_CONTEUDO")
							
							destino=PC("DE_DESTINO")
							
							dataEnvio=PC("DH_ENVIO")

							codigoArea=PC("CO_AREA")
							
							codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
							
							numeroOficio = PC("NO_PROTOCOLO")
							
							
							
									ConsultaSecundaria ="select DE_TIPO from TB_PROTOCOLO_TIPO WHERE CO_TIPO="&codigoTipoProtocolo&"" 
                       				 set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CS=Server.CreateObject("ADODB.RecordSet")
                        			CS.Open ConsultaSecundaria, dados_sys
									
									nomeTipoProtocolo = CS("DE_TIPO")
									
									
									ConsultaSecundariaDois ="select NO_AREA from TB_PROTOCOLO_AREAS WHERE CO_AREA="&codigoArea&"" 
                       				set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CSD=Server.CreateObject("ADODB.RecordSet")
                        			CSD.Open ConsultaSecundariaDois, dados_sys
									
									nomeCodigoArea = CSD("NO_AREA")
							
							
							
							
							
							'Response.Write "<p>"& codigoTipoProtocolo   &"</p>"
							'Response.Write "<p>"& AAProtocolo   &"</p>"
							'Response.Write "<p>"& nomeResponsavel   &"</p>"
							'Response.Write "<p>"& conteudo  &"</p>"
							'Response.Write "<p>"& destino   &"</p>"
							'Response.Write "<p>"& codigoArea   &"</p>"
							'Response.Write "<p>-------------------------</p>"
							
							
							response.write "<tr>"
							
							
							
							response.write "<td id='numOficio' value="&numeroOficio&">" & numeroOficio & "</td>"
							response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
							response.write "<td>" & nomeTipoProtocolo & "</td>"
							
							response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
							response.write "<td>" & nomeCodigoArea & "</td>"
							response.write "<td>" & dataEnvio & "</td>"
							response.write "<td>" & nomeResponsavel & "</td>"
							response.write "<td>" & conteudo & "</td>"
							response.write "<td>" & destino & "</td>"
							response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
							response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
							response.write "</tr>"
		
							PC.movenext
							
							LOOP
						Response.Write "</table>"
						CSD.Close
						CS.Close
						PC.Close	
	 		
	 	
	 
	 
	 
	 
	 
	 
	 End If 'end if do pc.eof
	 
	 END If 'end if do condicional
	 
	 
	 
	 
	 
	 
	 
	 if tipoProtocolo = "" AND areaProtocolo <> "" AND numeroOficio = ""  Then 
	 	
				
	'Response.Write "Teste 2 "			
				
						Query ="select * from TB_PROTOCOLO WHERE CO_AREA="&areaProtocolo&"" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set PC=Server.CreateObject("ADODB.RecordSet")
                        PC.Open Query, dados_sys
										 
                        
                        	If PC.eof Then
							
							Response.Write "<p>N&atilde;o h&aacute; protocolos registrados com essas informa&ccedil;&otilde;es</p>"
							
							else
							
									Response.Write "<table>"
									Response.Write "<tr>"
									Response.Write "<td width='1%'>N&uacute;mero</td>"
									Response.Write " <td width='5%' >Tipo</td>"
									Response.Write "<td width='7%'>&Aacute;rea</td>"
									Response.Write "<td width='7%'>Data</td>"
									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
									Response.Write "<td width='15%'>Conte&uacute;do</td>"
									Response.Write "<td width='12%'>Destino</td>"
									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
									  
									Response.Write "</tr>"
									
										
							
                            DO UNTIL PC.eof
							
                            codigoTipoProtocolo=PC("CO_TIPO")
							
                           	AAProtocolo=PC("AA_PROTOCOLO")
							
							nomeResponsavel=PC("NO_RESPONSAVEL")
							
							conteudo=PC("DE_CONTEUDO")
							
							destino=PC("DE_DESTINO")
							
							dataEnvio=PC("DH_ENVIO")

							codigoArea=PC("CO_AREA")
							
							codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
							
							numeroOficio = PC("NO_PROTOCOLO")
							
							
									ConsultaSecundaria ="select DE_TIPO from TB_PROTOCOLO_TIPO WHERE CO_TIPO="&codigoTipoProtocolo&"" 
                       				 set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CS=Server.CreateObject("ADODB.RecordSet")
                        			CS.Open ConsultaSecundaria, dados_sys
									
									nomeTipoProtocolo = CS("DE_TIPO")
									
									
									ConsultaSecundariaDois ="select NO_AREA from TB_PROTOCOLO_AREAS WHERE CO_AREA="&codigoArea&"" 
                       				set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CSD=Server.CreateObject("ADODB.RecordSet")
                        			CSD.Open ConsultaSecundariaDois, dados_sys
									
									nomeCodigoArea = CSD("NO_AREA")
							
							
							
							
							
							'Response.Write "<p>"& codigoTipoProtocolo   &"</p>"
							'Response.Write "<p>"& AAProtocolo   &"</p>"
							'Response.Write "<p>"& nomeResponsavel   &"</p>"
							'Response.Write "<p>"& conteudo  &"</p>"
							'Response.Write "<p>"& destino   &"</p>"
							'Response.Write "<p>"& codigoArea   &"</p>"
							'Response.Write "<p>-------------------------</p>"
							
							
							response.write "<tr>"
							
							response.write "<td id='numOficio' value="&numeroOficio&">" & numeroOficio & "</td>"
							response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
							response.write "<td>" & nomeTipoProtocolo & "</td>"
							
							response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
							response.write "<td>" & nomeCodigoArea & "</td>"
							response.write "<td>" & dataEnvio & "</td>"
							response.write "<td>" & nomeResponsavel & "</td>"
							response.write "<td>" & conteudo & "</td>"
							response.write "<td>" & destino & "</td>"
							response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
							response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
							response.write "</tr>"
		
							PC.movenext
							
							LOOP
						Response.Write "</table>"
						CSD.Close
						CS.Close
						PC.Close	
	 		
	 	
	 
	 
	 
	 
	 
	 
	 End If 'end if do pc.eof
	 
	 END If 'end if do condicional
	 
	 
	 
	 
	  if tipoProtocolo = "" AND areaProtocolo = "" AND numeroOficio = "" AND dataInicial <> "" AND dataFinal <> ""  Then 
	 	
				
	'Response.Write "Teste 2 "			
				
						Query ="select * from TB_PROTOCOLO WHERE DH_ENVIO BETWEEN "&dataInicial&" AND "&dataFinal&"" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set PC=Server.CreateObject("ADODB.RecordSet")
                        PC.Open Query, dados_sys
										 
                        
                        	If PC.eof Then
							
							Response.Write "<p>N&atilde;o h&aacute; protocolos registrados com essas informa&ccedil;&otilde;es</p>"
							
							else
							
									Response.Write "<table>"
									Response.Write "<tr>"
									Response.Write "<td width='1%'>N&uacute;mero</td>"
									Response.Write " <td width='5%' >Tipo</td>"
									Response.Write "<td width='7%'>&Aacute;rea</td>"
									Response.Write "<td width='7%'>Data</td>"
									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
									Response.Write "<td width='15%'>Conte&uacute;do</td>"
									Response.Write "<td width='12%'>Destino</td>"
									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
									  
									Response.Write "</tr>"
									
										
							
                            DO UNTIL PC.eof
							
                            codigoTipoProtocolo=PC("CO_TIPO")
							
                           	AAProtocolo=PC("AA_PROTOCOLO")
							
							nomeResponsavel=PC("NO_RESPONSAVEL")
							
							conteudo=PC("DE_CONTEUDO")
							
							destino=PC("DE_DESTINO")
							
							dataEnvio=PC("DH_ENVIO")

							codigoArea=PC("CO_AREA")
							
							codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
							
							numeroOficio = PC("NO_PROTOCOLO")
							
							
							
									ConsultaSecundaria ="select DE_TIPO from TB_PROTOCOLO_TIPO WHERE CO_TIPO="&codigoTipoProtocolo&"" 
                       				 set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CS=Server.CreateObject("ADODB.RecordSet")
                        			CS.Open ConsultaSecundaria, dados_sys
									
									nomeTipoProtocolo = CS("DE_TIPO")
									
									
									ConsultaSecundariaDois ="select NO_AREA from TB_PROTOCOLO_AREAS WHERE CO_AREA="&codigoArea&"" 
                       				set objConn = server.CreateObject("ADODB.Connection") 
                        			dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        			objConn.open dados_sys
                        			set CSD=Server.CreateObject("ADODB.RecordSet")
                        			CSD.Open ConsultaSecundariaDois, dados_sys
									
									nomeCodigoArea = CSD("NO_AREA")
							
							
							
							
							
							'Response.Write "<p>"& codigoTipoProtocolo   &"</p>"
							'Response.Write "<p>"& AAProtocolo   &"</p>"
							'Response.Write "<p>"& nomeResponsavel   &"</p>"
							'Response.Write "<p>"& conteudo  &"</p>"
							'Response.Write "<p>"& destino   &"</p>"
							'Response.Write "<p>"& codigoArea   &"</p>"
							'Response.Write "<p>-------------------------</p>"
							
							
							response.write "<tr>"
							
							response.write "<td id='numOficio' value="&numeroOficio&">" & numeroOficio & "</td>"
							response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
							response.write "<td>" & nomeTipoProtocolo & "</td>"
							
							response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
							response.write "<td>" & nomeCodigoArea & "</td>"
							response.write "<td>" & dataEnvio & "</td>"
							response.write "<td>" & nomeResponsavel & "</td>"
							response.write "<td>" & conteudo & "</td>"
							response.write "<td>" & destino & "</td>"
							response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
							response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
							response.write "</tr>"
		
							PC.movenext
							
							LOOP
						Response.Write "</table>"
						CSD.Close
						CS.Close
						PC.Close	
	 		
	 	
	 
	 
	 
	 
	 
	 
	 End If 'end if do pc.eof
	 
	 END If 'end if do condicional
	 
	 
	 
	 
	  

	 
'	 
'	 if todos <> "" Then
'	 
'						Query ="select * from TB_PROTOCOLO" 
'                        set objConn = server.CreateObject("ADODB.Connection") 
'                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
'                        objConn.open dados_sys
'                        set PC=Server.CreateObject("ADODB.RecordSet")
'                        PC.Open Query, dados_sys
'								
'								
'									Response.Write "<table>"
'									Response.Write "<tr>"
'									Response.Write "<td width='1%'>N&uacute;mero</td>"
'									Response.Write " <td width='5%' >Tipo</td>"
'									Response.Write "<td width='7%'>&Aacute;rea</td>"
'									Response.Write "<td width='7%'>Data</td>"
'									Response.Write "<td width='10%'>Respons&aacute;vel</td>"
'									Response.Write "<td width='15%'>Conte&uacute;do</td>"
'									Response.Write "<td width='12%'>Destino</td>"
'									Response.Write "<td width='5%'>Edi&ccedil;&atilde;o</td>"
'									Response.Write "<td width='5%'>Exclus&atilde;o</td>"
'									  
'									Response.Write "</tr>"				 
'                        
'						
'						
'										DO UNTIL PC.eof
'										
'											codigoTipoProtocolo=PC("CO_TIPO")
'											
'											numeroOficio = PC("NO_PROTOCOLO")
'										
'											'AAProtocolo=PC("AA_PROTOCOLO")
'										
'											nomeResponsavel=PC("NO_RESPONSAVEL")
'										
'											conteudo=PC("DE_CONTEUDO")
'										
'											destino=PC("DE_DESTINO")
'										
'											'dataEnvio=PC("DH_ENVIO")
'										
'											codigoArea=PC("CO_AREA")
'										
'											'codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
'						
'						
'						
'						
'						
'						
'											response.write "<tr>"
''											
'											response.write "<td>" & numeroOficio & "</td>"
'											response.write "<td>" & codigoTipoProtocolo & "</td>"
''											'response.write "<td>" & nomeTipoProtocolo & "</td>"
'''											
''											response.write "<td>" & codigoArea & "</td>"
''											'response.write "<td>" & nomeCodigoArea & "</td>"
''											response.write "<td>" & dataEnvio & "</td>"
''											response.write "<td>" & nomeResponsavel & "</td>"
''											response.write "<td>" & conteudo & "</td>"
''											response.write "<td>" & destino & "</td>"
''											response.write "<td width='5%'><img id=''  src='imagens/edit.png' style='cursor:pointer'></td>"
''											response.write "<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
'											response.write "</tr>"
'						
'                        PC.movenext
'										LOOP
'						Response.Write "</table>"
'						PC.Close	
'	 		
'	 	
'	 
'	 
'	 
'	 
'	 
'	 
'	 End If 'end if do pc.eof
'	 
	
	 	
	
	
	
	%>