<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<!-- #INCLUDE FILE ="../include/funcoes.asp" -->
<div class='tabela'>

<% 
dataTotal = Date() 'pegando a data total

strQuery = "use [SIIAG] " &_
				"declare @data datetime " &_
				"set @data = CONVERT(DATETIME,'24/05/2014',103) " &_
                   "SELECT  tb.no_nome, tb.aniv " &_
					 "from (select *, CONVERT(DATETIME, STR(DAY(DT_NASCIMENTO))+'/'+ " &_
                                                   "STR(MONTH(DT_NASCIMENTO))+'/'+ " &_
	                                               "STR(YEAR(@data)),103) as aniv from tb_usuarios where ic_ativo = 1 and co_unidade= 7180) tb " &_
												   "WHERE ( aniv = @data or " &_
                      "(DATEPART(DW,@DATA) = 6 AND ANIV BETWEEN @DATA AND DATEADD(D,2,@DATA)) OR " &_
                      "(DATEPART(DW,@DATA) = 2 AND ANIV BETWEEN DATEADD(D,-2,@DATA) AND @DATA )) " &_
               " ORDER BY NO_NOME "

set zs=Server.CreateObject("ADODB.RecordSet")
zs.Open strQuery, dados_sys

	IF zs.eof Then
			
		response.Write "<p>N&atilde;o h&aacute; aniversariantes hoje.</p>"
		
	ELSE	
	response.write ""
	Response.Write "<table >"
    Response.Write "<tr>"
    Response.Write "<td width='8%' >Nome</td>"
    Response.Write "<td width='10%'>Data</td>"
    Response.write"</tr>"
	
	DO UNTIL zs.eof
	
	Nome=zs("NO_NOME")
	
	dataBanco=zs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)

	response.Write "<tr>"	
	response.Write "<td>"&Nome&"</td>"
	response.Write "<td>"& Formatar_Dia(diaBanco) & "/" & Formatar_Mes(mesBanco) &"</td>"
	response.write "</tr>"
 
	zs.movenext
	LOOP
	
	End If

set zs = nothing
set objConn = nothing

%>

</table>
</div>
