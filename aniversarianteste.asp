<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
</head>
<style>
.headert	{
	font-size: 32px;
	font-weight: bold;
	/*font-style:inherit;*/
	font-family: "berlin Sans FB Demi";
}
.datat		{
	width:61px;
	font-size:21px;
	font-weight:200;
	font-style:inherit;
	font-family:"berlin Sans FB Demi";
	color:#666;
}
.nomet		{
	font-size:21px;
	font-weight:200;
	font-style:inherit;
	font-family:"berlin Sans FB Demi";
}
.gerenciat	{
	width:327px;
	font-size:17px;
	font-family:"Berlin Sans FB";
	font-variant:normal;
	font-weight:lighter;
}
/*body{
	height:2480px;
	width:3508px;
}*/
</style>
<body>
<%

mes = request("mes")

set leitura = Server.CreateObject("ADODB.RecordSet")

SQL = "SELECT TB_USUARIOS.NO_NOME AS NOME, TB_GS.NO_GS AS GERENCIA, DAY(TB_USUARIOS.DT_NASCIMENTO) AS DIA FROM TB_USUARIOS INNER JOIN TB_GS ON TB_USUARIOS.CO_GS = TB_GS.CO_GS WHERE (TB_USUARIOS.CO_UNIDADE = '7180')  AND (TB_USUARIOS.IC_ATIVO = 1) AND (MONTH(TB_USUARIOS.DT_NASCIMENTO) =  '" & mes & "') AND (TB_USUARIOS.NO_NOME <> 'Armando Costa Sousa') AND (TB_USUARIOS.NO_NOME <> 'Clelvania Monteiro Ferreira') ORDER BY DAY(TB_USUARIOS.DT_NASCIMENTO)"

leitura.Open SQL, dados_sys, 3, , 32

%>
<table style="width:800px">
	<tr class="headert">
        <td colspan="3">
        	Aniversariantes do mês de <%RetornaMes(mes)%>
        </td>
    </tr>

<%

do while not leitura.eof
	%>
    <tr>
    	<td colspan="3">
    		<hr />
        </td>
    </tr>
    <tr class="bodyt">
    	<td class="datat">
        	<%=response.Write("&ensp;" & leitura("DIA") & "/" & mes)%>
        </td>
        <td class="nomet">
            <%response.Write(ucase(leitura("NOME")) & "&emsp;")%>
        </td>
        <td class="gerenciat">
        	<%response.Write("&ensp;" & leitura("GERENCIA"))%>
        </td>
    </tr>
	<%
	leitura.movenext
loop

%>
</table>




</body>
</html>

<%
Sub RetornaMes(mes)
	If mes = 1 then
		response.Write("Janeiro")
		exit sub
	End If
	If mes = 2 then
		response.Write("Fevereiro")
		exit sub
	End If
	If mes = 3 then
		response.Write("Março")
		exit sub
	End If
	If mes = 4 then
		response.Write("Abril")
		exit sub
	End If
	If mes = 5 then
		response.Write("Maio")
		exit sub
	End If
	If mes = 6 then
		response.Write("Junho")
		exit sub
	End If
	If mes = 7 then
		response.Write("Julho")
		exit sub
	End If
	If mes = 8 then
		response.Write("Agosto")
		exit sub
	End If
	If mes = 9 then
		response.Write("Setembro")
		exit sub
	End If
	If mes = 10 then
		response.Write("Outubro")
		exit sub
	End If
	If mes = 11 then
		response.Write("Novembro")
		exit sub
	End If
	If mes = 12 then
		response.Write("Dezembro")
		exit sub
	End If
End Sub

if mes <> "" then
%>
<script language="javascript">
	window.print();
</script>
<%
end if
%>
