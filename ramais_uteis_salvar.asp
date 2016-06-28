<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->

<%
	descricao 	= request("descricao")
	numero 		= request("numero")
	co_criador 	= request.Cookies("co_usuario_siiag")
	co_unidade 	= request.Cookies("co_usuario_unidade_siiag")
	
	query = "INSERT INTO TB_RAMAIS_UTEIS (de_descricao, nu_ramal, co_criador, co_unidade) values ('"&descricao&"','"&numero&"','"&co_criador&"','"&co_unidade&"')"

	objConn.execute(query)
	
	response.Redirect("ramais_uteis.asp")
	
%>
    	
 