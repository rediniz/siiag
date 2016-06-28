<%

Set objFS = Server.CreateObject("Scripting.FileSystemObject")
objFS.CreateFolder(Server.MapPath(""&DATE()&"") )
Set objFS = Nothing
Response.Write "A pasta foi criada com sucesso"


%>