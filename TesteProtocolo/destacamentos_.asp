<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Destacamento</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<!-- efeito da janela de ajuda -->

<style>
#selectable .ui-selecting {
	background: #FDE499;
}

#selectable .ui-selected {
	background: #FFCC66;
}

#tabs {
	font-size:12px;
}

.ui-datepicker {
	font-size:12px;
}

    button {
        
        -moz-box-shadow:inset 0px 1px 0px 0px #97c4fe;
        -webkit-box-shadow:inset 0px 1px 0px 0px #97c4fe;
        box-shadow:inset 0px 1px 0px 0px #97c4fe;
        
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #3d94f6), color-stop(1, #1e62d0));
        background:-moz-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:-webkit-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:-o-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:-ms-linear-gradient(top, #3d94f6 5%, #1e62d0 100%);
        background:linear-gradient(to bottom, #3d94f6 5%, #1e62d0 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#3d94f6', endColorstr='#1e62d0',GradientType=0);
        
        background-color:#3d94f6;
        
        -moz-border-radius:6px;
        -webkit-border-radius:6px;
        border-radius:6px;
        
        border:1px solid #337fed;
        
        display:inline-block;
        color:#ffffff;
        font-family:Arial,Verdana, Helvetica;
        font-size:15px;
        font-weight:normal;
        padding:6px 24px;
        text-decoration:none;
        
        text-shadow:0px 1px 0px #1570cd;
        
    }
	
    button:hover {
        
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #1e62d0), color-stop(1, #3d94f6));
        background:-moz-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:-webkit-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:-o-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:-ms-linear-gradient(top, #1e62d0 5%, #3d94f6 100%);
        background:linear-gradient(to bottom, #1e62d0 5%, #3d94f6 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#1e62d0', endColorstr='#3d94f6',GradientType=0);      
        background-color:#1e62d0;	
    }
	
    button:active {
        position:relative;
        top:1px;
    }
	
	.datepicker{
			
			height:15px;
			border: 1px solid #b5cce2;
			background: #edf4fc;
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
			border-radius: 4px;
			color: #666;
			box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
			padding:6px;
			width:auto;	
}
		
.datepicker:focus {
	background: #fff;
	color: #000000;
	outline:none;
	padding:6px;
	box-shadow: 0 0 5px #9ecaed;
}

</style>

<script>
    $(function() {
    $( ".datepicker" ).datepicker({
    dateFormat: 'dd/mm/yy',
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText: 'Próximo',
    prevText: 'Anterior'
  });
   });
</script>

<script>
var trecho = 0;
var aereo=false;
var ntabs=1;

	$(function() {

     var tabs = $( "#tabs" ).tabs();

  $('#addSugestao').on('click', function(){
  
  ntabs=ntabs+1;
 
  var conteudo = "     <div id='sugestao"+ntabs+"'>" +
             "<p/>" +
              "<label for='transporte"+ntabs+"'>Transporte:</label>" +
              "<select name='transporte"+ntabs+"' id='transporte"+ntabs+"'>" +
              "  <option class='not_aereo'> Selecione um transporte</option>" +
              "  <option class='aereo'> Aéreo</option>" +
              "  <option class='not_aereo'> Terrestre</option>" +
              "  <option class='not_aereo'> Veículo Próprio</option>" +
              "  <option class='not_aereo'> Veículo da Caixa</option>" +
              "  <option class='not_aereo'> Aquático</option>" +
              "</select>" +
              "<label for='data"+ntabs+"'>Data:</label>" +
              "<select name='data"+ntabs+"' id='data"+ntabs+"'>" +
             "   <option>" +
             "   Teste" +
             "   </option>" +
              "</select>" +
              "<label for='horario"+ntabs+"'>Horário:</label>" +
              "<input class='form-field' name='horario"+ntabs+"' id='horario"+ntabs+"' type='text' size='5' maxlength='5' />" +
              "<p></p>" +
              "<div id='info_aereo"+ntabs+"'> </div>" +
              "<label for='cidade_embarque"+ntabs+"'>Cidade de embarque:</label>" +
              "<input class='form-field' name='cidade_embarque"+ntabs+"' id='cidade_embarque"+ntabs+"' type='text' size= '20' maxlength='50' />" +   
			  "              <button name='incluir_trecho"+ntabs+"' class ='incluir_trecho' id='incluir_trecho"+ntabs+"' style=' padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px'>Incluir Trecho</button>"  + 
			  
              "    <button name='excluir_sugestao' class ='excluir_sugestao' id='excluir_sugestao'  style=' padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px'>Excluir Sugestão</button>" + 
              "<div class='tabela' align='center'>" +
               " <table class 'tabelaTrecho' id='tabela"+ntabs+"'>" +
                "  <tr>" +
                 "   <td> Trecho </td>" +
                  "  <td> Tipo de Transporte </td>" +
                   " <td> Cidade </td>" +
                    "<td> Data </td> "+
                    "<td> Hora </td>" +
                    "<td> Cia de Transporte </td>" +
                    "<td> Nº do Vôo </td>" +
                    "<td></td>" +
                  "</tr>" +
                "</table>" +            
             " </div>"  +             
            "</div>";
  
  
  if(ntabs<=3){

    <!--$( ".addSugestao").before(" <li><a href='#sugestao1' style='font-size:11px'>Sugestão 1</a></li>");
	 
	 $("#addSugestao").before( " <li><a href='#sugestao"+ntabs+"' style='font-size:11px'>Sugestão"+ntabs+"</a></li>" );	 
	 tabs.append(conteudo);
	 $("#sugestao_aceita").append("<option id='op_sugestao"+ntabs+"' >Sugestão "+ntabs+"</option>");
	 tabs.tabs("refresh").tabs('option', 'active', ntabs-1);
	  
  }else{
   alert("O número máximo de sugestões é 3.");
   tabs.tabs("refresh").tabs('option', 'active', ntabs-2);
   ntabs=ntabs-1;     
  }
  
  });
	  $(document).on('click', '#X', function(){
		$(this).parent().remove(); 
		if(trecho !=0){
		trecho = trecho-1;
		}
		});
	
	$( document ).on("click",".incluir_trecho", function() {
	
				var id = tabs.find( ".ui-tabs-active" ).attr( "aria-controls" ).substring(8,9);
				
				trecho = trecho+1;
				var cia_transporte ="";
				var n_voo="";
				
				var tipo_transporte = $("#transporte"+id).val();
				var cidade = $("#cidade_embarque"+id).val();
				var data = $("#data"+id).val();
				var hora = $("#horario"+id).val();
				if(aereo){
				var cia_transporte = $("#cia"+id).val();
				var n_voo = $("#n_voo"+id).val();
				}
							
		$( "#tabela"+id ).append( 
							"<tr>" +
							"<td>"+trecho+"</td>" +
							"<td>"+tipo_transporte+"</td>" +
							"<td>"+cidade+"</td>" +
							"<td>"+data+"</td>" +
							"<td>"+hora+"</td>" +
							"<td>"+cia_transporte+"</td>" +
							"<td>"+n_voo+"</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
	});
	
		$( "#dialog" ).dialog({
			autoOpen: false,
			show: {
				effect: "blind",
				duration: 1000
			},
			hide: {
				effect: "explode",
				duration: 500
			}
		});

		$( "#opener" ).click(function() {
			$( "#dialog" ).dialog( "open" );
		});
				
		$( document ).on("click",".not_aereo", function() {
		 var id = tabs.find( ".ui-tabs-active" ).attr( "aria-controls" ).substring(8,9);
		 aereo=false;
		 $( "#aereo_container"+id ).remove();	
		});
		
		$( document ).on("click",".aereo", function() {
			var id = tabs.find( ".ui-tabs-active" ).attr( "aria-controls" ).substring(8,9);
			aereo=true;
		    $( "#aereo_container"+id ).remove();
			$( "#info_aereo"+id ).append("<div id='aereo_container"+id+"'> </div>");
			$( "#aereo_container"+id ).append("<label>Cia.</label>");
			$( "#aereo_container"+id ).append("<input class='form-field' name='cia"+id+"' id='cia"+id+"' type='text' size='15' maxlength='30' style='margin-right:5px' />");
			$( "#aereo_container"+id ).append("<label>Nº Vôo</label>");
			$( "#aereo_container"+id ).append("<input class='form-field' name='n_voo"+id+"' id='n_voo"+id+"' type='text' size='15' maxlength='15' />");
			});
		
			$( "#tipo_a" ).click(function() {
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'>² Diária tipo A - quando necessariamente há pernoite e o empregado paga as despesas com hospedagem, alimentação e transporte urbano.</div>");	
			$( "#sugestao" ).show("blind");	
			$( ".sugestao_aceita").show();
			});
			
			$( "#tipo_b" ).click(function() {
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'>² Diária tipo B - quando o empregado paga as despesas com alimentação e transporte urbano e, se há pernoite, a CAIXA paga a hospedagem.</div>");
			$( "#sugestao" ).show("blind");
			$( ".sugestao_aceita").show();
			});
			
			$( "#tipo_c" ).click(function() {
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'>² Diária tipo C - quando a CAIXA paga 1 refeição (almoço ou jantar) e, se há pernoite, a CAIXA paga também a hospedagem.</div>");
			$( "#sugestao" ).show("blind");
			$( ".sugestao_aceita").show();
			});
			
			$( "#sem_diaria" ).click(function() {
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'>² Sem Diária - Não é necessário preencher as sugestões de trechos.</div>");		   
			$( "#sugestao" ).hide("blind");
			$( ".sugestao_aceita").hide();
			});
		
<!--$( "#selectable" ).selectable({
<!--selected: function( event, ui ){}
<!--});
  	   $( document ).on("click", ".excluir_sugestao", function(){
		   
		 if(ntabs==1){
		 
		 alert("Não é possível excluir. Você precisa ter no mínimo uma sugestão.");
		 }else{
		var panelId = tabs.find( ".ui-tabs-active" ).remove().attr( "aria-controls" );
        $( "#" + panelId ).remove();
		
		var id=panelId.substring(8,9);

		ntabs = ntabs-1;
		$("#op_sugestao"+id).remove();
        tabs.tabs( "refresh");	
			}
		}); 

});	
	
	</script>
<script>
$(function () {
    $("td").dblclick(function () {
        var OriginalContent = $(this).text();
 
        $(this).addClass("cellEditing");
        $(this).html("<input type='text' style='width:60px; height:10px; font-size:10px' value='" + OriginalContent + "' />");
        $(this).children().first().focus();
 
        $(this).children().first().keypress(function (e) {
            if (e.which == 13) {
                var newContent = $(this).val();
                $(this).parent().text(newContent);
                $(this).parent().removeClass("cellEditing");
            }
        });
 
    $(this).children().first().blur(function(){
        $(this).parent().text(OriginalContent);
        $(this).parent().removeClass("cellEditing");
    });
    });
});
	</script>
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='destacamentos.asp'><span>Solicitar</span></a></li>
              <li ><a href='destacamento_consultar.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li id="opener"><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <div id="dialog" title="Caixa de Ajuda">
            <p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px" >
          <legend><span class="titulos">Solicitar Destacamento</span></legend>
          <p></p>
          <label>Usu&aacute;rio:</label>
          <input class="form-field" name="usuario" id="usuario" type="text" size="10" maxlength="7" />
          <label>Nome:</label>
          <input class="form-field" name="nome" id="nome" type="text" size="50" maxlength="60" />
          <p>
            <label>Período¹:</label>
            <input  name="periodo_de" id="periodo_de" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write(Date) %>"/>
            a
  			<input  name="periodo_a" id="periodo_a" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>
          <p style="font-size:12px">¹ No campo período deve ser informado apenas o primeiro e o último dia de efetivo destacamento.</p>
          </p>
          <p> </p>
          <label for="projeto">Projeto:</label>
          <input class="form-field" name="projeto" id="projeto" type="text" size="30" maxlength="60" />
          <label for="cidade">Cidade:</label>
          <input class="form-field" name="cidade" id="cidade" type="text" size="30" maxlength="60" />
          <label for="uf">UF:</label>
          <input class="form-field" name="uf" id="uf" type="text" size="2" maxlength="2" />
          <p> </p>
          <label for="diaria"> Diária²:</label>
          <select name="diaria" id = "diaria">
            <option selected="selected"> Selecione um tipo</option>
            <option id="tipo_a"> Tipo A</option>
            <option id="tipo_b"> Tipo B</option>
            <option id="tipo_c"> Tipo C</option>
            <option id="sem_diaria"> Sem diária</option>
          </select>
          <label for="sugestao_hospedagem">Sugestão de hospedagem:</label>
          <input class="form-field" name="sugestao_hospedagem" id="sugestao_hospedagem" type="text" size="30" maxlength="60" />
          <p style="font-size:12px" id="info_diaria">
          <div id="info_container" style="font-size:12px">² Nenhum tipo de diária foi previamente selecionado, por favor selecione o Tipo A, B ou C.</div>
          </p>
          <p> </p>
          <label for="observacoes"> Observações:</label>
          <p> </p>
          <textarea name="observacoes" id="observacoes" cols="50" rows="5" style="max-width:600px; min-width:600px; max-height:80px; min-height:80px;"></textarea>
          <p>
            <div id="sugestao">
          <p style="font-size:15px">Após informar os dados acima, preencha abaixo sugestões para transporte. No caso de transporte aéreo, informe pelo menos duas sugestões.</p>
          </p>
         
          <fieldset class="testess" style="  border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; background-color:#F7F7F7" >
          <legend><span class="titulos">Sugestões de transporte</span></legend>
          <div id="tabs">
            <ul>
              <li><a href="#sugestao1" style="font-size:11px">Sugestão 1</a></li>
              <li class="addSugestao" id="addSugestao" style=" background-image:url(imagens/add_16x16.png);background-position:center; background-repeat:no-repeat;"><a  style="font-size:11px;background-position:center; background-repeat:no-repeat; "> &nbsp; </a></li>
            </ul>
           
            <div id="sugestao1">
              <p/>
              <label for="transporte1">Transporte:</label>
              <select name="transporte1" id="transporte1">
                <option class='not_aereo'> Selecione um transporte</option>
                <option class="aereo"> Aéreo</option>
                <option class='not_aereo'> Terrestre</option>
                <option class='not_aereo'> Veículo Próprio</option>
                <option class='not_aereo'> Veículo da Caixa</option>
                <option class='not_aereo'> Aquático</option>
              </select>
              <label for="data1">Data:</label>
              <select name="data1" id="data1">
                <option>
                <% Response.Write(Date) %>
                </option>
              </select>
              <label for="horario1">Horário:</label>
              <input class="form-field" name="horario1" id="horario1" type="text" size="5" maxlength="5" />
              <p></p>
              <div id="info_aereo1"> </div>
              <label for="cidade_embarque1">Cidade de embarque:</label>
              <input class="form-field" name="cidade_embarque1" id="cidade_embarque1" type="text" size= "20" maxlength="50" />
              <button name="incluir_trecho" class ="incluir_trecho" id="incluir_trecho1" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px">Incluir Trecho</button>
                            <button name="excluir_sugestao" class ="excluir_sugestao" id="excluir_sugestao1" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px">Excluir Sugestão</button>
             
              <div class="tabela" align="center">
                <table id="tabela1" class="tabelaTrecho">
                  <tr>
                    <td> Trecho </td>
                    <td> Tipo de Transporte </td>
                    <td> Cidade </td>
                    <td> Data </td>
                    <td> Hora </td>
                    <td> Cia de Transporte </td>
                    <td> Nº do Vôo </td>
                    <td></td>
                  </tr>
                </table>
              </div>
              <!-- DIV "TABELA" -->
            </div>
            <!-- DIV "SUGESTAO1" -->
          </div>
          <!-- DIV "TABS" -->
          </fieldset>
          <p> </p>
           </div>
          <div align="center">
            <label for"situacao">Situação:</label>
            <select name="situacao"  style="margin-right:15px"/>
            
            <option>Solicitado</option>
            <input  name="aupg" class="myButton" type="button"  value="AUPG" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px"/>
            <label class = "sugestao_aceita" for"sugestao_aceita">Sugestão Aceita:</label>
            <select class = "sugestao_aceita" name="sugestao_aceita" id="sugestao_aceita" style="margin-right:15px">
              <option id="op_sugestao1"> Sugestão 1 </option>
            </select>
            <input name="cancelar" class="myButton" type="button" value="Cancelar"/>
            <input name="solicitar" class="myButton" type="button" value="Salvar"/>
          </div>
          </fieldset>
        </div>
      </div>

    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
