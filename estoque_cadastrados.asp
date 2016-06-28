<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->

<style>
table.bordasimples {border-collapse: collapse;}

table.bordasimples tr td {border:1px solid #000000;}
</style>
<%

response.charset = "utf-8"
	dim WHERE(3)
	dim cont
	dim query
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2
	imprimir = request("imprimir")
	
strQuery = 		"select MATERIAL.CO_MATERIAL, MATERIAL.NO_MATERIAL, MATERIAL.QT_QUANTIDADE, MATERIAL.QT_QTDE_MINIMA, MATERIAL.CO_UNIDADE, MATERIAL.CO_SIMAC, MATERIAL.DE_SIMAC, MATERIAL.QT_QTDE_SIMAC, MATERIAL.IC_ATIVO, MATERIAL.VR_VALOR_UNIT, UNIDADE.DE_UNIDADE from TB_ESTOQUE_MATERIAL AS MATERIAL JOIN TB_ESTOQUE_UNIDADE AS UNIDADE ON MATERIAL.CO_UNIDADE = UNIDADE.CO_UNIDADE where material.co_unidade_fgts = "&request.Cookies("co_usuario_unidade_siiag")&" "

if request("filtro") <> "" then
	
	strQuery = strQuery & "  and material.no_material like '%" & request("filtro")  & "%' " 
end if

strQuery = strQuery & "ORDER BY MATERIAL.NO_MATERIAL ASC" 
  
  objConn.execute(strQuery)
  'response.write strQuery
  
  Pag = cint(request("pag"))
	if (Pag <= 0 or Pag="" )then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Nenhum resultado.</p>"
	Else
	
		if imprimir = "1" then
%>
				<p> ESTOQUE DA UNIDADE </p>
				<table class="bordasimples" width="800" align="center">
<%
				fonte_cabe = " font-size:12px; font-family:Arial; background-color:#9ea2a6; "
				response.write  "<tr>"
				response.write    "<td width='300' style='text-align:center;" & fonte_cabe & "' >Nome</td>"
				response.write    "<td width='50'  style='text-align:center;" & fonte_cabe & "' >Qtd.</td>"
				response.write    "<td width='50'  style='text-align:center;" & fonte_cabe & "'>Qtd. Mínima</td>"
				response.write    "<td width='50'  style='text-align:center;" & fonte_cabe & "'>Unidade</td>"   
				if request("simac") <> "false" then       
				  response.write    "<td class = 'coluna_simac' width='50'  style='text-align:center;" & fonte_cabe & "'>Cód. SIMAC</td>"
				  response.write    "<td class = 'coluna_simac' width='150'  style='text-align:center;" & fonte_cabe & "'>Nome SIMAC</td>"
				  response.write    "<td class = 'coluna_simac' width='50'  style='text-align:center;" & fonte_cabe & "'>Qtd. SIMAC</td>"
				end if
				response.write    "<td width='50'  style='text-align:center;" & fonte_cabe & "'>Ativo</td>"
				response.write  "</tr>"
		 else
				response.write "<table border='0' width='50%' align='center'>"
				fonte_cabe = ""
				response.write  "<tr>"
				response.write    "<td width='20%' style='text-align:center;" & fonte_cabe & "' >Nome</td>"
				response.write    "<td width='5%'  style='text-align:center;" & fonte_cabe & "' >Qtd.</td>"
				response.write    "<td width='7%'  style='text-align:center;" & fonte_cabe & "'>Qtd. Mínima</td>"
				response.write    "<td width='7%'  style='text-align:center;" & fonte_cabe & "'>Unidade</td>"   
				if request("simac") <> "false" then       
				  response.write    "<td class = 'coluna_simac' width='8%'  style='text-align:center;" & fonte_cabe & "'>Cód. SIMAC</td>"
				  response.write    "<td class = 'coluna_simac' width='15%'  style='text-align:center;" & fonte_cabe & "'>Nome SIMAC</td>"
				  response.write    "<td class = 'coluna_simac' width='7%'  style='text-align:center;" & fonte_cabe & "'>Qtd. SIMAC</td>"
				end if
				response.write    "<td width='5%'  style='text-align:center;" & fonte_cabe & "'>Ativo</td>"
				response.write    "<td width='5%'  style='text-align:center;" & fonte_cabe & "'>Editar</td>"
				response.write  "</tr>"
		 end if


	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag and  imprimir <> "1") or (not rs.eof and imprimir = "1")
			'atribuindo os valores dos campos as variáveis
			Nome =		rs("NO_MATERIAL")
			Qtd =			rs("QT_QUANTIDADE")
			Qtd_min =		rs("QT_QTDE_MINIMA")
			Unidade =		rs("DE_UNIDADE")
			if request("simac") <> "false" then
				Cod_SIMAC =	rs("CO_SIMAC")
				De_SIMAC =	rs("DE_SIMAC")	
				Qt_SIMAC =	rs("QT_QTDE_SIMAC")
			end if
			Ativo =		rs("IC_ATIVO") 
			Valor = rs("VR_VALOR_UNIT")
			Codigo = rs("CO_MATERIAL")

			   if request("ativo") <> "false" and Ativo = "False" then
			   
			   else
			   response.write "<tr id='material'>"
			   response.write "<input type='hidden' id ='codigo' value="& Codigo &">"
			   response.write "<input type='hidden' id ='valor' value="& Valor &">"
			   response.write "<td id='nome' style='text-align:left;	font-size:11px; font-family:Arial;'>" & Nome & "</td>"
			   response.write "<td id='qtd' style='text-align:center; font-size:11px; font-family:Arial;'>" & formatnumber(Qtd,0) & "</td>"
			   response.write "<td id='qtd_min' style='text-align:center; font-size:11px; font-family:Arial;'>" & formatnumber(Qtd_min,0) & "</td>"
			   response.write "<td id='unidade'  style='text-align:center; font-size:11px; font-family:Arial;'>" & Unidade & "</td>"
			   if request("simac") <> "false" then
				   response.write "<td class = 'coluna_simac' id='cod_simac'  style='text-align:center; font-size:11px; font-family:Arial;' >" & Cod_SIMAC & "</td>"
				   response.write "<td class = 'coluna_simac' id='nome_simac' style='text-align:left; font-size:11px; font-family:Arial;'>" & De_SIMAC & "</td>"
				   response.write "<td class = 'coluna_simac' id='qtd_simac'  style='text-align:center; font-size:11px; font-family:Arial;'>" & Qt_SIMAC & "</td>"
			   end if
			   
				If Ativo = "True" Then
					response.write "<td id='ativo' style='text-align:center; font-size:11px; font-family:Arial;'>Sim</td>"
				else
					response.write "<td id='ativo' style='text-align:center; font-size:11px; font-family:Arial;'>Não</td>"
				end if
				response.write "<td  style='text-align:center; font-size:11px; font-family:Arial;'><img src='imagens/edit_23_23_2.png'/></td>"				 
				response.write "</tr>"
				end if
			rs.movenext
		LOOP
		if imprimir <> "1"  then
			Controla_Pagina()
		end if

	END IF ' fim do if da mensagem caso nao haja resultados
	response.write "</table>"
	if imprimir <> "1"  then
		response.write "<p align='center'>"
		Response.Write "<input type='button' class='myButton'"
		'Response.Write "onClick='JavaScript:window.open(""estoque_cadastrados.asp?imprimir=1"",""_blank"");' value='Imprimir Tudo'>"
		Response.Write "onClick='JavaScript:window.open(""estoque_cadastrados.asp?imprimir=1"",""_blank"", ""toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=100,height=100"");' value='Imprimir Estoque'>"
	else
		response.write "<script>"
		response.write " window.print(); window.close(); "
		response.write "</script>"		
	end if	


	objConn.close 
	set rs = nothing
	set objConn = nothing 


	Sub Writeln(texto)
		response.write(texto)
	End Sub
	
	Sub Controla_Pagina()
	
		 '****CONTROLE DE PÁGINA
		  'response.Write(" Pag: " & Pag)
		  Dim Ult
		  rs.MoveLast
		  rs.MoveFirst
		  Ult = rs.PageCount
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
		  WriteLn "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, 1 + (CStr(Round(Ult / numPag + 0.5, 0))-1)*numPag, "" ) & """);' value='&gt;&gt;'>"
	
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
%>
  
