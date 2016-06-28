

<%
Dim perfil_acesso_siiag
Dim perfil_acesso_admin_siiag
Dim perfil_acesso_siiag_desc

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


Sub Perfil_Acesso(cod_acesso)
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"select * from VW_USUARIOS_PERFIS where CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' and CO_ACESSO = " & cod_acesso & "; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		perfil_acesso_siiag = true
		if rs("IC_ADMIN") then
			perfil_acesso_admin_siiag = true
		else
			perfil_acesso_admin_siiag = false
		end if
	else
		perfil_acesso_siiag = false
		perfil_acesso_admin_siiag = false		
	end if
	rs.close
	
	set rs = nothing

End Sub


Sub Perfil_Nome()
%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<%
	set rs =			Server.CreateObject("ADODB.RecordSet")
	
	strQuery = 			"SELECT TOP 1 NO_PERFIL,IC_GERENTE FROM VW_USUARIOS_PERFIS WHERE CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "'; " 
	rs.Open strQuery, dados_sys
	if not rs.eof then
		if rs("IC_GERENTE") THEN
			response.Cookies("perfil_acesso_siiag_desc") = "Gerente"
		else
			response.Cookies("perfil_acesso_siiag_desc") = rs("NO_PERFIL")
		end if
	else
		response.Cookies("perfil_acesso_siiag_desc") = ""		
	end if
	response.Cookies("perfil_acesso_siiag_desc").expires = dateadd("n",+1,now())
	
	set rs = nothing
	objConn.close
End Sub


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


%>
