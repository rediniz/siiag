<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	dim WHERE(4)
	dim cont
	Query1 = ""
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2

	unidade = request.Cookies("co_usuario_unidade_siiag")

	'set objConn = 	server.CreateObject("ADODB.Connection") 
	'dados_sys = 	"Provider=sqloledb;Data Source=CE7180SR001;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"

	
	'CAPTURA DE VARIAVEIS
	enderecoLogico = Request("enderecoLogico")
	gerencia = Request("gerencia")
	tipo = Request("tipo")
		
	strQuery = "SELECT" 
	strQuery = strQuery &  " EndLog,Usuario,Marca,Modelo,NumSerie,Tipo,Hd,Ram,Clock,SisOp, co_equipamento"
	strQuery = strQuery &  " FROM TB_EQUIPAMENTOS"
	

	cont = 0
	if gerencia <> "" then
		cont = cont + 1
		WHERE(cont) = " (Gerencia = "& gerencia &") "
	end if
	
	if tipo <> "" then
		cont = cont + 1
		WHERE(cont) = " (Tipo = '"& tipo &"') "
 	end if
	
	if enderecoLogico <> "" then
		cont = cont + 1
		WHERE(cont) = " (EndLog = '"& enderecoLogico &"' )"
	end if
	
	if unidade <> "" then
		cont = cont + 1
		WHERE(cont) = " (CO_UNIDADE='"&request.Cookies("co_usuario_unidade_siiag")&"')"
	end if
	
	
	
	
	j=0
	For i=1 to cont
		If j=0 then
			Query1 = Query1 & " where " &  WHERE(i)
			j=1
	   Else
			Query1 = Query1 & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " order by Usuario"
	
	'strQuery = strQuery & Query & ordem
	strQuery = strQuery & Query1 & ordem
	
	'Response.Write strQuery
	Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
	Else
	%>
    <br />
    		<div class='tabela' align="center">
             <table>
              <tr>
                <td width="9%">Endere&ccedil;o L&oacute;gico</td>
                <td width="10%" >Usu&aacute;rio</td>
                <td width="9%">Marca</td>
                <td width="13%" >Modelo</td>
                <td width="13%">N&uacute;mero de S&eacute;rie</td>
                <td width="9%" >Tipo</td>
                <td width="5%" >HD</td>
                <td width="5%" >Ram</td>
                <td width="9%" >Clock</td>
                <td width="13%" >Sistema Operacional</td>
				<%if tem_acesso("11") then %>
	                <td width="5%" ></td>        
                <%end if%>        
              </tr>
	<%
	
		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
			'atribuindo os valores dos campos as variáveis
			EndLog=rs("EndLog")
			Usuario=rs("Usuario")
			Marca=rs("Marca")
			Modelo=rs("Modelo")
			NumSerie=rs("NumSerie")
			Tipo = rs("Tipo")
			Hd = rs("Hd")
			Ram = rs("Ram")
			Clock = rs("Clock")
			SisOp = rs("SisOp")
			co_equipamento = rs("co_equipamento")
			
			response.write "<tr>"
			response.write "<td id='EndLog' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& EndLog & "</td>"
			response.write "<td id='Usuario' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& Usuario &"</td>"
			response.write "<td id='Marca' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& Marca &"</td>"
			response.write "<td id='Modelo' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& Modelo &"</td>"
			response.write "<td id='NumSerie' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& NumSerie &"</td>"
			response.write "<td id='Tipo' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& Tipo &"</td>"
			response.write "<td id='Hd' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& Hd &"</td>"
			response.write "<td id='Ram' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& Ram &"</td>"
			response.write "<td id='Clock' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& Clock &"</td>"
			response.write "<td id='SisOp' onclick='window.navigate(""equipamentos_editar.asp?co=" & rs("co_equipamento") & """);' >"& SisOp &"</td>"
		    if tem_acesso("11") then
				response.write "<td id='' >"
				response.write "<img src='imagens\edit-document_16x16.png' title='editar equipamento' style='cursor:pointer;' onclick='window.navigate(""equipamentos_editar.asp?co=" & co_equipamento & """);' /> "
				response.write "<img src='imagens\delete_16x16.png' class = 'X' id='X' title='excluir equipamento' style='cursor:pointer;' />"
				response.Write "<input type='hidden' name='co_equipamento' id='co_equipamento' value='"&co_equipamento&"'/>"
				response.write "</td>"
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

	'objConn.close 
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