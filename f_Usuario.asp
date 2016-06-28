<%
Dim v_Usuario
Dim v_Nome_Usuario
Dim v_CGC_Usuario
Dim v_Usuario_Cargo
Dim wUser

'sub Login
'	If Request.ServerVariables("LOGON_USER")="" THEN
'		Response.Status = "401 - Acesso Negado" 		
'		Response.End
'	End If
'	Session("usr") = Request.ServerVariables("LOGON_USER")
'	Alerta = 2
'	wMat = Session("usr")
'	
'	GetName=""
'	If Not IsEmpty(wMat) Then
'		wUserName = "Usuário não cadastrado"
'		If Len(wMat) > 1 Then
'			on error resume next
'			wTamanho = Len(wMat)
'		   For i = 1 To wTamanho
'				If Mid(wMat, i, 1) = "\" then
'					wDominio = Left(wMat,i-1)
'					wUser    = Right(wMat,wTamanho-i)
'					Exit For
'				End If
'			Next
'			Set oUser = GetObject("WinNT://" & wDominio & "/" & wUser)
'			wUserName = oUser.FullName
'			wUserDescription = oUser.Description
'			If Err.Number <> 0 Then
'				Err.Clear
'				wUserName="Usuário não cadastrado"
'			End If
'			Dim A(20)
'			Dim j, unid
'			i=1
'			j=1
'	
'		   For Each oGroup In oUser.Groups
'			   'response.write oGroup.Name
'				If (Left(ucase(oGroup.Name),1) = "G")Then
'					if (Mid(oGroup.Name, 5, 4) <> "0000" and isnumeric(Mid(oGroup.Name, 5, 4))) then
'						A(i) = Mid(oGroup.Name, 5, 4)
'						Alerta = 1
'						if oGroup.Name = "" then exit for
'						'if (i=4) then exit for
'						i=i+1
'						'response.write oGroup.Name
'					end if
'				End If
'			Next
'			
'			unid=""
'			i=i-1
'			For j = 1 To i
'				unid = unid & A(j)
'			 Next
'			 'response.write unid
'			 
'		End If
'	
'		GetName = wUserName
'	End If
	'================================================
	' CONSISTE USUÁRIO
	'================================================
	Session("v_Usuario_Funcao") = "Hehe"
	Session("v_Usuario_Matricula") = "c124937"
	'Session("v_Usuario_Matricula") = "C023027"
	session("v_Usuario_Maquina") = "127.0.0.1"
	If len(trim(session("v_Usuario_Matricula"))) = 0 or trim(session("v_Usuario_Matricula"))= "" THEN
	
		Response.Status = "ERRO DE DOMÍNIO."
		Response.Write "<font face = 'Verdana' color = 'red' size = 3>"
		Response.write "Seu usuário não foi identificado no domínio da rede Caixa.<br>"
		'Response.write "Você deve solicitar regularização via SIATE." 		
		'Response.write "Favor entrar em contrato com a GICOP/FO." 		
		'Response.End
	End If
	
	Session("v_Usuario_Nome")= "Tatiana Bezerra Araújo"
	If len(trim(GetName)) = 0 THEN
		'Response.Status = "ERRO DE DOMÍNIO."
		'Response.Write "<font face = 'Verdana' color = 'red' size = 3>"
		'Response.write "Seu usuário não foi identificado no domínio da rede Caixa.<br>"
		'Response.write "Você deve solicitar regularização via SIATE." 		
		'Response.write "Favor entrar em contrato com a GICOP/FO." 		
		
		'Response.End
	End If
	Session("v_Usuario_CGC") = "7180"
	If len(trim(right(unid,4)))= 0 THEN
		'Response.Status = "ERRO DE DOMÍNIO."
		'Response.Write "<font face = 'Verdana' color = 'red' size = 3>"
		'Response.write "Seu usuário não foi identificado no domínio da rede Caixa.<br>"
		'Response.write "Você deve solicitar regularização via SIATE." 		
		'Response.write "Favor entrar em contrato com a GICOP/FO." 		
		'Response.End
	End If
	'response.write "<br>" & Session("v_Usuario_CGC")
	
	'wUser = ucase(right(wmat,7))
	'response.Write(Session("v_Usuario_Matricula")
	'response.write Session("v_Usuario_CGC")
	'response.Write(Session("v_Usuario_Funcao"))
'end sub
'login
%>