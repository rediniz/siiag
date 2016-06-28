<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!--#ALTERADO EM 15/05/2016-->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%
Response.buffer=true
Response.Expires = -1
Response.ExpiresAbsolute = Now() -1 
Response.AddHeader "pragma", "no-store"
Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"
server.ScriptTimeout = 1000
%>

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
	
	'#ALTERADO EM 15/05/2016
	ic_aviso_assinado = request("ic_aviso_assinado")
	ic_substituicao = request("ic_substituicao")
	ic_requerimento = request("ic_requerimento")
	
	'#ALTERADO EM 14/05/2016
	data_inicial =  Request("data_inicial")
	data_final = Request("data_final")
	'------------------------
	nome = Request("nome")
	
	strQuery = "SELECT  " 
	strQuery = strQuery &  " FERIAS.CO_MATRICULA," 
	if usuario <> "" then
		strQuery = strQuery & " CO_DIGITO,"
	end if
	'#ALTERADO EM 15/05/2016
	strQuery = strQuery & " FERIAS.CO_FERIAS, FERIAS.DIAS_ABONO, FERIAS.QT_DIAS, FERIAS.OBS_EDICAO, FERIAS.DT_INICIO, FERIAS.QT_PARCELAS, FERIAS.CO_CRIADOR, FERIAS.IC_ABONO, FERIAS.CO_SITUACAO, FERIAS.DH_CRIACAO, SITUACOES.DE_SITUACAO, FERIAS.IC_AVISO_ASSINADO, FERIAS.IC_SUBSTITUICAO, FERIAS.IC_REQUERIMENTO, FERIAS.IC_CANCELAMENTO "
	strQuery = strQuery &  "  FROM TB_FERIAS AS FERIAS "
	strQuery = strQuery &  "  INNER JOIN TB_SITUACOES AS SITUACOES ON FERIAS.CO_SITUACAO = SITUACOES.CO_SITUACAO"
	if usuario <> "" then
		strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA "
	end if
	'	strQuery = strQuery &  "  WHERE) order by FERIAS.DT_INICIO desc  "	
	
	cont = 0
	if situacao <> "" then
		cont = cont + 1
		WHERE(cont) = " (FERIAS.CO_SITUACAO = "& situacao &") "
	end if
	
	'#ALTERADO EM 21/05/2016
	if data_inicial <> "" and data_final <> "" then
		cont = cont + 1
		if data_inicial = data_final then
			WHERE(cont) = " ( '"& data_inicial &"' BETWEEN FERIAS.DT_INICIO  AND (DATEADD(DAY,(FERIAS.QT_DIAS-1),FERIAS.DT_INICIO)) ) "
		else
			WHERE(cont) = " ( FERIAS.DT_INICIO BETWEEN '"& data_inicial &"' AND '"&data_final&"' ) "
		end if
	end if
	
	if nome <> "" then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.NO_NOME = '"& nome &"') "
	end if
	
	if consultaGS then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') "
	elseif consultaTodos = "False" then
		cont = cont + 1
		WHERE(cont) = " USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' "
	end if
	
	'#ALTERADO EM 18/05/2016 ----------------------
	if ic_aviso_assinado = "1" then
		cont = cont + 1
		WHERE(cont) = " FERIAS.IC_AVISO_ASSINADO IS NULL "
	end if
	
	if ic_substituicao = "1" then
		cont = cont + 1
		WHERE(cont) = " FERIAS.IC_SUBSTITUICAO = IS NULL "
	end if
	
	if ic_requerimento = "1" then
		cont = cont + 1
		WHERE(cont) = " FERIAS.IC_REQUERIMENTO = IS NULL "
	end if
	'----------------------------------------------
	
	cont = cont + 1
		WHERE(cont) = " (FERIAS.CO_UNIDADE = "& request.Cookies("co_usuario_unidade_siiag") &") "
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " order by FERIAS.DH_CRIACAO desc "

	strQuery = strQuery & query & ordem
	'response.Write(strQuery)
	
	Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
	Else
	

	acesso_editar       = tem_acesso_cookie("21")	
	acesso_editar_admin = tem_acesso_admin_cookie("21")	
	
	'#ALTERADO EM 15/05/2016
	queryChecaPerfil = "SELECT * FROM TB_USUARIOS_PERFIS WHERE CO_MATRICULA = '"&session("v_usuario_matricula")&"' AND CO_PERFIL = 2"
	set resultadoPerfil= Server.CreateObject("ADODB.RecordSet")
	resultadoPerfil.Open queryChecaPerfil, dados_sys
	rh = false
	
	if not resultadoPerfil.eof then
		rh = true
	end if
	
	resultadoPerfil.close
%>
             <table>
              <tr>
                <td width="5%">Matr&iacute;cula</td>
                <td width="30%" >Nome</td>
                <td width="8%">In&iacute;cio</td>
                <td width="8%">Fim</td>
                <td width="5%">Dias Gozo</td>
                <td width="8%" >Situa&ccedil;&atilde;o</td>
                <td width="14%">Data de<br>Solicita&ccedil;&atilde;o</td>
                <td width="10%" >Empregado Solicitante</td>
                <td width="7%" >Dias de Abono</td>
                <td width="14%" >Observação</td>
                <% if rh then %>
                <td width=1%>A</td>
                <td width=1%>S</td>
                <td width=1%>R</td>
                <% end if %>
                <!----------------------->
				<%if acesso_editar_admin or acesso_editar then
					if situacao = "1" and not acesso_editar_admin  then %>
	                    <td width="15%" >Editar</td>
					<%elseif acesso_editar_admin then%>
	                    <td width="15%" >Editar</td>
                    <%end if%>
                <%end if%>
				<td></td>
              </tr>
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as variáveis
			Matricula=rs("CO_MATRICULA")
			Digito_Mat = rs("CO_DIGITO")
			Dias_de_abono=rs("DIAS_ABONO")
			Data_de_inicio=rs("DT_INICIO")
			Empregado_Solicitante=rs("CO_CRIADOR")
			Situacao=rs("CO_SITUACAO")
			dataCriacao = rs("DH_CRIACAO")
			co_ferias = rs("CO_FERIAS")
			ic_abono = rs("IC_ABONO")
			situacao= rs("CO_SITUACAO")
			dias_gozo = rs("QT_DIAS")
			obs = rs("OBS_EDICAO")
			'situacao = rs("CO_SITUACAO")
			descricao_Situacao = rs("DE_SITUACAO")
			qt_parcelas = rs("QT_PARCELAS")
			dataFim = dateadd("d",rs("QT_DIAS")-1,rs("DT_INICIO"))	
			ic_cancelamento = rs("ic_cancelamento")	
			
			if(matricula = request.Cookies("co_usuario_siiag")) then
				podeCancelar = true
			else
				podeCancelar = false
			end if		
			
			QueryNomeUser ="select NO_NOME from TB_USUARIOS  WHERE CO_MATRICULA ='"& Matricula &"';" 
			'set objConn = server.CreateObject("ADODB.Connection") 
			'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
			'objConn.open dados_sys
			set tuser=Server.CreateObject("ADODB.RecordSet")
			tuser.Open QueryNomeUser, dados_sys 
			
			nomeFuncionario=tuser("NO_NOME")	
			
			response.write "<tr>"
			response.write "<td id='matricula' >"& Matricula & "-" & Digito_Mat & "</td>"
			response.write "<td id='nome' style='text-align:left;' >"& nomeFuncionario &"</td>"
			response.write "<td id='data' >"& Formatar_Data(Data_de_inicio) &"</td>"
			response.write "<td id='data' >"& Formatar_Data(dataFim) &"</td>"
			response.write "<td id='data' >"& dias_gozo &"</td>"
			response.write "<td id='descricao' ><input type='hidden' name='co_situacao' id='co_situacao' value='" & rs("co_situacao") & "' >"& descricao_Situacao &"</td>"
			response.write "<td id='dtcriacao' >"& dataCriacao &"</td>"
			response.write "<td id='empregadosolicitante' >"& Empregado_Solicitante &"</td>"
			response.write "<td id='dias' >"& Dias_de_abono &"</td>"
			response.write "<td id='dias' >"& obs &"</td>"
			
			'#ALTERADO 21/05/2016--------------------
			if rh then
				%>
				<td id='aviso' ><input type='checkbox' disabled="disabled" <%if rs("ic_aviso_assinado") = "True" then response.write "checked" end if%>/></td>
                 <%
                queryCoordenadorGerente = "SELECT CO_CARGO FROM VW_USUARIOS WHERE CO_MATRICULA =  '"&rs("co_matricula")&"'"
				coCargo = objConn.execute(queryCoordenadorGerente)("CO_CARGO")
				if coCargo = 1 or coCargo = 2 then %>
					<td id='substituicao' ><input type='checkbox' disabled="disabled" <%if rs("ic_substituicao") = "True" then response.write "checked" end if%>/></td>
                <%
				else
					response.write "<td></td>"
				end if
				'#ALTERADO EM 16/06/2016
                queryIdade = "select CAST(DATEDIFF(DAY, DT_NASCIMENTO, '"&Formatar_Data(Data_de_inicio)&"') / 365.25 AS INTEGER) AS idade from tb_usuarios where co_matricula = '"&Matricula&"'"
				idade = cint(objConn.execute(queryIdade)("idade"))
				if idade >= 50 and cint(dias_gozo) < 30 then
				%>
					<td id='parcelamento' ><input type='checkbox' disabled="disabled" <%if rs("ic_requerimento") = "True" then response.write "checked" end if%>/></td>
				<%
				else
					response.write "<td></td>"
				end if
			end if
			'-------------------------------------------
			if acesso_editar_admin or acesso_editar then
				if situacao = "1" and not acesso_editar_admin  then
					response.write "<td width='1%'><img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer'></td>"
				elseif acesso_editar_admin then
					response.write "<td width='1%'><img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer'></td>"
				end if
			end if
			response.Write "<input type='hidden' name='qt_parcelas' id='qt_parcelas' value='"&qt_parcelas&"'/>"
			response.Write "<input type='hidden' name='dias_gozo' id='dias_gozo' value='"&dias_gozo&"'/>"
			response.Write "<input type='hidden' name='situacao' id='situacao' value='"&situacao&"'/>"
			response.Write "<input type='hidden' name='ic_abono' id='ic_abono' value='"&ic_abono&"'/>"
			response.Write "<input type='hidden' name='co_ferias' id='co_ferias' value='"&co_ferias&"'/>"
			
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
	if rh then
	%>	<p><b>Legenda:</b></p>
    	<!--#ALTERADO EM 18/05/2016-->
    	<p><b> A</b> = Aviso de férias | <b>S</b> = Substituição | <b>R</b> = Requerimento de parcelamento/pecúnia</p>
    <%
	end if
	%>
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