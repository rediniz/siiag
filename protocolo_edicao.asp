<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Edição de Protocolo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<script type="text/javascript" src="jquery-1.9.1.js" ></script>
<script type="text/javascript" src="jquery-ui-1.10.3.custom.js" ></script>

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<!--CSS-->
    <style type="text/css">
    <!--
        .style2 {
            font-size: 14
        }
        .style3 {
            color: #5683C4
        }


	.tipoarea{
	/*border:#000000 solid 1px;*/ float:left;
	
	}
	
	.destinoConteudo{
	/*border:#000000 solid 1px;*/
	float:right;
	
	
	}
	
	a {
	
	color: #006699;
	
	}
	
	.responsavelFile{/*border:#000000 solid 1px;*/float:left;margin-top:15px;}
	
	#receberLink{/*border:#000000 solid 1px;*/ float:left;margin-top:15%;}
	
	.arOficio{/*border:#000000 solid 1px;*/}
	
	.arOficio label{margin-left:28%;}
	.arOficio input{margin-left:21%;margin-bottom:10%;}
	
	
-->

.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce;
	font-weight: bold;
	color: #c77405;
}
.ui-widget {
	font-family: Arial,sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}

.ui-menu .ui-menu-item a{
    height:14px;
    font-size:13px;
}

.ui-autocomplete {

height:200px;
overflow-y:scroll;
overflow-x:hidden;
}

body{

background:#FFFFFF;

}

    </style>

    
<script language="javascript">
var ar = false;
	var qtde = 1;


	$(function() {
	
//		var ar = false;
		$(document).ready(function(){
		
				$("#aviso").hide();
				
if ($("#add_AR").prop("disabled")==false){
	ar = true;
} else {
	ar = false;
}


$('.X').on('click',function(){
	var confirmacao = window.confirm("Tem certeza que desejar excluir o arquivo?");
	
	if(confirmacao == true){
	
	var arquivo = $(this).parent().parent().find("#arquivo").attr("href")
	var nome_arquivo = $(this).parent().parent().find("#arquivo").html()
	var aa_protocolo = $(this).parent().parent().find("#aaProtocolo").val()
	var cod_tipo = $(this).parent().parent().find("#codTipo").val()
	var url = document.URL;
	
	//alert(nome_arquivo);
	
	//		$.ajax({
	//		
	//       			url: "protocolo_excluir_arquivo.asp?arquivo="+arquivo+"&nome_arquivo="+nome_arquivo+"&aa_protocolo="+aa_protocolo+"&cod_tipo="+cod_tipo, // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
	//				dataType: "html",
	//        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
	//					alert("Arquivo excluído com sucesso.");
	//					window.location.reload();
	// 
	//        		},
	//		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
	//					alert("Erro ao excluir arquivo.");  
	// 				}
	//		
	//      		})
	
	window.location.assign("protocolo_excluir_arquivo.asp?arquivo="+arquivo+"&nome_arquivo="+nome_arquivo+"&aa_protocolo="+aa_protocolo+"&cod_tipo="+cod_tipo+"&url="+url);
	
	} else{
	return false;
	}


});
	
			//Ao digitar executar essa função
			$("#responsavelProtocolo").focus().autocomplete({

				source: "autocompletar_nome2.asp",
				minlength: 2,
				select: function( event, ui ) {
					$( "#responsavelProtocolo" ).val( ui.item.nome);
					$( "#f_responsavel_matricula" ).val( ui.item.matricula);
					return false;
				}
			  });
					
		 });
		 
		 		 $( document ).on("click", "#addArquivo", function(){
	
	var confirma = window.confirm("Deseja adicionar outro arquivo?")
	
	if(confirma){

		qtde++;

$("#arquivos").append("<p style='padding-bottom:0px'/><input type='file' class='arquivo' id='arquivo"+qtde+"' name='arquivo"+qtde+"' style='margin-left:10px'/>")
//$("#arquivo"+qtde).trigger("click")
	}
	else
	{
		return false
	}
});
	
	});

	//$(function() {
	
	// Função que habilita ou desabilita o textbox com o número do AR
	function adicionarAR()
	{
			if(ar == false){
				$("#numeroAR").prop("disabled", false);
				ar = true;
			} else{
				$("#numeroAR").val("");
				$("#numeroAR").prop("disabled", true);
				ar = false;
			}
	
	}


	// Habilita o checkbox "Adicionar AR" se o tipo de protocolo for Ofício
	function habilitaAR()		
	{
		var tipoProtocolo = document.getElementById("tipoProtocolo").value;
		//alert(tipoProtocolo);
		
			
			if (tipoProtocolo == 2){
			
				$("#add_AR").prop("disabled", false);
				 
			}else{
				$("#add_AR").prop("disabled",true);
				$("#add_AR").prop("checked", false);
				$("#numeroAR").val("");
				$("#numeroAR").prop("disabled", true);
				ar = false;
	
			}
			
	}			


</script>
<script language="javascript">
	function validaCampos()
	{
	var qtd_arquivos = 0
		
		if($("#tipoProtocolo").val() == ""){
			alert ("Informe o tipo de protocolo.");
			return false
		}
		
		if($("#areaProtocolo").val() == ""){
			alert ("Informe a area do protocolo.");
			return false
		}
		
		if($("#destinoProtocolo").val() == ""){
			alert ("Informe o destino.");
			return false
		}
		
		if($("#conteudoProtocolo").val() == ""){
			alert ("Informe o conteúdo.");
			return false
		}
		
		if($("#responsavelProtocolo").val() == ""){
			alert ("Informe o responsável.");
			return false
		}
	
		   $(".arquivo").each(function(index, element) {
	  if($(this).val().length>0){
	  qtd_arquivos++;  
	  }
	  
});
	
		$("#qtd_arquivo").val(qtd_arquivos)

		$("#salvar2").hide();
		//$( "#aviso" ).dialog({ modal: true });
		$("#aviso").show();
		
		//$("#aviso").append("<img src='imagens/carregando.gif' />");
		//$("#aviso").append("<p style='font-size: 16px; font-weight:bold'>POR FAVOR, AGUARDE.</p>")
		
		window.setInterval(formProtocolo.submit(), 2000);
		//formProtocolo.submit();
	}
</script>
</head>

<body>
  <!--fundo azul do meio-->
<!-- #INCLUDE FILE ="include/conexao_protocolo.asp" -->
<%
'****** CONEXÃO COM O BANCO DE DADOS
'set objConn = server.CreateObject("ADODB.Connection") 
'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
'objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
			
'******
tipo_protocolo = request("tipoProtocolo")
cod_sequencial_protocolo = request("codSeq")

QueryNoProtocolo = "select * from VW_PROTOCOLOS where co_sequencial = "&request("codSeq")&""
ds.Open QueryNoProtocolo, dados_sys
if ds.eof then
	response.Write("Número de Protocolo não localizado")
	response.End()
end if

%>
    <!--corpo-->
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:px">
      
          <legend class="style2 style3">Edição de Protocolo </legend>
			<span class="style4 style2">
            <form ACTION="protocolo_edicao_sql.asp" name="formProtocolo" method="POST" enctype="multipart/form-data">
			<%response.Write "<input type='hidden' id = 'tipoProtocolo' name='tipoProtocolo' value='"&request("tipoProtocolo")&"'/>"%>
             <table width="200" border="0" cellspacing="4" cellpadding="0"  align="center">
            <tr>
              <td colspan="2"><b><label><% =ds("De_Tipo") %>&nbsp;<%=ds("NO_PROTOCOLO") %>/<%=DS("AA_PROTOCOLO")%> -  <%=ds("NO_AREA")%></label></b></td>
			</tr>
            <tr>
              <td align="right">     <input type="hidden" id="aa_protocolo" name="aa_protocolo" value="<%= DS("AA_PROTOCOLO") %>" />              </td>
              <td><p>
              <%
			'  if(request("numeroAR") <> "--") then
'                response.write "<input type='checkbox' checked='checked' name='add_AR' id='add_AR'  onchange='adicionarAR()' />"
'				
'				else
'				
'				 response.write "<input type='checkbox'  name='add_AR' id='add_AR' disabled='disabled' onchange='adicionarAR()' />"
'				
'				end if
				%>
            <!--    <label>Adicionar AR ao ofício</label>
              </p>
                <p>
                  <label>Nº AR</label>-->
                  
                  <%
'			  if(request("numeroAR") <> "--") then
'			  
'                 response.write "<input class='form-field' type='text'  name='numeroAR' id='numeroAR' size='10px' maxlength='9' style='width:85px' value='"&request("numeroAR")&"'/>"			
'				else
'				
'				 response.write "<input class='form-field' type='text'  name='numeroAR' id='numeroAR' disabled='disabled' size='10px' maxlength='9' style='width:85px'/>"
'				
'				end if
				%>
                  
                </p></td>
            </tr>
            <tr>
     		  <td> <label>Destino:</label></td>
              <td colspan="3"><input class="form-field" name="destinoProtocolo" id="destinoProtocolo" type="text" size="75" maxlength="100" onchange="ChamarLink();" value="<% response.write(request("destino"))%>"/></td>
            </tr>
            <tr>
              <td><label>Conte&uacute;do: </label></td>
              <td colspan="3"><textarea class="form-field" name="conteudoProtocolo" id="conteudoProtocolo" style="max-height:39px;min-height:39px;max-width:470px;min-width:470px;"  onchange="ChamarLink();"  ><% response.write(request("conteudo"))%></textarea></td>
            </tr>
            <tr>
              <td align="right"> <label>Respons&aacute;vel:</label></td>
              <td colspan="3"><input class="form-field" name="responsavelProtocolo" id="responsavelProtocolo" size="75" maxlength="300" type="text" onchange="ChamarLink();" value="<%response.write(trim(request("responsavel")))%>"/><input type="hidden" name="f_responsavel_matricula" id="f_responsavel_matricula" ></td>
            </tr>
     <!-- 
            <tr>
              <td height="33" colspan="2"><br/><label style="margin:0px">
              Anexar Arquivos:</label></td>
              </tr>

            <tr>
              <td height="33" align="right"> <span class="responsavelFile">
                <label> Arquivo:</label>
              </span></td>
                <td height="33"><span class="responsavelFile">
          		<div id="arquivos" align="center">
                    <input type="file" class = "arquivo" id="arquivo1" name="arquivo1" disabled="disabled"/> 
                    <input type="hidden" id="qtd_arquivo" name="qtd_arquivo" value="0" /> 
                </div>
                </span>
                </td>
            </tr>
                -->
          </table> 
     <!-- 
          <p/>
           <label id="addArquivoa" style=" margin:95px"><img src="imagens\add_16x16.png" /> Adicionar outro arquivo</label>
-->           

            <div class="tipoarea"><!--tipoarea -->
              
		
        <div id="receberAROficio" class="recebeArOficio"></div>                        
 
			
            </div> <!--fim tipoarea -->
            
            
            <div class="destinoConteudo"> <!-- comeco destinoConteudo -->

			
            
            </div><!--fim tipoarea -->
  
            <div class="responsavelFile"> <!-- inicio do responsavelFile -->
              <label></label>
              <br/><br/>
            </div>
            <!-- fim do responsavelFile -->
			
            
            <!--<input  name="incluir_material" class="myButton" type="button"  value="Salvar" id="adicionarRecurso" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>-->
            
             	<div align="center">
    <p/>
      <label>Anexar mais arquivos:&nbsp;</label>
          <div  style="background-color:#F1f1f1; width:500px; border-radius: 4px;" >
     	<p/>
            
                <p/>
               <p style='color:red; font-size: 12px'>*O processo de envio de arquivos pode demorar alguns minutos.</p>
            <div id="arquivos" align="center">
              <input type="file" class = "arquivo" id="arquivo1" name="arquivo1">
                <input type="hidden" id="qtd_arquivo" name="qtd_arquivo" value="0" />
            
                <input type="hidden" id="data" name="data" disabled="disabled" value="<% date() %>">
        </div>
        
        </p>
        <label id="addArquivo" style="cursor:pointer"><img src="imagens\add_16x16.png" /> Adicionar outro arquivo</label>
        </p>
        </p>
        </div>       
</div>
            <p />
        <p align="center"><label>Arquivos relacionados:</label></p>
     <div id="arquivos_relacionados">
     	
          <div align="center" class="tabela" style="margin-bottom:3%; width:300px" >
            <table style="width:660px">
              <tr>
                <td width="20%">Nome</td>
                <td width="1%" >Extensão</td>
                <td width="1%">Tamanho</td>
                <td width="2%" >Criador</td>
                <td width="13%">Data de Criação</td>
                <td width="3%">Excluir</td>
              </tr>
              <%
			set rsNoProtocolo=Server.CreateObject("ADODB.RecordSet")
			QueryPasta = " SELECT * FROM TB_PROTOCOLO_ARQUIVOS_LOCAL_GRA "
			rsNoProtocolo.Open QueryPasta, dados_sys 
			Pasta      =	rsNoProtocolo("LOCAL_GRAVACAO_ARQUIVOS")
			rsNoProtocolo.close
								
			
			QueryNoProtocolo = "select AA_PROTOCOLO, no_protocolo, co_tipo from TB_PROTOCOLO_ATUAL where co_sequencial = "&request("codSeq")&""
			
			'set objConn = server.CreateObject("ADODB.Connection") 
			'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
			'objConn.open dados_sys

			rsNoProtocolo.Open QueryNoProtocolo, dados_sys 
			noProtocolo = rsNoProtocolo("NO_PROTOCOLO")
			aaProtocolo = rsNoProtocolo("AA_PROTOCOLO")
			codTipo = rsNoProtocolo("CO_TIPO")
			set rsArquivo=Server.CreateObject("ADODB.RecordSet")
			QueryArquivo ="select * from TB_PROTOCOLO_ARQUIVOS WHERE NO_PROTOCOLO ="&noProtocolo&" AND AA_PROTOCOLO="&aaProtocolo&" AND CO_TIPO="&codTipo&""
			rsArquivo.Open QueryArquivo, dados_sys 
			
			do UNTIL rsArquivo.eof
			
				arquivo_nome =rsArquivo("NO_ARQUIVO")
				arquivo_extensao = rsArquivo("SG_EXTENSAO")	 
				arquivo_tamanho = rsArquivo("VR_TAMANHO_KB")& " KB"
				arquivo_criador = rsArquivo("CO_CRIADOR")
				arquivo_data = rsArquivo("DH_CRIACAO")
				
				response.write "<tr>"
				response.write "<td id='arquivo_nome' ><a id = 'arquivo' href='" & Pasta &""& aaProtocolo & "-" & codTipo & "-" &noProtocolo & "\" & arquivo_nome & "' target='_blank'>"&arquivo_nome&"</a><input type='hidden' id='aaProtocolo' value='"&aaProtocolo&"'/><input type='hidden' id='codTipo' value='"&codTipo&"'/></td>"
				response.write "<td id='arquivo_extensao' >"& arquivo_extensao &"</td>"
				response.write "<td id='arquivo_tamanho' >"& arquivo_tamanho &"</td>"
				response.write "<td id='arquivo_criador' >"& arquivo_criador &"</td>"
				response.write "<td id='arquivo_data' >"& arquivo_data & "</td>"	
				response.write "<td width='1%'><img class = 'X' id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>"					
				response.write "</tr>"
				rsArquivo.movenext
			LOOP
			objConn.close 
			set  rsArquivo = nothing
			set objConn = nothing 
		  %>
              </table>
     
     </div>       

    <div id="receberLink"></div>
     
     <div align="center">
     <p/>
    <!-- <input type = "submit" class="myButton" id='salvar' style='margin:16px;' value="Salvar" > -->
    

	<div align="center" id="aviso">
    <img src='imagens/carregando.gif' />
	<p style='font-size: 16px; font-weight:bold'>POR FAVOR, AGUARDE.</p>
    </div>
    
    <input type = "button" class="myButton" id='salvar2'  value="Salvar" onclick="javascript: validaCampos();" >
     </div>
<input type="hidden" name="codSeq" id="codSeq" value="<% response.write(request("codSeq"))%>"/>
</form>      
</fieldset>
    </div>
  </div>
  <!--fim do corpo-->
</div>

        <%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	
		
		if ( sucesso="true" ) then
			'response.write("<p style='color:green; font-size: 16px'>Protocolo incluído com sucesso.</p>")
			response.write ("<script language=""javascript""> alert('Protocolo editado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
		
		else 
		
			if( sucesso="false" ) then
		
				response.write ("<script language=""javascript""> alert('Erro na edição do protocolo.'); </script>")
		
			end if	
				
		end if
		
		%>
<!--teste-->
</body>
</html>
