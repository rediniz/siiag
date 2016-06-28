<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	dim WHERE(5)
	dim cont
	dim query
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2
	
	'CAPTURA DE VARIAVEIS
	
	situacao = Request("situacao")
	coordenador =  Request("coordenador")
	'coordenacao =  Request("coordenacao")
	data_inicio= Request("data_inicio")
	data_final=Request("data_final")
	
	strQuery = "SELECT  " 
	strQuery = strQuery &  "SUBSTITUICOES.OBS_EDICAO,  SUBSTITUICOES.CO_SUBSTITUICAO,SUBSTITUICOES.CO_SUBSTITUTO,CO_DIGITO, SUBSTITUICOES.DT_INICIO, SUBSTITUICOES.DT_FIM, SUBSTITUICOES.CO_SITUACAO, SUBSTITUICOES.CO_CRIADOR, SUBSTITUICOES.CO_GS, SUBSTITUICOES.CO_GERENTE, SUBSTITUICOES.CO_TIPO_AFASTAMENTO, SUBSTITUICOES.DH_CRIACAO,USUARIOS.NO_NOME, SITUACOES.DE_SITUACAO, TIPO.DE_TIPO_AFASTAMENTO, TIPO.CO_CAIXA, SUBSTITUICOES.IC_CANCELAMENTO "
	strQuery = strQuery &  "  FROM TB_SUBSTITUICOES AS SUBSTITUICOES "
	strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON SUBSTITUICOES.CO_SUBSTITUTO = USUARIOS.CO_MATRICULA"
	strQuery = strQuery &  "  INNER JOIN TB_SITUACOES AS SITUACOES ON SITUACOES.CO_SITUACAO =  SUBSTITUICOES.CO_SITUACAO"
	strQuery = strQuery &  "  INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPO ON TIPO.CO_TIPO_AFASTAMENTO = SUBSTITUICOES.CO_TIPO_AFASTAMENTO"
	'if usuario <> "" then
	'	strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA "
	'end if
	'	strQuery = strQuery &  "  WHERE) order by FERIAS.DT_INICIO desc  "	
	
	cont = 0
	if situacao <> ""  then
		cont = cont + 1
		WHERE(cont) = " (SUBSTITUICOES.CO_SITUACAO = "& situacao &") "
	else
		
	end if
	
	'if coordenacao <> "" then
	'	cont = cont + 1
	'	WHERE(cont) = " (SUBSTITUICOES.CO_GS = "& coordenacao &") " 
 	'end if

	if coordenador <> "" then
		cont = cont + 1
		WHERE(cont) = " (SUBSTITUICOES.CO_GERENTE = '"& coordenador &"') " 
 	end if
	
	if data_inicio <> "" and data_final <> "" then
		cont = cont + 1
		WHERE(cont) = " (SUBSTITUICOES.DT_INICIO >= '"& data_inicio &"' AND SUBSTITUICOES.DT_FIM <='"&data_final&"') "
	end if
	
	if consultaGS then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') "
	elseif consultaTodos = "False" then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' or SUBSTITUICOES.co_gerente = '" & request.Cookies("co_usuario_siiag") & "') "
	end if
	
	cont = cont + 1
	WHERE(cont) = " (SUBSTITUICOES.CO_UNIDADE = "& request.Cookies("co_usuario_unidade_siiag") &") "
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " order by SUBSTITUICOES.DT_INICIO desc, CO_SUBSTITUICAO DESC "

	strQuery = strQuery & query & ordem
	'response.Write(strQuery)
	
	Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br/><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
	Else
	%>
             <table name="tabela" >
              <tr>
                <td> C&oacute;digo </td>
                <td> Gerente </td>
                <td> Substituto </td>
                <td> De </td>
                <td> Até </td>
                <td> Situa&ccedil;&atilde;o </td>
                <td> Motivo </td>
                <td> Observação </td>
                <%if tem_acesso("25") then%>
	                <td width="1%">Editar</td>
                <%end if%>
                <td></td>
              </tr>
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as variáveis
			codigo=rs("CO_SUBSTITUICAO")
			mat_gerente = rs("CO_GERENTE")
			mat_substituto = rs("CO_SUBSTITUTO")
			dig_substituto = rs("CO_DIGITO")
			substituto=rs("NO_NOME")
			situacao=rs("CO_SITUACAO")
			tipo_Afastamento=rs("CO_TIPO_AFASTAMENTO")
			data_inicio_banco = formatar_data(rs("DT_INICIO"))
			data_final_banco = formatar_data(rs("DT_FIM"))
			
			descricao_situacao = rs("DE_SITUACAO")
			descricao_afastamento = rs("DE_TIPO_AFASTAMENTO")
			cod_caixa = rs("CO_CAIXA")
			obs = rs("OBS_EDICAO")
			
			QueryNomeUser ="select NO_NOME, CO_MATRICULA, CO_DIGITO from VW_USUARIOS WHERE CO_MATRICULA ='"& mat_gerente &"';" 
			'set objConn = server.CreateObject("ADODB.Connection") 
			'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
			'objConn.open dados_sys
			set tuser=Server.CreateObject("ADODB.RecordSet")
			tuser.Open QueryNomeUser, dados_sys 
			
			nomeFuncionario=tuser("NO_NOME")
			mat_funcionario = tuser("CO_MATRICULA")
			dig_funcionario = tuser("CO_DIGITO")
			
			ic_cancelamento = rs("ic_cancelamento")	
							
			if(mat_gerente = request.Cookies("co_usuario_siiag")) then
				podeCancelar = true
			else
				podeCancelar = false
			end if
				
			
			response.write "<tr>"
			response.write "<td id='codigo' >"& codigo & "</td>"
			response.write "<td id='nomeFuncionario' style='text-align:left;' ><input type='hidden' id='co_situacao' name='co_situacao' value='" & rs("co_situacao") & "' />"& mat_funcionario & "-" & dig_funcionario & " - " & nomeFuncionario &"</td>"
			response.write "<td id='substituto' style='text-align:left;' >"& mat_substituto & "-" & dig_substituto & " - " & substituto &"</td>"
			response.write "<td id='data_inicio_total' >"& data_inicio_banco &"</td>"
			response.write "<td id='data_fim_total' >"& data_final_banco &"</td>"
			response.write "<td id='descricao_situacao' >"& descricao_situacao &"</td>"
			response.write "<td id='descricao_afastamento' >"& descricao_afastamento &" - "& cod_caixa &"</td>"
			response.write "<td id='obs' >"& obs &"</td>"
			
            if tem_acesso("25") then
				response.write "<td width='1%'><img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer'></td>"
			end if
			'response.write "<td width='1%'><img class = 'X' id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
			'response.Write "<input type='hidden' name='qt_parcelas' id='qt_parcelas' value='"&qt_parcelas&"'/>"
			'response.Write "<input type='hidden' name='dias_gozo' id='dias_gozo' value='"&dias_gozo&"'/>"
			'response.Write "<input type='hidden' name='situacao' id='situacao' value='"&situacao&"'/>"
			'response.Write "<input type='hidden' name='ic_abono' id='ic_abono' value='"&ic_abono&"'/>"
			'response.Write "<input type='hidden' name='co_ferias' id='co_ferias' value='"&co_ferias&"'/>"
			
			if podeCancelar = true and rs("co_situacao") = 2 then
				%><td><img class='cancelar' id='cancelar'  src='imagens/delete_16x16.png' style='cursor:pointer; width:16px; height:16px'></td>
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