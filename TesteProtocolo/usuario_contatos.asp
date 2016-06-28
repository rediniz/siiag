<% 

strQuery = "select * from TB_USUARIOS_CONTATOS where CO_MATRICULA='" & usuario & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys 

codigoContato=rs("CO_CONTATO")


strQuery = "select DE_CONTATO from TB_CONTATOS where CO_CONTATO='" & codigoContato & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys 

descricaoContato=rs("DE_CONTATO")

response.Write descricaoContato



objConn.close 
set rs = nothing
set objConn = nothing 

%>