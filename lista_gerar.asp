<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="FPDF/fpdf.asp"-->
<!-- #INCLUDE FILE ="include/Conexao.asp" -->

<%

matricula= Request("matricula")
nome = Request("nome")
data= Request("data")
turno= Request("turno")

if turno = 0 Then

	nomeTurno = "Manhã"
	horarioTurno = "08:00 às 13:00"

Else

	nomeTurno = "Tarde"
	horarioTurno = "13:00 às 18:00"

End If 
	
'	
' if ds.eof Then
'  response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Destacamentos<p>"
'  else	
' DO UNTIL ds.eof
'
'numeroProtocolo =		ds("NO_PROTOCOLO")
'dataEnvio =		ds("DH_ENVIO")
'nomeResponsavel =		ds("NO_RESPONSAVEL")

Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.clearBuffer()
pdf.SetPath("FPDF/fpdf/")
pdf.SetFont "Arial","",16
pdf.Open()
pdf.AddPage()
pdf.SetTitle "Relatório de Frequência de Estagiários"
pdf.SetSubject "Relatório de Frequência de Estagiários"

'pdf.Image "imagens/caixarelatorio.jpg", 83, 5, 40, 15 ,"JPG"

'pdf.MultiCell 100, 25, ""
'pdf.MultiCell 190, 6, "As we move into a world where mobile devices are becoming the primary mechanism for people to connect with the Internet, it should come as no surprise that the ability to develop applications for mobile devices is becoming a sought after skill. We also have very strong vendor competition in the space, resulting in a marketplace filled with a variety of devices. We see vendors promoting development tools and marketplaces for their own devices, attempting to create software ecosystems around their products. For the most part, the strategy is working too","C"

'pdf.MultiCell s100, 10, ""
'pdf.MultiCell 100, 7, "Numero do Protocolo: "& numeroProtocolo
'pdf.MultiCell 100, 7, "Data do Envio: "& dataEnvio
'pdf.MultiCell 100, 7, "Nome do Responsavel: "& nomeResponsavel

pdf.Line 10,10,200,10
pdf.SetFontSize 12
pdf.MultiCell 200, 5, "Controle de Comparecimento dos Estagiários                                                                     GIFUG/FO"
pdf.SetFontSize 10
pdf.MultiCell 150,2, matricula
pdf.Line 10,18,200,18
pdf.SetFontSize 10
pdf.Image "imagens/logo-caixa-vetorial3.jpg", 10, 25, 38, 10 ,"JPG"

pdf.Rect 175,36,25,8, "D"
pdf.Text 176.5, 39, "Grau de Sigilo" 
pdf.Text 176.5, 43, "#10"

pdf.Rect 10,48,190,8, "D"

pdf.Text 12, 51, "Nome"
pdf.Text 12, 55, nome
 
pdf.Rect 10,56,50,8, "D"

pdf.Text 12, 59, "Unidade de Atuação"
pdf.Text 12, 63, request.Cookies("co_usuario_unidade_siiag")

pdf.Rect 60,56,40,8, "D"

pdf.Text 62, 59, "Turno"
pdf.Text 62, 63, nomeTurno

pdf.Rect 100,56,50,8, "D"

pdf.Text 102, 59, "Horário"
pdf.Text 102, 63, horarioTurno

pdf.Rect 150,56,50,8, "D"

pdf.Text 152, 59, "Mês/ano"
pdf.Text 152, 63, data

pdf.Rect 10,68,10,4, "D"

pdf.Text 12, 71.3, "Dia"

pdf.Rect 10,68,29,4, "D"
pdf.Text 23, 71.3, "Entrada"

pdf.Rect 10,68,50,4, "D"
pdf.Text 44, 71.3, "Saída"

pdf.Rect 10,68,190,4, "D"
pdf.Text 62, 71.3, "Ocorrências"

contador = 1

contAltura=72
contAlturaDias = 75.3

dataRelatorio = datevalue("01/"&data&"")
mesInicial = month(dataRelatorio)
mesFinal = month(dataRelatorio)

do while mesFinal = mesInicial

	'linha abaixo descreve o quadrado referente ao preenchimento de dias
	pdf.Rect 10,contAltura,10,4, "D"
	pdf.Text 12, contAlturaDias, contador
	
	'linha abaxo descreve o quadrado referente ao preenchimento dos horarios de entrada
	pdf.Rect 10,contAltura,29,4, "D"
	
	'linha abaxo descreve o quadrado referente ao preenchimento dos horarios de saida
	pdf.Rect 10,contAltura,50,4, "D"
	
	'linha abaxo descreve o quadrado referente ao preenchimento das ocorrencias
	pdf.Rect 10,contAltura,190,4, "D"
	
	if(WeekDayName(weekday(dataRelatorio)) = "sábado" or WeekDayName(weekday(dataRelatorio)) = "domingo") then
		
		pdf.Text 23,contAltura+3, "----------"
		pdf.Text 43,contAltura+3, "----------"
		pdf.Text 63,contAltura+3.4, Ucase(WeekDayName(weekday(dataRelatorio)))
	
	end if
	
	'linha abaixo eh o contador dos dias
	contador = contador + 1
	'linha abaixo eh o contador da altura de cada celula
	contAltura = contAltura +4
	contAlturaDias = contAlturaDias +4
	
	dataRelatorio = dateAdd("d", 1, dataRelatorio)
	mesFinal = month(dataRelatorio)

Loop 

pdf.Text 10, contAltura+10, "Obs."
pdf.Text 10, contAltura+14, "1.O controle de frequência é efetuado por empregado da CAIXA indicado para acompanhar o estágio."
pdf.Text 10, contAltura+18, "2.As ocorrências podem ser: início de estágio, desligamento, falta, atraso, etc."


pdf.Line 10,contAltura+40,80,contAltura+40
pdf.Text 16, contAltura+43, "Assinatura do supervisor de estágio"


pdf.Line 130,contAltura+40,190,contAltura+40
pdf.Text 141, contAltura+43, "Assinatura do estagiário"

'pdf.MultiCell 100, 7, "Matricula: "& matricula
'pdf.MultiCell 100, 7, "Data: "& data
'pdf.MultiCell 100, 7, "Turno: "& turno

'pdf.Cell 20,10,"PDF",1,0
'pdf.Cell "Ola "& matricula &"" 'primeiro parametro Ã© a distancia da margem, o segundo Ã© a distancia do topo e o terceiro Ã© o que vai aparecer na pagina'

 'ds.movenext
'  
'  LOOP
'  End If 
  
pdf.Close()
pdf.Output()
'pdf.Output "", true, true

'set tuser = 	nothing
'set ds = 		nothing

%>
