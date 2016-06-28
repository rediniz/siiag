<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<%

pesquisa = request("pesquisa")


if pesquisa <> "" then

  QueryRamaisUteis = "SELECT * from tb_ramais_uteis WHERE de_descricao like '%"&pesquisa&"%' and co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" order by de_descricao"

else

  QueryRamaisUteis = "SELECT * from tb_ramais_uteis WHERE co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" order by de_descricao"

end if

	set ramaisUteis =	Server.CreateObject("ADODB.RecordSet")
	ramaisUteis.Open QueryRamaisUteis, dados_sys
	
	if ramaisUteis.eof Then
	
		response.write "<p>Nenhum ramal com esses parâmetros encontrado.</p>"
	
	else
	
	%>

<table>
    <tr>
    <td>Descrição</td><td>Número</td>
    </tr>
	<%
	do until ramaisUteis.eof
	
		co_sequencial = ramaisUteis("co_sequencial")
		de_descricao  = ramaisUteis("de_descricao")
		nu_ramal 	  = ramaisUteis("nu_ramal")
		co_criador 	  = ramaisUteis("co_criador")
		co_unidade    = ramaisUteis("co_unidade")
		
		%>

        <tr>
        <td><%=de_descricao%></td>
        <td><%=nu_ramal%></td>
        </tr>

    <%
	
		ramaisUteis.movenext
	
	loop
	
	end if
%>
</table>  	
 