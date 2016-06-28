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
co_equipamento = request("co")



strQuery = "UPDATE TB_EQUIPAMENTOS SET EndLog = '"&endLogico&"', Usuario='"&usuario&"',Gerencia="&gerencia&",Marca='"&marca&"', Modelo='"&modelo&"',NumSerie='"&numSerie&"', Tipo='"&tipo&"',Ram='"&ram&"', Clock='"&clock&"', SisOP='"&sisOp&"' WHERE co_equipamento = " & co_equipamento & ""

'falta atualizar  Hd='"&hd&"', 

Response.Write strQuery


objConn.execute(strQuery)

objConn.close
set objConn = nothing

%>