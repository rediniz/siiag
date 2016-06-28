<%@LANGUAGE=VBSCRIPT CODEPAGE="1252"%>
<!-- #include file = "Upload_funcoes.asp" -->
<%
	'Chamando Funções, que fazem o Upload funcionar
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
	response.Write("<p>Cópias da CTPS : "&quantidade&"</p>")
	
	Case 7
	response.Write("<p>Certidão aposentadoria/MEMÓRIA DE CÁLCULO : "&quantidade&"</p>")
	
	Case 8
	response.Write("<p>Alvará : "&quantidade&"</p>")
	
	Case 9
	response.Write("<p>Termo de audiência : "&quantidade&"</p>")
	
	Case 10
	response.Write("<p>Atestado médico : "&quantidade&"</p>")
	
	Case 11
	response.Write("<p>Portaria/estatuto/ata de nomeação : "&quantidade&"</p>")
	
	Case 12
	response.Write("<p>Portaria/estatuto/ata portaria de exoneração : "&quantidade&"</p>")
	
	Case 13
	response.Write("<p>Contrato de trabalho : "&quantidade&"</p>")
	
	Case 14
	response.Write("<p>Declaração do OGMO : "&quantidade&"</p>")
	
	Case 15
	response.Write("<p>Comprovante de residência : "&quantidade&"</p>")
	
	Case 16
	response.Write("<p>Declaração de dependetes : "&quantidade&"</p>")
	
	Case 17
	response.Write("<p>Documento de identificação do trabalhador : "&quantidade&"</p>")
	
	Case 18
	response.Write("<p>Outros : "&quantidade&"</p>")
	
	End Select
	
	End If
	
	next 
		
	
%> 