

<%
Dim perfil_acesso_siiag
Dim perfil_acesso_admin_siiag
Dim perfil_acesso_siiag_desc
DIM eh_perfil

Function Usuario_Rede()
	mat = Request.ServerVariables("LOGON_USER")
	i = InStr(mat,"\")
	If i > 0 Then
		dominio = UCase(Left(mat,i-1))
		usuario = UCase(Right(mat,Len(mat)-i))
	else
		usuario = ""
	End If
	Usuario_Rede = usuario
End Function


Sub Perfil_Acesso_original(cod_acesso)
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"select * from VW_USUARIOS_PERFIS where CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' and CO_ACESSO = " & cod_acesso & " order by ic_admin desc; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		perfil_acesso_siiag = true
		if rs("IC_ADMIN") then
			perfil_acesso_admin_siiag = true
		else
			perfil_acesso_admin_siiag = false
		end if
		response.Cookies("co_usuario_co_visao") = rs("co_visao")
	else
		perfil_acesso_siiag = false
		perfil_acesso_admin_siiag = false		
		response.Cookies("co_usuario_co_visao") = ""
	end if
	rs.close
	
	set rs = nothing
End Sub

Sub Perfil_Acesso(cod_acesso)
	dim codigo
	dim ic_admin
	dim co_visao

	encontrou = false
	acessos = split(request.Cookies("acessos_siiag"),";")
	tamanho = ubound(acessos)
	for i = 0 to tamanho - 1
		acesso = split(acessos(i),"-")
		codigo = acesso(0)
		ic_admin = acesso(1)
		co_visao = acesso(2)
		
		if (codigo = cod_acesso) then
			'response.write "TEM ACESSO"
			perfil_acesso_siiag = true
			if ic_admin then
				'response.write "ADMIN"
				perfil_acesso_admin_siiag = true
			else
				'response.write "N&Acirc;O ADMIN"
				perfil_acesso_admin_siiag = false
			end if
			encontrou = true
			response.Cookies("co_usuario_co_visao") = co_visao
			exit for
			
		end if
	next
	if not encontrou then
		'response.write "NÃO TEM ACESSO"
		perfil_acesso_siiag = false
		perfil_acesso_admin_siiag = false		
		response.Cookies("co_usuario_co_visao") = ""
	end if

End Sub

Sub Perfil_Acesso_Cookie(cod_acesso)
	dim codigo
	dim ic_admin
	dim co_visao

	encontrou = false
	acessos = split(request.Cookies("acessos_siiag"),";")
	tamanho = ubound(acessos)
	for i = 0 to tamanho - 1
		acesso = split(acessos(i),"-")
		codigo = acesso(0)
		ic_admin = acesso(1)
		co_visao = acesso(2)
		
		if (codigo = cod_acesso) then
			'response.write "TEM ACESSO"
			perfil_acesso_siiag = true
			if ic_admin then
				'response.write "ADMIN"
				perfil_acesso_admin_siiag = true
			else
				'response.write "N&Acirc;O ADMIN"
				perfil_acesso_admin_siiag = false
			end if
			encontrou = true
			response.Cookies("co_usuario_co_visao") = co_visao
			exit for
			
		end if
	next
	if not encontrou then
		'response.write "NÃO TEM ACESSO"
		perfil_acesso_siiag = false
		perfil_acesso_admin_siiag = false		
		response.Cookies("co_usuario_co_visao") = ""
	end if

End Sub

Sub Carrega_Acessos()
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"select * from VW_USUARIOS_PERFIS where CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' order by ic_admin desc; " 
	rs.Open strQuery, dados_sys
	acessos = ""
	do while not rs.eof
		acessos =  acessos & rs("co_acesso") & "-" & rs("IC_ADMIN") & "-"  & rs("co_visao") & ";"
		rs.movenext
	loop
	rs.close
	response.Cookies("acessos_siiag")	 = acessos
	set rs = nothing

End Sub



Function Tem_Acesso_original(cod_acesso)
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	dim rs
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"select * from VW_USUARIOS_PERFIS where CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' and CO_ACESSO = " & cod_acesso & "; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		Tem_Acesso_original = true
	else
		Tem_Acesso_original = false		
	end if
	rs.close
	
	set rs = nothing
End Function


Function Tem_Acesso_Cookie(cod_acesso)
	dim codigo

	encontrou = false
	acessos = split(request.Cookies("acessos_siiag"),";")
	tamanho = ubound(acessos)
	for i = 0 to tamanho - 1
		acesso = split(acessos(i),"-")
		codigo = acesso(0)
		
		if (codigo = cod_acesso) then
			Tem_Acesso_Cookie = true
			encontrou = true
			exit for
		end if
	next
	if not encontrou then
		Tem_Acesso_Cookie = false
	end if
End Function


Function Tem_Acesso(cod_acesso)
	dim codigo

	encontrou = false
	acessos = split(request.Cookies("acessos_siiag"),";")
	tamanho = ubound(acessos)
	for i = 0 to tamanho - 1
		acesso = split(acessos(i),"-")
		codigo = acesso(0)
		
		if (codigo = cod_acesso) then
			Tem_Acesso = true
			encontrou = true
			exit for
		end if
	next
	if not encontrou then
		Tem_Acesso = false
	end if
End Function

Function Tem_Acesso_Admin_Cookie(cod_acesso)
	dim codigo

	encontrou = false
	acessos = split(request.Cookies("acessos_siiag"),";")
	tamanho = ubound(acessos)
	for i = 0 to tamanho - 1
		acesso = split(acessos(i),"-")
		codigo = acesso(0)
		ic_admin = acesso(1)
				
		if (codigo = cod_acesso) then
			if ic_admin then
				'response.write "ADMIN"
				Tem_Acesso_Admin_Cookie = true
			else
				'response.write "N&Acirc;O ADMIN"
				Tem_Acesso_Admin_Cookie = false
			end if
			encontrou = true
			exit for
		end if
	next
	if not encontrou then
		Tem_Acesso_Admin_Cookie = false
	end if
End Function


Function Tem_Acesso_Admin(cod_acesso)
	dim codigo

	encontrou = false
	acessos = split(request.Cookies("acessos_siiag"),";")
	tamanho = ubound(acessos)
for i = 0 to tamanho - 1
		acesso = split(acessos(i),"-")
		codigo = acesso(0)
		ic_admin = acesso(1)
				
		if (codigo = cod_acesso) then
			if ic_admin then
				'response.write "ADMIN"
				Tem_Acesso_Admin = true
			else
				'response.write "N&Acirc;O ADMIN"
				Tem_Acesso_Admin = false
			end if
			encontrou = true
			exit for
		end if
	next
	if not encontrou then
		Tem_Acesso_Admin = false
	end if
End Function

Function Tem_Acesso_Admin_original(cod_acesso)
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	dim rs
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"select * from VW_USUARIOS_PERFIS where CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' and CO_ACESSO = " & cod_acesso & " and IC_ADMIN = 1 ; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		Tem_Acesso_Admin_original = true
	else
		Tem_Acesso_Admin_original = false		
	end if
	rs.close
	
	set rs = nothing
End Function

Sub Perfil_Nome()
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"SELECT TOP 1 NO_PERFIL, CO_PERFIL, IC_GERENTE, CO_VISAO FROM VW_USUARIOS_PERFIS WHERE CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' ORDER BY ORDEM; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		'if rs("IC_GERENTE") THEN
			'response.Cookies("perfil_acesso_siiag_desc") = "Gerente"
		'else
			response.Cookies("perfil_acesso_siiag_cod") = rs("co_PERFIL")
			response.Cookies("perfil_acesso_siiag_desc") = rs("NO_PERFIL")
			response.Cookies("co_usuario_co_visao") = rs("co_visao")
		'end if
	else
		response.Cookies("perfil_acesso_siiag_cod") = ""
		response.Cookies("perfil_acesso_siiag_desc") = ""		
		response.Cookies("co_usuario_co_visao") = ""
	end if
	response.Cookies("perfil_acesso_siiag_desc").expires = dateadd("n",+1,now())
	
	set rs = nothing
	'objConn.close
End Sub

Function Localiza_Admn_Unidade()
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"SELECT * FROM VW_USUARIOS_PERFIS WHERE CO_UNIDADE='" & request.Cookies("co_usuario_unidade_siiag") & "' and co_perfil = 4 " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		Localiza_Admn_Unidade =  rs("no_nome")
	else
		Localiza_Admn_Unidade = ""
	end if
	
	set rs = nothing
	'objConn.close
End Function

sub Verifica_Perfil(cod_perfil)
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"SELECT TOP 1 * FROM VW_USUARIOS_PERFIS WHERE CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' AND CO_PERFIL = " & cod_perfil & "; " 
	'response.write strQuery
	rs.Open strQuery, dados_sys
	if not rs.eof then
		eh_perfil = True
	else
		eh_perfil = False
	end if
	
	set rs = nothing
	'objConn.close
End sub


function Eh_Perfil_Verificado(cod_perfil)
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	dim rs, strQuery
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"SELECT TOP 1 * FROM VW_USUARIOS_PERFIS WHERE CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' AND CO_PERFIL = " & cod_perfil & "; " 
	'response.write strQuery
	rs.Open strQuery, dados_sys
	if not rs.eof then
		Eh_Perfil_Verificado = True
	else
		Eh_Perfil_Verificado = False
	end if
	
	set rs = nothing
	'objConn.close
End function


Sub Perfil_Acesso_Old(cod_acesso)
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")	
	strQuery = 			"select * from VW_USUARIOS_PERFIS where CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' and CO_ACESSO = " & cod_acesso & "; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		response.Cookies("perfil_acesso_siiag") = true
		if rs("IC_ADMIN") then
			response.Cookies("perfil_acesso_admin_siiag") = true
		else
			response.Cookies("perfil_acesso_admin_siiag") = false
		end if
	else
		response.Cookies("perfil_acesso_siiag") = false
		response.Cookies("perfil_acesso_admin_siiag") = false		
	end if
	rs.close
	
	
	strQuery = 			"SELECT TOP 1 NO_PERFIL,IC_GERENTE FROM VW_USUARIOS_PERFIS WHERE CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "'; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		if rs("IC_GERENTE") THEN
			response.Cookies("perfil_acesso_siiag_desc") = "Gerente"
		else
			response.Cookies("perfil_acesso_siiag_desc") = server.HTMLEncode(rs("NO_PERFIL"))
		end if
	else
		response.Cookies("perfil_acesso_siiag_desc") = ""		
	end if
	response.Cookies("perfil_acesso_siiag_desc").expires = dateadd("n",+1,now())			

	set rs = nothing

End Sub

Function Formatar_Data(data)
	if isDate(data) then
		Formatar_Data = right("00" & day(data),2) & "/" &right("00" & month(data),2) & "/" & year(data)
	else
		Formatar_Data = ""
	end if

End Function

Function Formatar_Dia(dia)

	If dia < 10 Then		
		Formatar_Dia = "0"&dia		
	Else		
		Formatar_Dia = dia		
	End If

End Function

Function Formatar_Mes(mes)
	If mes < 10 Then		
		Formatar_Mes = "0"&mes		
	Else		
		Formatar_Mes = mes	
	End If
End Function

Function Formatar_hora(data)
	if isDate(data) then
		Formatar_hora = right("00" & hour(data),2) & ":" & right("00" & minute(data),2)
	else
		Formatar_hora = ""
	end if

End Function


Function Capitalize(maiusculo)
	if maiusculo <> "" then
		array_nome = split(trim(maiusculo), " ")	
		nome = ""
		for i=0 to Ubound(array_nome)
			if trim(array_nome(i)) <> "" then
				'response.write "i:" & array_nome(i) & "<br/>"
				if array_nome(i) = "DE" or array_nome(i) = "DO" or array_nome(i) = "DA" then
					nome = nome & " " & Lcase(array_nome(i))
				else
					nome = nome & " " & UCase(left(array_nome(i), 1)) & LCase(right(array_nome(i), len(array_nome(i))-1))
				end if
			end if
		next
	end if
	Capitalize = nome
	
End Function

Function Primeiro_Nome(nome)
	if nome <>"" then
		Primeiro_Nome = mid(nome,1, instr(nome," "))
	end if
end Function


Function Pegar_qt_nomes(nome, qt)
	resultado = ""
	'response.write "nome:" & nome & "<br/>"
	if nome <> "" then
		for i = 1 to qt
			if instr(nome, " ") = 0 then
				resultado = resultado & nome
				nome = ""
			else
				resultado = resultado &  mid(nome, 1, instr(nome, " "))
				nome = right(nome, len(nome) - instr(nome, " "))
			end if
			'response.write "resultado:" & i & " " & resultado & "<br/>"

			'response.write "nome:" & i & " " & nome & "<br/>"
		next
	end if
	Pegar_qt_nomes = resultado
End Function



%>
