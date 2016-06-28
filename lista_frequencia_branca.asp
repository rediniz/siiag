<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Lista de Frequ&ecirc;ncia</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--<script src="scripts/jquery-1.9.1.js"></script> -->
<!--favicon -->
<!--CSS-->
<style type="text/css">
<!--
.style2 {
	font-size: 14
}


.ui-datepicker {
	font-size:12px;
}
-->
</style>


<style type="text/css">
.check {
font-family:verdana;
font-size:13px;
color:#666666;
}

body {
font-family:verdana;
font-size:15px;
background:#FFFFFF;
}

</style>

<script language="javascript">
	<!--
	function imprimir(){
		//var h = factory.printing.header;
		/*var f = factory.printing.footer;
		var l = factory.printing.leftMargin;
		var lf = factory.printing.leftMargin;
		var t = factory.printing.topMargin;
		var r = factory.printing.rightMargin;
		var b = factory.printing.bottomMargin;
		*/
		
		document.all("bt_imprimir").style.visibility = 'hidden';
		window.print();
		document.all("bt_imprimir").style.visibility = 'visible';
		
		//bt_imprimir.style.display='none';
		//window.print();
		//bt_imprimir.style.display='';
	}
	-->
</script>

</head>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<body>
    
	<%

  Perfil_Acesso("26") 
  
  if not  perfil_acesso_siiag then
	response.write "Acesso Negado"
	response.end 
  end if


	mat = Request.ServerVariables("LOGON_USER")
	usuario = UCase(Right(mat,Len(mat)-10))
	titulo = request.form("f_titulo")
	if titulo = "" then titulo = "LISTA DE USUÁRIOS"
    'response.write usuario
	imprimir = request("imprimir")
	
	strQuery = "select * from TB_EVENTOS WHERE CO_EVENTO = '" & request("co_evento") & "'" 
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys	
	
	qt_dias = datediff("d",rs("dh_fim"),rs("dh_inicio"))
	qt_participantes = rs("qt_participantes")
	'response.Write(qt_dias)
    %>
	
	<center>
	<BR>
    <table width="700" style=" border-top:#000000 solid 2PX; border-bottom:#000000 solid 2PX;" >
    <tr>
    	<td align="left">Evento: <%=capitalize(rs("de_evento"))%></td> <td align="right"><%=request.Cookies("co_usuario_sg_unidade_siiag") %></td>
    </tr>
    <tr>
<%
	if qt_dias > 0 then
%>
    	<td align="left" >Período do Evento: <%=formatar_data(rs("dh_inicio"))%> - <%=formatar_data(rs("dh_fim"))%></td>
<%
	else
%>
    	<td align="left" >Data do Evento: <%=formatar_data(rs("dh_inicio"))%></td>
<%
	end if
%>    
        <td align="right">Participantes: <%=rs("qt_participantes")%></td>
    </tr>
    </table>
    <br>
	</center>
<center >
<table  width="700" border="2" style=" border-collapse:collapse;">
<tr>
<td width="350" style=" background-color:#999999" ><b>Nome</b></td>
<td width="170" style=" background-color:#999999"><b>Assinatura </b></td>
</tr>
<%for i = 1 to qt_participantes + 5%>
        <tr>
        <td style="padding:10px; text-align:left; font-size:10px;"><%=i%>.</td>
        <td></td>
        </tr>
<%next%>
</table>

<br /> <br />
	<%if imprimir = "" then%>
	    <input type="button" value="imprimir" id="bt_imprimir" onclick=" return(imprimir())" />
    <%else%>
    <%end if%>
</center>

</body>
</html>
