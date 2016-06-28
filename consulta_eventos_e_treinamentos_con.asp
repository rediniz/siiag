<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	dim WHERE(10)
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
	tipo = Request("tipo")
	
	
	strQuery = "SELECT  " 
	strQuery = strQuery &  " EVENTOS.CO_EVENTO,  EVENTOS.OBS_EDICAO, EVENTOS.CO_SITUACAO, EVENTOS.DE_EVENTO,  EVENTOS.DH_INICIO, EVENTOS.DH_FIM,  EVENTOS.DH_CRIACAO, EVENTOS.CO_CRIADOR, EVENTOS.QT_PARTICIPANTES,TIPO.DE_TIPO_EVENTO,SITUACOES.DE_SITUACAO,GS.NO_GS,LOCAL.DE_LOCAL, EVENTOS.IC_CANCELAMENTO "
	strQuery = strQuery &  " FROM TB_EVENTOS AS  EVENTOS "
	strQuery = strQuery &  " INNER JOIN TB_TIPOS_EVENTO AS TIPO ON TIPO.CO_TIPO_EVENTO = EVENTOS.CO_TIPO_EVENTO "
	
	strQuery = strQuery &  " INNER JOIN TB_SITUACOES AS SITUACOES ON SITUACOES.CO_SITUACAO = EVENTOS.CO_SITUACAO "
	strQuery = strQuery &  " INNER JOIN VW_GS AS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA "
	strQuery = strQuery &  " INNER JOIN TB_LOCAL AS LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL"
	
	'if usuario <> "" then
	'strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA "
	'end if
	'	strQuery = strQuery &  "  WHERE) order by FERIAS.DT_INICIO desc  "	
	
	cont = 0
	if situacao <> "" then
		cont = cont + 1
		WHERE(cont) = " (EVENTOS.CO_SITUACAO = "& situacao &") "
	end if
	
	if tipo <> "" then
		cont = cont + 1
		WHERE(cont) = " (TIPO.CO_TIPO_EVENTO = '"& tipo &"') " 
 	end if

	if data_inicio <> "" and data_final <> "" then
		cont = cont + 1
		WHERE(cont) = " (EVENTOS.DH_INICIO >= '"& data_inicio &"' AND EVENTOS.DH_FIM <= '"& data_final &"') "
	end if
	
	cont = cont + 1
	WHERE(cont) = " (EVENTOS.CO_UNIDADE = '"& request.Cookies("co_usuario_unidade_siiag") &"') "
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " order by EVENTOS.DH_INICIO DESC"

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
             <table  >
              <tr>
                <td width="8%">Tipo Evento</td>
                <td width="10%" >Situa&ccedil;&atilde;o</td>
     <!--           <td width="8%">Criador</td>    -->
                <td width="15%" >Evento</td>
                <td width="15%">Per&iacute;odo</td>
                <td width="17%" >Local</td>
                <td width="15%" >Iniciativa</td>
                <td width="5%" >Qtd de<br>Particip</td>
                <td width="8%" >Criador</td>
                <td width="20%" >Observação</td>
                <td width="7%">Editar</td>
                <td></td>
              </tr>
              
              
          
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as variáveis
			
			
		 
		 	CO_EVENTO = rs("CO_EVENTO")
			DE_TIPO_EVENTO=rs("DE_TIPO_EVENTO")
			DE_SITUACAO = rs("DE_SITUACAO")
			'CO_CRIADOR=rs("CO_CRIADOR")
			CO_SITUACAO = RS("CO_SITUACAO")
			DE_EVENTO=rs("DE_EVENTO")
			DH_INICIO = rs("DH_INICIO")
			DH_FIM = rs("DH_FIM")
			DE_LOCAL = rs("DE_LOCAL")
			NO_GS =rs("NO_GS")
			QT_PARTICIPANTES= rs("QT_PARTICIPANTES")
			CO_CRIADOR = rs("CO_CRIADOR")
			obs = rs("OBS_EDICAO")
			ic_cancelamento = rs("ic_cancelamento")	
							
			if(ucase(CO_CRIADOR) = request.Cookies("co_usuario_siiag")) then
				podeCancelar = true
			else
				podeCancelar = false
			end if
			

			'FORMATANDO DATA INICIAL 
			diaInicio = DAY(DH_INICIO) ' PEGANDO SO O DIA INICIAL
			mesInicio = MONTH(DH_INICIO) ' PEGANDO SO O MES INICIAL
			anoInicio = YEAR(DH_INICIO) ' PEGANDO SO O ANO INICIAL
			
			data_inicio_total = diaInicio &"/"& mesInicio& "/"& anoInicio ' FORMATANDO A DATA PARA QUE APARECA DE FORMA DD/MM/YYYY	

			'FIM DA FORMATACAO DA DATA INICIAL

			'FORMATANDO DATA FINAL
			diaFim = DAY(DH_FIM) ' PEGANDO SO O DIA INICIAL
			mesFim = MONTH(DH_FIM) ' PEGANDO SO O MES INICIAL
			anoFim = YEAR(DH_FIM) ' PEGANDO SO O ANO INICIAL
			
			data_fim_total = diaFim &"/"& mesFim& "/"& anoFim ' FORMATANDO A DATA PARA QUE APARECA DE FORMA DD/MM/YYYY	

			'FIM DA FORMATACAO DA DATA FINAL

			response.write "<tr>"
			response.write "<td id='DE_TIPO_EVENTO' ><input type='hidden' id='co_evento' name='co_evento' value="&CO_EVENTO&">"& DE_TIPO_EVENTO & "</td>"
			response.write "<td id='DE_SITUACAO' ><input type='hidden' id='co_situacao' name='co_situacao' value="&CO_SITUACAO&">"& DE_SITUACAO &"</td>"
			'response.write "<td id='CO_CRIADOR' >"& CO_CRIADOR &"</td>"
			response.write "<td id='DE_EVENTO' >"& DE_EVENTO &"</td>"
			response.write "<td id='PERIODO' >"& Formatar_Data(data_inicio_total) &"  -  "&Formatar_Data(data_fim_total)&"</td>"
			response.write "<td id='DE_LOCAL' >"& DE_LOCAL &"</td>"
			response.write "<td id='NO_GS' >"& NO_GS &"</td>"
			response.write "<td id='QT_PARTICIPANTES' >"& QT_PARTICIPANTES &"</td>"
			response.write "<td id='CO_CRIADOR' >"& CO_CRIADOR &"</td>"
			response.write "<td id='obs' >"& obs &"</td>"
			response.write "<td width='3%'>"
			if not ISNULL(rs("QT_PARTICIPANTES"))  THEN
				response.write "<img class='lista' id='lista'  src='imagens/edit-paste_002.png' style='cursor:pointer' title='Lista de Frequência'>"
			end if
			response.write "<img class='edit' id='edit'  src='imagens/edit_23_23.png' width='23' height='23' style='cursor:pointer' title='Editar'>"
			response.write "</td>"
			
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