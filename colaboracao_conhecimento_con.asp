<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE = "include/conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%	
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"

	acao = request("acao")
	
	select case acao
		case "salvar"	
			salvar()
			
		case "consultar"	
			dim rs	
			dim tagPAG
			tagPAG = "pag"
			dim Pag 
			dim numPag
			numPag = 2
			
			consultar()
			
		case "cadastrarNovoConhecimento"
			cadastrarNovoConhecimento()
			
		case "atualizarTiposConhecimento"
			atualizarTiposConhecimento()
			
		case else
	
	end select
		
	'==================================[SALVAR]================================================
	
	sub salvar()
	
		empregado = request("empregado")
		tipo = request("tipoConhecimento")
		
		query = "insert into tb_colaboracao_conhecimento values ('"&empregado&"', "&tipo&")"
		objConn.execute(query)
	
	end sub
	
	'==================================[CONSULTAR]==============================================
	
	sub consultar()
		
		dim where(2)
		dim contador
		
		coordenacao = request("coordenacao")
		conhecimento = request("conhecimento")
		
		contador = 0
		
'		if coordenacao <> ""  then
'			contador = contador + 1
'			where(contador) = " (usuario.co_gs = "& coordenacao &") "
'		end if
		
		if conhecimento <> ""  then
			contador = contador + 1
			where(contador) = " (id = "& conhecimento &") "
		end if
		
		'query = "select usuario.no_gs as coordenacao, usuario.no_nome as nomeEmpregado, tipo_conhecimento.descricao as descricaoConhecimento from tb_colaboracao_conhecimento as colaboracao_conhecimento join vw_usuarios as usuario on colaboracao_conhecimento.empregado = usuario.co_matricula join tb_tipo_conhecimento as tipo_conhecimento on colaboracao_conhecimento.tipo = tipo_conhecimento.id"
		
		query = "select * from tb_tipo_conhecimento"
		
		j=0
		for i=1 to contador
			if j=0 then
				query = query & " where " &  where(i)
				j=1
		   else
				query = query & " and " & where(i)
		   end If
		next
		
		query = query & " order by descricao"
		
		Pag = cint(request("pag"))
		if Pag = 0 then Pag = 1
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open query, dados_sys, 3, , 32
		
		if not rs.eof then
		%>
	
		<table>
			<tr>
                <td width="70%">Conhecimento</td>
                <td width="30%">Nº de empregados com o conhecimento</td>
			</tr>
			<%
				rs.AbsolutePage = pag
				do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
						queryEmpregados = "select * from tb_colaboracao_conhecimento as conhecimento join tb_tipo_conhecimento as tipo_conhecimento on conhecimento.tipo = tipo_conhecimento.id join vw_usuarios as usuario on conhecimento.empregado = usuario.co_matricula where tipo_conhecimento.id = " & rs("id") & " "
						if(coordenacao <> "")then
							queryEmpregados = queryEmpregados & " and usuario.co_gs = " &coordenacao& " "
						end if
						queryEmpregados = queryEmpregados& " order by no_gs, no_nome"
						set rs2 = Server.CreateObject("ADODB.RecordSet")
						rs2.cursorlocation = 3			
						rs2.open queryEmpregados, dados_sys
					%>
					<tr <% if rs2.recordcount > 0 then %> style="cursor:pointer"  class="linhaConhecimento" <% end if %>  idConhecimento="<%=rs("id")%>">
                        <td><% if rs2.recordcount > 0 then %> <img class = "setaConhecimento" id="setaConhecimento<%=rs("id")%>" src="imagens/setalado.png" style="vertical-align:middle; float:left"/><% end if %> <b><%=rs("descricao")%></b></td>
                        <td><%=rs2.recordcount%></td>
                    </tr>
					<%
						if not rs2.eof then
							%>
							<div id="teste" style="display:none">
								<tr class = "conhecimento conhecimento<%=rs("id")%>" style="background:#CCC;display:none">
									<td>Empregado</td>
									<td>Coordenação</td>
								</tr>	
							 <%		
								do while not rs2.eof 
									%>
										<tr class = "conhecimento conhecimento<%=rs("id")%>" style="background:#E8E8E8;display:none">
											<td><%=rs2("no_nome")%></td><td><%=rs2("no_gs")%></td>
										</tr>
									<%
									rs2.movenext
								loop
							%>
							</div>
							<%
						end if
					%>
                    </tr>
				<%
				rs.movenext
			loop
			
			Controla_Pagina()
			
			%>
		</table>
		<%
		else
			%>	<br />
				<div align="center"><p>Nenhum resultado a ser exibido.</p></div>
			<%
		end if
	end sub
	
	'=======================[CADASTRAR NOVO TIPO DE CONHECIMENTO]================================
	
	sub cadastrarNovoConhecimento()
	
		descricaoNovoConhecimento = request("descricaoNovoConhecimento")
		
		query = "insert into tb_tipo_conhecimento values ('"&descricaoNovoConhecimento&"')"
		objConn.execute(query)
		
	end sub
	
	'=======================[ATUALIZAR TIPOS DE CONHECIMENTO]================================
	sub atualizarTiposConhecimento()
	
		descricaoNovoConhecimento = request("descricaoNovoConhecimento")
		
		%>
		<option value=''>Selecione o tipo de conhecimento...</option>
			<%
				query = "SELECT * from TB_TIPO_CONHECIMENTO order by descricao"
				set rs = Server.CreateObject("ADODB.RecordSet")
				rs.Open query, dados_sys
			
				DO UNTIL rs.eof
					idConhecimento = rs("id")
					descricaoConhecimento = rs("descricao")
				%>
					<option value=<%=idConhecimento%> <%if descricaoNovoConhecimento = descricaoConhecimento then %> selected="selected" <%end if%>><%=descricaoConhecimento%></option>
				<%
					rs.movenext
				LOOP
				
				rs.close 
				set rs = nothing      
	end sub
	
	Sub Writeln(texto)
		response.write(texto)
	End Sub
	
	sub Controla_Pagina()

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
	  Response.Write "<input type='button' class='myButton paginacao'"
	  If (Pag <= numPag) Then Response.Write " disabled "
	  Response.Write " value='&lt;&lt;'>"

			
	  Response.Write "<input type='button' id='anterior' class='myButton paginacao'"
	  If (Pag <= numPag) Then Response.Write " disabled "
	  Response.Write " value='&lt;'>"
			
	  WriteLn "		</td>"
	  WriteLn "		<td>"
	  Response.Write "p&aacute;gina &nbsp;"
	  Response.Write "<input size=3 type='text'  class='form-field' id = 'inputPagina' value='" & CStr(Round(Pag / numPag + 0.5, 0)) & "'>&nbsp;"
	  if Ult = numPag then
		 Response.Write "de&nbsp;" & Ult/numPag & Chr(13)
	  else
		  Response.Write "de&nbsp;" & CStr(Round(Ult / numPag + 0.5, 0)) & Chr(13)
	  end if
	  WriteLn "		</td>"
	  WriteLn "		<td>"

	  Response.Write "<input type='button' id='proxima' class='myButton paginacao'"
	  If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
	  Response.Write " value='&gt;' >"


	  
	  Response.Write "<input type='button' id='ultima' class='myButton paginacao'"
	  If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
	  WriteLn " value='&gt;&gt;'>"

	  WriteLn "		</td>"
	  WriteLn "		</tr>"
	  WriteLn "	</table>"
	  WriteLn " <input type='hidden' id='pag' value='"&numPag&"' />"
	  WriteLn " <input type='hidden' id='ultimaPagina' value='"&Ult&"' />"

	  '***** FIM CONTROLA PAGINA

	end sub
%>