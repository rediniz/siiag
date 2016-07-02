<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	acao = request("acao")

	select case acao
	
		case "consultarSaldo"
			consultarSaldo()
		case "adicionarHoras"
			atualizarSaldo(1)
		case "debitarHoras"
			atualizarSaldo(2)
		case "carregarSaldosIniciais"
			carregarSaldosIniciais()
		case "carregarHistorico"
			carregarHistorico()
		case else

	end select

	sub consultarSaldo()
	
		matricula = request("matricula")
		queryConsultaSaldo = "SELECT SALDO FROM TB_ACOMPANHAMENTO_MEDICO WHERE CO_MATRICULA = '"&matricula&"'"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryConsultaSaldo, dados_sys
		
		if not rs.eof then		
			saldo = rs("saldo")
		end if
		
		response.write "{""saldo"":"""&saldo&"""}"
	
	end sub
	
	sub atualizarSaldo(operacao)
	
		matricula 		= request("matricula")
		quantidadeHoras = request("quantidadeHoras")
		afastamento 	= request("afastamento")
		usuarioOperacao = session("v_usuario_matricula")
		dataOperacao 	= date()&" "&time()
		
		if afastamento = "" then
			afastamento = "NULL"
		end if
		
		if usuarioOperacao = "" then
			usuarioOperacao = "SISTEMA"
		end if
	
		querySaldoAnterior = "SELECT SALDO FROM TB_ACOMPANHAMENTO_MEDICO WHERE CO_MATRICULA = '"&matricula&"'"
		saldoAnterior = objConn.execute(querySaldoAnterior)("SALDO")
		
		if operacao = 1 then
			saldoNovo = cint(saldoAnterior) + cint(quantidadeHoras)
			queryAtualizar = "UPDATE TB_ACOMPANHAMENTO_MEDICO SET QTD_HORAS = (QTD_HORAS + "&quantidadeHoras&"), SALDO = "&saldoNovo&" WHERE CO_MATRICULA = '"&matricula&"'"
		else
			saldoNovo = cint(saldoAnterior) - cint(quantidadeHoras)
			queryAtualizar = "UPDATE TB_ACOMPANHAMENTO_MEDICO SET QTD_HORAS_UTILIZADA = (QTD_HORAS_UTILIZADA + "&quantidadeHoras&"), SALDO = "&saldoNovo&" WHERE CO_MATRICULA = '"&matricula&"'"
		end if
		
		objConn.execute(queryAtualizar)
		
		queryAtualizarHistorico = "INSERT INTO TB_ACOMPANHAMENTO_HISTORICO (CO_MATRICULA, CO_USUARIO_OPERACAO, DT_OPERACAO, TIPO_OPERACAO, QTD_MODIFICADA, SALDO_ANTERIOR, SALDO, CO_AFASTAMENTO) VALUES ('"&matricula&"', '"&usuarioOperacao&"', '"&dataOperacao&"',"&operacao&", "&quantidadeHoras&","&saldoAnterior&","&saldoNovo&","&afastamento&")"
		
		objConn.execute(queryAtualizarHistorico)
	
		response.write "{""saldo"":"""&saldoNovo&"""}"
	
	end sub
	
	sub carregarSaldosIniciais()
	
		response.write "Executando a query...<br>"
		
		queryMatriculas = "SELECT CO_MATRICULA, CO_CARGO FROM TB_USUARIOS WHERE substring(co_matricula, 1, 1) = 'C'"
		set rsMatriculas = Server.CreateObject("ADODB.RecordSet")
		rsMatriculas.Open queryMatriculas, dados_sys
		
		queryLimparTabelas = "DELETE FROM TB_ACOMPANHAMENTO_MEDICO; DELETE FROM TB_ACOMPANHAMENTO_HISTORICO;"
		objConn.execute(queryLimparTabelas)
		
		do until rsMatriculas.eof	
			queryCarregaSaldoInicial = "DECLARE @CO_CARGO INT; SET @CO_CARGO = "&rsMatriculas("CO_CARGO")&"; INSERT INTO TB_ACOMPANHAMENTO_MEDICO (CO_MATRICULA, QTD_HORAS, QTD_HORAS_UTILIZADA, SALDO) VALUES ('"&rsMatriculas("CO_MATRICULA")&"',CASE @CO_CARGO WHEN 2 THEN 16 ELSE 12 END, 0,CASE @CO_CARGO WHEN 2 THEN 16 ELSE 12 END); " &_
	 "INSERT INTO TB_ACOMPANHAMENTO_HISTORICO (CO_MATRICULA, CO_USUARIO_OPERACAO, DT_OPERACAO, TIPO_OPERACAO, QTD_MODIFICADA, SALDO_ANTERIOR, SALDO, CO_AFASTAMENTO) VALUES ('"&rsMatriculas("CO_MATRICULA")&"', 'SISTEMA', '"&date()&" "&time()&"',1, CASE @CO_CARGO WHEN 2 THEN 16 ELSE 12 END, 0,CASE @CO_CARGO WHEN 2 THEN 16 ELSE 12 END,NULL)"
			
			objConn.execute(queryCarregaSaldoInicial)

			rsMatriculas.movenext
		loop
		
		response.write "Query executada com sucesso. Checar tabelas <b>TB_ACOMPANHAMENTO_MEDICO</b> e <b>TB_ACOMPANHAMENTO_HISTORICO</b>."
		
	end sub
	
	sub carregarHistorico()
		matricula = request("matricula")
		%>
	  <div class='tabela'>
		<table>
		  <tr>
			<td colspan="4">Extrato de horas para Acompanhamento Médico</td>
		  </tr>
		  <%
			queryHistorico = "SELECT * FROM TB_ACOMPANHAMENTO_HISTORICO WHERE CO_MATRICULA = '"&matricula&"'"
			set rsHistorico = Server.CreateObject("ADODB.RecordSet")
			rsHistorico.Open queryHistorico, dados_sys
			
			if not rsHistorico.eof then
			%>
			<tr>
                <td>Data</td>
                <td>Matrícula</td>
                <td>Quantidade</td>
                <td>Saldo</td>
		  	</tr>
          	<%
			end if
			do until rsHistorico.eof
				%>
				  <tr>
					<td><%=rsHistorico("DT_OPERACAO")%></td>
					<td><%=rsHistorico("CO_USUARIO_OPERACAO")%></td>
					<td><% 		
						if rsHistorico("TIPO_OPERACAO") = 1 then
							cor = "#090"
							sinal = "+"
						else
							cor = "#F00"
							sinal = "-"
						end if
						%>
					<span style="color:<%=cor%>"><%=sinal%><%=rsHistorico("QTD_MODIFICADA")%></span>
					</td>
					<td><%=rsHistorico("SALDO")%></td>
				  </tr>
				<%
				rsHistorico.movenext
			loop
			
			rsHistorico.close
		  %>
		</table>
	  </div>
	<%
	end sub
%>