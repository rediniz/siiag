<%@LANGUAGE=VBSCRIPT CODEPAGE="1252"%>
<!-- #include file = "Upload_funcoes.asp" -->
<%
	'Chamando Fun��es, que fazem o Upload funcionar
	byteCount = Request.TotalBytes
	RequestBin = Request.BinaryRead(byteCount)
	Set UploadRequest = CreateObject("Scripting.Dictionary")
	BuildUploadRequest RequestBin
		
		
	for i= 1 to 18 
	
    quantidade = UploadRequest.Item("quantidade"&i).Item("Value")
	
	if(quantidade <> 0) then
	
	
	Select case i
	
	Case 1
	response.Write("<p>TRCT : "&quantidade&"</p>")
	
	Case 2
	response.Write("<p>THRCT : "&quantidade&"</p>")
	
	Case 3
	response.Write("<p>TQRCT : "&quantidade&"</p>")
	
	Case 4
	response.Write("<p>SSFGTS : "&quantidade&"</p>")
	
	Case 5
	response.Write("<p>EXTRATO com saque : "&quantidade&"</p>")
	
	Case 6
	response.Write("<p>C�pias da CTPS : "&quantidade&"</p>")
	
	Case 7
	response.Write("<p>Certid�o aposentadoria/MEM�RIA DE C�LCULO : "&quantidade&"</p>")
	
	Case 8
	response.Write("<p>Alvar� : "&quantidade&"</p>")
	
	Case 9
	response.Write("<p>Termo de audi�ncia : "&quantidade&"</p>")
	
	Case 10
	response.Write("<p>Atestado m�dico : "&quantidade&"</p>")
	
	Case 11
	response.Write("<p>Portaria/estatuto/ata de nomea��o : "&quantidade&"</p>")
	
	Case 12
	response.Write("<p>Portaria/estatuto/ata portaria de exonera��o : "&quantidade&"</p>")
	
	Case 13
	response.Write("<p>Contrato de trabalho : "&quantidade&"</p>")
	
	Case 14
	response.Write("<p>Declara��o do OGMO : "&quantidade&"</p>")
	
	Case 15
	response.Write("<p>Comprovante de resid�ncia : "&quantidade&"</p>")
	
	Case 16
	response.Write("<p>Declara��o de dependetes : "&quantidade&"</p>")
	
	Case 17
	response.Write("<p>Documento de identifica��o do trabalhador : "&quantidade&"</p>")
	
	Case 18
	response.Write("<p>Outros : "&quantidade&"</p>")
	
	End Select
	
	End If
	
	next 
		
	
%> 