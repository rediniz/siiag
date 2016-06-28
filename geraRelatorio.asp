<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!--#include file="FPDF/fpdf.asp"-->

<%
dataInicial = Request("dataInicial")

dataFinal =  Request("dataFinal")

Query4 ="select NO_PROTOCOLO, DH_ENVIO,NO_RESPONSAVEL from TB_PROTOCOLO WHERE DH_ENVIO BETWEEN '"& dataInicial & "' AND '" & dataFinal &"'"
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
ds.Open Query4, dados_sys 
	
 if ds.eof Then
  response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Destacamentos<p>"
  else	
 DO UNTIL ds.eof

numeroProtocolo =		ds("NO_PROTOCOLO")
dataEnvio =		ds("DH_ENVIO")
nomeResponsavel =		ds("NO_RESPONSAVEL")



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
pdf.MultiCell 100, 7, "Numero do Protocolo: "& numeroProtocolo
pdf.MultiCell 100, 7, "Data do Envio: "& dataEnvio
pdf.MultiCell 100, 7, "Nome do Responsavel: "& nomeResponsavel



'pdf.Cell 20,10,"PDF",1,0
'pdf.Cell "Ola "& matricula &"" 'primeiro parametro é a distancia da margem, o segundo é a distancia do topo e o terceiro é o que vai aparecer na pagina'

 ds.movenext
  
  LOOP
  End If 
  
  
pdf.Close()
pdf.Output()

set tuser = 	nothing
set ds = 		nothing

%>
