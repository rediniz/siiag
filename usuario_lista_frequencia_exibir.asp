
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

<!--#include file="FPDF/fpdf.asp"-->
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%

chk_campo_todos = request.Form("chk_campo_todos")
campo_matricula = request.Form("chk_matricula")
campo_nome = request.Form("chk_nome")
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

colunas = "|"

if(campo_matricula = "on")then
	colunas = colunas & " Matrícula |"   
end if
if(campo_nome = "on")then
	colunas = colunas & "                        Nome                      |"   
end if
if(campo_coordenacao = "on")then
	colunas = colunas & "             Coordenação            |"   
end if
if(campo_assinatura = "on")then
	colunas = colunas & "         Assinatura      |"   
end if


Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.SetPath("FPDF/fpdf/")
pdf.SetFont "Arial","",12
pdf.Open()
pdf.AddPage()
pdf.SetTitle "Teste da Imagem"
pdf.SetSubject "Assunto"
pdf.Image "imagens/logo-caixa-vetorial.jpg", 5	, 5, 40, 10 ,"JPG"

pdf.Text 83,25, "Relatorio de Oficios"
pdf.Text 180, 25, DAY(DATE()) & "/" & MONTH(DATE()) & "/" & YEAR(DATE())

strQuery = 		"select * from VW_USUARIOS " 	
	'response.write "strQuery: " & strQuery
	
	Dim campos(30)
	cont = 0
	
	cont = cont + 1
	campos(cont)= "CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag")& "'"

'------------------------------------------ CARGOS
	if(chk_cargo_todos <> "1") then
		
		if(chk_aux_servicos = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '10')"
		end if
		if(chk_estagiario = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '11')"
		end if

		if(chk_gerente_filial = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '1')"
		end if
		
		if(chk_aux_operacional = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '7')"
		end if
		
		if(chk_junior = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '6')"
		end if
		
		if(chk_coordenador = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '2')"
		end if
		if(chk_tbn = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '8')"
		end if
		if(chk_pleno = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '5')"
		end if
		if(chk_senior = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '4')"
		end if
		if(chk_escrituario = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '9')"
		end if
		
		if(chk_terceirizado = "on") then
			cont = cont + 1
			campos(cont) = " (CO_CARGO = '14')"
		end if
		
		'if(chk_aprendiz = "on") then    
		'	cont = cont + 1
		'	campos(cont) = " (CO_CARGO = '7')"
		'end if
		
		'if(chk_secretario = "on") then
		'	cont = cont + 1
		'	campos(cont) = " (CO_CARGO = '7')"
		'end if	
	end if
	
'------------------------------------------COORDENAÇÃO
	
	if(chk_coordenacao_todos <> "1") then
		if(chk_aplicacao = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '6')"
		end if
		if(chk_gerencia = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '8')"
		end if
		if(chk_pagamento = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '5')"
		end if
		if(chk_arrecadacao = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '2')"
		end if
		if(chk_apoio = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '7')"
		end if
		if(chk_recuperacao = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '3')"
		end if
		if(chk_cadastro = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '4')"
		end if
		if(chk_monitoramento = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '10')"
		end if
		if(chk_relacionamento = "on") then
			cont = cont + 1
			campos(cont) = " (CO_GS = '13')"
		end if
	end if
	
	strQuery = strQuery & " WHERE " & campos(1)
	dim i 
	i = 0
	aux = 0
	if(chk_cargo_todos = "0") then
		For i = 2 to cont
			if(left(campos(i),7) = " (CO_CA") then
				if(aux = 0) then
					strQuery = strQuery & " AND (" & campos(i)
					aux = 1
				else
					strQuery = strQuery & " OR " & campos(i)
				end if
			end if
			if i=cont then
				strQuery = strQuery & ")"
			end if
		Next
	end if
	
	aux = 0
	
	For i = 2 to cont
		if(left(campos(i),7) = " (CO_GS") then
			if(aux = 0) then
				strQuery = strQuery & " AND (" & campos(i)
				aux = 1
			else
				strQuery = strQuery & " OR " & campos(i)
			end if
			if i=cont then
				strQuery = strQuery & ")"
			end if
		end if
	Next
	
	if (chk_ausentes <> "on") then  
 
		strQuery = strQuery & "AND (VW_USUARIOS.CO_MATRICULA NOT IN (SELECT CO_MATRICULA FROM TB_FERIAS WHERE (GETDATE() BETWEEN CONVERT(datetime, DT_INICIO + ' 00:00:01', 103) AND CONVERT(datetime, DATEADD(day, QT_DIAS, DT_INICIO) + ' 23:59:59', 103)))) " & "AND (VW_USUARIOS.CO_MATRICULA NOT IN (SELECT CO_MATRICULA FROM TB_DESTACAMENTOS WHERE (GETDATE() BETWEEN CONVERT(datetime, DT_INICIO + ' 00:00:01', 103) AND CONVERT(datetime, DT_FIM + ' 23:59:59', 103)) AND CO_SITUACAO = 2)) " & "AND (VW_USUARIOS.CO_MATRICULA NOT IN (SELECT CO_MATRICULA FROM TB_AFASTAMENTOS WHERE (GETDATE() BETWEEN CONVERT(datetime, DT_INICIO + ' 00:00:01', 103) AND CONVERT(datetime, DT_FIM + ' 23:59:59', 103)) AND CO_SITUACAO = 2)) "
	end if
	
	strQuery = strQuery & " ORDER BY NO_GS, NO_NOME "
	set rs = server.CreateObject("ADODB.RecordSet")   
	rs.Open strQuery, dados_sys
	
	pdf.Text 10, 40, colunas
	pdf.Text 10, 43, "__________________________________________________________________________"
	
	pdf.SetFont "Arial","",10
	
	
	
	pdf.Text 13, 50, response.write("<table border='1px'><tr><td>TESTE</td></tr></table>")
	pdf.Text 35, 50, rs("NO_NOME")
	pdf.Text 100, 50, rs("NO_GS")
	
	
	
	contador = 0
	x = 0	
	Do until rs.eof
		if contador >200 Then
			pdf.AddPage()
			contador=0
		End If
		
		'pdf.Text 13, 50+x, rs("CO_MATRICULA")
		pdf.Text 35, 50+x, rs("NO_NOME")
		pdf.Text 100, 50+x, rs("NO_GS")
		
		x = x + 5
		contador = contador + 1
		rs.MoveNext
	Loop
	
	
pdf.Close()
pdf.Output()
%>
