<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
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

	
	'CAPTURA DE VARIAVEIS
	situacao = Request("situacao")
	matricula = Request("matr_colaborador")
	nome = Request("nome_colaborador")
	horario_inicio = Request("horario_inicio")
	horario_fim =  Request("horario_fim")
	coordenacao = Request("coordenacao")
	unidade = request.Cookies("co_usuario_unidade_siiag")
	'response.Write("horario_inicio:"& horario_inicio) & "<br>"

		
	strQuery = "SELECT  " 
	strQuery = strQuery &  " JORNADA.CO_SITUACAO, JORNADA.CO_JORNADA,JORNADA.CO_MATRICULA, CO_DIGITO, JORNADA.DH_ENTRADA, JORNADA.DH_SAIDA, JORNADA.DH_VIGENCIA, JORNADA.OBS_EDICAO, JORNADA.CO_SITUACAO,JORNADA.CO_CRIADOR, SITUACOES.DE_SITUACAO, USUARIOS.NO_NOME, COORDENACAO.NO_GS, JORNADA.IC_CANCELAMENTO "
	strQuery = strQuery &  " FROM TB_JORNADA AS JORNADA"
	strQuery = strQuery &  " INNER JOIN TB_SITUACOES AS SITUACOES ON JORNADA.CO_SITUACAO = SITUACOES.CO_SITUACAO"
	strQuery = strQuery &  " INNER JOIN VW_USUARIOS AS USUARIOS ON JORNADA.CO_MATRICULA = USUARIOS.CO_MATRICULA "
	strQuery = strQuery &  " INNER JOIN VW_GS AS COORDENACAO ON USUARIOS.CO_GS = COORDENACAO.CO_GS "	
		
	cont = 0
	if situacao <> "" then
		cont = cont + 1
		WHERE(cont) = " (JORNADA.CO_SITUACAO = "& situacao &") "
	end if
	
	if coordenacao <> "" then
		cont = cont + 1
		WHERE(cont) = " (COORDENACAO.CO_GS = "& coordenacao &") "
 	end if
	
	if nome <> "" then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.NO_NOME = '"& nome &"') "
	end if
	
	if matricula <> "" then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_MATRICULA = '"& matricula &"') "
	end if
	
	if horario_inicio <> "00:00" and horario_inicio <> "" then
		cont = cont + 1
		WHERE(cont) = " (JORNADA.DH_ENTRADA = '"& horario_inicio &"') "
	end if
	
	if horario_fim <> "00:00" and horario_fim <> "" then
		cont = cont + 1
		WHERE(cont) = " (JORNADA.DH_SAIDA  = '"& horario_fim &"') "
	end if

	'if request("consultaGS") then
	'	cont = cont + 1
	'	WHERE(cont) = " (USUARIOS.CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') or (USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' or JORNADA.CO_CRIADOR='" & request.Cookies("co_usuario_siiag") & "' ) "
	'elseif request("consultaTodos") = "False" then
	'	cont = cont + 1
	'	WHERE(cont) = " (USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' or JORNADA.CO_CRIADOR='" & request.Cookies("co_usuario_siiag") & "' )  "
	'end if

	if request("consultaGS") then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "')  "
	elseif request("consultaTodos") = "False" then
		cont = cont + 1
		WHERE(cont) = " (USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "')  "
	end if

	
	cont = cont + 1
	WHERE(cont) = " (JORNADA.CO_UNIDADE  = "& unidade &") "
			
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " order by JORNADA.DH_VIGENCIA desc "

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
    <div class="tabela" >
             <table>
              <tr>
                <td width="1%">Código</td>
                <td width="20%">Empregado</td>
                <td width="5%">Entrada</td>
                <td width="5%">Saída</td>
                <td width="5%">Vigência</td>
                <td width="8%">Situação</td>
                <td width="15%">Gerência</td>
                <td width="15%">Observação</td>
				<%if tem_acesso_cookie("23") then%>
	                <td width="1%">Editar</td>
				<%end if%>
				<td width="1%"> </td>

                <!--<td width="1%">Edi&ccedil;&atilde;o</td>
                <td>Cancelar</td>-->
                
              </tr>
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as variáveis
			Matricula = rs("CO_MATRICULA")
			digito = rs("CO_DIGITO")
			horario_inicio = formatdatetime(rs("DH_ENTRADA"),4)
			horario_fim = formatdatetime(rs("DH_SAIDA"),4)
			vigencia = rs("DH_VIGENCIA")
			situacao = rs("DE_SITUACAO")
			codigo = rs("CO_JORNADA")
			co_criador = rs("CO_CRIADOR")
			nome=ucase(rs("NO_NOME"))
			gerencia=rs("NO_GS")	
			obs=rs("OBS_EDICAO")	
			ic_cancelamento = rs("ic_cancelamento")		
			
			if(matricula = request.Cookies("co_usuario_siiag")) then
				podeCancelar = true
			else
				podeCancelar = false
			end if			
			
			response.write "<tr>"
			response.write "<td id='codigo' >"& codigo & "</td>"
			response.write "<td id='nome' style='text-align:left;' ><input type='hidden' name='co_situacao' id='co_situacao' value='" & rs("co_situacao") & "'>"& Matricula & "-" & digito & " - " & nome &"</td>"
			response.write "<td id='horario_inicio' >"& horario_inicio &"</td>"
			response.write "<td id='horario_fim' >"& horario_fim &"</td>"
			response.write "<td id='vigencia' >"& vigencia &"</td>"
			response.write "<td id='situacao' >"& situacao &"</td>"
			response.write "<td id='gerencia' >"& gerencia &"</td>"
			response.write "<td id='obs' >"& obs &"</td>"
			if tem_acesso_cookie("23") then
				response.write "<td width='1%'><img class='edit' src='imagens/edit.png' style='cursor:pointer'></td>"
			end if
			'response.write "<td width='1%'><img class = 'X' id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"
			'response.Write "<input type='hidden' name='co_criador' id='co_criador' value='"&co_criador&"'/>"
			
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