<%

Set objFS = Server.CreateObject("Scripting.FileSystemObject")
objFS.CreateFolder("\\ce7180sr002\Public\testess" )
Set objFS = Nothing
Response.Write "A pasta foi criada com sucesso"

%>