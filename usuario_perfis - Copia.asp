<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--CSS -->


<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />

	<style type="text/css">
    body {
    font-family:verdana;
    font-size:15px;
    }
    
    a {color:#333; text-decoration:none}
    a:hover {color:#ccc; text-decoration:none}
    
    #mask {
      position:absolute;
      left:0;
      top:0;
      z-index:9000;
      background-color:#000;
      display:none;
    }
      
    #boxes .window {
      position:absolute;
      left:0;
      top:0;
      width:440px;
      height:200px;
      display:none;
      z-index:9999;
      padding:20px;
    }
    
    #boxes #dialog {
      width:375px; 
      height:203px;
      padding:10px;
      background-color:#ffffff;
    }
    
    #boxes #dialog1 {
      width:375px; 
      height:203px;
    }
    
    #dialog1 .d-header {
      background:url(login-header.png) no-repeat 0 0 transparent; 
      width:375px; 
      height:150px;
    }
    
    #dialog1 .d-header input {
      position:relative;
      top:60px;
      left:100px;
      border:3px solid #cccccc;
      height:22px;
      width:200px;
      font-size:15px;
      padding:5px;
      margin-top:4px;
    }
    
    #dialog1 .d-blank {
      float:left;
      background:url(login-blank.png) no-repeat 0 0 transparent; 
      width:267px; 
      height:53px;
    }
    
    #dialog1 .d-login {
      float:left;
      width:108px; 
      height:53px;
    }
    
    #boxes #dialog2 {
      background:url(notice.png) no-repeat 0 0 transparent; 
      width:326px; 
      height:229px;
      padding:50px 0 20px 25px;
    }
    .close{display:block; text-align:right;}
    
    </style>

</HEAD>
<BODY>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<% 



usuario =  request("usuario")
strQuery = "select * from VW_PERFIS where CO_MATRICULA='" & usuario & "'; " 
'set objConn = server.CreateObject("ADODB.Connection") 
'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
'objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
'response.write strQuery
rs.Open strQuery, dados_sys 

%>


 <div class="tabela" >
    <table border="0" style="width:400px;" >
    <tr >
    <td width="100">perfis</td>
    </tr>
<%
	do while not rs.eof
		
		response.Write "<tr >"	
		response.Write "<td>"
		response.Write	trim(rs("NO_PERFIL"))
		response.Write "</td>"
		response.Write "</tr>"	
	
		rs.movenext
	loop

	objConn.close 
	set rs = nothing
	set objConn = nothing

%>
</table>
</div>
</BODY>
</html>