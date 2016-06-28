
<%

	set objConn = 	server.CreateObject("ADODB.Connection") 
	dados_sys = 	"Provider=sqloledb;Data Source=CE7180sr001;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
	objConn.open dados_sys
%>