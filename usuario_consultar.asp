<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge"> 

<title>Usu&aacute;rio</title>

	    <link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
        <script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
        <script src="scripts/jquery.autocomplete.js" language="javascript"></script>

	<script type="text/javascript" language="javascript">

                      
			$(document).ready(function(){
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete("autocompletar_nome.asp",{
					minChars: 1 //Número mínimo de caracteres para aparecer a lista
				  , matchContains: true //Aparecer somente os que tem relação ao valor digitado
				  , scrollHeight: 220 //Altura da lista dos nomes
				  , selectFirst: true  //Vim o primeiro da lista selecionado
				  , mustMatch: false //Caso não existir na lista, remover o valor
				  , delay: 100 //Tempo para aparecer a lista para 0, por padrão vem 200
				  });
				  
				  	$("#matricula").focus().autocomplete("autocompletar_matricula.asp",{
					minChars: 1 //Número mínimo de caracteres para aparecer a lista
				  , matchContains: true //Aparecer somente os que tem relação ao valor digitado
				  , scrollHeight: 220 //Altura da lista dos nomes
				  , selectFirst: true //Vim o primeiro da lista selecionado
				  , mustMatch: false //Caso não existir na lista, remover o valor
				  , delay: 100 //Tempo para aparecer a lista para 0, por padrão vem 200
				  });
				  
				  
				   //Quando selecionar valor pegar retorno. O retorno nesse caso são: Nome|Código
                $("#nome").result(function(event, retorno) {
                    if (retorno==undefined)
					
                        $("#matricula").val(""),
						$("#coordenacao").val(""),	
						$("#cargo").val(""),
                        $("#nascimento").val(""),
						$("#admissao").val(""),
						$("#inicio").val(""),
						$("#jornada").val(""),
						$("#ativo").val(""),
						$("#gerente").val("");
						
                 		else
					 
					    $("#matricula").val(retorno[1]);
						$("#coordenacao").val(retorno[2]);	
						$("#cargo").val(retorno[3]);
                        $("#nascimento").val(retorno[4].replace("-", "/").replace("-", "/").split(" ", 1));
						$("#admissao").val(retorno[5].replace("-", "/").replace("-", "/").split(" ", 1));
						$("#inicio").val(retorno[6].replace("-", "/").replace("-", "/").split(" ", 1));
						$("#jornada").val(retorno[7] + " horas");	
						
						if (retorno[8] == "True") {
						$("#ativo").attr("checked", "checked");
							
						}
						if (retorno[9] == "True") {
						$("#gerente").attr("checked", "checked");					
						}
						if(retorno[10] == ""){
						$("#foto").attr("src", "\\\ce7180nt005\\imagensGIFUG$\\usuarios\\X000001.png");
						}else{
						$("#foto").attr("src", retorno[10]);
						}
						
                });   
				
				 $("#matricula").result(function(event, retorno) {
                    if (retorno==undefined)
					
                        $("#matricula").val(""),
						$("#coordenacao").val(""),	
						$("#cargo").val(""),
                        $("#nascimento").val(""),
						$("#admissao").val(""),
						$("#inicio").val(""),
						$("#jornada").val(""),
						$("#ativo").val(""),
						$("#gerente").val("");
						
                    else
						
					    $("#nome").val(retorno[1]);
						$("#coordenacao").val(retorno[2]);				
						$("#cargo").val(retorno[3]);
                        $("#nascimento").val(retorno[4].replace("-", "/").replace("-", "/").split(" ", 1));
						$("#admissao").val(retorno[5].replace("-", "/").replace("-", "/").split(" ", 1));
						$("#inicio").val(retorno[6].replace("-", "/").replace("-", "/").split(" ", 1));
						$("#jornada").val(retorno[7] + " horas");
						
						
						if (retorno[8] == "True") {
						$("#ativo").attr("checked", "checked");
							
						}
						if (retorno[9] == "True") {
						$("#gerente").attr("checked", "checked");					
						}
						if(retorno[10] == ""){
						$("#foto").attr("src", "\\\ce7180nt005\\imagensGIFUG$\\usuarios\\X000001.png");
						}else{
						$("#foto").attr("src", retorno[10]);
						}
						
                });
			});
			
		</script>
        

<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />

<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon"><!--favicon -->




<!--CSS-->
<style type="text/css">
<!--
.style2 {font-size: 14}
.style3 {color: #5683C4}
-->
</style>
 		
     


</head>
<body>
<div class="teste"> <!--fundo azul do meio-->

<!-- #INCLUDE FILE ="topo.asp" -->

<div class="corposite"> <!--corpo-->

<div class="container">

<div class="conteudo">

<div class="usuariodiv"> 

 <div id='cssmenu'>
<ul>
   <li><a href='usuario.asp'><span>Visualização</span></a></li>
   <li class='active'><a href='usuario_consultar.asp'><span>Consultar</span></a></li>
   <li  ><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
   
</ul>
</div></p>




<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">

  <legend class="style2 style3">Informações do Usu&aacute;rio</legend>
  <p class="paragrafoteste style2">    
  <span class="style4 style2">

  <div  class='img_usuario'><img id='foto' src='\\ce7180nt005\imagensGIFUG$\usuarios\X000001.png'/></div>

	    <label >Matr&iacute;cula: </label> 
     <input class='form-field' name='matricula' id='matricula' autocomplete="off"  type='text'  size='10' maxlength='100'  value= '' />

    <br/>
    <br/>
    <label >Nome: </label>
  
    <input class="form-field" name="nome" id="nome" autocomplete="off"  type="text"  size="54" maxlength="100">
    <br/>
    <br/>
    <label > Coordena&ccedil;&atilde;o: </label> 
   
    <input class='form-field' name='coordenacao' id="coordenacao" type='text'  size='50' maxlength='50' value='' readonly='readonly' />
	
     <br/>
    <br/>

    <label >Cargo: </label> 

    <input class='form-field' name='cargo' id="cargo" type='text'  size='10' maxlength='10' value='' readonly='readonly' />  
    <br/>
    <br/>                     
    <label >Nascimento: </label> 
 
    <input class='form-field' name='nascimento'  id="nascimento" type='text'  size='10' maxlength='10' value='' readonly='readonly' />
    <br/>
    <br/>


    <label >Admissão: </label>  


        <input class='form-field' name='admissao' id="admissao" type='text'  size='10' maxlength='10'  value='' readonly='readonly' />
    <label>Início: </label> 
   <input class='form-field' name='inicio'  id="inicio" type='text'  size='10' maxlength='10' value='' readonly='readonly' />
    <br/>
    <br/>
    <label >Jornada:</label> 
    
  <input class='form-field' name='jornada' id="jornada" type='text'  id="jornada" size='10' maxlength='10' value='' readonly='readonly' />
  
    </span>
  <p>
      <span >
      <label style="float:left; "> Ativo:</label>
      <input  type='checkbox' name='ativo' value='ativo' id='ativo'  readonly='readonly'/>
	
      <br/>
      <label for="RadiodaJornada_1" style="text-align:right;">Gerente ou Substituto:</label>
<input type='checkbox' name='gerente' value='gerente' id='gerente' readonly='readonly' />

        

      </span><span class="style4"><br />
  </span></p>
  <div>
  
   <fieldset style="border:none;">
      
      <div id='submenu'>
     
      
        <ul>
        
           <li> <a href='usuario.asp?aba=contatos#bottom'><span>Contatos</span></a></li>
           <li> <a href='usuario.asp?aba=perfis#bottom'><span>Perfis</span></a></li>
        
           
        </ul>
        
<% 

	aba=Request("aba")
	SELECT CASE aba
		CASE "contatos"
	%>
    <!-- #INCLUDE FILE ="usuario_contatos.asp" -->
    <%
		CASE "perfis"
	%>
    <!-- #INCLUDE FILE ="usuario_perfis.asp" -->
  
    <%
		
	
	END SELECT

%> 
       
<p/><a name="bottom" id="bottom"></a>        </div>
      </fieldset>  

  </p>
  </fieldset>
   
</div>

</div> 

</div>

</div> <!--fim do corpo-->

<!-- #INCLUDE FILE ="rodape.asp" -->
</div> <!--teste-->

</body>
</html>