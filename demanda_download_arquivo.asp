<!--#INCLUDE FILE="include/Conexao.asp"-->
<%
Dim objConn, strFile
Dim intCampaignRecipientID

co_File = Request.QueryString("file")

If co_File <> "" Then

    Response.Buffer = False
    Dim objStream
    Set objStream = Server.CreateObject("ADODB.Stream")


	'PEGA ENDERECO NO BANCO
    Set RS = Server.CreateObject("ADODB.RecordSet")
	rs.Open "SELECT * FROM TB_DEMANDAS_ARQUIVOS WHERE CO_SEQUENCIAL = " &co_File& "", dados_sys
	if not rs.eof then
		objStream.Type = 1 'adTypeBinary
		objStream.Open
		objStream.LoadFromFile(rs("endereco_arquivo"))
		Response.ContentType = "application/x-unknown"
		Response.Addheader "Content-Disposition", "attachment; filename=" & rs("no_arquivo")
		Response.BinaryWrite objStream.Read
		objStream.Close
		Set objStream = Nothing
	end if
	set rs = nothing
End If
%>
