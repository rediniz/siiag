<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<title>SIIAG-WEB</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<link type="text/css" rel="stylesheet" href="css/rcarousel.css" />

<style>

.botaoFerias{ margin-left:auto;}

.labels{margin-left:auto;}

.inputFerias{margin-left:auto;}

</style>

<script>

$(function() {

$( document ).on("click",".testando", function() {
alert("teste");
}

});

</script>
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- fazendo o include do topo aqui -->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container2">
      <div class="conteudo">
       
       <%
	   relatorio = Request("Relatorio")
	   SELECT CASE relatorio 
	   
	   CASE "ferias"

	   	%>
        
        <h3 class="tituloRelatorio">Relat&oacute;rio de F&eacute;rias</h3>
        <div class="labelsRelatorio">
        <label class="labels">Ger&ecirc;ncia:</label><br/>
        
        
        
        
        <select name="gerencia" id = "gerencia">
            <option selected="selected"> Selecione a Ger&ecirc;ncia</option>
            <option class="testando" value="aplicacao">Aplica&ccedil;&atilde;o</option>
            <option value="arrecadacao">Arreca&ccedil;&atilde;o e Repasse</option>
            <option value="cadastro">Cadastro</option>
            <option value="gerencia">Ger&ecirc;ncia</option>
            <option value="informacao">Informa&ccedil;&otilde;es e Apoio &agrave; Gest&atilde;o</option>
            <option value="monitoramento">Monitoramento</option>
            <option value="pagamento">Pagamento</option>
            <option value="recuperacao">Recupera&ccedil;&atilde;o de Cr&eacute;dito</option>
            <option value="relacionamento">Relacionamento com o Cliente</option>
          </select>
        
        
        
        
        
        <br/><br/>
        <label class="labels">Per&iacute;odo:</label><br/><br/>
        
        
        <label>De:</label>
         <select name="diaInicial">
							 <option value="01" <%If DAY(Date())="1" Then%>selected<%End If%>>01</option>
							 <option value="02" <%If DAY(Date())="2" Then%>selected<%End If%>>02</option>
							 <option value="03" <%If DAY(Date())="3" Then%>selected<%End If%>>03</option>
							 <option value="04" <%If DAY(Date())="4" Then%>selected<%End If%>>04</option>
							 <option value="05" <%If DAY(Date())="5" Then%>selected<%End If%>>05</option>
							 <option value="06" <%If DAY(Date())="6" Then%>selected<%End If%>>06</option>
							 <option value="07" <%If DAY(Date())="7" Then%>selected<%End If%>>07</option>
							 <option value="08" <%If DAY(Date())="8" Then%>selected<%End If%>>08</option>
							 <option value="09" <%If DAY(Date())="9" Then%>selected<%End If%>>09</option>
							 <option value="10" <%If DAY(Date())="10" Then%>selected<%End If%>>10</option>
							 <option value="11" <%If DAY(Date())="11" Then%>selected<%End If%>>11</option>
							 <option value="12" <%If DAY(Date())="12" Then%>selected<%End If%>>12</option>
							 <option value="13" <%If DAY(Date())="13" Then%>selected<%End If%>>13</option>
							 <option value="14" <%If DAY(Date())="14" Then%>selected<%End If%>>14</option>
							 <option value="15" <%If DAY(Date())="15" Then%>selected<%End If%>>15</option>
							 <option value="16" <%If DAY(Date())="16" Then%>selected<%End If%>>16</option>
							 <option value="17" <%If DAY(Date())="17" Then%>selected<%End If%>>17</option>
							 <option value="18" <%If DAY(Date())="18" Then%>selected<%End If%>>18</option>
							 <option value="19" <%If DAY(Date())="19" Then%>selected<%End If%>>19</option>
							 <option value="20" <%If DAY(Date())="20" Then%>selected<%End If%>>20</option>
							 <option value="21" <%If DAY(Date())="21" Then%>selected<%End If%>>21</option>
							 <option value="22" <%If DAY(Date())="22" Then%>selected<%End If%>>22</option>
							 <option value="23" <%If DAY(Date())="23" Then%>selected<%End If%>>23</option>
							 <option value="24" <%If DAY(Date())="24" Then%>selected<%End If%>>24</option>
							 <option value="25" <%If DAY(Date())="25" Then%>selected<%End If%>>25</option>
							 <option value="26" <%If DAY(Date())="26" Then%>selected<%End If%>>26</option>
							 <option value="27" <%If DAY(Date())="27" Then%>selected<%End If%>>27</option>
							 <option value="28" <%If DAY(Date())="28" Then%>selected<%End If%>>28</option>
							 <option value="29" <%If DAY(Date())="29" Then%>selected<%End If%>>29</option>
							 <option value="30" <%If DAY(Date())="30" Then%>selected<%End If%>>30</option>
							 <option value="31" <%If DAY(Date())="31" Then%>selected<%End If%>>31</option>
						</select>
						
						/
						
						
						
						<select name="mesInicial">
						
							 <option value="01" <%If MONTH(Date())="1" Then%>selected<%End If%>>01</option>
							 <option value="02" <%If MONTH(Date())="2" Then%>selected<%End If%>>02</option>
							 <option value="03" <%If MONTH(Date())="3" Then%>selected<%End If%>>03</option>
							 <option value="04" <%If MONTH(Date())="4" Then%>selected<%End If%>>04</option>
							 <option value="05" <%If MONTH(Date())="5" Then%>selected<%End If%>>05</option>
							 <option value="06" <%If MONTH(Date())="6" Then%>selected<%End If%>>06</option>
							 <option value="07" <%If MONTH(Date())="7" Then%>selected<%End If%>>07</option>
							 <option value="08" <%If MONTH(Date())="8" Then%>selected<%End If%>>08</option>
							 <option value="09" <%If MONTH(Date())="9" Then%>selected<%End If%>>09</option>
							 <option value="10" <%If MONTH(Date())="10" Then%>selected<%End If%>>10</option>
							 <option value="11" <%If MONTH(Date())="11" Then%>selected<%End If%>>11</option>
							 <option value="12" <%If MONTH(Date())="12" Then%>selected<%End If%>>12</option>
									
							
						</select>
                        
                        /
						
						<select name="anoInicial">
						
							 <option value="01" <%If MONTH(Date())="1" Then%>selected<%End If%>>Janeiro</option>
							 <option value="02" <%If MONTH(Date())="2" Then%>selected<%End If%>>Fevereiro</option>
							 <option value="03" <%If MONTH(Date())="3" Then%>selected<%End If%>>Mar&ccedil;o</option>
							 <option value="04" <%If MONTH(Date())="4" Then%>selected<%End If%>>Abril</option>
							 <option value="05" <%If MONTH(Date())="5" Then%>selected<%End If%>>Maio</option>
							 <option value="06" <%If MONTH(Date())="6" Then%>selected<%End If%>>Junho</option>
							 <option value="07" <%If MONTH(Date())="7" Then%>selected<%End If%>>Julho</option>
							 <option value="08" <%If MONTH(Date())="8" Then%>selected<%End If%>>Agosto</option>
							 <option value="09" <%If MONTH(Date())="9" Then%>selected<%End If%>>Setembro</option>
							 <option value="10" <%If MONTH(Date())="10" Then%>selected<%End If%>>Outubro</option>
							 <option value="11" <%If MONTH(Date())="11" Then%>selected<%End If%>>Novembro</option>
							 <option value="12" <%If MONTH(Date())="12" Then%>selected<%End If%>>Dezembro</option>
									
							
						</select>
               
        <br/><br/>                
        <label>At&eacute;:</label>  
        
        	 <select name="diaFinal">
							 <option value="01" <%If DAY(Date())="1" Then%>selected<%End If%>>01</option>
							 <option value="02" <%If DAY(Date())="2" Then%>selected<%End If%>>02</option>
							 <option value="03" <%If DAY(Date())="3" Then%>selected<%End If%>>03</option>
							 <option value="04" <%If DAY(Date())="4" Then%>selected<%End If%>>04</option>
							 <option value="05" <%If DAY(Date())="5" Then%>selected<%End If%>>05</option>
							 <option value="06" <%If DAY(Date())="6" Then%>selected<%End If%>>06</option>
							 <option value="07" <%If DAY(Date())="7" Then%>selected<%End If%>>07</option>
							 <option value="08" <%If DAY(Date())="8" Then%>selected<%End If%>>08</option>
							 <option value="09" <%If DAY(Date())="9" Then%>selected<%End If%>>09</option>
							 <option value="10" <%If DAY(Date())="10" Then%>selected<%End If%>>10</option>
							 <option value="11" <%If DAY(Date())="11" Then%>selected<%End If%>>11</option>
							 <option value="12" <%If DAY(Date())="12" Then%>selected<%End If%>>12</option>
							 <option value="13" <%If DAY(Date())="13" Then%>selected<%End If%>>13</option>
							 <option value="14" <%If DAY(Date())="14" Then%>selected<%End If%>>14</option>
							 <option value="15" <%If DAY(Date())="15" Then%>selected<%End If%>>15</option>
							 <option value="16" <%If DAY(Date())="16" Then%>selected<%End If%>>16</option>
							 <option value="17" <%If DAY(Date())="17" Then%>selected<%End If%>>17</option>
							 <option value="18" <%If DAY(Date())="18" Then%>selected<%End If%>>18</option>
							 <option value="19" <%If DAY(Date())="19" Then%>selected<%End If%>>19</option>
							 <option value="20" <%If DAY(Date())="20" Then%>selected<%End If%>>20</option>
							 <option value="21" <%If DAY(Date())="21" Then%>selected<%End If%>>21</option>
							 <option value="22" <%If DAY(Date())="22" Then%>selected<%End If%>>22</option>
							 <option value="23" <%If DAY(Date())="23" Then%>selected<%End If%>>23</option>
							 <option value="24" <%If DAY(Date())="24" Then%>selected<%End If%>>24</option>
							 <option value="25" <%If DAY(Date())="25" Then%>selected<%End If%>>25</option>
							 <option value="26" <%If DAY(Date())="26" Then%>selected<%End If%>>26</option>
							 <option value="27" <%If DAY(Date())="27" Then%>selected<%End If%>>27</option>
							 <option value="28" <%If DAY(Date())="28" Then%>selected<%End If%>>28</option>
							 <option value="29" <%If DAY(Date())="29" Then%>selected<%End If%>>29</option>
							 <option value="30" <%If DAY(Date())="30" Then%>selected<%End If%>>30</option>
							 <option value="31" <%If DAY(Date())="31" Then%>selected<%End If%>>31</option>
						</select>
						
						/
						
						
						
						<select name="mesFinal">
						
							 <option value="01" <%If MONTH(Date())="1" Then%>selected<%End If%>>01</option>
							 <option value="02" <%If MONTH(Date())="2" Then%>selected<%End If%>>02</option>
							 <option value="03" <%If MONTH(Date())="3" Then%>selected<%End If%>>03</option>
							 <option value="04" <%If MONTH(Date())="4" Then%>selected<%End If%>>04</option>
							 <option value="05" <%If MONTH(Date())="5" Then%>selected<%End If%>>05</option>
							 <option value="06" <%If MONTH(Date())="6" Then%>selected<%End If%>>06</option>
							 <option value="07" <%If MONTH(Date())="7" Then%>selected<%End If%>>07</option>
							 <option value="08" <%If MONTH(Date())="8" Then%>selected<%End If%>>08</option>
							 <option value="09" <%If MONTH(Date())="9" Then%>selected<%End If%>>09</option>
							 <option value="10" <%If MONTH(Date())="10" Then%>selected<%End If%>>10</option>
							 <option value="11" <%If MONTH(Date())="11" Then%>selected<%End If%>>11</option>
							 <option value="12" <%If MONTH(Date())="12" Then%>selected<%End If%>>12</option>
									
							
						</select>
                        
                        /
						
						<select name="anoFinal">
						
							 <option value="01" <%If MONTH(Date())="1" Then%>selected<%End If%>>Janeiro</option>
							 <option value="02" <%If MONTH(Date())="2" Then%>selected<%End If%>>Fevereiro</option>
							 <option value="03" <%If MONTH(Date())="3" Then%>selected<%End If%>>Mar&ccedil;o</option>
							 <option value="04" <%If MONTH(Date())="4" Then%>selected<%End If%>>Abril</option>
							 <option value="05" <%If MONTH(Date())="5" Then%>selected<%End If%>>Maio</option>
							 <option value="06" <%If MONTH(Date())="6" Then%>selected<%End If%>>Junho</option>
							 <option value="07" <%If MONTH(Date())="7" Then%>selected<%End If%>>Julho</option>
							 <option value="08" <%If MONTH(Date())="8" Then%>selected<%End If%>>Agosto</option>
							 <option value="09" <%If MONTH(Date())="9" Then%>selected<%End If%>>Setembro</option>
							 <option value="10" <%If MONTH(Date())="10" Then%>selected<%End If%>>Outubro</option>
							 <option value="11" <%If MONTH(Date())="11" Then%>selected<%End If%>>Novembro</option>
							 <option value="12" <%If MONTH(Date())="12" Then%>selected<%End If%>>Dezembro</option>
									
							
						</select>
                    
                        
        
        
        <br/><br/>
        <label class="labels">Situa&ccedil;&atilde;o:</label><br/>
        
        <select name"situacao">
              <option value="solicitado" selected="selected">Socilitado</option>
              <option value="confirmado">Confirmado</option>
              <option value="pendente">Pendente</option>
              <option value="gozado">Gozado</option>
              <option value="natendido">Não Atendido</option>
              <option value="cancelado">Cancelado</option>
              <option value="emandamento">Em Andamento</option>
            </select>
        
        <input name="" id="teste2" class="botaoTeste" type="button" value="Teste"/>
        
        <br/><br/>
        
        <div id="linkRelatorio"></div>
        
        <input name="" class="botaoFerias" type="button" value="Gerar Relat&oacute;rio"/>
		</div>
	   
	   <%
	   Case "destacamento"
	   
		%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Destacamentos</h3>	
		
		<%   
	   
	   
	   Case "estoque"
	   
	   	%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Estoque</h3>	
		
		<% 
	   
		   
			
		
	   
	   Case "treinamentos"
	   
	   	%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Treinamentos</h3>	
		
		<% 
		   
	   
	   
	   
	   Case "emprestimos"
	   
	  	%>
		
        <h3 class="tituloRelatorio">Relat&oacute;rio de Empr&eacute;stimos</h3>	
		
		<% 	  
	   
	   
	  
	     
	   END SELECT
	   
	   %> 
       
      </div>
      <!-- #INCLUDE FILE ="calendario.asp" -->
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
