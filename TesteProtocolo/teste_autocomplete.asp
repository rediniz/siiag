<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

   
  <link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet" />
        <script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
        <script src="scripts/jquery.autocomplete.js" language="javascript"></script>

        <script type="text/javascript" language="javascript">

			$(document).ready(function(){
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete("usuario_consultar_nomes.asp",{
					minChars: 1 //Número mínimo de caracteres para aparecer a lista
				  , matchContains: true //Aparecer somente os que tem relação ao valor digitado
				  , scrollHeight: 220 //Altura da lista dos nomes
				  , selectFirst: false //Vim o primeiro da lista selecionado
				  , mustMatch: false //Caso não existir na lista, remover o valor
				  , delay: 100 //Tempo para aparecer a lista para 0, por padrão vem 200
				  });
				  
				  
				   //Quando selecionar valor pegar retorno. O retorno nesse caso são: Nome|Código
                $("#nome").result(function(event, retorno) {
                    if (retorno==undefined)
                        $("#nascimento").val(""),
						$("#jornada").val("");
                    else
                        $("#nascimento").val(retorno[1]),
						$("#jornada").val(retorno[2] + " horas");
						
                });   
			});
			
		</script>


</head>

<body>

Nome: <input name="nome" id="nome" type="text" autocomplete="off" />
</body>
</html>
