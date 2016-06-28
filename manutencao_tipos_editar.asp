

        <script type="text/javascript" language="javascript">

	$(document).ready(function(){
	
	$(".edicao").hide();
	
	$("#salvar").hide();

 $("#tipos").on("change", function(){ 
 
 $("#salvar").hide();
$(".edicao").hide();
if($("#tipos").val()==1){
$("#afastamento").show();
}
if($("#tipos").val()==2){
$("#contato").show();
}
if($("#tipos").val()==3){
$("#contratacao").show();
}
if($("#tipos").val()==4){
$("#diaria").show();
}
if($("#tipos").val()==5){
$("#emprestimo").show();
}
if($("#tipos").val()==6){
$("#evento").show();
}
if($("#tipos").val()==7){
$("#recurso").show();
}
if($("#tipos").val()==8){
$("#transporte").show();
}
if($("#tipos").val()==9){
$("#treinamento").show();
}
 });
 
 
		
/*$("#solicitar").on("click", function(){ 

 if($("#mat_usuario").val() != "C054423" || $("#mat_usuario").val() != "C097105"){
 alert("Você não está autorizado a solicitar férias.")
 
 }
 });*/	
			});
			
	
	</script>
    

 <script>

	$(function() { 
	
			
		  $("#tipos").on( "change",function() {

		//window.location.assign("consulta_tipos_con.asp?tipo="+$("#tipos").val());
					$.ajax({
				method: "GET",
       			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
       			url: "consulta_tipos_con.asp?tipo="+$("#tipos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$('#lista_tipos').html(data); 
					$('.bloqueio').attr("disabled", true); 
					$('#edicao').html("");
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao pesquisar tipos.");
 				}
		
      		})
    });
				$("#lista_tipos").on( "change",function() {
				
				$('#edicao').html(""); 
				$("#salvar").hide();
				
				});
	
			  $("#editar").on( "click",function() {
			  
			

		//window.location.assign("manutencao_teste.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val());
				$.ajax({
				method: "GET",
       			url: "manutencao_tipos_monta_form.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$('#edicao').html(data); 
					$("#salvar").show();
        		},
		 		error: function(erro){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro.");
 				}		
      		})
			
    });	
	
				  $("#salvar").on( "click",function() {
				    
					confirma = window.confirm("Confirmar edição?");
			  
					if(!confirma){
						return false;
					} else {
					
					//$("#edicao").append("<input type='text' class='form-field bloqueio'   id='tipo' name='tipo' size='60' value="+$("#tipos").val()+">")
//					$("#edicao").append("<input type='text' class='form-field bloqueio'   id='codigo' name='codigo' size='60' value="+$("#lista_tipos").val()+">")
//					
//					$("#formulario").submit();
					
				//window.location.assign("manutencao_teste.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val());
						$.ajax({
							method: "GET",
							url: "manutencao_tipos_editar_con.asp?tipo="+$("#tipos").val()+"&codigo="+$("#lista_tipos").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
							data: $("#formulario").serialize(),
							dataType: "html", // TIPO DE DADOS DE RETORNO
							//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
							beforeSend: function() { // ANTES DA REQUISIÇÃO
								},
							complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
							},
							success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
								alert("Edição realizada com sucesso.");
							},
							error: function(data, error){ // CASO OCORRA ERRO NA REQUISIÇÃO
								alert("Erro na edição");
							}		
					})
			}
    });	
	});

 </script>
<!-- fecha efeito da janela de ajuda -->
          <form id="formulario" name="formulario" action="manutencao_tipos_editar_con.asp">
          
          <table width="653" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="128"><span class="alinhador" >
                <select class='form-select' id='tipos' name='tipos' style="padding-bottom:3px">
                    <option value=''> 	Selecione um tipo...</option>  
                    <option value='1'> 	Afastamento	</option>  
                    <option value='2'> 	Contato		</option>
                    <option value='3'> 	Contratação	</option>
                    <option value='11'> Coordenação	</option>
                    <option value='4'> 	Diária		</option>
                    <option value='5'> 	Empréstimo	</option>
                    <option value='6'> 	Evento		</option>
                    <option value='10'> Local		</option>
                    <option value='7'> 	Recursos		</option>
                    <option value='8'> 	Transporte	</option>  
                    <option value='9'> 	Treinamento	</option>         
                </select> 
                </span></td>
              <td width="62"><span class="alinhador" >
                <select name="lista_tipos" id="lista_tipos" class='form-select'></select></span>
              </td>
                <td width="370">
                <input name="editar" id="editar" class="myButton" type="button" value="Editar" style="margin-left:5px"/>
              </td>
              
            </tr>
          </table>
          
          </p>
          <div id="edicao"></div>
          
          <input type='hidden' id='codigo_tipo' name='codigo_tipo' value='' />

        </form>
        
        <input  style="margin-top:7px;margin-left:5px;" name="salvar" id="salvar" class="myButton" type="button" value="Salvar"/>
         

    


