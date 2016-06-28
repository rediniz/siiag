<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
<script src="scripts/jquery.autocomplete.js" language="javascript"></script>

<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

<script>
	$(document).ready(function(){
		$("#trocaPerfil").on('click',function(){
			var opcoes = $("#select").val();
			var matriculaLogado = $("#matriculaLogado").val();
		
			window.location.assign("usuario_perfis_editar.asp?matriculapedinte="+matriculaLogado+"&opcao="+opcoes+"");
		});
	});
</script>   

<body>
	<div class="teste" style="width:350px;">
		<div class="corposite">
    		<!--corpo-->
			<div class="container">
				<div class="fundobranco" style="margin:20px; height:200px; background:#FFFFFF; border-radius:10px;">
					<%
						response.Write "<br/>"
						response.Write "<br/>"
						
						perfiledicao = Request("perfiledicao")
						matriculaLogado = request.Cookies("co_usuario_siiag")
						
						Response.Write "<input type='hidden' id='matriculaLogado' value="&matriculaLogado&">"

						strQuery = "SELECT CO_PERFIL, NO_PERFIL FROM TB_TIPOS_PERFIS ORDER BY NO_PERFIL" 
						set rs=Server.CreateObject("ADODB.RecordSet")
						rs.Open strQuery, dados_sys	
					 
						Response.Write "<select name='select' id='select' style='margin-left:95px;'>"
	
						DO UNTIL rs.eof
							codigoPerfil = rs("CO_PERFIL")
							nomePerfil = rs("NO_PERFIL")

  							response.Write codigoPerfil
			    			Response.Write"<option value='"&codigoPerfil&"'>"&nomePerfil&"</option>"
							Response.Write"<br />"
						
						   	rs.movenext
					   	LOOP
										  
					    Response.Write"</select>"
					%>
					<input class="myButton" type="button"  value="Trocar" id ="trocaPerfil" style="width:auto; margin-left:34.1%; margin-top:15px;" />
				</div>
			</div>
		</div>
	</div>
</body>

<%
	matriculaPedinte = Request("matriculapedinte")
	opcao = Request("opcao")
	opcaointeira= cint(opcao)

	IF matriculaPedinte <> "" and opcaointeira <> "" Then
		query = "UPDATE TB_USUARIOS_PERFIS SET CO_PERFIL="&opcaointeira&" WHERE CO_MATRICULA='"&matriculaPedinte&"'"

		set rs=Server.CreateObject("ADODB.RecordSet")
				
		rs.Open query, dados_sys

		response.write ("<script language=""javascript""> alert('Perfil editado com sucesso.'); </script>")
		response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
		response.write ("<script language=""javascript""> window.close(); </script>")
	End If
%>