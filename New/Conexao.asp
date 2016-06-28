<%
	set objConn = 	server.CreateObject("ADODB.Connection") 
	dados_sys = 	"Provider=sqloledb;Data Source=RS7655NT005;Initial Catalog=SIIAG;User Id=italo;Password=italo;"
	objConn.open dados_sys
%>