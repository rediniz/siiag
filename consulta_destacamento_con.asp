
<!-- #INCLUDE FILE ="include/conexao.asp" -->
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
	data_inicio= Request("data_inicio")
	data_final=Request("data_final")
	nome = Request("nome")

	strQuery = "SELECT  "
	strQuery = strQuery &  " DESTACAMENTOS.OBS_EDICAO, DESTACAMENTOS.CO_CRIADOR, DESTACAMENTOS.CO_DESTACAMENTO,DESTACAMENTOS.CO_MATRICULA,CO_DIGITO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.SG_UF, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.CO_SITUACAO, DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, SITUACOES.DE_SITUACAO, USUARIOS.NO_NOME, DESTACAMENTOS.IC_CANCELAMENTO "
	strQuery = strQuery &  "  FROM TB_DESTACAMENTOS AS DESTACAMENTOS "
	strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON DESTACAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA"
	strQuery = strQuery &  "  INNER JOIN TB_SITUACOES AS SITUACOES ON DESTACAMENTOS.CO_SITUACAO = SITUACOES.CO_SITUACAO"
	
	' strQuery = strQuery &  "  INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPO ON SUBSTITUICOES.CO_TIPO_AFASTAMENTO = TIPO.CO_TIPO_AFASTAMENTO"
	'if usuario <> "" then
	'strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA "
	'end if
	'	strQuery = strQuery &  "  WHERE) order by FERIAS.DT_INICIO desc  "
	
	cont = 0
	if situacao <> "" and situacao <> 0 then
		cont = cont + 1
		WHERE(cont) = " (DESTACAMENTOS.CO_SITUACAO = "& situacao &") "
	else
		
	end if
	
	if nome <> ""  then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.NO_NOME = '"& nome &"') " 
 	end if
	
	if data_inicio <> "" and data_final <> "" then
		cont = cont + 1
		WHERE(cont) = " (DESTACAMENTOS.DT_INICIO >= '"& data_inicio &"' AND DESTACAMENTOS.DT_FIM <='"&data_final&"') "
	end if
	
	if consultaGS then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') "
	elseif consultaTodos = "False" then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "') "
	end if

	cont = cont + 1
	WHERE(cont) = " (DESTACAMENTOS.CO_UNIDADE = "& request.Cookies("co_usuario_unidade_siiag") &") "
	
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " order by DESTACAMENTOS.CO_DESTACAMENTO desc "

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
				<td width="7%"> Código </td>
                <td width="30%" >Empregado</td>
                <td width="25%"> Projeto </td>
                <td width="11%"> Cidade/UF </td>
                <td width="16%"> De / Até </td>
                <td width="11%"> Situação </td>
                <td width="20%"> Observação </td>
                <td width="11%"> Editar </td>
   				<td width="11%"> </td>
           </tr>
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as variáveis
			codigo=rs("CO_DESTACAMENTO")
			matricula = rs("CO_MATRICULA")
			codigo_mat = rs("CO_DIGITO")
			projeto=rs("DE_PROJETO")
			cidade=rs("NO_CIDADE")
			UF=rs("SG_UF")
			data_inicio_banco = rs("DT_INICIO")
			data_final_banco = rs("DT_FIM")
			descricao_situacao = rs("DE_SITUACAO")
			obs = rs("OBS_EDICAO")
			'descricao_afastamento = rs("DE_TIPO_AFASTAMENTO")
			ic_cancelamento = rs("ic_cancelamento")	
			
			if(matricula = request.Cookies("co_usuario_siiag")) then
				podeCancelar = true
			else
				podeCancelar = false
			end if
			
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
			
			
			QueryNomeUser ="select NO_NOME from VW_USUARIOS  WHERE CO_MATRICULA ='"& matricula &"';" 
			'set objConn = server.CreateObject("ADODB.Connection") 
			'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
			'objConn.open dados_sys
			set tuser=Server.CreateObject("ADODB.RecordSet")
			tuser.Open QueryNomeUser, dados_sys 
			
			nome=ucase(tuser("NO_NOME")) 
			
			response.write "<tr>"
			response.write "<td id='codigo' >" & codigo & "</td>"
%>
			<input type="hidden" id="co_situacao" name="co_situacao" value="<%=rs("co_situacao")%>" />
			<input type="hidden" id="co_criador" name="co_criador" value="<%=rs("co_criador")%>" />
<%
			response.write "<td id='matricula' style='text-align:left;' >"& matricula &  "-" & codigo_mat & " - " &  nome &"</td>"
			'response.write "<td id='nome' style='text-align:left;'  >"& nome &"</td>"
			response.write "<td id='projeto' >"& projeto &"</td>"
			response.write "<td id='cidade' >"& cidade & "/" & UF  &"</td>"
			'response.write "<td id='uf' >"& UF &"</td>"
			response.write "<td id='datainicio' >"& Formatar_Data(data_inicio_total) & " - " & Formatar_Data(data_fim_total) &"</td>"
			'response.write "<td id='datainicio' >"& data_fim_total &"</td>"
			response.write "<td id='datainicio' >"& descricao_situacao &"</td>"
			response.write "<td id='obs' >"& obs &"</td>"
			response.write "<td width='1%'>"

			response.write "<img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer'>"
			
			response.write "</td>"
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