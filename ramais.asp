
<style>

.ramais{
	background:#FFFFFF;
	float:right;
	margin-top:25px;
	width:230px;
	margin-right:2.1%;
	border-radius: 10px;
	position: relative;
	height:auto;
}


</style>


<script>

			$(document).ready(function() {
				
				$("#pesquisar").hide();
				$("#nomePesquisa").hide();
				
				$("#tipo_ramal").on("change", function(){
					
					var tipoPesquisa = $("#tipo_ramal").val();
					
					if(tipoPesquisa != "0"){						
						$("#pesquisar").show();
						$("#nomePesquisa").show();				
					}else{
						$("#pesquisar").hide();
						$("#nomePesquisa").hide();
					}
									

				});
			
			$('#pesquisar').on('click',function(){
	
				var tipoPesquisa = $("#tipo_ramal").val();
				
				if(tipoPesquisa == "0"){
					
					alert("Selecione um tipo.");
					return false;
				}

				
				if(tipoPesquisa == "1"){
											
						var nomePesquisa = $("#nomePesquisa").val()
						
						
						var top = (window.innerHeight / 4) +80
						var left = (window.innerWidth / 4) -60
			
			window.open("ramais_consulta.asp?nomePesquisa="+nomePesquisa, "Pesquisar Ramal", "height=354, width=594, scrollbars=yes, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
			
				}else{
					
					var nomePesquisa = $("#nomePesquisa").val();
					$("#frame_ramais").prop("src", "ramais_uteis.asp?pesquisa="+nomePesquisa);
						
					$("#ramais_uteis").dialog({
						modal: false, // Escurecer o fundo ou não
						closeText: "Fechar",
						height:700,
						width:700
					});
					
				}
									
				});
				
				$("#uteis").on("click", function(){
												
					$("#ramais_uteis").dialog({
						modal: false, // Escurecer o fundo ou não
						closeText: "Fechar",
						height:500,
						width:700
					});
				});
		});
				
</script> 


<div class="ramais">
<h5 class="subtitulosAgenda" style="margin-left:19%; margin-top:15px; margin-bottom:10px; color: #f89514;"><i class="fa fa-phone" style="color:#039"></i> Pesquisa de Ramais</h5>
<!--<form>-->
<div align="center" style="margin-bottom:5px">
<select id="tipo_ramal" name="tipo_ramal" class="form-select">
<option value="0">Selecione...</option>
<option value="1">Usuários <%=request.Cookies("co_usuario_sg_unidade_siiag")%></option>
<option value="2">Ramais Úteis</option>
</select>
</div>
<input type="text" class="form-field" style="margin-left:15%;" id="nomePesquisa" />
<input type="submit" class="myButton"  id="pesquisar" value="Pesquisar" style="margin-left:25%;margin-top:5%;margin-bottom:3%;"/>
<!--</form>-->
<!--
<button  type="button" id="uteis" class="myButton" style="margin-bottom:5px;margin-left:15%"><img src="imagens/tel_uteis.png" width="18" height="18"  style="margin-right:5px; vertical-align:middle"/>Ramais Úteis</button>-->
   

<!--<img class="myButton" src="imagens/search_24x24.png" style="margin-left:34%;margin-top:8%;margin-bottom:5px;" />-->
</div>
<div  align="center" id="dialog-message" title="Atividade" class="msg-dialog" style="display:none;">
   <div id = "ramais_uteis" title="Ramais úteis" style="display:none;">
   	    <iframe id="frame_ramais" name="frame_ramais" src="ramais_uteis.asp" width="100%" style=" min-height:600px;" frameborder="0" />
        </iframe>
   </div>
   </div>


    	
 