<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
 
<%

endLogico 	= request("endLogico")
usuario 	= request("usuario")
gerencia	= request("gerencia")
marca 		= request("marca")
modelo 		= request("modelo")
numSerie 	= request("numSerie")
tipo 		= request("tipo")
hd			= request("hd")
ram			= request("ram")
clock		= request("clock")
sisOp		= request("sisOp")
co_unidade 	= request.Cookies("co_usuario_unidade_siiag")

	
strQuery = "INSERT INTO TB_EQUIPAMENTOS (EndLog, Usuario, Gerencia, Marca, Modelo, NumSerie, Tipo, Hd, Ram, Clock, SisOP, co_unidade) values ('"&endLogico&"', '"&usuario&"', "&gerencia&", '"&marca&"', '"&modelo&"', '"&numSerie&"','"&tipo&"','" & hd & "','"&ram&"', '"&clock&"','"&sisOp&"',"&co_unidade&")"

'response.write strQuery

objConn.execute(strQuery)

objConn.close
set objConn = nothing

%>