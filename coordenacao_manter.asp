<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Usu&aacute;rio</title>
<%
	Response.buffer=true
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() -1 
	Response.AddHeader "pragma", "no-store"
	Response.AddHeader "cache-control","no-store, no-cache, must-revalidate"
%>
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
	
	body{
		background:white;
	}
</style>
<script>

$(document).ready( function() {
	$(".bt_add_coordenador").click(function(){	

		var co_coord = $(this).parent().parent().parent().parent().parent().find("#co_coord").val();
		$("#co_coordenacao").val(co_coord);
		$("#dialog-coordenador").prop("title", "Cadastrar Coordenador");
		//============================================[DIÁLOGO]===========================
		// A div com o conteúdo da janela está lá embaixo
		$( "#dialog-coordenador" ).dialog({
			modal: true, // Escurecer o fundo ou não
			dialogClass: "dialogo", //classe para formatar via CSS
			closeText: "Fechar",
			close: function( event, ui ) { 
				},
			height:130,
			width:450,
		});			
		//================================================================================			

	});
	
	$(".bt_edit_coordenacao").click(function(){	

		var co_coord = $(this).parent().parent().parent().parent().parent().find("#co_coord").val();
		var no_coord = $(this).parent().parent().parent().parent().parent().find("#no_coord").val();
		//alert(no_coord);
		//var id_pergunta = $(this).parent().parent().find("#id_pergunta").val();
		$("#co_coordenacao").val(co_coord);
		$("#no_coordenacao").val(no_coord);

		$("#dialog-coordenacao").prop("title", "Editar Coordenação");
		//============================================[DIÁLOGO]===========================
		// A div com o conteúdo da janela está lá embaixo
		$( "#dialog-coordenacao" ).dialog({
			modal: true, // Escurecer o fundo ou não
			dialogClass: "dialogo", //classe para formatar via CSS
			closeText: "Fechar",
			close: function( event, ui ) { 
				},
			height:130,
			width:500,
		});			
		//================================================================================			

	});

	$(".bt_add_coordenacao").click(function(){	

		$("#dialog-criar-coordenacao").prop("title", "Criar Coordenação");
		//============================================[DIÁLOGO]===========================
		// A div com o conteúdo da janela está lá embaixo
		$("#dialog-criar-coordenacao").dialog({
			modal: true, // Escurecer o fundo ou não
			dialogClass: "dialogo", //classe para formatar via CSS
			closeText: "Fechar",
			close: function( event, ui ) { 
				},
			height:130,
			width:500,
		});			
		//================================================================================			

	});

	$(".bt_delete_coordenacao").click(function(){	

		var co_coord = $(this).parent().parent().parent().parent().parent().find("#co_coord").val();

		$("#co_coordenacao").val(co_coord);
		if (confirm('AVISO: Todos os usuários vinculados a esta coordenação, bem como todos os RELATÓRIOS e pesquisas referentes a esta coordenação serão PERDIDOS. Confirma a EXCLUSÃO?'))
	    {
			$.ajax({
				method: "GET",
				cache:false,					
				url: 'jquery_coordenacao_coord_delete.asp?tp=3&co_coordenacao=' + $("#co_coordenacao").val(),
				success: function (data) {
						window.navigate('coordenacao_manter.asp');
					},
				error: function() {
					alert(erro);
					},
			});
		}
		
	});
	
	$(".bt_add_substituto").click(function(){	
		var co_coord = $(this).parent().parent().parent().parent().parent().find("#co_coord").val();
		$("#co_coordenacao").val(co_coord);
		
		$("#dialog-substituto").prop("title", "Cadastrar Substituto");
		//============================================[DIÁLOGO]===========================
		// A div com o conteúdo da janela está lá embaixo
		$( "#dialog-substituto" ).dialog({
			modal: true, // Escurecer o fundo ou não
			dialogClass: "dialogo", //classe para formatar via CSS
			closeText: "Fechar",
			close: function( event, ui ) { 
				},
			height:130,
			width:450,
		});			
		//================================================================================			

	});
	
	$("#co_coordenador").focusout(function() {
		pesquisar_matricula_coordenador();
	});

	$("#co_substituto").focusout(function() {
		pesquisar_matricula_substituto();
	});

	$("#bt_salvar_coordenacao").click(function(){	
		no_coordenacao =  encodeURIComponent($("#no_coordenacao").val());
		$.ajax({
			method: "GET",
			cache:false,					
			url: 'jquery_coordenacao_coord_salvar.asp?tp=3&no_coordenacao='+ no_coordenacao  + '&co_coordenacao=' + $("#co_coordenacao").val(),
			success: function (data) {
					$("#dialog-coordenacao").dialog('close');
					window.navigate('coordenacao_manter.asp');
				},
			error: function() {
				alert(erro);
				},
		});
	});

	$("#bt_criar_coordenacao").click(function(){	
		$.ajax({
			method: "GET",
			cache:false,					
			url: 'jquery_coordenacao_coord_salvar.asp?tp=4&no_coordenacao='+ encodeURIComponent($("#no_coordenacao_2").val()),
			success: function (data) {
					$("#dialog-criar-coordenacao").dialog('close');
					//parent.carregar_pagina();
					window.navigate('coordenacao_manter.asp');
				},
			error: function() {
				alert(erro);
				},
		});
		//window.location.assign('jquery_coordenacao_coord_salvar.asp?tp=4&no_coordenacao='+ $("#no_coordenacao_2").val());
		
	});

	$("#bt_salvar_coordenador").click(function(){	
		pesquisar_matricula_coordenador();


		$.ajax({
			method: "GET",
			cache:false,					
			url: 'jquery_coordenacao_coord_salvar.asp?tp=1&matricula='+ $("#co_coordenador").val() + '&co_coordenacao=' + $("#co_coordenacao").val(),
			success: function (data) {
					$("#co_coordenador").val('');
					$("#co_coordenacao").val('');
					$("#lbl_no_coordenador").val('');
					$("#dialog-coordenador").dialog('close');
					//parent.carregar_pagina();
					window.navigate('coordenacao_manter.asp');
				},
			error: function() {
				alert(erro);
				},
		});
		//window.location.assign('jquery_coordenacao_coord_salvar.asp?matricula='+ $("#co_coordenador").val() + '&co_coordenacao=' + $("#co_coordenacao").val());
	});

	$("#bt_salvar_substituto").click(function(){	
		pesquisar_matricula_substituto();


		$.ajax({
			method: "GET",
			cache:false,					
			url: 'jquery_coordenacao_coord_salvar.asp?tp=2&matricula='+ $("#co_substituto").val() + '&co_coordenacao=' + $("#co_coordenacao").val(),
			success: function (data) {
					$("#co_substituto").val('');
					$("#co_coordenacao").val('');
					$("#lbl_no_substituto").val('');
					$("#dialog-substituto").dialog('close');
					//parent.carregar_pagina();
					window.navigate('coordenacao_manter.asp');
				},
			error: function() {
				alert(erro);
				},
		});
		//window.location.assign('jquery_coordenacao_coord_salvar.asp?matricula='+ $("#co_substituto").val() + '&co_coordenacao=' + $("#co_coordenacao").val());
	});
	
	

	function pesquisar_matricula_coordenador(){
		if ($("#co_coordenador").val() != '') {
			var nome = '';
			$.ajax({
				method: "GET",
				cache:false,					
				url: 'jquery_consulta_matricula.asp?matricula='+ $("#co_coordenador").val(),
				success: function (data) {
						//$("lbl_no_coordenador").html(data);
						
						var inicio = data.indexOf('"nome":"') + 8; 
						nome = data.substring(inicio, data.length).trim();
						var fim = nome.substring(1,nome.length).indexOf(',');
						nome = nome.substring(0, fim);
						
						if (nome != '') {
							$("#lbl_no_coordenador").html(nome);
							$("#bt_salvar_coordenador").prop("disabled","");
						}
						else
						{
							$("#lbl_no_coordenador").html('');
							$("#bt_salvar_coordenador").prop("disabled","disabled");
							alert('Matrícula não encontrada');
						}
						$("#co_coordenador").val($("#co_coordenador").val().toUpperCase());
					},
				error: function() {
					alert(erro);
					},
			});
		}
		//window.location.assign('jquery_consulta_matricula.asp?matricula='+ $("#co_coordenador").val());
	
	};
	
	
	function pesquisar_matricula_substituto(){

		if ($("#co_substituto").val() != '') {
			var nome = '';
			$.ajax({
									
				url: 'jquery_consulta_matricula.asp?matricula='+ $("#co_substituto").val(),
				success: function (data) {
						//$("lbl_no_coordenador").html(data);
						
						var inicio = data.indexOf('"nome":"') + 8; 
						nome = data.substring(inicio, data.length).trim();
						var fim = nome.substring(1,nome.length).indexOf(',');
						nome = nome.substring(0, fim);
						
						if (nome != '') {
							$("#lbl_no_substituto").html(nome);
							$("#bt_salvar_substituto").prop("disabled","");
						}
						else
						{
							$("#lbl_no_substituto").html('');
							$("#bt_salvar_substituto").prop("disabled","disabled");
							alert('Matrícula não encontrada');
						}
						$("#co_substituto").val($("#co_substituto").val().toUpperCase());
					},
				error: function() {
					alert(error);
					},
			});
		}
		//window.location.assign('jquery_consulta_matricula.asp?matricula='+ $("#co_coordenador").val());
	
	};
	$(".editarEmail").click(function(e){	
			var co_coord = $(this).parent().parent().parent().parent().parent().find("#co_coord").val();
			$("#co_coordenacao").val(co_coord);
			$("#dialogEditarEmail").prop("title", "Editar E-mail");
			$("#email").val($(this).parent().parent().find("#emailAtual").html());
			$("#addRH").prop("checked", $(this).parent().parent().find("#rh").prop("checked"));
			$( "#dialogEditarEmail" ).dialog({
				modal: true,
				dialogClass: "dialogo",
				closeText: "Fechar",
				close: function( event, ui ) { 
					},
			});		
			$('body').animate({ scrollTop: $( "#dialogEditarEmail").offset().top - ( $(window).height() - $( "#dialogEditarEmail").outerHeight(true) ) / 2  }, 200);
		});
		
	$("#salvarEmail").on("click",function(){	
		var co_coord = $("#co_coordenacao").val();	
		var email = $("#email").val();
		var rh = $("#addRH").prop("checked") ? 1:0;
		
		$.ajax({
			method: "GET",
			cache:false,					
			url: "coordenacao_con.asp?acao=salvarEmail&email="+email+"&rh="+rh+"&coordenacao="+co_coord,
			success: function (data) {
				alert("Email salvo com sucesso.");
				window.location.reload();
				},
			error: function(erro) {
				console.log(erro.responseText);
				alert("Erro ao salvar e-mail.");
			},
		});		
	});
	
	$(".rh").on("click",function(){	
		var co_coord = $(this).parent().parent().parent().parent().parent().parent().find("#co_coord").val();
		$("#co_coordenacao").val(co_coord);
		var flagRH = $(this).prop("checked") ? 1:0;
		$.ajax({
			method: "GET",
			cache:false,					
			url: "coordenacao_con.asp?acao=setarRH&flagRH="+flagRH+"&coordenacao="+co_coord,
			success: function (data) {
				alert("Informação de RH atualizada com sucesso.");
				window.location.reload();
				},
			error: function(erro) {
				console.log(erro.responseText);
				alert("Erro ao atualizar informação de RH.");
			},
		});		
	});
	
	$(".bt_add_email").click(function(){	
		var co_coord = $(this).parent().parent().parent().parent().parent().find("#co_coord").val();

		$("#co_coordenacao").val(co_coord);
		$("#addRH").prop("checked", false);
		$("#dialogEditarEmail").prop("title", "Cadastrar E-mail");
		$("#dialogEditarEmail").dialog({
			modal: true,
			dialogClass: "dialogo",
			closeText: "Fechar",
			close: function( event, ui ) { 
				},
		});					

	});
	
});
</script>

</head>

<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<body>
<div align="center">
<input type="hidden" name="co_coordenacao" id="co_coordenacao" value="" />
<%	
	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("10")
	'Response.write request.Cookies("perfil_acesso_siiag_desc")

if not perfil_acesso_siiag then
	response.write "<label>     Acesso negado.</label>"
	response.End()
end if

strQuery = "select * from [VW_GS] where co_unidade ='" & request.Cookies("co_usuario_unidade_siiag") & "' order by no_gs; " 
set rs = Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys
%>   <table width="80%"  border="0" class="">
        <tr height="90px"><td style=" text-align:center; width:40px;" >
			<input type="button" id="add_coordenacao" class="myButton bt_add_coordenacao" value="Adicionar Coordenação" />
	 	</td>
     </tr>
     </table>

	<%do while not rs.eof%>

        <table width="80%"  border="0">
        <tr height="90px">
            <td align="left" valign="top">
                   	<div class="tabela">
                <table width="100%" border="0" >
               
                <td style="text-align:center; font-size:14px; font-weight:bold;" colspan="2"><%=rs("no_gs")%></td>
                <td style=" text-align:right; width:40px;" >
                
                <img src="imagens\delete_16x16.png" class="bt_delete_coordenacao" title="Excluir coordenação" style="cursor:pointer;"  >
                <img src="imagens\edit.png" class="bt_edit_coordenacao"  title="Editar coordenação"  style="cursor:pointer;"  >
                </td>
                </tr>
                 <tr style="display:none"><td colspan="2"><input type="hidden" name="co_coord" id="co_coord" value="<%=rs("co_gs")%>" />
                <input type="hidden" name="no_coordenacao" id="no_coord" value="<%=rs("no_gs")%>" /></td></tr>
                <tr>
                <tr>
                <%if not isnull(rs("co_gerente")) then %>
                    <td style="font-weight:bold; text-align:right"  width="20%">Coordenador(a): </td>
                    <td><%=rs("no_coordenador")%></td>
                    <td style=" text-align:center; width:10px;" ><img src="imagens\edit.png" class="bt_add_coordenador"  style="cursor:pointer;"  ></td>
                <%else%>
                    <td style="" colspan="3"><input type="button" style="width:100%;" class="bt_add_coordenador"  value="Adicionar Coordenador(a)"  /></td>
                <%end if%>
                </tr>
                <tr>

                <%if not isnull(rs("co_substituto")) then %>
                    <td style="font-weight:bold; text-align:right">Substituto(a):</td>
                    <td><%=rs("no_substituto")%></td>
                    <td style=" text-align:center; width:10px;" ><img src="imagens\edit.png" class="bt_add_substituto"  style="cursor:pointer;"  ></td>
                <%else%>
                    <td style="" colspan="3"><input type="button" style="width:100%;" class="bt_add_substituto" value="Adicionar Substituto(a)"  /></td>

                <%end if%>

                </tr>
                <tr>
               <%if not isnull(rs("EMAIL_COORDENACAO")) then %>
                <td style="font-weight:bold; text-align:right">Email: </td>
                <td><span id='emailAtual'><%=rs("EMAIL_COORDENACAO")%></span><% if rs("EMAIL_COORDENACAO") <> "" then response.write "@caixa.gov.br" end if%><%if rs("RH") = "True" then%> - <input type="checkbox" <%if rs("RH") = "True" then %> checked="checked"<% end if %> id="rh" name="rh" value= "1" style="vertical-align:middle" onClick="return false" /> RH <%end if%></td>
                <td style=" text-align:center; width:10px;"><img src="imagens\edit.png" class="editarEmail"  style="cursor:pointer;"  ></td>
                <%else%>
                	<td style="" colspan="3"><input type="button" style="width:100%;" class="bt_add_email" value="Adicionar E-mail"  /></td>
                <%end if%>
                </tr>
                </table>
                        </div>
            </td>
        </tr>
        </table>
        <br/>

    <%
        rs.movenext
    loop
	
    %>
    
    </center>
 </div>
</body>
</html>
 <!-- DIV QUE VIRA DIALOG -->
<div  align="center" id="dialog-coordenador" title="Relatório" class="msg-dialog" style="display:none;">
    <div id="div_coordenador" style="text-align:left;" >
		<label>Matrícula:</label><input type="text" id="co_coordenador" style="width:80px;" size="7" /> - <label id="lbl_no_coordenador" class="lbl"></label>
        <br/><br/>
        <input type="button" value="Salvar" id="bt_salvar_coordenador" style="width:400px;" disabled="disabled" />
    </div>
</div>
<!-- FIM DIV QUE VIRA DIALOG -->


  <!-- DIV QUE VIRA DIALOG -->
<div  align="center" id="dialog-substituto" title="Relatório" class="msg-dialog" style="display:none;">
    <div id="div_substituto"  style="text-align:left;" >
		<label>Matrícula:</label><input type="text" id="co_substituto" style="width:80px;" size="7" /> - <label id="lbl_no_substituto" class="lbl"></label>
        <br/><br/>
        <input type="button" value="Salvar" id="bt_salvar_substituto" style="width:400px;" disabled="disabled" />
    </div>
</div>
<!-- FIM DIV QUE VIRA DIALOG -->

  <!-- DIV QUE VIRA DIALOG -->
<div  align="center" id="dialog-coordenacao" title="Relatório" class="msg-dialog" style="display:none;">
    <div id="div_nome_coordenacao"  style="text-align:left;" >
		<label>Nome da Coordenação:</label><input type="text" id="no_coordenacao" style="width:270px;" />
        <br/><br/>
        <input type="button" value="Salvar" id="bt_salvar_coordenacao" style="width:450px;" />
    </div>
</div>
<!-- FIM DIV QUE VIRA DIALOG -->

  <!-- DIV QUE VIRA DIALOG -->
<div  align="center" id="dialog-criar-coordenacao" title="Relatório" class="msg-dialog" style="display:none;">
    <div id="div_nome_coordenacao"  style="text-align:left;" >
		<label>Nome da Coordenação:</label><input type="text" id="no_coordenacao_2" style="width:270px;" />
        <br/><br/>
        <input type="button" value="Salvar" id="bt_criar_coordenacao" style="width:450px;" />
    </div>
</div>
<!-- FIM DIV QUE VIRA DIALOG -->

 <!-- DIV EDITAR E-MAIL -->
 <!--#ALTERADO EM 01/06/2016-->
<div  align="center" id="dialogEditarEmail" title="Editar E-mail" class="msg-dialog" style="display:none;">
		<label>E-mail da Coordenação:</label><input type="text" id="email" style="width:270px;" />
        <br/><br/>
        <input type="checkbox" id="addRH" name="addRH" value= "1" style="vertical-align:middle"/> RH
        <br/><br/>
        <input type="button" class = "myButton" value="Salvar" id="salvarEmail"/>
</div>
<!--------------------------------->
<!-- FIM DIV EDITAR E-MAIL -->