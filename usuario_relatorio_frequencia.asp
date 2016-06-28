<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Lista de Frequ&ecirc;ncia</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--<script src="scripts/jquery-1.9.1.js"></script> -->
<!--favicon -->
<!--CSS-->
<style type="text/css">
<!--
.style2 {
	font-size: 14
}


.ui-datepicker {
	font-size:12px;
}
-->
</style>


<style type="text/css">
.check {
font-family:verdana;
font-size:13px;
color:#666666;
}

body {
font-family:verdana;
font-size:15px;
background:#FFFFFF;
}

</style>

<script language="javascript">
	<!--
	function imprimir(){
		//var h = factory.printing.header;
		/*var f = factory.printing.footer;
		var l = factory.printing.leftMargin;
		var lf = factory.printing.leftMargin;
		var t = factory.printing.topMargin;
		var r = factory.printing.rightMargin;
		var b = factory.printing.bottomMargin;
		*/
		
		document.all("bt_imprimir").style.visibility = 'hidden';
		window.print();
		document.all("bt_imprimir").style.visibility = 'visible';
		
		//bt_imprimir.style.display='none';
		//window.print();
		//bt_imprimir.style.display='';
	}
	-->
</script>

</head>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<body>
    
	<%
	mat = Request.ServerVariables("LOGON_USER")
	usuario = UCase(Right(mat,Len(mat)-10))
	titulo = request.form("f_titulo")
	if titulo = "" then titulo = "LISTA DE USUÁRIOS"
    'response.write usuario
	imprimir = request("imprimir")
    %>
	
	<center>
	<BR>
    <table width="900" style=" border-top:#000000 solid 2PX; border-bottom:#000000 solid 2PX;" >
    <tr>
    	<td align="left"><%=titulo%></td> <td align="right"><%=request.Cookies("co_usuario_sg_unidade_siiag") %></td>
    </tr>
    <tr>
    	<td align="left" ><%=usuario%></td>
        <td align="right">Gerado às <%=now()%></td>
    </tr>
    </table>
    <br>
	</center>
<%
'Chama a subrotina para verificar o perfil

Perfil_Acesso("9")
if not perfil_acesso_siiag then
	response.write "<label>     Acesso negado.</label>"
	response.End()
end if


chk_campo_todos = request.Form("chk_campo_todos")
campo_matricula = request.Form("chk_matricula")
campo_nome = request.Form("chk_nome")
campo_cargo = request.Form("chk_cargo")
campo_coordenacao = request.Form("chk_coordenacao")
campo_assinatura = request.Form("chk_assinatura")
chk_cargo_todos = request.Form("chk_cargo_todos")
chk_aux_servicos = request.Form("chk_aux_servicos")
chk_estagiario = request.Form("chk_estagiario")
chk_admin = request.Form("chk_admin")
chk_gerente_filial = request.Form("chk_gerente_filial")
chk_aprendiz = request.Form("chk_aprendiz")
chk_aux_operacional = request.Form("chk_aux_operacional")
chk_junior = request.Form("chk_junior")
chk_coordenador = request.Form("chk_coordenador")
chk_tbn = request.Form("chk_tbn")
chk_pleno = request.Form("chk_pleno")
chk_terceirizado = request.Form("chk_terceirizado")
chk_senior = request.Form("chk_senior")
chk_escrituario = request.Form("chk_escrituario")
chk_secretario = request.Form("chk_secretario")
chk_coordenacao_todos = request.Form("chk_coordenacao_todos")
chk_aplicacao = request.Form("chk_aplicacao")
chk_gerencia = request.Form("chk_gerencia")
chk_pagamento = request.Form("chk_pagamento")
chk_arrecadacao = request.Form("chk_arrecadacao")
chk_apoio = request.Form("chk_apoio")
chk_recuperacao = request.Form("chk_recuperacao")
chk_cadastro = request.Form("chk_cadastro")
chk_monitoramento = request.Form("chk_monitoramento")
chk_relacionamento = request.Form("chk_relacionamento")
chk_ausentes = request.Form("chk_ausentes")
sexo_M = request("chk_sexo_M")
sexo_F = request("chk_sexo_F")

if campo_matricula = "on" then campo_matricula_exibir = "" else campo_matricula_exibir = "none" end if
if campo_nome = "on" then campo_nome_exibir = "" else campo_nome_exibir = "none" end if
if campo_coordenacao = "on" then campo_coordenacao_exibir = "" else campo_coordenacao_exibir = "none" end if
if campo_cargo = "on" then campo_cargo_exibir = "" else campo_cargo_exibir = "none" end if
if campo_assinatura = "on" then campo_assinatura_exibir = "" else campo_assinatura_exibir = "none" end if


	strQuery = 		"select * from VW_USUARIOS " 	
	'response.write "strQuery: " & strQuery
	
	Dim campos(30)
	dim campos_aux(30)
	cont = 0
	
	cont = cont + 1
	campos(cont)= "CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag")& "'"

	'------------------------------------------ CARGOS
	cont_aux = 0
	'if(chk_cargo_todos <> "1") then
		for i = 1 to request("qt_cargos")
			if request("chk_cargo_" & i) <> "" then
				cont_aux = cont_aux + 1
				campos_aux(cont_aux) = " (CO_CARGO = '" & request("chk_cargo_" & i) & "')"
				'response.write request("chk_cargo_" & i) & "<br>"
			end if
		next
	'end if
	If cont_aux <> "" then
		strAux = ""
		cont = cont + 1
		For i = 1 to cont_aux
			if i = 1 then
				strAux = strAux & " (" & campos_aux(i)
				aux = 1
			else
				strAux = strAux & " OR " & campos_aux(i)
			end if
			if i=cont_aux then
				strAux = strAux & ")"
			end if
		Next
		campos(cont) = strAux
		'response.write "cargos " & strAux & "<br/>"
	end if
	
	'------------------------------------------COORDENAÇÃO
	'if(chk_coordenacao_todos <> "1") then
		cont_aux = 0
		for i = 1 to request("qt_coordenacoes")
			if request("chk_coord_" & i) <> "" then
				cont_aux = cont_aux + 1
				if request("chk_coord_" & i) = "99999" then
					campos_aux(cont_aux) = " ( NO_GS IS NULL )"
				else
					campos_aux(cont_aux) = " ( CO_GS = '" & request("chk_coord_" & i) & "' )"
				end if
			end if
			'response.write request("chk_coord_" & i) & "<br>"
		next

	'end if
	If cont_aux >0 then
		strAux = ""
		cont = cont + 1
		For i = 1 to cont_aux
			if i = 1 then
				strAux = strAux & " (" & campos_aux(i)
				aux = 1
			else
				strAux = strAux & " OR " & campos_aux(i)
			end if
			if i=cont_aux then
				strAux = strAux & ")"
			end if
		Next
		campos(cont) = strAux
		'response.write "Coord " & strAux & "<br/>"
	end if
	'******************
	
	'******************
	cont_aux = 0
	if sexo_m <> "" then
		cont_aux = cont_aux + 1
		campos_aux(cont_aux) = "  SEXO in('" &  sexo_M & "') "
	end if
	if sexo_F <> "" then
		cont_aux = cont_aux + 1
		campos_aux(cont_aux) = "  SEXO in('" &  sexo_f & "') "
	end if

	If cont_aux >0 then
		strAux = ""
		cont = cont + 1
		For i = 1 to cont_aux
			if i = 1 then
				strAux = strAux & " (" & campos_aux(i)
				aux = 1
			else
				strAux = strAux & " OR " & campos_aux(i)
			end if
			if i=cont_aux then
				strAux = strAux & ")"
			end if
		Next
		campos(cont) = strAux
		'response.write "Coord " & strAux & "<br/>"
	end if
	'********************************

	strQuery = strQuery & " WHERE "
	
	For i = 1 to cont
		if i = 1 then
			strQuery = strQuery & " (" & campos(i)
			aux = 1
		else
			strQuery = strQuery & " AND " & campos(i)
		end if
		if i=cont then
			strQuery = strQuery & ")"
		end if
	Next

	
'	aux = 0
'	if(chk_cargo_todos = "0") then
'		For i = 2 to cont
'			if(left(campos(i),7) = " (CO_CA") then
'				if(aux = 0) then
'					strQuery = strQuery & " AND (" & campos(i)
'					aux = 1
'				else
'					strQuery = strQuery & " OR " & campos(i)
'				end if
'			end if
'			if i=cont then
'				strQuery = strQuery & ")"
'			end if
'		Next
'	end if
'	
'	aux = 0
'	
'	For i = 2 to cont
'		if(left(campos(i),7) = " (CO_GS") then
'			if(aux = 0) then
'				strQuery = strQuery & " AND (" & campos(i)
'				aux = 1
'			else
'				strQuery = strQuery & " OR " & campos(i)
'			end if
'			if i=cont then
'				strQuery = strQuery & ")"
'			end if
'		end if
'		
'	Next
	
	if (chk_ausentes <> "on") then  
 
		strQuery = strQuery & "AND (VW_USUARIOS.CO_MATRICULA NOT IN (SELECT CO_MATRICULA FROM TB_FERIAS WHERE (GETDATE() BETWEEN CONVERT(datetime, DT_INICIO + ' 00:00:01', 103) AND CONVERT(datetime, DATEADD(day, QT_DIAS, DT_INICIO) + ' 23:59:59', 103)))) " & "AND (VW_USUARIOS.CO_MATRICULA NOT IN (SELECT CO_MATRICULA FROM TB_DESTACAMENTOS WHERE (GETDATE() BETWEEN CONVERT(datetime, DT_INICIO + ' 00:00:01', 103) AND CONVERT(datetime, DT_FIM + ' 23:59:59', 103)) AND CO_SITUACAO = 2)) " & "AND (VW_USUARIOS.CO_MATRICULA NOT IN (SELECT CO_MATRICULA FROM TB_AFASTAMENTOS WHERE (GETDATE() BETWEEN CONVERT(datetime, DT_INICIO + ' 00:00:01', 103) AND CONVERT(datetime, DT_FIM + ' 23:59:59', 103)) AND CO_SITUACAO = 2)) "
	end if
	
	strQuery = strQuery & " ORDER BY NO_NOME "
	
	'response.write strQuery
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys
	
%>

<center >
<table  width="900" border="2" style=" border-collapse:collapse;">
<tr>
<td width="500" style="display:<%=campo_nome_exibir%>;"><b>Nome</b></td>
<td width="200" style="display:<%=campo_cargo_exibir%>;"><b>Cargo</b></td>
<td width="300" style="display:<%=campo_coordenacao_exibir%>;"><b>Coordenação</b></td>
<td width="170" style="display:<%=campo_assinatura_exibir%>;"><b>Assinatura </b></td>
</tr>
<%
	do while not rs.eof
%>
        <tr height="25" >
        <!--<td style="display:<%'=campo_matricula_exibir%>; font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;"><%'=ucase(RS("CO_MATRICULA"))%></td>-->
        <td align="left"  style="display:<%=campo_nome_exibir%>;  font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;max-height:25px;"><%=capitalize(RS("NO_NOME"))%> (<%=ucase(RS("CO_MATRICULA"))%>-<%=ucase(RS("CO_DIGITO"))%>)</td>
        <td style="display:<%=campo_cargo_exibir%>;  font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;max-height:25px;"><%=capitalize(RS("NO_CARGO"))%></td>
        <td style="display:<%=campo_coordenacao_exibir%>;  font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;max-height:25px;"><%=RS("NO_GS")%></td>
        <td style="display:<%=campo_assinatura_exibir%>; font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;max-height:25px;"></td>
        </tr>
<%
		rs.movenext
	Loop
%>
</table>

<br /> <br />
	<%if imprimir = "" then%>
	    <input type="button" value="imprimir" id="bt_imprimir" onclick=" return(imprimir())" />
    <%else%>
    <%end if%>
</center>

</body>
</html>
