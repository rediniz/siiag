<%@LANGUAGE="VBScript" CODEPAGE="65001"%><head>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
</head>

<style>
@import url("form.css");
.tabela {
	margin:0px;
	padding:0px;
	width:99%;
	border:0px solid #ffffff;
	align: center;
	-moz-border-radius-bottomleft:4px;
	-webkit-border-bottom-left-radius:4px;
	border-bottom-left-radius:4px;
	-moz-border-radius-bottomright:4px;
	-webkit-border-bottom-right-radius:4px;
	border-bottom-right-radius:4px;
	-moz-border-radius-topright:4px;
	-webkit-border-top-right-radius:4px;
	border-top-right-radius:4px;
	-moz-border-radius-topleft:4px;
	-webkit-border-top-left-radius:4px;
	border-top-left-radius:4px;
}
.tabela table {
	align:center;
	text-align:center;
	border-collapse: collapse;
	border-spacing: 0;
	/*width:99%;
	height:100%;*/
	margin:0px;
	padding:0px;
}
.tabela tr:last-child td:last-child {
	text-align:center;
	-moz-border-radius-bottomright:4px;
	-webkit-border-bottom-right-radius:4px;
	border-bottom-right-radius:4px;
}
.tabela table tr:first-child td:first-child {
	text-align:center;
	-moz-border-radius-topleft:4px;
	-webkit-border-top-left-radius:4px;
	border-top-left-radius:4px;
}
.tabela table tr:first-child td:last-child {
	text-align:center;
	-moz-border-radius-topright:4px;
	-webkit-border-top-right-radius:4px;
	border-top-right-radius:4px;
}
.tabela tr:last-child td:first-child {
	text-align:center;
	-moz-border-radius-bottomleft:4px;
	-webkit-border-bottom-left-radius:4px;
	border-bottom-left-radius:4px;
}
.tabela tr:hover td {
	background:#bed4ea;
	text-align:center;
}
.tabela tr:nth-child(odd) {
	background-color:#e5eff9;
}
.tabela tr:nth-child(even) {
	background-color:#edf4fc;
}
.tabela td {
	vertical-align:middle;
	border:1px solid #ffffff;
	border-width:0px 1px 1px 0px;
	text-align:center;
	padding:5px;
	font-size:10px;
	font-family:Arial;
	font-weight:normal;
	color:#000000;
}
.tabela tr:last-child td {
	border-width:0px 1px 0px 0px;
}
.tabela tr td:last-child {
	border-width:0px 0px 1px 0px;
}
.tabela tr:last-child td:last-child {
	border-width:0px 0px 0px 0px;
}
.tabela tr:first-child td {
	background:-o-linear-gradient(bottom, #3d94f6 5%, #1e62d0 100%);
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #3d94f6), color-stop(1, #1e62d0) );
	background:-moz-linear-gradient( center top, #3d94f6 5%, #1e62d0 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#3d94f6", endColorstr="#1e62d0");
	background: -o-linear-gradient(top, #3d94f6, 1e62d0);
	background:-ms-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
	background:linear-gradient(to bottom, #3d94f6 5%, #1e62d0 100%);
 	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#3d94f6', endColorstr='#1e62d0', GradientType=0);
	background-color:#3d94f6;
	border:0px solid #ffffff;
	text-align:center;
	border-width:0px 0px 1px 1px;
	font-size:14px;
	font-family:Arial;
	font-weight:normal;
	color:#ffffff;
	padding:5px;
}
.tabela tr:first-child:hover td {
	background:-o-linear-gradient(bottom, #3d94f6 5%, #1e62d0 100%);
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #3d94f6), color-stop(1, #1e62d0) );
	background:-moz-linear-gradient( center top, #3d94f6 5%, #1e62d0 100% );
 	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#3d94f6", endColorstr="#1e62d0");
	background: -o-linear-gradient(top, #3d94f6, 1e62d0);
	background-color:#3d94f6;
}
.tabela tr:first-child td:first-child {
	border-width:0px 0px 1px 0px;
}
.tabela tr:first-child td:last-child {
	border-width:0px 0px 1px 1px;
}

.titulos{
	font-family: Futura, Arial, Helv�tica;
	color: #5683C4;
	font-size:16px;
	font-weight:bold;
	
}

.myButton {
		
        -moz-box-shadow:inset 0px 1px 0px 0px #97c4fe;
        -webkit-box-shadow:inset 0px 1px 0px 0px #97c4fe;
        box-shadow:inset 0px 1px 0px 0px #97c4fe;
        
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #3d94f6), color-stop(1, #1e62d0));
        background:-moz-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:-webkit-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:-o-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:-ms-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:linear-gradient(to bottom, #3d94f6 5%, #1e62d0 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#3d94f6', endColorstr='#1e62d0',GradientType=0);
        
        background-color:#3d94f6;
        
        -moz-border-radius:6px;
        -webkit-border-radius:6px;
        border-radius:6px;
        
        border:1px solid #337fed;
        
        display:inline-block;
        color:#ffffff;
        font-family:Arial,Verdana, Helvetica;
        font-size:15px;
        font-weight:normal;
        padding:6px 24px;
        text-decoration:none;
        
        text-shadow:0px 1px 0px #1570cd;
        
    }
.myButton:hover {
        
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #1e62d0), color-stop(1, #3d94f6));
        background:-moz-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:-webkit-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:-o-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:-ms-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:linear-gradient(to bottom, #1e62d0 5%, #3d94f6 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#1e62d0', endColorstr='#3d94f6',GradientType=0);
        
        background-color:#1e62d0;
		
    }
.myButton:active {
        position:relative;
        top:1px;
    }

</style> 

<script language="javascript">
$(function() {
			$('#btCadastro').on('click',function(){

				window.opener.location.assign("usuario.asp");
				window.close();
				

				});
				});


</script>
<title>Consulta de Ramais</title>

<body style="background:#0d3f88;">
<div style="background:#FFFFFF;border-radius:10px;min-width:404px;min-height:166px;" >
<%

nomePesquisa = Request("nomePesquisa")

QueryRamais =	"SELECT USUARIOS.CO_MATRICULA, USUARIOS.NO_NOME, USUARIOS_CONTATOS.CO_CONTATO, CONTATOS.DE_CONTATO FROM TB_USUARIOS USUARIOS INNER JOIN TB_USUARIOS_CONTATOS USUARIOS_CONTATOS ON USUARIOS_CONTATOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_CONTATOS CONTATOS ON CONTATOS.CO_CONTATO = USUARIOS_CONTATOS.CO_CONTATO WHERE(USUARIOS.NO_NOME LIKE '%"&nomePesquisa&"%' OR CONTATOS.DE_CONTATO LIKE '%"&nomePesquisa&"%') AND(USUARIOS.IC_ATIVO = 1) AND (CONTATOS.CO_TIPO = 5) and usuarios.co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY USUARIOS.NO_NOME"


	set ramais =	Server.CreateObject("ADODB.RecordSet")
	ramais.Open QueryRamais, dados_sys

	

	if ramais.eof Then
  	response.Write "<p class='titulos' style='margin-left:23%;'>N&atildeo h&aacute; ramal cadastrado para esse usuário.<p>"
	response.Write "<input style='margin-left:35%;'class='myButton' id='btCadastro' value='Deseja Cadastrar?' type='button'/>"
  	else
	response.Write "<p class='titulos' style='margin-left:34%;'>Resultado Encontrado<p>" 
	response.Write "<div class='tabela' style='margin-left:3px;'>"	
	
	response.Write "<table><tr><td width='5%' height='2%'>Nome</td><td width='5%'>Contato</td></tr>"
	
	DO UNTIL ramais.eof
	
	
		NO_NOME = ramais("NO_NOME")
		DE_CONTATO = ramais("DE_CONTATO")
		
			response.write "<tr>"
			response.write "<td id='NO_NOME'>"& NO_NOME & "</td>"
			response.write "<td id='DE_CONTATO'>"& DE_CONTATO &"</td>"
			response.write "</tr>"
		
		
		

		ramais.movenext
		
	LOOP
	END IF
	
objConn.close 
set ramais = 	nothing
set objConn = 		nothing 



%>
</table>
</div>
</div>
</body>