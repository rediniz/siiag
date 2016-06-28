<%
'matricula do usuario logado
MATRICULA = usuario 

QueryNomeUser ="select IC_GERENTE from TB_USUARIOS  WHERE CO_MATRICULA ='"& MATRICULA &"';" 
response.write  QueryNomeUser
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set tuser=Server.CreateObject("ADODB.RecordSet")
tuser.Open QueryNomeUser, dados_sys 

IC_GERENTE=tuser("IC_GERENTE")

if IC_GERENTE = true THEN
	IC_GERENTE = 1
END IF

if IC_GERENTE = false THEN
	IC_GERENTE = 0
END IF	
%>