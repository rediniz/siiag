<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<script>

var qtde = 1

$(function() {
	
    $(document).on( "change", ".arquivo", function() {
        var nomeArquivo = $(this).val();
        if ( ! (/\.pdf$/.test(nomeArquivo) || /\.PDF$/.test(nomeArquivo))) {
            alert('Por favor, selecione um arquivo PDF');
			//$(this).replaceWith($(this).clone(true))
			$(this).trigger('click');
        }
    });
	  $(".quantidade").on( "change",function() {
        var quantidade = $(this).val();
        if ( ! $.isNumeric(quantidade)) {
         $(this).val(0)   
        }
    });
	  $("#codigoSaque").on( "change",function() {
        var codigo = $(this).val();
        if ( ! $.isNumeric(codigo)) {
         $(this).val("")   
        }
    });
	
	$(document).on("change", "#cpfgts", function(){
	
	var valor = $("#cpfgts").val();
	if (valor.length < 18){
	
		$("#aviso_cpfgts").remove()
		$("#div_cpfgts").append("<div id='aviso_cpfgts' style='color:red; font-size:11px; font-family: Verdana'>O CPFGTS deve conter 18 dígitos alfanuméricos.</div>")
           	 $("#cpfgts").css({
		border: "2px red solid"
        });

	}else{
			$("#aviso_cpfgts").remove()	
				 $("#cpfgts").css({
		border: "1px #cccccc solid"
	   });
	}
	});
});

$( "form" ).submit(function( event ) {
event.preventDefault();
});

$( document ).on("click", "#addArquivo", function(){
	
	var confirma = window.confirm("Deseja adicionar outro arquivo?")
	
	if(confirma){
		qtde++;
		$("#arquivos").append("<p style='padding-bottom:0px'/><input type='file' class='arquivo' id='arquivo"+qtde+"' name='arquivo"+qtde+"' accept='application/pdf'/>")
		$("#arquivo"+qtde).trigger("click")
	}
	else
	{
		return false
	}

});


function valida()
  { 
   var qtd_arquivos = 0
   $(".arquivo").each(function(index, element) {
	  if($(this).val().length>0){
	  qtd_arquivos++;  
	  }
});

$("#qtd_arquivo").val(qtd_arquivos)
 
   if ($("#cpfgts").val()=="") 
     { 
      alert("Informe o CPFGTS!") 
	   $("#cpfgts").focus();
	   $("#cpfgts").css({
	   border:"2px red solid"
	   });
	    return false     
     }else{
		 $("#cpfgts").css({
		border: "1px #cccccc solid"
	   });
	 }
	 
   if($("#cpfgts").val().length != 18)
   {
   	  alert("Informe o CPFGTS corretamente!") 
	   $("#cpfgts").focus();
	     $("#cpfgts").css({
	   border:"2px red solid"
	   });
	    return false   
   }else{
   	 $("#cpfgts").css({
		border: "1px #cccccc solid"
	   });
   }
   
	   if ($("#codigoSaque").val()=="") 
     { 
      alert("Informe o Código de Saque!") 
	  $("#codigoSaque").focus();
	   $("#codigoSaque").css({
	   border:"2px red solid"
	   });
	    return false     
     }else{
	  	 $("#codigoSaque").css({
		border: "1px #cccccc solid"
	   });
	 }
	  	 
	   if ($("#tipoDocumento").val()=="") 
     { 
      alert("Informe o Tipo de Documento!")
	  $("#tipoDocumento").focus();
	    $("#tipoDocumento").css({
	   border:"2px red solid"
	   });
	  	return false  
     }else{
	  $("#tipoDocumento").css({
		border: "1px #cccccc solid"
	   });
	 }
	 
	   if ($("#quantidade").val()=="") 
     { 
      alert("Informe a Quantidade!") 
	  $("#quantidade").focus();
	     $("#quantidade").css({
	   border:"2px red solid"
	   });
	    return false     
     }else{
	   	 $("#quantidade").css({
		border: "1px #cccccc solid"
	   });
	 }
	 
	   if ($("#arquivo").val()=="") 
     {
	 alert("Selecione o arquivo a ser enviado!") 
	  $("#arquivo").focus();
	  
	      $("#arquivo").css({
	   border:"2px red solid"
	   });
	    return false     
     } 
	 
  } 

</script>
<body>
<input type="file" class = "arquivo" id="arquivo1" name="arquivo1" accept="application/pdf"/>
</body>
</html>
