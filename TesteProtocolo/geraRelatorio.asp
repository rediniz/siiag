<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="FPDF/fpdf.asp"-->

<%
dataInicial = Request("dataInicial")

dataFinal =  Request("dataFinal")




Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.SetPath("FPDF/fpdf/")
pdf.SetFont "Arial","",12
pdf.Open()
pdf.AddPage()
pdf.SetTitle "Relatorio de Oficios"
pdf.SetSubject "Assunto"
pdf.Image "imagens/logo-caixa-vetorial.jpg", 5	, 5, 40, 10 ,"JPG" 'primeiro parametro é a imagem, o segundo é a distancia da margem esquerda, o terceiro é a distancia do topo, o quarto é a largura da imagem, o quinto é o tamanho da imagem, e o ultimo é o formato da imagem

pdf.Text 83,25, "Relatorio de Oficios"
pdf.Text 180, 25, DAY(DATE()) & "/" & MONTH(DATE()) & "/" & YEAR(DATE()) 'primeiro parametro é a distancia da lateral esquerda, o segundo é a distancia com relacao ao topo, e o ultimo é o conteudo






'pdf.MultiCell 100, 25, ""
'pdf.MultiCell 100, 25, ""






Query4 = "SELECT ATUAL.NO_PROTOCOLO, ATUAL.DH_ENVIO, ATUAL.NO_RESPONSAVEL, ATUAL.CO_TIPO, ARS.NU_AR FROM TB_PROTOCOLO_ATUAL AS ATUAL INNER JOIN TB_PROTOCOLO_ARS AS ARS ON ATUAL.NO_PROTOCOLO = ARS.NO_PROTOCOLO AND ATUAL.CO_TIPO = ARS.CO_TIPO WHERE(ATUAL.CO_TIPO = 2) AND (ATUAL.DH_ENVIO BETWEEN '"&dataInicial&"' AND '"&dataFinal&"') order by ATUAL.DH_ENVIO asc"
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
ds.Open Query4, dados_sys 

contador = 0

 DO UNTIL ds.eof
 
 
 
numeroProtocolo =		ds("NO_PROTOCOLO")
dataEnvio =		ds("DH_ENVIO")
nomeResponsavel =		ds("NO_RESPONSAVEL")
numeroAr =      ds("NU_AR")
 

if isnull(numeroAr)  then    'Verificando se o numero da AR é nulo

numeroAr = "---------------"
'response.write numeroAR

end if


 
'if numeroAr <> "" Then
'
'response.Write numeroAr
'
'End If

'Response.Write numeroProtocolo 
'Response.write "/"
'Response.Write dataEnvio
'Response.write "/" 
'Response.Write nomeResponsavel 
'Response.write "/"
'Response.write numeroAr
'Response.write "/"
'
'Response.Write "--------------"




'pdf.MultiCell 190, 6, "As we move into a world where mobile devices are becoming the primary mechanism for people to connect with the Internet, it should come as no surprise that the ability to develop applications for mobile devices is becoming a sought after skill. We also have very strong vendor competition in the space, resulting in a marketplace filled with a variety of devices. We see vendors promoting development tools and marketplaces for their own devices, attempting to create software ecosystems around their products. For the most part, the strategy is working too","C"




if contador >200 Then

pdf.AddPage()
contador=0
End If



pdf.Text 10, 40, "Numero do Protocolo   |   AR                |    Data do Envio    |         Responsavel      "
pdf.Text 10, 45, "_________________________________________________________________________"

'if numeroAr <> "" Then

if numeroProtocolo < 10 Then
pdf.Text 10,50+contador, numeroProtocolo &"                                      "&numeroAr&"         "& DAY(dataEnvio)&"/"&MONTH(dataEnvio)&"/"&YEAR(dataEnvio)& "                 "&nomeResponsavel

End If

if numeroProtocolo >= 10 and numeroProtocolo<100 Then
pdf.Text 10,50+contador, numeroProtocolo &"                                    "&numeroAr&"         "& DAY(dataEnvio)&"/"&MONTH(dataEnvio)&"/"&YEAR(dataEnvio)& "                 "&nomeResponsavel

End If

if numeroProtocolo >= 100 and numeroProtocolo<1000 Then
pdf.Text 10,50+contador, numeroProtocolo &"                                  "&numeroAr&"         "& DAY(dataEnvio)&"/"&MONTH(dataEnvio)&"/"&YEAR(dataEnvio)& "                 "&nomeResponsavel

End If

if numeroProtocolo >= 1000 and numeroProtocolo<10000 Then
pdf.Text 10,50+contador, numeroProtocolo &"                              "&numeroAr&"         "& DAY(dataEnvio)&"/"&MONTH(dataEnvio)&"/"&YEAR(dataEnvio)& "                 "&nomeResponsavel

End If





'End If
'pdf.Text 20, 56, "___________________________________________________________________"
'pdf.MultiCell 100, 7, "Numero do Protocolo: "& numeroProtocolo
'pdf.MultiCell 100, 7, "Data do Envio: "& dataEnvio
'pdf.MultiCell 100, 7, "Nome do Responsavel: "& nomeResponsavel
''
'
'
'pdf.Cell 20,10,"PDF",1,0
'pdf.Cell "Ola "& matricula &"" 'primeiro parametro é a distancia da margem, o segundo é a distancia do topo e o terceiro é o que vai aparecer na pagina'





 contador=contador+6
 	
 ds.movenext
  
  LOOP

  
  
pdf.Close()
pdf.Output()



%>
