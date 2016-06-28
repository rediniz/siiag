
<style>

.ramais{
background:#FFFFFF;
float:right;
margin-top:25px;
width:230px;
margin-right:2.1%;
border-radius: 10px;
position: relative;
}


</style>


<script>

			$(document).ready(function() {
			
			$('.myButton').on('click',function(){
											
						var nomePesquisa = $("#nomePesquisa").val()
						
						
						var top = (window.innerHeight / 4) +80
						var left = (window.innerWidth / 4) -60
			
			window.open("ramais_consulta.asp?nomePesquisa="+nomePesquisa, "Pesquisar Ramal", "height=354, width=594, scrollbars=yes, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
									
				});
				});
				
</script> 


<div class="ramais">
<h5 class="titulos" style="margin-left:20%; margin-top:15px; margin-bottom:10px;"> Pesquisa de Ramais</h5>
<form>
<input type="text" class="form-field" style="margin-left:15%;" id="nomePesquisa" />
<input type="submit" class="myButton"  value="Pesquisar" style="margin-left:24%;margin-top:5%;margin-bottom:7%;"/>
</form>
<!--<img class="myButton" src="imagens/search_24x24.png" style="margin-left:34%;margin-top:8%;margin-bottom:5px;" />-->
</div>