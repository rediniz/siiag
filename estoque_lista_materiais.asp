<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->

<%
response.ContentType = "text/html; charset=utf-8"
response.Codepage = "65001"
response.Charset = "utf-8"

'dim WHERE(3)
'	dim cont
'	dim query
'	dim ordem
'	
'	dim tagPAG
'	tagPAG = "pag"
'	dim Pag 
'	dim numPag
'	numPag = 2

filtro=request("filtro")

strQuery = 		"select MATERIAL.CO_MATERIAL, MATERIAL.NO_MATERIAL, MATERIAL.QT_QUANTIDADE, MATERIAL.QT_QTDE_MINIMA, MATERIAL.CO_UNIDADE, MATERIAL.CO_SIMAC, MATERIAL.DE_SIMAC, MATERIAL.QT_QTDE_SIMAC, MATERIAL.IC_ATIVO, UNIDADE.DE_UNIDADE, MATERIAL.QT_DISPONIVEL_SOLICITACAO from TB_ESTOQUE_MATERIAL AS MATERIAL JOIN TB_ESTOQUE_UNIDADE AS UNIDADE ON MATERIAL.CO_UNIDADE = UNIDADE.CO_UNIDADE WHERE MATERIAL.IC_ATIVO = 1 and material.co_unidade_fgts = "&request.Cookies("co_usuario_unidade_siiag")

if filtro <> "" then

strQuery = strQuery & " AND NO_MATERIAL LIKE '%" & filtro & "%' "

end if

strQuery = strQuery & " ORDER BY MATERIAL.NO_MATERIAL ASC" 

  
  objConn.execute(strQuery)
  
 ' Pag = cint(request("pag"))
'	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Nenhum resultado.</p>"
	Else
	
          response.write "<table id ='tab_produtos' width='30%' style='height:auto' >"
          response.write  "<tr >"
          response.write    "<td width='31%'>Nome</td>"
          response.write    "<td width='7%' >Estoque</td>"
          response.write    "<td width='7%' >Disponível para Solicitação</td>"
          response.write    "<td width='7%'>Unidade</td>"
          response.write    "<td width='7%'>Quantidade</td>" 
		  response.write    "<td width='1%'>Adicionar</td>"   
          response.write  "</tr>"

	
		'rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof  )
			'atribuindo os valores dos campos as variáveis
			  Nome =		rs("NO_MATERIAL")
			  Qtd_Estoque=	rs("QT_QUANTIDADE")
			  Qtd =			rs("QT_DISPONIVEL_SOLICITACAO")
			  Unidade =		rs("DE_UNIDADE")
			  Ativo =		rs("IC_ATIVO") 
			  Codigo =      rs("CO_MATERIAL")

			If Ativo = "True" Then
			if cint(rs("QT_DISPONIVEL_SOLICITACAO")) <= cint(0) then
				cor = "background-color:#ed6868;"
			else
				cor = ";"
			end if
		   response.write "<tr style='" & cor & "' >"
		   response.write "<input type='hidden' id='codigo' name='codigo' value=" & Codigo & ">"
		   response.write "<td id='nome' name='nome'>" & Nome & "</td>"
		   response.write "<td id='estoque' name='estoque'>" & Qtd_Estoque & "</td>"
		   response.write "<td id='disponivel' name='disponivel'>" & Qtd & "</td>"
		   response.write "<td id='unidade' name='unidade'>" & Unidade & "</td>"
		   response.write "<td><input class='form-field' type='text' name='quantidade' id='quantidade'  value='0' size='2' maxlength = '3'style='height:10px; font-size:11px; text-align:center'/></td>"
		   response.write "<td width='1%'><img class='adicionar' id='adicionar'  src='imagens/add_16x16.png' style='cursor:pointer'></td>"
		   response.write "</tr>"
			 else
			 
			 end if

			rs.movenext
		LOOP
	
		'Controla_Pagina()

	END IF ' fim do if da mensagem caso nao haja resultados

response.write "</table>"


	


	objConn.close 
	set rs = nothing
	set objConn = nothing 


	'Sub Writeln(texto)
'		response.write(texto)
'	End Sub
'	
'	Sub Controla_Pagina()
'	
'		 '****CONTROLE DE PÁGINA
'		  'response.Write(" Pag: " & Pag)
'		  Dim Ult
'		  rs.MoveLast
'		  rs.MoveFirst
'		  Ult = rs.PageCount
'		  'response.Write(" Pag: " & Pag)
'		  'response.Write(" ultima pagina:" & Ult)
'		  If (Pag < 1)   Then Pag = 1
'		  If (Pag > Ult) Then Pag = Ult
'	
'		  WriteLn "	<table style='height:auto' >"
'		  WriteLn "		<tr valign=middle>"
'		  WriteLn "		<td>"
'		  Response.Write "<input type='button' class='myButton'"
'		  If (Pag <= numPag) Then Response.Write " disabled "
'		  Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(1), "") & """);' value='&lt;&lt;'>"
'				
'		  Response.Write "<input type='button' class='myButton'"
'		  If (Pag <= numPag) Then Response.Write " disabled "
'		  Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(Pag - numPag), "") & """);' value='&lt;'>"
'				
'		  WriteLn "		</td>"
'		  WriteLn "		<td>"
'		  Response.Write "p&aacute;gina"
'		  WriteLn "		</td>"
'		  WriteLn "		<td>"
'		  Response.Write "<input size=3 type='text' value='" & CStr(Round(Pag / numPag + 0.5, 0)) & "' onKeyPress='JavaScript:if(window.event.keyCode==13)window.navigate(""?" &  rsSubst(tagPag, """ + (1 + (this.value - 1) * " & numPag & ") + """, "") & """);'>"
'		  WriteLn "		</td>"
'		  WriteLn "		<td>"
'		  if Ult = numPag then
'			 Response.Write "de&nbsp;" & Ult/numPag & Chr(13)
'		  else
'			  Response.Write "de&nbsp;" & CStr(Round(Ult / numPag + 0.5, 0)) & Chr(13)
'		  end if
'		  WriteLn "		</td>"
'		  WriteLn "		<td>"
'	
'		  'response.write Cpf
'		  Response.Write "<input type='button' class='myButton'"
'		  If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
'		  Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(Pag + numPag), "") & """);' value='&gt;' >"
'	
'	
'		  
'		  Response.Write "<input type='button' class='myButton'"
'		  If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
'		  WriteLn "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, 1 + (CStr(Round(Ult / numPag + 0.5, 0))-1)*numPag, "") & """);' value='&gt;&gt;'>"
'	
'		  WriteLn "		</td>"
'		  WriteLn "		</tr>"
'		  WriteLn "	</table>"
'		  '***** FIM CONTROLA PAGINA
'	
'	End Sub
'
''******************************************************************************
'  '** FUNÇÃO QUE PERMITE REDIRECIONAR A PÁGINA COM NOVOS PARÂMETROS            **
'  '------------------------------------------------------------------------------
'  Function rsSubst(tag, valor, rqs)
'  	  Dim j
'	  Dim k
'	  Dim rs
'	  
'	  If rqs = "" Then rqs = Request.QueryString
'	  rs = rqs
'	  j = instr(1, rs, tag & "=", 1)
'	  If j > 0 Then
'	    k = instr(j, rs & "&", "&", 1)
'	    rs = left(rs, j - 1) & tag & "=" & valor & mid(rs, k)
'	  Else
'	    If rs <> "" Then rs = rs & "&"
'	    rs = rs & tag & "=" & valor
'	  End If
'	  rsSubst = rs
'  End Function
'  '******************************************************************************

%>
  
