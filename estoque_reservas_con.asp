<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%
dim WHERE(3)
	dim cont
	dim query
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2
  	cod_unidade = request.Cookies("co_usuario_unidade_siiag")
	
	strQuery = " SELECT * FROM VW_ESTOQUE_RESERVAS WHERE CO_UNIDADE = '" & cod_unidade & "'  ORDER BY no_material " 
  
  objConn.execute(strQuery)
  'RESPONSE.WRITE strQuery
   
  Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não há requisições pendentes.</p>"
	Else
	%>
    <br />
    
             <table width="100%">
              <tr>
              	<td width="20%"> Material </td>
              	<td width="10%"> Qtd. Solicitada </td>
              	<td width="25%"> Solicitante </td>
              	<td width="25%"> Coordenação </td>
              	<td width="10%"> Solicitado em </td>
              </tr>
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as vari�veis
			'motivo=rs("DE_MOTIVO")
			'co_pedido = rs("CO_PEDIDO")
			co_material = rs("CO_MATERIAL")
			material=rs("NO_MATERIAL")
			qtd_reserva=rs("QT_RESERVADA")
			solicitante=rs("NO_NOME")
			coordenacao=rs("NO_GS")
			solicitado=formatdatetime(rs("DT_SOLICITACAO"),2)

			response.write "<tr>"
			response.write "<input type='hidden' id='co_pedido' name='co_pedido' value=" & co_pedido & ">"
			response.write "<input type='hidden' id='co_material' name='co_material' value=" & co_material & ">"
			'if tem_acesso("10") then
			'	response.write "<td class='atender' id='atender' ><img src='imagens/ok_16x16.png' style='cursor:pointer' title='Atender'></td>"
			'	response.write "<td class = 'rejeitar' id='rejeitar' ><img   src='imagens/delete_16x16.png' style='cursor:pointer' title='Rejeitar'></td>"
			'end if
			'response.write "<td class = 'restaurar' id='restaurar' ><img  src='imagens/refresh_16x16.png' style='cursor:pointer' title='Restaurar'></td>"
			'response.write "<td id='motivo' >"& motivo & "</td>"
			response.write "<td id='material' >"& material &"</td>"
			response.write "<td id='qtd_solicitada' >"& qtd_reserva &"</td>"
			'response.write "<td id='qtd_liberada' >"& qtd_liberada &"</td>"
			response.write "<td id='solicitante' style='text-align:left;' >"& left(solicitante,30) &"</td>"
			response.write "<td id='coordenacao' >" & coordenacao &"</td>"
			response.write "<td id='solicitado' >"& solicitado &"</td>"
			response.write "</tr>"
			rs.movenext
		LOOP
	
		Controla_Pagina()


	END IF ' fim do if da mensagem caso nao haja resultados
%>

	</table>
    <br />
<%

	objConn.close 
	set rs = nothing
	set objConn = nothing 


	Sub Writeln(texto)
		response.write(texto)
	End Sub
	
	Sub Controla_Pagina()
	
		 '****CONTROLE DE P�GINA
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
  '** FUN��O QUE PERMITE REDIRECIONAR A P�GINA COM NOVOS PAR�METROS            **
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