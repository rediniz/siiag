<%
	set objConn = 	server.CreateObject("ADODB.Connection") 
	dados_sys = 	"Provider=sqloledb;Data Source=renato-virtual;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
	objConn.open dados_sys
%>