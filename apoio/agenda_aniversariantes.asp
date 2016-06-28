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

'strQuery = "SELECT NO_NOME, DT_NASCIMENTO FROM VW_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"') AND CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" and ic_ativo = 1 ORDER BY NO_NOME "

'strQuery = "set language portuguese declare @data datetime set @data = CONVERT(DATETIME,'26/05/2014',103) SELECT  tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_NASCIMENTO))+'/'+STR(MONTH(DT_NASCIMENTO))+'/'+ STR(YEAR(@data)),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= 7180) tb WHERE ( aniv = @data or (DATEPART(DW,@DATA) = 6 AND ANIV BETWEEN @DATA AND DATEADD(D,2,@DATA)) OR (DATEPART(DW,@DATA) = 2 AND ANIV BETWEEN DATEADD(D,-2,@DATA) AND @DATA )) ORDER BY NO_NOME"

'strQuery = "set language portuguese declare @data datetime set @data = CONVERT(DATETIME,'26/05/2014',103) "

if dataPesquisar <> "" Then



strQuery = "SELECT TB.DT_NASCIMENTO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_NASCIMENTO))+'/'+STR(MONTH(DT_NASCIMENTO))+'/'+ STR(YEAR(getdate())),103) as aniv from tb_usuarios where ic_ativo = 1 AND IC_NAO_EXIBIR_ANIV = 0 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ( aniv = convert(datetime, STR(day('"&dataPesquisar&"'))+'/'+str(month('"&dataPesquisar&"'))+'/'+str(year('"&dataPesquisar&"')), 103) or (DATEPART(DW,'"&dataPesquisar&"') = 6 AND ANIV BETWEEN '"&dataPesquisar&"' AND DATEADD(D,2,'"&dataPesquisar&"')) OR (DATEPART(DW,'"&dataPesquisar&"') = 2 AND ANIV BETWEEN DATEADD(D,-2,'"&dataPesquisar&"') AND '"&dataPesquisar&"' )) ORDER BY NO_NOME"


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

IF rs.eof Then
		response.Write "<p>N&atilde;o h&aacute; aniversariantes hoje.</p>"		
	ELSE	
		response.write ""
		Response.Write "<table style='height:100px;' >"
		Response.Write "<tr>"
		Response.Write "<td width='8%' height='1%'>Nome</td>"
		Response.Write "<td width='8%' height='1%'>Data</td>"
		Response.write"</tr>"
		
		DO UNTIL rs.eof
		
			Nome=rs("NO_NOME")
			
			dataBanco=rs("DT_NASCIMENTO")
			
			diaBanco=DAY(dataBanco)
			mesBanco=MONTH(dataBanco)
		
			response.Write "<tr>"	
			response.Write "<td>"&Nome&"</td>"
			response.Write "<td>"& Formatar_Dia(diaBanco) & "/" & Formatar_Mes(mesBanco) &"</td>"
			response.write "</tr>"
		
		rs.movenext
		LOOP
	
	End If

set rs = nothing
set objConn = nothing



Else


strQuery = "SELECT TB.DT_NASCIMENTO, tb.no_nome, tb.aniv from (select *, CONVERT(DATETIME, STR(DAY(DT_NASCIMENTO))+'/'+STR(MONTH(DT_NASCIMENTO))+'/'+ STR(YEAR(getdate())),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= "&request.Cookies("co_usuario_unidade_siiag")&") tb WHERE ( aniv = convert(datetime, STR(day(getdate()))+'/'+str(month(getdate()))+'/'+str(year(getdate())), 103) or (DATEPART(DW,getdate()) = 6 AND ANIV BETWEEN getdate() AND DATEADD(D,2,getdate())) OR (DATEPART(DW,getdate()) = 2 AND ANIV BETWEEN DATEADD(D,-2,getdate()) AND getdate() )) ORDER BY NO_NOME"

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys
'response.write strQuery

	IF rs.eof Then
		response.Write "<p>N&atilde;o h&aacute; aniversariantes hoje.</p>"		
	ELSE	
		response.write ""
		Response.Write "<table style='height:100px;' >"
		Response.Write "<tr>"
		Response.Write "<td width='8%' height='1%'>Nome</td>"
		Response.Write "<td width='8%' height='1%'>Data</td>"
		Response.write"</tr>"

		DO UNTIL rs.eof
		
			Nome=rs("NO_NOME")
			
			dataBanco=rs("DT_NASCIMENTO")
			
			diaBanco=DAY(dataBanco)
			mesBanco=MONTH(dataBanco)
		
			response.Write "<tr>"	
			response.Write "<td>"&Nome&"</td>"
			response.Write "<td>"& Formatar_Dia(diaBanco) & "/" & Formatar_Mes(mesBanco) &"</td>"
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