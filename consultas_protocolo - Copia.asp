
<%
dim WHERE(10)
dim tagPAG
tagPAG = "pag"
dim Pag 

dim numPag
numPag = 2

'dim cont

	' REQUEST	
	tipoProtocolo = Request("tipoProtocolo")
	areaProtocolo = Request("areaProtocolo")
	dataInicial = Request("dataInicial")
	dataFinal=Request("dataFinal")
	numeroOficio = Request("numeroOficio")
	responsavelMatricula = request("f_responsavel_matricula")
	
	Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1
   'todos = Request("todos")

Query = " SELECT A.*, B.DE_TIPO, C.NO_AREA, ARS.NU_AR  FROM TB_PROTOCOLO_ATUAL A  LEFT JOIN TB_PROTOCOLO_TIPO B ON A.CO_TIPO = B.CO_TIPO LEFT JOIN TB_PROTOCOLO_AREAS C ON A.CO_AREA = C.CO_AREA"
  	Query = query & " LEFT JOIN [TB_PROTOCOLO_ARS] ARS ON (A.NO_PROTOCOLO  = ARS.NO_PROTOCOLO AND A.CO_TIPO = ARS.CO_TIPO AND A.AA_PROTOCOLO=ARS.AA_PROTOCOLO	)	"
	cont = 0
	If numeroOficio <> "" then 
		cont = cont + 1
		WHERE(cont)  =  " A.NO_PROTOCOLO =" & numeroOficio & " "
	End If

	If tipoProtocolo <> "" then 
		cont = cont + 1
		WHERE(cont)  =  " A.CO_TIPO ='" & tipoProtocolo & "' "
	End If

	If areaProtocolo <> "" then 
		cont = cont + 1
		WHERE(cont)  =  " A.CO_AREA ='" & areaProtocolo & "' "
	End If

	If responsavelMatricula <> "" then 
		cont = cont + 1
		WHERE(cont)  =  " A.CO_RESPONSAVEL_MATRICULA ='" & responsavelMatricula & "' "
	End If
	
	If dataInicial <> "" then 
		If dataFinal <> "" then 
			cont = cont + 1
			WHERE(cont)  =  " ( cast(convert(varchar(10),DH_ENVIO,103) as datetime) >= '" &dataInicial& "' AND cast(convert(varchar(10),DH_ENVIO,103) as datetime) <= '" &dataFinal& "' ) "
		else
			cont = cont + 1
			WHERE(cont)  =  " DH_ENVIO >= '" & dataInicial & "' "

		End If
	ElseIf dataFinal <> "" then 
			cont = cont + 1
			WHERE(cont)  =  " DH_ENVIO <= '" & dataFinal & "' "
	End If
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
   Next

 query = query & " ORDER BY A.NO_PROTOCOLO "
'response.Write(Query)
'response.End()
  
	set objConn = server.CreateObject("ADODB.Connection") 
	dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
	objConn.open dados_sys
	set PC=Server.CreateObject("ADODB.RecordSet")
	PC.Open Query, dados_sys, 3, , 32
	
	if not pc.eof then
	
		pc.AbsolutePage = pag
	
		Response.Write "<table>"
		Response.Write "<tr>"
		Response.Write "<td width='5%'>N&uacute;mero</td>"
		Response.Write " <td width='5%' >Tipo</td>"
		Response.Write "<td width='7%'>AR</td>"
		Response.Write "<td width='7%'>&Aacute;rea</td>"
		Response.Write "<td width='4%'>Data</td>"
		Response.Write "<td width='12%'>Respons&aacute;vel</td>"
		Response.Write "<td width='15%'>Conte&uacute;do</td>"
		Response.Write "<td width='12%'>Destino</td>"
		Response.Write "<td width='1%'>Edi&ccedil;&atilde;o</td>"
		Response.Write "<td width='1%'>Exclus&atilde;o</td>"
		Response.Write "</tr>"
		
		do while (not PC.eof and Abs(pc.AbsolutePage - pag) < numPag )
		
			codigoTipoProtocolo=PC("CO_TIPO")
			AAProtocolo=PC("AA_PROTOCOLO")
			nomeResponsavel=PC("NO_RESPONSAVEL")
			if not isnull(pc("nu_ar"))  then
				nuAR = pc("nu_ar")
			else
				nuAR = "--"
			end if
			conteudo=PC("DE_CONTEUDO")
			destino=PC("DE_DESTINO")
			dataEnvio=PC("DH_ENVIO")
			codigoArea=PC("CO_AREA")
			codigoUnidadeFGTS=PC("CO_UNIDADE_FGTS")
			numeroOficio = PC("NO_PROTOCOLO")
			nomeTipoProtocolo = PC("DE_TIPO")
			nomeCodigoArea = PC("NO_AREA")
			codSeq = PC("CO_SEQUENCIAL")
		
						response.write "<tr>"
			response.write "<td id='numOficio' value="&numeroOficio&"><input type='hidden' id='codSeq' value='"&codSeq&"'/>" & numeroOficio & " / " & AAProtocolo & "</td>"
			response.write "<td  id='codTipo' value="&codigoTipoProtocolo&" style='display:none;'>" & codigoTipoProtocolo & "</td>"
			response.write "<td id='nomeTipoProtocolo'>" & nomeTipoProtocolo & "</td>"
			response.write "<td id='nuAR'>" & nuAR & "</td>"			
			response.write "<td id='codArea' value="&codigoArea&" style='display:none;'>" & codigoArea & "</td>"
			response.write "<td id='nomeCodigoArea'>" & nomeCodigoArea & "</td>"
			response.write "<td id='dataEnvio'>" & FormataData(dataEnvio) & "</td>"
			response.write "<td style='text-align:left' id='responsavel'>" & FormataFrase(nomeResponsavel) & "</td>"
			response.write "<td style='text-align:left' id='conteudo'>" & conteudo & "</td>"
			response.write "<td style='text-align:left' id='destino'>" & destino & "</td>"
			response.write "<td width='1%'><img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer'></td>"
			response.write "<td width='1%'><img class = 'X' id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
			response.write "</tr>"
		
			PC.movenext
		
		LOOP
		response.Write("</table>")
		Controla_Pagina()
		'CSD.Close
		'CS.Close
		PC.Close
	else
		Response.Write "<table>"
		Response.Write "<tr>"
		Response.Write "<td width='100%'>N&Atilde;O FORAM LOCALIZADOS DADOS PARA O FILTRO SELECIONADO</td>"
		Response.Write "</tr>"
		Response.Write "</table>"
	end if
			 

Sub Writeln(texto)
	response.write(texto)
End Sub

Sub Controla_Pagina()

     '****CONTROLE DE PÁGINA
	  'response.Write(" Pag: " & Pag)
      Dim Ult
      PC.MoveLast
      PC.MoveFirst
      Ult = PC.PageCount
	  'response.Write(" Pag: " & Pag)
	  'response.Write(" ultima pagina:" & Ult)
      If (Pag < 1)   Then Pag = 1
      If (Pag > Ult) Then Pag = Ult




      WriteLn "	<table style='' >"
      WriteLn "		<tr valign=middle>"
      WriteLn "		<td>"
      Response.Write "<input type='button' class='myButton'"
      If (Pag <= numPag) Then Response.Write " disabled "
      Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(1), "") & """);' value='&lt;&lt;'>"

            
      Response.Write "<input type='button' class='myButton'"
      If (Pag <= numPag) Then Response.Write " disabled "
      Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(Pag - numPag), "") & """);' value='&lt;'>"
            
      WriteLn "		</td>"
      WriteLn "		<td>"
      Response.Write "p&aacute;gina"
      WriteLn "		</td>"
      WriteLn "		<td>"
      Response.Write "<input size=3 type='text' value='" & CStr(Round(Pag / numPag + 0.5, 0)) & "' onKeyPress='JavaScript:if(window.event.keyCode==13)window.navigate(""?" &  rsSubst(tagPag, """ + (1 + (this.value - 1) * " & numPag & ") + """, "") & """);'>"
      WriteLn "		</td>"
      WriteLn "		<td>"
      if Ult = numPag then
         Response.Write "de&nbsp;" & Ult/numPag & Chr(13)
      else
	      Response.Write "de&nbsp;" & CStr(Round(Ult / numPag + 0.5, 0)) & Chr(13)
      end if
      WriteLn "		</td>"
      WriteLn "		<td>"

      'response.write Cpf
      Response.Write "<input type='button' class='myButton'"
      If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
      Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(Pag + numPag), "") & """);' value='&gt;' >"


      
      Response.Write "<input type='button' class='myButton'"
      If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
      WriteLn "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, 1 + (CStr(Round(Ult / numPag + 0.5, 0))-1)*numPag, "") & """);' value='&gt;&gt;'>"

      WriteLn "		</td>"
      WriteLn "		</tr>"
      WriteLn "	</table>"
      '***** FIM CONTROLA PAGINA

End Sub

'******************************************************************************
  '** FUNÇÃO QUE PERMITE REDIRECIONAR A PÁGINA COM NOVOS PARÂMETROS            **
  '------------------------------------------------------------------------------
  Function rsSubst(tag, valor, rqs)
  	  Dim j
	  Dim k
	  Dim rs
	  
	  If rqs = "" Then rqs = Request.QueryString
	  rs = rqs
	  j = instr(1, rs, tag & "=", 1)
	  If j > 0 Then
	    k = instr(j, rs & "&", "&", 1)
	    rs = left(rs, j - 1) & tag & "=" & valor & mid(rs, k)
	  Else
	    If rs <> "" Then rs = rs & "&"
	    rs = rs & tag & "=" & valor
	  End If
	  rsSubst = rs
  End Function
  '******************************************************************************

Function FormataData(Data)
  If Data <> "" Then
    FormataData = Right("0" & DatePart("d", Data),2) & "/" & Right("0" & DatePart("m", Data),2) & "/" & DatePart("yyyy", Data)
  End If
End Function

Function FormataFrase(frase)
	Temp = Split(frase," ")
	For i = LBound(Temp) to UBound(Temp)
		FraseTemp = FraseTemp &" "& UCase(Left(Temp(i),1)) & lcase(mid(Temp(i),2))
	Next
	FormataFrase = FraseTemp
End Function

%>