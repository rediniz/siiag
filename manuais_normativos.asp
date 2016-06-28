<link rel="stylesheet" href="tabela.css" type="text/css"/>
<style>
.manuaisNormativos {
	background: #FFFFFF;
	float: right;
	margin-top: 25px;
	width: 230px;
	margin-right: 2.1%;
	border-radius: 10px;
	height: auto;
	min-height: 100px;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){	
		carregou = false;
		$("#buscaManuaisNormativos").on("keyup", function(){
			$.ajax({
				data: {
					filtro: $("#buscaManuaisNormativos").val()
				},
				url: "manuais_normativos_con.asp",
				dataType: "json",
				success: function(data) {
					$('#tabelaNormativos').html("<tr><td>Código</td><td>Descrição</td><td>Visualizar</td></tr>");
					$.each(data, function(chave,valor) {
						$('#tabelaNormativos').append("<tr><td>"+valor.co_manual+"</td><td>"+valor.de_manual+"</td><td><a href='"+valor.link_manual+"' target='_blank'><img src='imagens/search_24x24.png' style='border-style:none'  width='16' height='16'/></a></td></tr>");
					});	  
				},
				error: function(data){
					alert("Erro ao carregar manuais normativos.");
					console.log(data.responseText);
				}	
			})
		});
		
		$("#pesquisarManuais").on("click", function(){		
			$("#janelaNormativos").dialog({
				modal: false,
				closeText: "Fechar",
				height:600,
				width:800,
				draggable: false,
				title: "Manuais Normativos",
				open: function(event,ui){
					if(!carregou){
						$.ajax({
							url: "manuais_normativos_con.asp",
							dataType: "json",
							success: function(data) {
								$.each(data, function(chave,valor) {
									$('#tabelaNormativos').append("<tr><td>"+valor.co_manual+"</td><td>"+valor.de_manual+"</td><td><a href='"+valor.link_manual+"' target='_blank'><img src='imagens/search_24x24.png' style='border-style:none'  width='16' height='16'/></a></td></tr>");
								});
								carregou = true;
							},
							error: function(data) {
								alert("Erro ao carregar manuais normativos.");
								console.log(data.responseText);
							}
						});
					}
				},
				close: function(event,ui){
					$("#buscaManuaisNormativos").val(""); 
					$("#buscaManuaisNormativos").trigger("keyup");
				}
			});
		});
	});
</script>

<div class="manuaisNormativos" >
  <h3 class="subtitulosAgenda" style="margin-left:19%; margin-top:15px; margin-bottom:10px; color: #f89514;"><i class="fa fa-book" style="color:#039"></i> Manuais Normativos</h3>
  <div align="center" style="margin-bottom:5px">
    <button id="pesquisarManuais" name="pesquisarManuais" type="button" class="myButton">Pesquisar Manuais</button>
  </div>
</div>
<div id="janelaNormativos" class="janelaNormativos" style="display:none;">
		<label>Buscar:</label>
    <br />
    <input type="text" class="form-field" id="buscaManuaisNormativos" name="buscaManuaisNormativos"  style="width:96%" />
    <br />
    <br />
    <div class="tabela">
        <table id="tabelaNormativos">
            <tr>
				<td>Código</td><td>Descrição</td><td>Visualizar</td>
            </tr>
        </table>
    </div>
    <br />
    <br />
</div>