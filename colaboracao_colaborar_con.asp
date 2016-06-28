<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE = "include/conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%	
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"

	acao = request("acao")
	
	select case acao
		
		case "colaborar"
			colaborar()
		
		case else
	
	end select
		
	'==================================[COLABORAR]================================================
	
	sub colaborar()
	
		indicado   		= request("indicado")
		quantidadeHoras = request("quantidadeHoras")
		pedido			= request("pedido")
		
		queryColaborar = "insert into tb_colaboracao(indicado, quantidade_horas, pedido) values ('"&indicado&"', "&quantidadeHoras&","&pedido&")"
		queryStatusPedido = "update tb_colaboracao_pedido set status = 2 where id = "&pedido&""
		
		objConn.execute(queryColaborar)
		objConn.execute(queryStatusPedido)
		
		'enviarEmailCoordenacao()
	
	end sub
	
	sub enviarEmailCoordenacao()
	
		matriculaUsuario = session("v_Usuario_Matricula")

		vTexto = "<body>" &_
				"<font size ='2' face='Verdana'>" &_
				"<p align='center'><b>Empregado indicado para colaboração</b></p>" &_
				"<p>Favor contatar a coordenação Informações e Apoio à Gestão para confirmar a viabilidade do gozo de férias no período solicitado.</p>" &_
				"<p>Atenciosamente,<br /><br />Informações e Apoio à Gestão</p>" &_
				"</font>" &_
				"</body>" &_
				"</html>"
				
		sqlEmailCoordenacao = "SELECT EMAIL_COORDENACAO FROM TB_USUARIOS u, TB_GS c WHERE u.co_gs = c.co_gs and u.co_matricula = '"&matriculaUsuario&"'"
		emailCoordenacao = objConn.execute(sqlEmailCoordenacao)("EMAIL_COORDENACAO") 
		
		if err.number<>0 then
			response.write("Erro: " & err.description & "<br")
			response.end	
		else
			if err.number<>0 then
				response.write("Erro: " & err.description & "<br>")
				response.end
			else
				vDe =  "gifugfo@mail.caixa"
				vPara = emailCoordenacao
				vCC ="gifugfo01@mail.caixa;" & matriculaUsuario & "@mail.caixa;"
				vCCO = "C124937@mail.caixa;C054423@mail.caixa;C097105@mail.caixa"
				vAssunto = "GIFUG Colaborativa - Empregado indicado para colaboração"
				vUsuario = matricula
			
				email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
			end if
		end if
	end sub	
%>