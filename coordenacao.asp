<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Usu&aacute;rio</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
<script src="scripts/jquery.autocomplete.js" language="javascript"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--<script src="scripts/jquery-1.9.1.js"></script> -->
<!--favicon -->
<!--CSS-->
<style type="text/css">
<!--

.background_coord{
/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#587fb5+0,e8f8ff+100 */
background: #587fb5; /* Old browsers */
background: -moz-linear-gradient(left,  #587fb5 0%, #e8f8ff 100%); /* FF3.6+ */
background: -webkit-gradient(linear, left top, right top, color-stop(0%,#587fb5), color-stop(100%,#e8f8ff)); /* Chrome,Safari4+ */
background: -webkit-linear-gradient(left,  #587fb5 0%,#e8f8ff 100%); /* Chrome10+,Safari5.1+ */
background: -o-linear-gradient(left,  #587fb5 0%,#e8f8ff 100%); /* Opera 11.10+ */
background: -ms-linear-gradient(left,  #587fb5 0%,#e8f8ff 100%); /* IE10+ */
background: linear-gradient(to right,  #587fb5 0%,#e8f8ff 100%); /* W3C */
filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#587fb5', endColorstr='#e8f8ff',GradientType=1 ); /* IE6-9 */

border-bottom-left-radius: 5px;
border-bottom-right-radius: 5px;
border-top-left-radius: 5px;
border-top-right-radius: 5px;

font-family:arial;
font-size:12px;

}
	

.lbl{
	font-family:arial;
	font-size:12px;
}
-->
</style>

<script language="javascript">
<!--

-->
</script>


<style type="text/css">
	.check {
		font-family:verdana;
		font-size:13px;
		color:#666666;
	}
	
	body {
		font-family:verdana;
		font-size:14px;
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
<script>

$(document).ready(function() {


	



});
carregar_pagina();
	function carregar_pagina() {
		$("#div_coordenacoes").html('');
		$.ajax({
			cache:false,
			url: 'coordenacao_manter.asp',
			dataType:"html",
			success: function (data) {
					$("#div_coordenacoes").html(data);
				},
			error: function() {
				alert(erro);
				},
		});
		//window.location.assign('coordenacao_manter.asp');

	}
</script>

</head>

<!-- #INCLUDE FILE ="include/conexao.asp" -->
<body>
	<div class="teste2">
		<!--fundo azul do meio-->
  		<!-- #INCLUDE FILE ="topo.asp" -->
		<%	
  			'Chama a subrotina para verificar o perfil
			Perfil_Acesso("10")
			'Response.write request.Cookies("perfil_acesso_siiag_desc")
		%>
        <div class="corposite">
        	<!--corpo-->
	        <div class="container">
    		    <div class="conteudo2">
			        <div class="titulosModulos" ><span >USUÁRIO</span> </div>
				        <div class="usuariodiv">
					        <div id='cssmenu'>
						        <ul>
								<%aba_ativa = 3%>
                                <!-- #INCLUDE FILE ="abas_usuarios.asp" -->
						        </ul>
					        </div>
					        </p>
					        <%
						        if not perfil_acesso_siiag then
							        response.write "<label>     Acesso negado.</label>"
							        response.End()
						        end if

								strQuery = "select * from [VW_GS] where co_unidade ='" & request.Cookies("co_usuario_unidade_siiag") & "' order by no_gs; " 
								set rs = Server.CreateObject("ADODB.RecordSet")
								rs.Open strQuery, dados_sys

					        %>
					        <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
						        <legend class="style2 style3">Manter Coordenações</legend>
                                <input type="hidden" name="co_coordenacao" id="co_coordenacao" value="" />
                                <br/>
								<center>
								<div id="div_coordenacoes">
                                </div>
                                </center>
    	    			    </fieldset>
		            </div>
            	</div>
            </div>
		</div>
		<!--fim do corpo-->
		<!-- #INCLUDE FILE ="rodape.asp" -->
	</div>
</body>
</html>
