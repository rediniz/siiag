<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
	acao = request("acao")
	coordenacao = request("coordenacao")
	
	select case acao
	
		case "salvarEmail"
			email = request("email")
			rh = request("rh")
			call salvarEmail(email, rh)
		case "setarRH"
			flagRH = request("flagRH")
			call setarRH(flagRH)
	
	end select
	
	sub salvarEmail(email, rh)
		querySalvarEmail = "UPDATE TB_GS SET EMAIL_COORDENACAO = '"&email&"', RH = "&rh&" WHERE CO_GS = "&coordenacao&""
		objConn.execute(querySalvarEmail)
		
	end sub
	
	sub setarRH(flagRH)

		querySetarRH = "UPDATE TB_GS SET RH = "&flagRH&" WHERE CO_GS = "&coordenacao&""
		objConn.execute(querySetarRH)	
		
	end sub 

%>