<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="FPDF/fpdf.asp"-->

<%
nome = Request("nome")
matricula = Request("matricula")


Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.SetPath("FPDF/fpdf/")
pdf.SetFont "Arial","",16
pdf.Open()
pdf.AddPage()
pdf.SetTitle "Teste da Imagem"
pdf.SetSubject "Assunto"
pdf.Image "imagens/caixarelatorio.jpg", 83, 5, 40, 15 ,"JPG"

pdf.MultiCell 100, 25, ""
'pdf.MultiCell 190, 6, "As we move into a world where mobile devices are becoming the primary mechanism for people to connect with the Internet, it should come as no surprise that the ability to develop applications for mobile devices is becoming a sought after skill. We also have very strong vendor competition in the space, resulting in a marketplace filled with a variety of devices. We see vendors promoting development tools and marketplaces for their own devices, attempting to create software ecosystems around their products. For the most part, the strategy is working too","C"

pdf.MultiCell 100, 10, ""
pdf.MultiCell 100, 7, "Nome: "& nome
pdf.MultiCell 100, 7, "Periodo: "
pdf.MultiCell 100, 7, "Gerencia: "


'pdf.Cell 20,10,"PDF",1,0
'pdf.Cell "Ola "& matricula &"" 'primeiro parametro é a distancia da margem, o segundo é a distancia do topo e o terceiro é o que vai aparecer na pagina'
pdf.Close()
pdf.Output()
%>


 
 
 