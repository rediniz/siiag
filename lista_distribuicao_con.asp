<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
	response.Expires = 0
	tipo = request("tipo")
	matricula = Session("v_Usuario_Matricula")
	Response.Write co_unidade
		'CAPTURAR CO_GS DA PESSOA LOGADA
		consultaGS =  "SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '" &matricula& "' " 
			set gs = Server.CreateObject("ADODB.RecordSet")
			gs.Open consultaGS, dados_sys, 3, , 32
			co_gs = gs("CO_GS")
	  


	dim lista 
	
	'Empregados da GIFUG/FO
	If tipo = 1 Then
		
consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE LEFT(CO_MATRICULA, 1) = 'C' AND IC_ATIVO = 1 AND CO_MATRICULA <> 'Z000002' AND CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_NOME"

		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			
			Response.Write "Lista vazia."
			
		Else
			
			Do While Not rs.eof
				
				lista = lista & rs("CO_MATRICULA")  & ";"
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
		
	'Estagiários da GIFUG/FO
	Elseif tipo = 2 Then
		
		consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE LEFT(CO_MATRICULA, 1) IN ('E', 'M') AND IC_ATIVO = 1 AND CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_NOME"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				lista = lista & rs("CO_MATRICULA") & ";"'& "@correiolivre.caixa; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
		
	'Todos da GIFUG/FO
	Elseif tipo = 3 Then
		
		consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE IC_ATIVO = 1 AND CO_MATRICULA <> 'Z000002' AND CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY CO_MATRICULA, NO_NOME"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				matricula = rs("CO_MATRICULA")
				tipoUsuario =  UCase(Left(matricula, 1))
				
				If tipoUsuario = "C" Then
					
					lista = lista & matricula  & ";"' & "@caixa.gov.br; "
					
				Else
					
					lista = lista & matricula  & ";"' & "@correiolivre.caixa; "
					
				End If
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
		
	'Empregados da Coordenação
	Elseif tipo = 4 Then
				
		consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE LEFT(CO_MATRICULA, 1) = 'C' and IC_ATIVO = 1 AND CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND CO_GS = "&co_gs&" ORDER BY CO_MATRICULA, NO_NOME"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				matricula = rs("CO_MATRICULA")
				tipoUsuario =  UCase(Left(matricula, 1))
				
				If tipoUsuario = "C" Then
					
					lista = lista & matricula  & ";"'& "@caixa.gov.br; "
					
				Else
					
					lista = lista & matricula  & ";"'& "@correiolivre.caixa; "
					
				End If
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
		
	
	'Estagiários da Coordenação
	Elseif tipo = 5 Then
		
		consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE LEFT(CO_MATRICULA, 1) IN ('E', 'M')and IC_ATIVO = 1 AND CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND CO_GS = "&co_gs&" ORDER BY CO_MATRICULA, NO_NOME"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				matricula = rs("CO_MATRICULA")
				tipoUsuario =  UCase(Left(matricula, 1))
				
				If tipoUsuario = "C" Then
					
					lista = lista & matricula  & ";"' & "@caixa.gov.br; "
					
				Else
					
					lista = lista & matricula  & ";"' & "@correiolivre.caixa; "
					
				End If
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
	
	
	'Todos da Coordenação
	Elseif tipo = 6 Then
		
		consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS WHERE IC_ATIVO = 1 AND CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND CO_GS = "&co_gs&" ORDER BY CO_MATRICULA, NO_NOME"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				matricula = rs("CO_MATRICULA")
				tipoUsuario =  UCase(Left(matricula, 1))
				
				If tipoUsuario = "C" Then
					
					lista = lista & matricula  & ";" '& "@caixa.gov.br; "
					
				Else
					
					lista = lista & matricula & ";"' & "@correiolivre.caixa; "
					
				End If
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
	
	
	'Coordenações
	Elseif tipo = 7 Then
		
		dados_sys = 	"Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
		
		consulta = "SELECT DE_CONTATO FROM TB_GS_CONTATOS INNER JOIN TB_CONTATOS ON TB_CONTATOS.CO_CONTATO = TB_GS_CONTATOS.CO_CONTATO INNER JOIN TB_GS ON TB_GS_CONTATOS.CO_GS = TB_GS.CO_GS WHERE TB_GS.CO_UNIDADE = "&request.Cookies("co_usuario_unidade_siiag")&" AND CO_TIPO = 1 AND IC_ATIVO = 1 AND TB_GS.CO_GS <> 7"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				contato = rs("DE_CONTATO")
					
				lista = lista & contato & "; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
	
	'Coordenadores
	Elseif tipo = 8 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
		
		consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS INNER JOIN TB_CARGOS ON TB_USUARIOS.CO_CARGO = TB_CARGOS.CO_CARGO WHERE TB_USUARIOS.IC_ATIVO = 1 AND TB_USUARIOS.CO_CARGO IN (2) and co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_NOME"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				matricula = rs("CO_MATRICULA")
					
					lista = lista & matricula & "; "

				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
	
	
	'Agência da SR Norte e Sul do Ceará
	Elseif tipo = 9 Then
		
		dados_sys = 	"Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=UsuariosPv;User Id=todos;Password=todosce;"
		
		consulta = "SELECT DE_MAIL FROM TB_PVS INNER JOIN TB_PVS_DADOS ON TB_PVS_DADOS.CO_PV = TB_PVS.CO_PV INNER JOIN TB_SR ON TB_PVS.CO_SR = TB_SR.CO_SR WHERE IC_ATIVO = 1 AND TB_PVS.CO_SR = 2651 ORDER BY NO_NOME "
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				email = rs("DE_MAIL")				
					
				lista = lista & email & "; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
			
	
	'Agências da SR Fortaleza
	Elseif tipo = 10 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=UsuariosPv;User Id=todos;Password=todosce;"
		
		consulta = "SELECT DE_MAIL FROM TB_PVS INNER JOIN TB_PVS_DADOS ON TB_PVS_DADOS.CO_PV = TB_PVS.CO_PV INNER JOIN TB_SR ON TB_PVS.CO_SR = TB_SR.CO_SR WHERE IC_ATIVO = 1 AND TB_PVS.CO_SR = 2650 ORDER BY NO_NOME"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				email = rs("DE_MAIL")				
					
				lista = lista & email & "; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
		
	
	'Agências do SR Maranhão
	Elseif tipo = 11 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=UsuariosPv;User Id=todos;Password=todosce;"
		
		consulta = "SELECT DE_MAIL FROM TB_PVS INNER JOIN TB_PVS_DADOS ON TB_PVS_DADOS.CO_PV = TB_PVS.CO_PV INNER JOIN TB_SR ON TB_PVS.CO_SR = TB_SR.CO_SR WHERE IC_ATIVO = 1 AND TB_PVS.CO_SR = 2654 ORDER BY NO_NOME "
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				email = rs("DE_MAIL")				
					
				lista = lista & email & "; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
		
	
	'Agências do SR Piauí
	Elseif tipo = 12 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=UsuariosPv;User Id=todos;Password=todosce;"
		
		consulta = "SELECT DE_MAIL FROM TB_PVS INNER JOIN TB_PVS_DADOS ON TB_PVS_DADOS.CO_PV = TB_PVS.CO_PV INNER JOIN TB_SR ON TB_PVS.CO_SR = TB_SR.CO_SR WHERE IC_ATIVO = 1 AND TB_PVS.CO_SR = 2655 ORDER BY NO_NOME "
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				email = rs("DE_MAIL")				
					
				lista = lista & email & "; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If	
	
	'Agências do CE/PI/MA
	Elseif tipo = 13 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=UsuariosPv;User Id=todos;Password=todosce;"
		
		consulta = "SELECT DE_MAIL FROM TB_PVS INNER JOIN TB_PVS_DADOS ON TB_PVS_DADOS.CO_PV = TB_PVS.CO_PV INNER JOIN TB_SR ON TB_PVS.CO_SR = TB_SR.CO_SR WHERE IC_ATIVO = 1"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				email = rs("DE_MAIL")				
					
				lista = lista & email & "; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If	
	
	'SR CE/PI/MA
	Elseif tipo = 14 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=UsuariosPv;User Id=todos;Password=todosce;"
		consulta = "SELECT 'sr' + CAST(CO_SR AS VARCHAR(10)) + SG_UF + '@caixa.gov.br' as email from TB_SR " & "WHERE CO_SR <> 9999"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				email = rs("email")				
					
				lista = lista & email & "; "
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
	
	'Todas as GIFUG
	Elseif tipo = 15 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
		consulta = "SELECT SG_UNIDADE AS Expr1 FROM TB_UNIDADE WHERE CO_UNIDADE <> 9999"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			Response.Write "Lista vazia."
		Else
			
			Do While Not rs.eof
				
				email = rs("Expr1")
					
				lista = lista & email & "; "
				
				rs.movenext
				
			Loop
			
			lista = Replace(lista, "/", "")
			lista = Replace(lista, ";", "@caixa.gov.br;") '& "@caixa.gov.br"			
			
			response.write lista
			
		End If
	
	
	'if request.Cookies("co_usuario_unidade_siiag") = "7180" then
	Elseif tipo = 17 Then
		
		dados_sys = "Provider=sqloledb;Data Source=ce7180nt005;Initial Catalog=Ativa Fgts;User Id=todos;Password=todosce;"
		consulta = "SELECT CO_MATRICULA FROM TB_USUARIOS_GRUPOS WHERE IC_SUSPENSO <> 1"
		'Response.Write consulta
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open consulta, dados_sys, 3, , 32
		
		If rs.eof Then 
			
			Response.Write "Lista vazia."
			
		Else
			
			Do While Not rs.eof
				
				lista = lista & rs("CO_MATRICULA")  & ";"
				
				rs.movenext
				
			Loop
			
			response.write lista
			
		End If
		'End If
		
		'Gerências Nacionais
	Elseif tipo = 16 Then
			
		response.write "pefug@caixa.gov.br; geavo@caixa.gov.br; gepas@caixa.gov.br; gerfu@caixa.gov.br; gefom@caixa.gov.br"
			
	End If

%>