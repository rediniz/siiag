<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%
	response.expires = 0
	tipo = request("tipo")
	
	if tipo <> "" then
	
	Select case tipo
	
						
					    Case 1 'Afastamento	
					  		query = "SELECT CO_TIPO_AFASTAMENTO, DE_TIPO_AFASTAMENTO FROM TB_TIPOS_AFASTAMENTO ORDER BY DE_TIPO_AFASTAMENTO ASC"							
						
					    Case 2 'Contato
					  		query = "SELECT CO_TIPO, NO_TIPO FROM TB_TIPOS_CONTATOS ORDER BY NO_TIPO ASC"
						
					    Case 3 'Contratação
					  		query = "SELECT CO_TIPO_CONTRATACAO, DE_TIPO FROM TB_TIPOS_CONTRATACAO ORDER BY DE_TIPO ASC"
					  
					    Case 4 'Diária
					  		query = "SELECT CO_TIPO_DIARIA, DE_TIPO_DIARIA FROM TB_TIPOS_DIARIA ORDER BY DE_TIPO_DIARIA ASC"
						
						Case 5 'Empréstimo
					  		query = "SELECT CO_TIPO_EMPRESTIMO, DE_TIPO_EMPRESTIMO FROM TB_TIPO_EMPRESTIMO ORDER BY DE_TIPO_EMPRESTIMO ASC"
						
						Case 6 'Evento
					  		query = "SELECT CO_TIPO_EVENTO, DE_TIPO_EVENTO FROM TB_TIPOS_EVENTO ORDER BY DE_TIPO_EVENTO ASC"	
										
						Case 7 'Recursos	
					  		query = "SELECT CO_RECURSO, DE_RECURSO, QT_RECURSO FROM TB_TIPOS_RECURSOS ORDER BY DE_RECURSO ASC"
						
						Case 8 'Transporte
					  		query = "SELECT CO_TIPO_TRANSPORTE, DE_TIPO_TRANSPORTE FROM TB_TIPOS_TRANSPORTE ORDER BY DE_TIPO_TRANSPORTE ASC"
						
						Case 9 'Treinamento	
					  		query = "SELECT CO_TIPO_TREINAMENTO, NO_TIPO_TREINAMENTO FROM TB_TIPOS_TREINAMENTO ORDER BY NO_TIPO_TREINAMENTO ASC"
							
						Case 10 'Local	
					  		query = "SELECT CO_LOCAL, DE_LOCAL FROM TB_LOCAL ORDER BY DE_LOCAL ASC"
							
						Case 11 'Coordenação	
					  		query = "SELECT CO_GS, NO_GS FROM TB_GS WHERE CO_UNIDADE ="& request.Cookies("co_usuario_unidade_siiag")&" AND IC_ATIVO=1 ORDER BY NO_GS ASC"
						
						Case else
							query = ""
End Select


			if query <> "" then

				set rs=Server.CreateObject("ADODB.RecordSet")
				rs.Open query, dados_sys
				
				do until rs.eof

					response.write "<option value="&rs(0)&">"&rs(1)&"</option>"
					
					rs.movenext
				
				loop
				
			end if
		
					
		end if
	

%>