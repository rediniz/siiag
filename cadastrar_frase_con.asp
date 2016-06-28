<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->					
                            
             <%        
                            de_frases =  request("frase_descricao")	
							de_autor = request("autor")
							co_unidade = request.Cookies("co_usuario_unidade_siiag")
							Response.Write(de_frases)
						    Response.Write(de_autor)
							Response.Write(co_unidade)
								
							
					  		query = "INSERT INTO TB_FRASES (DE_FRASE, NO_AUTOR, CO_UNIDADE) VALUES ('"&de_frases&"', '"&de_autor&"', '"&co_unidade&"')"
							objConn.execute(query)


			response.write ("<script language=""javascript""> alert('Frase cadastrada com sucesso'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
			response.write ("<script language=""javascript""> window.close(); </script>")
							
							
			%>		