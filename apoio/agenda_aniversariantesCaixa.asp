<%@LANGUAGE="VBScript" CODEPAGE="65001"%><head>
<!-- #INCLUDE FILE ="../include/funcoes.asp" -->
		<link href="../tabela.css" rel="stylesheet" type="text/css" />
		<link href="../menu.css" rel="stylesheet" type="text/css" />
</head>

<!-- #INCLUDE FILE ="../include/Conexao.asp" -->


<div class='tabela'>


<%

dataPesquisar = Request("data")

dataTotal = Date() 'pegando a data total
mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)



if dataPesquisar <> "" Then



strQuery = "SELECT TB.DT_ADMISSAO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_ADMISSAO))+'/'+STR(MONTH(DT_ADMISSAO))+'/'+ STR(YEAR('"&dataPesquisar&"')),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ( aniv = convert(datetime, STR(day('"&dataPesquisar&"'))+'/'+str(month(getdate()))+'/'+str(year('"&dataPesquisar&"')), 103) or (DATEPART(DW,'"&dataPesquisar&"') = 6 AND ANIV BETWEEN STR(day('"&dataPesquisar&"'))+'/'+str(month('"&dataPesquisar&"'))+'/'+str(year('"&dataPesquisar&"')) AND DATEADD(D,2,STR(day('"&dataPesquisar&"'))+'/'+str(month(getdate()))+'/'+str(year('"&dataPesquisar&"')))) OR (DATEPART(DW,'"&dataPesquisar&"') = 2 AND ANIV BETWEEN DATEADD(D,-2,STR(day('"&dataPesquisar&"'))+'/'+str(month('"&dataPesquisar&"'))+'/'+str(year('"&dataPesquisar&"'))) AND STR(day('"&dataPesquisar&"'))+'/'+str(month('"&dataPesquisar&"'))+'/'+str(year('"&dataPesquisar&"')) )) ORDER BY NO_NOME"
 

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	IF rs.eof Then
	
		response.Write "<p>N&atilde;o h&aacute; aniversariantes de CAIXA hoje.</p>"
		
	ELSE	
	
	Response.Write "<table>"
    Response.Write "<tr>"
    Response.Write "<td width='8%'>Nome</td>"
    Response.Write "<td width='10%' >Data de Admiss&atilde;o</td>"
    Response.write"</tr>"
	
	DO UNTIL rs.eof
	
	NO_NOME=rs("NO_NOME")
	
	DATA_ADMISSAO=rs("DT_ADMISSAO")
	
	response.Write "<tr>"	
	response.Write "<td>"& NO_NOME &"</td>"
	response.Write "<td>"& Formatar_Dia(DAY(DATA_ADMISSAO))&"/"&Formatar_Mes(MONTH(DATA_ADMISSAO)) &"</td>"
	response.write "</tr>"
	
	rs.movenext
	LOOP
	
	End If
	
	

set rs = nothing
set objConn = nothing


ELSE


strQuery = "SELECT TB.DT_ADMISSAO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_ADMISSAO))+'/'+STR(MONTH(DT_ADMISSAO))+'/'+ STR(YEAR(getdate())),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ( aniv = convert(datetime, STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate())), 103) or (DATEPART(DW,getdate()) = 6 AND ANIV BETWEEN STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate())) AND DATEADD(D,2,STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate())))) OR (DATEPART(DW,getdate()) = 2 AND ANIV BETWEEN DATEADD(D,-2,STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate()))) AND STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate())) )) ORDER BY NO_NOME"
 

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	IF rs.eof Then
	
		response.Write "<p>N&atilde;o h&aacute; aniversariantes de CAIXA hoje.</p>"
		
	ELSE	
	
	Response.Write "<table>"
    Response.Write "<tr>"
    Response.Write "<td width='8%'>Nome</td>"
    Response.Write "<td width='10%' >Data de Admiss&atilde;o</td>"
    Response.write"</tr>"
	
	DO UNTIL rs.eof
	
	NO_NOME=rs("NO_NOME")
	
	DATA_ADMISSAO=rs("DT_ADMISSAO")
	
	response.Write "<tr>"	
	response.Write "<td>"& NO_NOME &"</td>"
	response.Write "<td>"& Formatar_Dia(DAY(DATA_ADMISSAO))&"/"&Formatar_Mes(MONTH(DATA_ADMISSAO)) &"</td>"
	response.write "</tr>"
	
	rs.movenext
	LOOP
	
	End If
	
	

set rs = nothing
set objConn = nothing

End If

%>
</table>
</div>