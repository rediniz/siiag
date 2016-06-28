<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%

	filtro = request("filtro")
	
	sql = "SELECT * FROM TB_MANUAIS_NORMATIVOS WHERE DE_MANUAL LIKE '%" & filtro & "%' OR CO_MANUAL LIKE '%" & filtro & "%'"
	
	set rs = Server.CreateObject("ADODB.RecordSet")
	rs.Open sql, dados_sys 
	
	resposta = "["
	do until rs.eof	
		resposta = resposta & "{""value"":"""&rs("de_manual")&""", ""co_manual"":"""&rs("co_manual")&""", ""de_manual"":"""&rs("de_manual")&""", ""link_manual"":"""&rs("link_manual")&"""},"						 
		rs.movenext
	loop
	
	resposta = Left(resposta,Len(resposta)-1)
	resposta = resposta & "]"
	
	if resposta = "]" then
		resposta = "[]"	
	end if
	
	response.write resposta
			
%>
