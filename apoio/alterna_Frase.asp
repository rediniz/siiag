
<%
'pegaFrase = "SELECT CO_FRASE, DE_FRASE, NO_AUTOR FROM TB_FRASES WHERE CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"" 
pegaFrase = "SELECT CO_FRASE, DE_FRASE, NO_AUTOR FROM TB_FRASES " 


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open pegaFrase, dados_sys

if rs.eof Then

Response.Write "N&atilde; h&aacute; frases cadastradas no banco - "&request.Cookies("co_usuario_unidade_siiag")&""

ELSE

Response.Write "<select class='form-field' style='width:310px;height:40px;' id='mudaFrase' >"



DO UNTIL rs.eof
DE_FRASE=rs("DE_FRASE")
NO_AUTOR = rs("NO_AUTOR")
CO_FRASE = rs("CO_FRASE")


response.Write "<option value='"&CO_FRASE&"'>"& DE_FRASE &"  - "&NO_AUTOR&"</option>"

rs.movenext
LOOP

Response.Write "</select>"
End If
 
set rs = nothing
set objConn = nothing

%>