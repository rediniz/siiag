<h3 class="tituloRelatorio">Relat&oacute;rio de F&eacute;rias</h3>
        <div class="labelsRelatorio">
        <label class="labels">Ger&ecirc;ncia:</label><br/>
        

        
        <select name="gerencia" id ="gerencia" class="form-select" onchange="ChamarLink();">
            <option selected="selected">Selecione a Ger&ecirc;ncia</option>
            <option value="1">Arreca&ccedil;&atilde;o e Repasse</option>
            <option value="2">Recupera&ccedil;&atilde;o de Cr&eacute;dito</option>
            <option value="3">Cadastro</option>
            <option value="4">Pagamento</option>
            <option value="5">Gest&atilde;o Aplica&ccedil;&atilde;o</option>
            <option value="6">Informa&ccedil;&otilde;es e Apoio &agrave;</option>
            <option value="7">Ger&ecirc;ncia</option>
            <option value="9">Monitoramento</option>
            <option value="16">Relacionamento com o Cliente</option>
          </select>
        
        
        
        
        
        <br/><br/>
        
        
        <label class="labels">Per&iacute;odo:</label>
        <br/><br/>
        
  
        De:</label>
        <input type="text" style="margin-bottom:5px;" id="dataInicial" class="datepicker" onchange="ChamarLink();">
               
        <br/>              
        <label>A:</label>  
        <input type="text" style="margin-left:22px;" id="dataFinal" class="datepicker" onchange="ChamarLink();"> 
  

        
        <br/><br/>
        <label class="labels">Situa&ccedil;&atilde;o:</label><br/>
        
        <select id="situacao" name"situacao" class="form-select">
              <option value="1" selected="selected">Socilitado</option>
              <option value="2">Confirmado</option>
              <option value="3">Pendente</option>
              <option value="5">Gozado</option>
              <option value="6">Não Atendido</option>
              <option value="7">Cancelado</option>
              <option value="8">Em Andamento</option>
            </select>
        
        
        
        
        <br/><br/>
    
<script>

function Pesquisar(){

 var situacao = document.getElementById("situacao").value;
 var gerencia =  document.getElementById("gerencia").value;
 var data_inicio = document.getElementById("dataInicial").value;
 var data_final = document.getElementById("dataFinal").value;

	//alert(gerencia);
	//alert(data_inicio);
	//alert(data_final);
	//alert(situacao);
 
 //window.location.assign("destacamento_consultar.asp?situacao="+situacao+"&nome="+nome+"&data_inicio="+data_inicio+"&data_final="+data_final+"");
 window.location.assign("ferias_gerador.asp?situacao="+situacao+"&data_inicio="+data_inicio+"&data_final="+data_final+"&gerencia="+gerencia+"");
 

}

</script>
	


			
	</script>
    
    <div id="receberLink">
    
    <input type="submit" name="button" id="button" class="myButton" value="Pesquisar" onclick="Pesquisar();" />
    
    
    </div>
</div>