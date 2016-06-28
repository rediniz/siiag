<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%

	dataSolicitacaoInicial = request("dataSolicitacaoInicial")
	dataSolicitacaoFinal = request("dataSolicitacaoInicial")
	tipo = request("tipo")
	situacao = request("situacao")
	no_responsavel = request("no_responsavel")
	co_reparo = request("co_reparo")
	
	dim WHERE(10)
	dim cont
	dim querya
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2
	Pag = cint(request("pag"))
	if Pag = 0 or Pag = "" then Pag = 1	
	
	objConn.CursorLocation = 3
	
	strQuerya = "SELECT * FROM TB_REPAROS"
	
	cont = 0
	
	
	if dataSolicitacaoInicial <> "" and dataSolicitacaoFinal <> "" then
		cont = cont + 1
		WHERE(cont) = " (DH_CRIACAO BETWEEN (CONVERT(DATETIME,CAST(DAY('"&dataSolicitacaoInicial&"') AS varchar) + '/' + CAST(MONTH('"&dataSolicitacaoInicial&"') AS varchar) + '/' + CAST(YEAR('"&dataSolicitacaoInicial&"') AS varchar), 103))  AND (CONVERT(DATETIME,CAST(DAY('"&dataSolicitacaoFinal&"') AS varchar) + '/' + CAST(MONTH('"&dataSolicitacaoFinal&"') AS varchar) + '/' + CAST(YEAR('"&dataSolicitacaoFinal&"') AS varchar), 103))) " 
	end if
	
	if tipo <> "" then
		cont = cont + 1
		WHERE(cont) = " (CO_TIPO = '"& tipo &"') "
	end if
	
	if situacao <> "" then
		cont = cont + 1
		WHERE(cont) = " (CO_SITUACAO = '"& situacao &"') "
	end if
	
	if no_responsavel <> "" then
		cont = cont + 1
		WHERE(cont) = " (NO_RESPONSAVEL = '"& no_responsavel &"') "
	end if

	j=0
	
	For i=1 to cont
		If j=0 then
			Querya = Querya & " where " &  WHERE(i)
			j=1
		Else
			Querya = Querya & " and " & WHERE(i)
		End If
	Next
	
	
	strQuerya = strQuerya & Querya & " ORDER BY DH_CRIACAO DESC "
	
	set zs=Server.CreateObject("ADODB.RecordSet")
	zs.Open strQuerya, dados_sys, 3, , 32
	If zs.eof Then 'if 1
		Response.Write "<p>Não foram encontrados resultados com os parâmetros informados.</p>"
	Else

		zs.AbsolutePage = pag

%>
	

    <table name='tabela'>
        <tr>
            <td>Data de solicitação</td>
            <td>Matrícula</td>
            <td>Nome</td>
            <td>Tipo</td>
            <td>Local</td>
            <td>Situação</td>
            <td>Observação</td>
            <td>Editar</td>
            <td></td>
    	</tr>
    
    
        <%  
					do while (not zs.eof and Abs(zs.AbsolutePage - pag) < numPag )

	 				res_co_reparo = zs("CO_REPARO")
					res_dt_solicitacao = zs("DH_CRIACAO")
					res_matricula = zs("CO_RESPONSAVEL")
					res_nome = zs("NO_RESPONSAVEL")
					res_tipo = zs("CO_TIPO")
					res_local = zs("DE_LOCAL")
					res_situacao = zs("CO_SITUACAO")
					obs = zs("OBS_EDICAO")
					ic_cancelamento = zs("ic_cancelamento")	
						
					if(UCASE(res_matricula) = request.Cookies("co_usuario_siiag")) then
						podeCancelar = true
					else
						podeCancelar = false
					end if
					
					
					consultaDeTipo ="SELECT DE_TIPO FROM TB_TIPO_REPAROS WHERE CO_TIPO = " & res_tipo 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set ds=Server.CreateObject("ADODB.RecordSet")
                                                ds.Open consultaDeTipo, dados_sys
												
												
                                                if not ds.eof then
                                                    res_de_tipo=ds("DE_TIPO")						

                                                end if
                                                set ds = nothing
												
							'#Alterado em 08/12/2015 (usando agora a TB_SITUACOES original)
				    		consultaDeSituacao ="SELECT DE_SITUACAO FROM TB_SITUACOES WHERE CO_SITUACAO = " & res_situacao
                                               ' set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set ts=Server.CreateObject("ADODB.RecordSet")
                                                ts.Open consultaDeSituacao, dados_sys
												
												
                                                if not ts.eof then
                                                    res_de_situacao=ts("DE_SITUACAO")						

                                                end if
                                                set ts = nothing
												
												
				 %>
                 
                 <tr class="linha">
                     <td id="v_dt_solicitacao">
                     <input type="hidden" id="co_reparo" name="co_reparo" value="<%=res_co_reparo%>" />
                     <%=res_dt_solicitacao%>
                     </td>
                     <td id="v_matricula"> <%=res_matricula%></td>
                     <td id="v_nome"> <%=res_nome%></td>
                     <td id="v_tipo"> <%=res_de_tipo%></td>
                     <td id="v_local"> <%=res_local%></td>
                     <td id="v_situacao"> <%=res_de_situacao%></td>
                     <td id="obs"> <%=obs%></td>      
                     <td><img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer'></td>   
                     <%if podeCancelar = true and zs("co_situacao") = 2 then%>
                     <td width='10%'><img class='cancelar' id='cancelar'  src='imagens/delete_16x16.png' style='cursor:pointer; width:16px; height:16px'></td>
					 <%else%><td></td><%end if%>    
							 
                 </tr>
	 
	 <%
					zs.movenext
	
					Loop
		%> 
    
    
    
    
	</table>
 
 <%
	
	Controla_Pagina()	
	
	
	
End if ' fecha if 1

response.write "</table>"

'conexaoa.close
set objConn = nothing
set zs = nothing	

Sub Writeln(texto)
	response.write(texto)
End Sub

Sub Controla_Pagina()
	
'****CONTROLE DE PÁGINA
'response.Write(" Pag: " & Pag)
	Dim Ult
	zs.MoveLast
	zs.MoveFirst
	Ult = zs.PageCount
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
