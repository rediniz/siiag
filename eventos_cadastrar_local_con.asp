<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->					
                            
                    <%        
                            de_local= request("local_descricao")	
							co_unidade = request.Cookies("co_usuario_unidade_siiag")
							
							if request("local_ativo") = "on" then ic_ativo = 1 else ic_ativo = 0 end if			
							
							
					  		query = "INSERT INTO TB_LOCAL (DE_LOCAL,ATIVO, CO_UNIDADE) VALUES ('"&de_local&"',"&ic_ativo&", '"&co_unidade&"') "
							objConn.execute(query)


			response.write ("<script language=""javascript""> alert('Local cadastrado com sucesso'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
			response.write ("<script language=""javascript""> window.close(); </script>")
							
							
					%>		