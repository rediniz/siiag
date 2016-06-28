<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="x-ua-compatible" content="IE=edge">
<script src="jquery-1.9.1.js" type="text/javascript"></script>
<style type="text/css">
<!--
.style1 {
	font-size: 16px;
	font-weight: bold;
}

.quantidade{	
	text-align:center;
}

-->

</style>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Conformidade SIGEP</title>
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<script>

var qtde = 1

$(function() {
	
    $(document).on( "change", ".arquivo", function() {
        var nomeArquivo = $(this).val();
        if ( ! (/\.jpg$/.test(nomeArquivo) || /\.JPG$/.test(nomeArquivo))) {
            alert('Por favor, selecione um arquivo JPG');
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

$("#arquivos").append("<p style='padding-bottom:0px'/><input type='file' class='arquivo' id='arquivo"+qtde+"' name='arquivo"+qtde+"' />")
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

<%
cpfgts = Request("cpfgts")
%>

</head>
<body>
<div align='center'></div>
<div class='corpo'>
  <div class='conteudo' align="center" style="width:700px;">
    <div class ="cabecalho" style="background-color:#006bb7; padding-top:1%; padding-bottom:3px;">
      <h2>SIGEP - ENTRADA DE DOCUMENTOS</h2>
      </span>
      <p align="center"> 
    </div>
    <div class="formulario" style="background-color:#FFF;padding-bottom:1%; padding-top:1%;  border-bottom: 1px solid #d0dada; border-top: 1px solid #d0dada;">
      <form  ACTION="usuario_upload_arquivo.asp" METHOD="POST" ENCtype="multipart/form-data" onSubmit="return valida()" name="formulario">
        <table width="90%" border="0" align="center" cellpadding="1" cellspacing="0">
          <tr>
            <td width="35%"><span class="formulario" style="background-color:#FFF; padding-bottom:1%;">
              <label>
              <div align="right">Diretório Base:&nbsp;&nbsp;</div>
              </span></td>
            <td width="69%"><div align="left"><span class="formulario" style="background-color:#FFF;">
                <input type="text"  id="diretorio" name="diretorio" value="\\ce7180sr002\Public\Conformidade_SIGEP" size="45" disabled="disabled"/>
              </div>
          </tr>
          <tr>
            <td><span class="formulario" style="background-color:#FFF;">
              <label>
              <div align="right">Data de hoje:&nbsp;&nbsp;</div>
              </label>
              </span></td>
            <td><div align="left">
            <input name="data1" id="data1" type="text" size="12" maxlength="18" disabled="disabled" value="<%response.write(Date())%>">
            </div></td>
          </tr>
          <tr>
            <td><span class="formulario" style="background-color:#FFF;">
              <label>
              <div align="right">CGC:&nbsp;&nbsp;</div>
              </label>
              </span></td>
            <td><div align="left">
              <span class="formulario" style="background-color:#FFF; padding-top:3%;padding-bottom:1%;">
              <input type="text" id="cgc"  name="cgc"  value="7180" size="5" disabled="disabled"/></span></div></td>
          </tr>
          <tr>
            <td height="53"><div align="right">
                <label>CPFGTS:&nbsp;</label>
              </div></td>
            <td><div align="left"><span class="formulario" style="background-color:#FFF; padding-top:3%;padding-bottom:1%; ">
                <%
            	response.Write "<input type='text' id='cpfgts'  name='cpfgts' size='24' maxlength='18'  value='"&Request("cpfgts")&"' >"
                %>
                </span></div></td>
          </tr>
          <tr >
            <td height="0"></td>
            <td id = "div_cpfgts" height="0" nowrap="nowrap"></td>
          </tr>
          <tr>
            <td height="57"><div align="right">
                <label>Código de Saque:&nbsp;</label>
              </div></td>
            <td><div align="left"><span class="formulario" style="background-color:#FFF;">
                <input type="text" id="codigoSaque" size="5" maxlength="5" />
                <br />
                </span></div></td>
          </tr>
        </table>
        <p/>
        
        <div class="tabela" align="center" style="width:600px">
        
        <table width="70%" border="0" cellpadding="0" cellspacing="0" id="tabela">
      <tr>
                    <td width="513"><span class="style1">Tipo de documento</span></td>
                    <td width="100"><div align="center" class="style1">Quantidade</div></td>
            </tr>
                  <tr>
                    <td>TRCT</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade1" id="quantidade1" size="2" maxlength="3" style="height:25px" value="0" />
                      </div></td>
                  </tr>
                  <tr>
                    <td>THRCT</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade2" id="quantidade2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>TQRCT</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade3" id="quantidade3" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>SSFGTS</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade4" id="ssfgts" size="2" maxlength="3"  style="height:25px" value="0" />
                      </div></td>
                  </tr>
                  <tr>
                    <td>EXTRATO com saque</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade5" id="extrato_saque" size="2" maxlength="3"  style="height:25px" value="0" />
                      </div></td>
                  </tr>
                  <tr>
                    <td>Cópias da CTPS</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade6" id="copiaCTPS" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Certidão aposentadoria / MEMÓRIA DE CÁLCULO</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade7" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Alvará</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade8" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Termo de audiência</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade9" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Atestado médico</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade10" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Portaria / estatuto / ata de nomeação</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade11" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Portaria / estatuto / ata portaria de exoneração</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade12" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Contrato de trabalho</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade13" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Declaração do OGMO</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade14" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Comprovante de residência</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade15" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Declaração de dependetes</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade16" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Documento de identificação do trabalhador</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade17" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
                  <tr>
                    <td>Outros</td>
                    <td><div align="center">
                        <input type="text" class="quantidade" name="quantidade18" id="textfield2" size="2" maxlength="3"  style="height:25px" value="0"/>
                      </div></td>
                  </tr>
          </table>
          <p/>
        </div>
        
                <label>Arquivos:&nbsp;</label>
                <p/>
            <div id="arquivos" align="center">
              <input type="file" class = "arquivo" id="arquivo1" name="arquivo1" />
                <input type="hidden" id="qtd_arquivo" name="qtd_arquivo" value="0" />
                <input type="hidden" id="data" name="data" disabled="disabled" value="<% date() %>">
        </div>
        
        </p>
        <label id="addArquivo" style="cursor:pointer"><img src="imagens\add_16x16.png" /> Adicionar outro arquivo</label>
        <p style='color:red; font-size: 12px'>*Somente arquivos .pdf</p>
        </p>
        </p>
        <button  id='enviarArquivo' style='margin:16px;'>ENVIAR</button>
        <div id="sucesso">
          <%
		sucesso = Request("sucesso")	
		
		if ( sucesso="true" ) then
		
		response.write("<p style='color:green; font-size: 16px'> Arquivo enviado com sucesso.</p>")
		
		else
		
		if( sucesso="false" ) then
		
		response.write("<p style='color:red; font-size: 16px'>Erro ao enviar o arquivo.</p>")
		
		end if		
		end if
		
		%>
        </div>
      </form>

      <div id="teste"></div>
    </div>
    <div class ="rodape" style="padding-top:1%; padding-bottom:3px;">
      <div align="center" style="margin-top:10px"><a href="Ferramenta de Apoio à Liberação do FGTS.xls">Ajuda</a></div>
      </br>
    </div>
  </div>
</div>
</div>
</body>
</html>
