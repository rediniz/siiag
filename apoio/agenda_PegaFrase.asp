
<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<%

if codFrase <> "" Then

pegaFrase = "SELECT DE_FRASE, NO_AUTOR FROM TB_FRASES WHERE CO_FRASE="&codFrase&""

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open pegaFrase, dados_sys

DE_FRASE=rs("DE_FRASE")
NO_AUTOR = rs("NO_AUTOR")


response.Write "<blockquote style='margin:13px;padding:0px;font-size:14px; font-weight:bold'>"& DE_FRASE &"    -     "&NO_AUTOR&"</blockquote>"



Else

pegaFrase = "SELECT TOP 1 CO_FRASE, DE_FRASE, NO_AUTOR FROM TB_FRASES WHERE CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NEWID()" 


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open pegaFrase, dados_sys

if rs.eof Then

Response.Write "N&atilde; h&aacute; frases cadastradas no banco - "&request.Cookies("co_usuario_unidade_siiag")&""

ELSE

DE_FRASE=rs("DE_FRASE")
NO_AUTOR = rs("NO_AUTOR")


response.Write "<blockquote style='margin:13px;padding:0px;font-size:14px; font-weight:bold'>"& DE_FRASE &"    -     "&NO_AUTOR&"</blockquote>"

End If
 
set rs = nothing
set objConn = nothing

End If

%>