<%
	dim WHERE(9)
	dim cont
	dim query
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2

	if tipoTabela = "" then
		tipoTabela = "afastamento"
	end if
	
	dim tabela
	dim chave
	
	if tipoTabela <> "" then
		select case tipoTabela
			case "afastamento": 
				tabela = "TB_AFASTAMENTOS"
				chave = "co_afastamento"
			case "destacamento": 
				tabela = "TB_DESTACAMENTOS"
				chave = "co_destacamento"
			case "ferias": 
				tabela = "TB_FERIAS"
				chave = "co_ferias"
			case "jornada": 
				tabela = "TB_JORNADA"
				chave = "co_jornada"
			case "substituicao": 
				tabela = "TB_SUBSTITUICOES"
				chave = "co_substituicao"
			case "emprestimo": 
				tabela = "TB_EMPRESTIMO"
				chave = "co_emprestimo"
			case "evento": 
				tabela = "TB_EVENTOS"
				chave = "co_evento"
			'case "estoque": 
'				tabela = "TB_ESTOQUE_PEDIDO"
'				chave = "co_pedido"
			case "reparo": 
				tabela = "TB_REPAROS"
				chave = "co_reparo"
			'case "demandaTI": 
'				tabela = "TB_DEMANDAS"
'				chave = "co_demanda"
		end select
	end if

	if valorChave <> "" then
		strQuery = "SELECT * FROM [SIIAG_WEB_LOG].[dbo].["&tabela&"_LOG] where " & chave & " = " & valorChave & " and tipo_log = 'DEPOIS'"
	else
		strQuery = "SELECT * FROM [SIIAG_WEB_LOG].[dbo].["&tabela&"_LOG] where tipo_log = 'DEPOIS'"
	end if
		
	Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	if rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
	else
	%> 
    <div class="tabela" >
        <table>
            <tr>
                <td width="1%">Código</td>
                <td width="8%">Data</td>
                <td width="30%">Ação</td>
                <td width="5%">Detalhes</td>         
            </tr>
	<%
		rs.AbsolutePage = pag
		
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )

			coLog = rs("co_log")
			coLogAntes = rs("co_log_antes")
			dataLog = rs("dt_log")
			matriculaEdicao = rs("co_matricula_edicao")	
			if tipoTabela = "destacamento" then
				acao = "Destacamento:" & rs("co_destacamento") & " - O usuário " & matriculaEdicao & " modificou a tabela " & tabela & "."		
			else
				acao = "O usuário " & matriculaEdicao & " modificou a tabela " & tabela & "."	
			end if
				
			%>
            <tr class="linhaLog">
            	<td width="1%" id="valorChave" style="display:none"><%=valorChave%></td>
             	<td width="1%" id="tipoTabela" style="display:none"><%=tipoTabela%></td>   
                <td width="1%" id="coLog"><%=coLog%></td>
                <td width="2%" id="dataLog"><%=dataLog%></td>
                <td width="5%" id="acao" align="left" style="text-align:left;"><%=acao%></td>
                <td width="5%"><img class='detalhe' id='detalhe'  src='imagens/edit.png' style='cursor:pointer'></td>      
            </tr>
            <%			
							
			rs.movenext
			
		LOOP
	
		Controla_Pagina()

	end if
%>
	</table>
    </div>
<%

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
%>