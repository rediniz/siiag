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
		case "atualizarSaldo"
			atualizarSaldo()
		case "carregarSaldosIniciais"
			carregarSaldosIniciais()
		case else

	end select

	sub consultarSaldo()
	
		matricula = request("matricula")
		queryConsultaSaldo = "SELECT * FROM TB_ACOMPANHAMENTO_MEDICO WHERE CO_MATRICULA = '"&matricula&"'"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryConsultaSaldo, dados_sys
		
		if not rs.eof then		
			saldo = cint(rs("qtd_dias")) - cint(rs("qtd_dias_utilizados"))
		end if
		
		response.write "{'saldo':'"&saldo&"'}"
	
	end sub
	
	sub atualizarHorasDisponiveis()
	
		matricula = request("matricula")
		horasDisponiveis = request("horasDisponiveis")
	
		queryAtualizar = "UPDATE TB_ACOMPANHAMENTO_MEDICO SET QTD_HORAS = (QTD_HORAS + "&horasDisponiveis&") WHERE CO_MATRICULA = '"&matricula&"'"
		objConn.execute(queryAtualizar)
	
		response.write "{'saldo':'"&saldo&"'}"
	
	end sub
	
	sub atualizarHorasUtilizadas()
	
		matricula = request("matricula")
		quantidadeHoras = request("quantidadeHoras")
	
		queryConsultaSaldo = "UPDATE TB_ACOMPANHAMENTO_MEDICO SET QUANTIDADE WHERE CO_MATRICULA = '"&matricula&"'"
		
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryConsultaSaldo, dados_sys
		
		if not rs.eof then		
			saldo = cint(rs("qtd_dias")) - cint(rs("qtd_dias_utilizados"))
		end if
		
		response.write "{'saldo':'"&saldo&"'}"
	
	end sub
	
	sub carregarSaldosIniciais()
	
		queryMatriculas = "SELECT CO_MATRICULA, NU_JORNADA FROM TB_USUARIOS WHERE substring(co_matricula, 1, 1) = 'C'"
		set rsMatriculas = Server.CreateObject("ADODB.RecordSet")
		rsMatriculas.Open queryMatriculas, dados_sys
		
		do until rsMatriculas.eof	
			queryCarregaSaldoInicial = "DECLARE @NU_JORNADA INT; SET @NU_JORNADA = "&rsMatriculas("NU_JORNADA")&"; INSERT INTO TB_ACOMPANHAMENTO_MEDICO (CO_MATRICULA, QTD_HORAS, QTD_HORAS_UTILIZADA) VALUES ('"&rsMatriculas("CO_MATRICULA")&"',CASE @NU_JORNADA WHEN 6 THEN 12 WHEN 8 THEN 16 ELSE 12 END, 0)"
			response.write queryCarregaSaldoInicial
			objConn.execute(queryCarregaSaldoInicial)
			rsMatriculas.movenext
		loop
		
	end sub
%>