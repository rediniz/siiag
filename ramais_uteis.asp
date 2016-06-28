<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
Response.buffer=false
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="tabela.css" type="text/css"/>
<link rel="stylesheet" href="botao_azul.css" type="text/css" />
<link rel="stylesheet" href="form.css" type="text/css" />

<style>
body{
	background:white;	
}
</style>
<script>

$(document).ready(function() {
	
	
	function carregarTabela(data){
		
	//		var pesquisa = $("#pesquisa").val();
//		$.ajax({
//				
//				method: "GET",
//				url: 'ramais_uteis_carregar.asp?pesquisa='+pesquisa,
//				success: function (data) {
//					$("#tabela_ramais").html(data);
//					alert("carregou");
//					},
//				error: function() {
//					alert("Erro ao carregar ramais.");
//					},
//				});	


	}
	
	//carregarTabela();
	
	$("#cadastrar").on("click", function(){
		
		var confirma = window.confirm("Deseja cadastrar o ramal?");
		
		if (confirma){
						
			var descricao = $("#descricao").val();
			var numero 	  = $("#numero").val();		
			
			if(descricao == ""){		
				alert("Informe a descrição.");
				return false;	
			}
			
			if(numero == ""){
				alert("Informe o número.");
				return false;
			}
			
			window.location.assign('ramais_uteis_salvar.asp?descricao=' + descricao + '&numero=' + numero);
			
	//		$.ajax({
//			
//				method: "GET",
//				url: 'ramais_uteis_salvar.asp?descricao=' + descricao + '&numero=' + numero,
//				success: function (data) {
//					alert("Ramal cadastrado com sucesso!");
//					carregarTabela(data);
//					},
//				error: function() {
//					alert("Erro ao cadastrar ramal.");
//					},
//				});		
		
		} else {
			return false;	
		}
	});
});
				
</script> 
<body>
<%
pesquisa = request("pesquisa")
%>
<input type="hidden" id="pesquisa" name="pesquisa" value="<%=pesquisa%>">
  <div class="corposite">
<div>

	
    <div align="left">
<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;" >
<legend><span class="titulos" >Cadastrar novo ramal</span></legend>
    <table>
    <tr>
    <td><label>Descrição:</label></td><td><input type="text" class="form-field"  id="descricao" name="descricao"  style="width:400px" /></td>
    </tr>
    <tr>
    <td><label>Número:</label></td><td><input type="text" class="form-field"  id="numero" name="numero"  /></td>
    </tr>
    </table>
    <br />
    <div align="center">
    <button id="cadastrar" class="myButton" >Cadastrar</button>
    </div>
    </fieldset>
    </div>
<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;" >
<legend><span class="titulos" >Ramais cadastrados</span></legend>

    
    <div class="tabela" id="tabela_ramais" align="center" style="overflow:hidden">
  <%

pesquisa = request("pesquisa")


if pesquisa <> "" then

  QueryRamaisUteis = "SELECT * from tb_ramais_uteis WHERE (de_descricao like '%"&pesquisa&"%' OR nu_ramal like '%"&pesquisa&"%') and co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" order by de_descricao"

else

  QueryRamaisUteis = "SELECT * from tb_ramais_uteis WHERE co_unidade = "&request.Cookies("co_usuario_unidade_siiag")&" order by de_descricao"

end if

	set ramaisUteis =	Server.CreateObject("ADODB.RecordSet")
	ramaisUteis.Open QueryRamaisUteis, dados_sys
	
	if ramaisUteis.eof Then
	
		response.write "<p>Nenhum ramal com esses parâmetros encontrado.</p>"
	
	else
	
	%>

<table>
    <tr>
    <td>Descrição</td><td>Número</td>
    </tr>
	<%
	do until ramaisUteis.eof
	
		co_sequencial = ramaisUteis("co_sequencial")
		de_descricao  = ramaisUteis("de_descricao")
		nu_ramal 	  = ramaisUteis("nu_ramal")
		co_criador 	  = ramaisUteis("co_criador")
		co_unidade    = ramaisUteis("co_unidade")
		
		%>

        <tr>
        <td><%=de_descricao%></td>
        <td><%=nu_ramal%></td>
        </tr>

    <%
	
		ramaisUteis.movenext
	
	loop
	
	end if
%>
</table>
      </div>
  </fieldset>
</div>

</div>
</body>

    	
 