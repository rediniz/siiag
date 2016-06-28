<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
        <script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
        <script src="scripts/jquery.autocomplete.js" language="javascript"></script>

		     <script type="text/javascript" language="javascript">


                      
			$(document).ready(function(){
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete("autocompletar_ramal.asp",{
					minChars: 1 //Número mínimo de caracteres para aparecer a lista
				  , matchContains: true //Aparecer somente os que tem relação ao valor digitado
				  , scrollHeight: 220 //Altura da lista dos nomes
				  , selectFirst: true  //Vim o primeiro da lista selecionado
				  , mustMatch: false //Caso não existir na lista, remover o valor
				  , delay: 100 //Tempo para aparecer a lista para 0, por padrão vem 200
				  });
				  
				
				  
				  
				   //Quando selecionar valor pegar retorno. O retorno nesse caso são: Nome|Código
                $("#nome").result(function(event, retorno) {
                    if (retorno==undefined)
                        $("#nascimento").val(""),
						$("#jornada").val("");
                    else
					 
					    
						$("#coordenacao").val(retorno[1]),	
						
						
                });   
				
				 
			
		</script>
        
        
<div class="buscadorTelefone">

<p>Pesquisar Ramal</p>
 <input class="form-field" name="nome" id="nome" autocomplete="off"  type="text"  size="54" maxlength="100">
 
 <br/>
 <br/>
 <p>Ramal</p>
 <input class='form-field' name='coordenacao' id="coordenacao" type='text'   size='50' maxlength='50' value='' readonly='readonly' />
 
</div>        