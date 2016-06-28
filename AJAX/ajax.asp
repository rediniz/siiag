<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="x-ua-compatible" >
<script src="jquery-1.9.1.js" type="text/javascript"></script>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Testes AJAX</title>
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	$(document).ready(function() {
	
		$("#carregando").hide();
		
		$(document).on("click", "#consultar", function() {
		
      		$.ajax({
		
       			data: $("#formulario").serialize() + "&nome="+$("#nomes").val()+"", // DADOS A SEREM PASSADOS PARA O SERVIDOR
       			url: "ajax_banco.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        			$("#carregando").show(); 
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		$("#carregando").hide();  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$("#resultado").html(data);	// Preenche a DIV "resultado" com o html "data" recebido, no caso uma tabela 	  
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Houve um erro na consulta.");  
 				}
		
      		}).done(function( data ) { // APÓS TODO O CÓDIGO AJAX TERMINAR
      			alert("Feitooo!"); 
			});
  
		});
	
	});
 
</script>


</head>
<body>
<div style="background:#FFF; padding:10px">
<select id="nomes" name="nomes">
<option value="Renato">Renato</option>
<option value="Belmondo">Belmondo</option>
<option value="Tatiana">Tatiana</option>
<option value="Italo">Italo</option>
</select>
<button id="consultar">Consultar</button>
<div class="tabela" id="resultado" style="width:30%"><div id="carregando">Carregando...</div></div>
<p/>
<form action="ajax_banco.asp" method="post" name="formulario" id="formulario" enctype="application/x-www-form-urlencoded">
<p/>
Dados quaisquer do formulário que não perderão o estado após a requisição:
<p/>
<input type="time" name="hora"/>
<input type="date" name="data"/>
</form>
</div>

</body>
</html>
