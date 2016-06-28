<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
if data <> "" Then
	dataTotal = data
else
	dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'
END IF 


mesCorrente = MONTH(dataTotal) 'Pegando o mes atual
diaCorrente = DAY(dataTotal)

aniversariantesDoDia = "SELECT NO_NOME, DT_NASCIMENTO FROM VW_USUARIOS WHERE (DAY(DT_NASCIMENTO) = '"&diaCorrente&"') AND (MONTH(DT_NASCIMENTO) = '"&mesCorrente&"') AND IC_ATIVO=1 AND CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"" 


set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open aniversariantesDoDia, dados_sys

IF rs.eof Then
		response.Write ""
ELSE
	response.Write "<h3 class='subtitulosAgenda'>Aniversariantes do Dia</h3>"
DO UNTIL rs.eof
	
	Nome=rs("NO_NOME")
	Nome = UCASE(Nome)
	dataBanco=rs("DT_NASCIMENTO")
	
	diaBanco=DAY(dataBanco)
	mesBanco=MONTH(dataBanco)
	
	


	
Response.Write "<p class='textosAgenda'><strong>Nome: </strong>"& Nome  &"<br/><strong>Data: </strong> " & Formatar_dia(diaBanco)&"/"&Formatar_mes(mesBanco) &"</p>"
	
	'END IF

	 
	rs.movenext
	LOOP
	
End If

set rs = nothing
set objConn = nothing

%>




