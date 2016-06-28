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
		
		case "carregarEdicao"
			carregarEdicao()
		
		case "editar"
			editar()
		
		case "carregarColaboradores"
			carregarColaboradores()
		
		case else
	
	end select
		
	'==================================[SALVAR]================================================
	
	sub salvar()
	
		atividade   	= request("atividade")
		dataInicial 	= request("dataInicial")
		dataFinal   	= request("dataFinal")
		quantidadeHoras = request("quantidadeHoras")
		criador			= session("v_Usuario_Matricula")
		coordenacao 	= objConn.execute("select co_gs from vw_usuarios where co_matricula = '"&criador&"'")("co_gs")
		dataCriacao 	= date()
		
		query = "insert into tb_colaboracao_pedido (atividade, data_inicial, data_final, quantidade_horas, criador, coordenacao, data_criacao) values ('"&atividade&"', '"&dataInicial&"','"&dataFinal&"',"&quantidadeHoras&", '"&criador&"', "&coordenacao&" ,'"&dataCriacao&"')"
		
		objConn.execute(query)
	
	end sub
	
	'==================================[EDITAR]================================================
	
	sub editar()
	
		id					   = request("id")
		atividade   		   = request("atividade")
		dataInicial 		   = request("dataInicial")
		dataFinal   		   = request("dataFinal")
		quantidadeHoras 	   = request("quantidadeHoras")
		statusPedido		   = request("status")
		observacao			   = request("observacao")
		mensagemReconhecimento = request("mensagemReconhecimento")
		
		if statusPedido = 3 then
			data_conclusao 	= date()
		end if
		
		query = "update tb_colaboracao_pedido set atividade = '"&atividade&"', data_inicial = '"&dataInicial&"', data_final = '"&dataFinal&"', quantidade_horas = "&quantidadeHoras&", status = "&statusPedido&", observacao = '"&observacao&"', data_conclusao = '"&data_conclusao&"', mensagem_reconhecimento = '"&mensagemReconhecimento&"' where id = "&id&" "
		
		objConn.execute(query)
	
	end sub
	
	'==================================[CONSULTAR]==============================================

	sub consultar()
		
		dim where(4)
		dim contador
		
		dataInicial  = request("dataInicial")
		dataFinal 	 = request("dataFinal")
		atividade 	 = request("atividade")
		statusPedido = request("status")
		
		contador = 0
		
		if dataInicial  <> ""  then
			contador = contador + 1
			where(contador) = " (pedido.data_inicial = '"& dataInicial &"') "
		end if
		
		if dataFinal <> ""  then
			contador = contador + 1
			where(contador) = " (pedido.data_final = '"& dataFinal &"') "
		end if
		
		if atividade <> ""  then
			contador = contador + 1
			where(contador) = " (pedido.atividade like '%"& atividade &"%') "
		end if
		
		if statusPedido <> ""  then
			contador = contador + 1
			where(contador) = " (pedido.status = "& statusPedido &") "
		end if
		
		query = "select *, pedido.id as idPedido from tb_colaboracao_pedido as pedido join tb_status_colaboracao as status on pedido.status = status.id join tb_usuarios as usuario on pedido.criador = usuario.co_matricula "
		
		j=0
		for i=1 to contador
			if j=0 then
				query = query & " where " &  where(i)
				j=1
		   else
				query = query & " and " & where(i)
		   end If
		next
		
		query = query & " order by pedido.atividade"
		
		Pag = cint(request("pag"))
		
		if Pag = 0 then Pag = 1
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.cursorlocation = 3
		rs.Open query, dados_sys, 3, , 32
		
		if not rs.eof then
		%>

<table>
  <tr>
    <td>Atividade</td>
    <td>Data Inicial</td>
    <td>Data Final</td>
    <td>Horas</td>
    <td>Status</td>
    <td>Criador</td>
    <td>Data Criação</td>
    <td>Colaboradores</td>
    <td>Editar</td>
  </tr>
  <%
			rs.AbsolutePage = pag
			do while (not rs.eof and Abs(rs.AbsolutePage - pag) < numPag )
				queryColaboradores = "select *, colaboracao.quantidade_horas as quantidadeHoras from tb_colaboracao_pedido as pedido join tb_colaboracao as colaboracao on pedido.id = colaboracao.pedido join tb_usuarios as usuario on colaboracao.indicado = usuario.co_matricula where pedido.id = "& rs("idPedido") &""
		
				set rs2 = Server.CreateObject("ADODB.RecordSet")
				rs2.cursorlocation = 3
				rs2.Open queryColaboradores, dados_sys

				%>
  <tr>
    <td style="display:none"><input type="hidden" id="idPedido" value="<%=rs("idPedido")%>" /></td>
    <td style="display:none"><input type="hidden" id="criador" value="<%=rs("criador")%>" /></td>
    <td><%=rs("atividade")%></td>
    <td><%=rs("data_inicial")%></td>
    <td><%=rs("data_final")%></td>
    <td><%=rs("quantidade_horas")%></td>
    <td><%=rs("descricao")%></td>
    <td><%=rs("no_nome")%></td>
    <td><%=rs("data_criacao")%></td>
    <td width='1%'><%if rs2.recordcount > 0 then %><img class='colaboradores' id='colaboradores<%=rs("idPedido")%>'  colaboradores="" src='imagens/users_24x24.png' style='cursor:pointer' width="16" height="16"><% end if %></td>
    <td width='1%'><img class='editarPedido' id='editarPedido<%=rs("idPedido")%>'  src='imagens/edit.png' style='cursor:pointer;'></td>
  </tr>
  <%
				rs.movenext
			loop
			
			Controla_Pagina()
			
			%>
</table>
<%
		else
			%>
<br />
<div align="center">
  <p>Nenhum resultado a ser exibido.</p>
</div>
<%
		end if
	end sub
	
	sub carregarEdicao()
	
		id = request("id")
		
		query = "select * from tb_colaboracao_pedido where id = "&id&" "
		resultado = objConn.execute(query)
		
		%>
        <form action="colaboracao_pedido_con?acao=editar.asp" method="post" name="formularioEditar" id="formularioEditar" target="_self" enctype="application/x-www-form-urlencoded">
          <table>
            <tr>
              <td colspan="2"><input type="hidden" id="id" name="id" value="<%=id%>" /></td>
            </tr>
            <tr>
              <td align="right"><label>De</label></td>
              <td><input name="dataInicial" id="dataInicialEdicao" class="datepicker" type="text" size="10" maxlength="10" value="<%=resultado("data_inicial")%>"/>
                <label>Até</label>
                <input name="dataFinal" id="dataFinalEdicao" class="datepicker" type="text" size="10" maxlength="10" value="<%=resultado("data_final")%>"/></td>
            </tr>
            <tr>
              <td align="right"><label>Atividade</label></td>
              <td align="left"><input type="text" class="form-field" id="atividadeEdicao" name="atividade"  size="80" value="<%=resultado("atividade")%>"/></td>
            </tr>
            <tr>
              <td align="right"><label>Quantidade<br/>
                  de horas</label></td>
              <td><input style="width:20px;height:20px;font-size:14px;" class = "spinner" id="quantidadeHorasEdicao" name="quantidadeHoras" value="<%=resultado("quantidade_horas")%>" ></td>
            </tr>
            <tr>
              <td align="right"><label>Status</label></td>
              <td><select class="form-select" id="statusEdicao" name="status">
                  <option value="">Selecione...</option>
                  <%
                                    queryStatus = "select * from TB_STATUS_COLABORACAO ORDER BY descricao;" 
                                    set rs=Server.CreateObject("ADODB.RecordSet")
                                    rs.Open queryStatus, dados_sys
                                    
                                    do while not rs.eof 
                                %>
                  <option value="<%=rs("id")%>" <%if resultado("status") = rs("id") then %> selected="selected" <% end if %>><%=rs("descricao")%></option>
                  <%
                                        rs.movenext
                                    loop
                                    rs.close
                                    set rs = nothing
                                %>
                </select></td>
            </tr>
            <tr>
              <td align="right"><label>Observação</label></td>
              <td><textarea  class="form-field" name="observacao" id="observacao" cols="50" rows="5" style="max-width:470px;min-width:470px;max-height:70px;min-height:70px;"></textarea></td>
            </tr>
            <tr>
              <td></td>
            </tr>
            <tr id="linhaMensagemReconhecimento" <% if resultado("status") <> 3 then %>style="display:none"<% end if %>>
              <td align="right"><label>Mensagem de <br />Reconhecimento</label></td>
              <td><textarea  class="form-field" name="mensagemReconhecimento" id="mensagemReconhecimento" cols="50" rows="7" style="max-width:470px;min-width:470px;max-height:100px;min-height:100px;"><%=resultado("mensagem_reconhecimento")%></textarea></td>
            </tr>
            <tr>
              <td></td>
              <td><input name="editar" class="myButton" type="button" value="Editar" id="editar" /></td>
            </tr>
          </table>
        </form>
<%
		
	end sub
	
	sub carregarColaboradores()
	
		pedido = request("pedido")
		
		queryColaboradores = "select *, colaboracao.quantidade_horas as quantidadeHoras from tb_colaboracao_pedido as pedido join tb_colaboracao as colaboracao on pedido.id = colaboracao.pedido join tb_usuarios as usuario on colaboracao.indicado = usuario.co_matricula where pedido.id = "& pedido &""
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.cursorlocation = 3
		rs.Open queryColaboradores, dados_sys
		
		if not rs.eof then
		%>
        	<div id="tooltipColaboradores<%=pedido%>">
                <ul>
				  <%
					do while not rs.eof
						%>
							<li><%=rs("no_nome")%> - <%=rs("quantidadeHoras")%> hora(s)</li>
						<%
						rs.movenext
					loop
                  %>               
                </ul>
            </div>
        <%
		end if
		
		rs.close
		set rs = nothing	
	
	end sub
	
	sub Writeln(texto)
		response.write(texto)
	end sub

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
