<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<script type='text/javascript'>
$(document).ready(function(e) {
    $('#btn_sim_soli').on('click', function(){
		/*$.ajax({
				url: 'substituicao.asp?coord_soli=1', 
				dataType: 'html', // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
				},
				complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
					//$("#carregando").hide();  
				},
				success: function(data) { // CASO RECEBA RESPOSTA COM SUCESSO*/
					$('#solic_subst_dialog').dialog(close);
					$('#solic_subst_dialog').dialog({height:350, width:570});
					$('#solic_subst_dialog').html("<iframe id='iframe_dialog' width='550' height='300' frameborder='0' marginheight='0' marginwidth='0' height='100' scrolling='no'></iframe>")
					//parent.ae();
					
					$('#iframe_dialog').attr("src", 'substituicao.asp?coord_soli=1&matricula_coord=' + $("#matricula").val());
				/*},
				error: function(data) { // CASO OCORRA ERRO NA REQUISIÇÃO
					alert('Erro na página que checa coordenadores.');
				}
			});
		//$("#solic_subst_dialog").dialog("close");*/
	});
	
	$("#btn_nao_soli").on('click', function(){
		salvarSemSubs();
	});
});
</script>

<body>
<label class="labelsRelatorio">Deseja solicitar substituição?</label>
<br />
<br />
<input type="button" id="btn_sim_soli" class="myButton" value="Sim">
<input type="button" id="btn_nao_soli" class="myButton" value="Não">
</body>
</html>
