<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	dim WHERE(4)
	dim cont
	dim query
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2

	situacao = Request("situacao")
	data_inicio= Request("data_inicio")
	data_final=Request("data_final")
	recurso = Request("recurso")
	
	
	strQuery = "SELECT  " 
	strQuery = strQuery &  "  EMPRESTIMO.CO_CRIADOR, EMPRESTIMO.OBS_EDICAO, EMPRESTIMO.CO_SITUACAO, RECURSO.CO_RECURSO, RECURSO.CO_STATUS, ISNULL(USUARIOS.NO_NOME, EMPRESTIMO.DE_RESPONSAVEL) AS DE_RESPONSAVEL, EMPRESTIMO.CO_EMPRESTIMO, EMPRESTIMO.CO_CRIADOR, EMPRESTIMO.CO_MATRICULA_RESPONSAVEL, EMPRESTIMO.DE_OBS, EMPRESTIMO.DH_INICIO, EMPRESTIMO.DH_FIM, EMPRESTIMO.DE_LOCAL, TIPO.DE_RECURSO, SITUACOES.DE_SITUACAO, EMPRESTIMO.IC_CANCELAMENTO "
	strQuery = strQuery &  " FROM TB_EMPRESTIMO AS EMPRESTIMO "
	strQuery = strQuery &  " INNER JOIN TB_EMPRESTIMO_RECURSO AS RECURSO ON RECURSO.CO_EMPRESTIMO = EMPRESTIMO.CO_EMPRESTIMO "
	
	strQuery = strQuery &  " INNER JOIN TB_TIPOS_RECURSOS AS TIPO ON TIPO.CO_RECURSO = RECURSO.CO_RECURSO "
	strQuery = strQuery &  " INNER JOIN  TB_SITUACOES AS SITUACOES ON SITUACOES.CO_SITUACAO = EMPRESTIMO.CO_SITUACAO"
	strQuery = strQuery &  " LEFT JOIN  VW_USUARIOS AS USUARIOS ON CO_MATRICULA_RESPONSAVEL = USUARIOS.CO_MATRICULA"
	
	' strQuery = strQuery &  "  INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPO ON SUBSTITUICOES.CO_TIPO_AFASTAMENTO = TIPO.CO_TIPO_AFASTAMENTO"
	'if usuario <> "" then
	'strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA "
	'end if
	'	strQuery = strQuery &  "  WHERE) order by FERIAS.DT_INICIO desc  "	
	
	cont = 0
	if situacao <> "" then
		cont = cont + 1
		WHERE(cont) = " (EMPRESTIMO.CO_SITUACAO = "& situacao &") "
	else
		
	end if
	
	if recurso <> "" then
		cont = cont + 1
		WHERE(cont) = " (TIPO.CO_RECURSO = '"& recurso &"') " 
 	end if
''	
	if data_inicio <> "" and data_final <> "" then
		cont = cont + 1
		WHERE(cont) = " (EMPRESTIMO.DH_INICIO >= '"& data_inicio &"' AND EMPRESTIMO.DH_FIM <= '"& (DAY(data_final)+1)&"/"&MONTH(data_final)&"/"&YEAR(data_final) &"') "
	end if

	if consultaGS then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') "	
	elseif consultaTodos = "False" then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' or EMPRESTIMO.CO_CRIADOR='" & request.Cookies("co_usuario_siiag") & "' )"
	end if
	
	cont = cont + 1
		WHERE(cont) = " (EMPRESTIMO.CO_UNIDADE = "& request.Cookies("co_usuario_unidade_siiag") &") "
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " order by EMPRESTIMO.DH_INICIO DESC"

	strQuery = strQuery & query & ordem
	'response.Write(strQuery)
	
	Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
	Else
	%>
             <table name="tabela" >
              <tr>
                <td width="14%"> Recurso </td>
                <td width="8%" >Situa&ccedil;&atilde;o</td>
                <td width="20%"> Local </td>
                <td width="23%"> Respons&aacute;vel </td>
                <td width="15%"> Per&iacute;odo </td>
	            <td width="20%"> Observa&ccedil;&atilde;o </td>
                <%IF tem_acesso("39") then%>
                	<td width="11%">Devolução</td>
                <%end if%>
				<%IF tem_acesso("28") then%>
	                <td width="11%"> Editar </td>
                <%end if%>
                <td></td>
              </tr>
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as variáveis
			
		 	codigo = rs("CO_EMPRESTIMO")
			co_recurso = rs("CO_RECURSO")
			descricao=rs("DE_RECURSO")
			situacao = rs("DE_SITUACAO")
			responsavel= LEFT(UCASE(rs("DE_RESPONSAVEL")),30)
			obs=rs("DE_OBS") &"<br>"& rs("OBS_EDICAO")
			data_inicio_banco = rs("DH_INICIO")
			data_final_banco = rs("DH_FIM")
			local = rs("DE_LOCAL")
			controle = rs("CO_STATUS")
			ic_cancelamento = rs("ic_cancelamento")
			
			if(rs("co_matricula_responsavel") = request.Cookies("co_usuario_siiag")) then
				podeCancelar = true
			else
				podeCancelar = false
			end if
			
			if controle = 1 then
			
				checked = "checked = 'checked' disabled='disabled'"
			
			else
			
				checked = ""
			
			end if
			
			'evento = rs("CO_EVENTO")
			'descricao_afastamento = rs("DE_TIPO_AFASTAMENTO")
			
			
			'FORMATANDO DATA INICIAL 
			diaInicio = DAY(data_inicio_banco) ' PEGANDO SO O DIA INICIAL
			mesInicio = MONTH(data_inicio_banco) ' PEGANDO SO O MES INICIAL
			anoInicio = YEAR(data_inicio_banco) ' PEGANDO SO O ANO INICIAL
			
			data_inicio_total = diaInicio &"/"& mesInicio& "/"& anoInicio ' FORMATANDO A DATA PARA QUE APARECA DE FORMA DD/MM/YYYY	

			'FIM DA FORMATACAO DA DATA INICIAL

			
			'FORMATANDO DATA FINAL
			diaFim = DAY(data_final_banco) ' PEGANDO SO O DIA INICIAL
			mesFim = MONTH(data_final_banco) ' PEGANDO SO O MES INICIAL
			anoFim = YEAR(data_final_banco) ' PEGANDO SO O ANO INICIAL
			
			data_fim_total = diaFim &"/"& mesFim& "/"& anoFim ' FORMATANDO A DATA PARA QUE APARECA DE FORMA DD/MM/YYYY	

			'FIM DA FORMATACAO DA DATA FINAL
			
			
		'QueryNomeUser ="select NO_NOME from VW_USUARIOS  WHERE CO_MATRICULA ='"& matricula &"';" 
			'set objConn = server.CreateObject("ADODB.Connection") 
			'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
			'objConn.open dados_sys
		'set tuser=Server.CreateObject("ADODB.RecordSet")
		'tuser.Open QueryNomeUser, dados_sys 
			
		'nome=tuser("NO_NOME")
			
				
			%>
			<tr class="linha_recurso">
			<td id='recurso' >
            <input type='hidden' id='codigo' name='codigo' value="<%=codigo%>" />
            <input type='hidden' id='co_recurso' name='co_recurso' value="<%=co_recurso%>" />
            <input type='hidden' id='co_matricula_responsavel' name='co_matricula_responsavel' value="<%=rs("co_matricula_responsavel")%>" />
            <input type='hidden' id='co_criador' name='co_criador' value="<%=rs("co_criador")%>" />
			<input type='hidden' id='co_situacao' name='co_situacao' value="<%=rs("co_situacao")%>" />            
			<%=descricao%></td>
			<td id='situacao' ><%=situacao%></td>
			<td id='local' ><%=local %></td>
			<td id='responsavel' style=" text-align:left" TITLE="<%=UCASE(rs("DE_RESPONSAVEL"))%>" ><%= responsavel %></td>
			<td id='periodo'  ><%= Formatar_Data(data_inicio_total) & " - " & Formatar_Data(data_fim_total) %></td>
			<td id='observacao'  ><% = obs %></td>           
            <td id="controle">
             <% 
			 IF tem_acesso("39") then
				response.write "<input class = 'check_controle' type='checkbox' id='check_devolucao' " & checked &"  />"
			 End if	
			 %>
             </td>
  
			<%
			IF tem_acesso("28") then
				response.write "<td width='1%'><img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer'></td>"
			end if
			'response.write "<td width='1%'><img class = 'X' id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
			'response.Write "<input type='hidden' name='qt_parcelas' id='qt_parcelas' value='"&qt_parcelas&"'/>"
			'response.Write "<input type='hidden' name='dias_gozo' id='dias_gozo' value='"&dias_gozo&"'/>"
			'response.Write "<input type='hidden' name='situacao' id='situacao' value='"&situacao&"'/>"
			'response.Write "<input type='hidden' name='ic_abono' id='ic_abono' value='"&ic_abono&"'/>"
			'response.Write "<input type='hidden' name='co_ferias' id='co_ferias' value='"&co_ferias&"'/>"
			if podeCancelar = true and rs("co_situacao") = 2 then
			  %><td width='10%'><img class='cancelar' id='cancelar'  src='imagens/delete_16x16.png' style='cursor:pointer; width:16px; height:16px'></td>
			  <%else%><td></td><%
		  	end if
			response.write "</tr>"
			rs.movenext
		LOOP
	
		Controla_Pagina()


	END IF ' fim do if da mensagem caso nao haja resultados
%>


	</table>
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