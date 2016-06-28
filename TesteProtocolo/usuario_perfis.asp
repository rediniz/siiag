<% 

strQuery = "select * from TB_USUARIOS_PERFIS where CO_MATRICULA='" & usuario & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys 

    codigoPerfis=rs("CO_PERFIL")


strQuery = "select NO_PERFIL from TB_PERFIS where CO_PERFIL='" & codigoPerfis & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys 

    nomePerfis=rs("NO_PERFIL")


    response.Write nomePerfis


objConn.close 
set rs = nothing
set objConn = nothing 




%>