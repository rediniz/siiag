<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	tipo = request("tipo")
	codigo = request("codigo")
	motivo = request("motivo")
	
	select case tipo
	
		case "afastamento"
			tabela = "TB_AFASTAMENTOS"
			codigoTabela = "CO_AFASTAMENTO"
		case "destacamento"
			tabela = "TB_DESTACAMENTOS"
			codigoTabela = "CO_DESTACAMENTO"
		case "ferias"
			tabela = "TB_FERIAS"
			codigoTabela = "CO_FERIAS"
		case "jornada"
			tabela = "TB_JORNADA"
			codigoTabela = "CO_JORNADA"
		case "substituicao"
			tabela = "TB_SUBSTITUICOES"
			codigoTabela = "CO_SUBSTITUICAO"
		case "emprestimo"
			tabela = "TB_EMPRESTIMO"
			codigoTabela = "CO_EMPRESTIMO"
		case "evento"
			tabela = "TB_EVENTOS"
			codigoTabela = "CO_EVENTO"
		case "reparo"
			tabela = "TB_REPAROS"
			codigoTabela = "CO_REPARO"

	end select
	
	queryCancelamento = "UPDATE "&tabela&" SET IC_CANCELAMENTO = 1, MOTIVO_CANCELAMENTO = '"&motivo&"' WHERE "&codigoTabela&" = "&codigo&""
	objConn.execute(queryCancelamento)
%>