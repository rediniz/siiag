<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Editar Destacamento</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.mousewheel.js"></script>
<script src="scripts/globalize.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery.ui.button.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.timepicker.js"></script>
<script src="scripts/jquery.ui.mask.js"></script>
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

#info_container, #info{

background:#F2F2F2;
color:#666666;
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

<style>
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
.ui-mask ui-spinner-input {

font-size:16px;

}

</style>
   
<script>
	$(function() {
		$("#culture").change(function() {
			$( "input" ).timepicker( "option", "culture", $( this ).val() );
		});
		function setup() {

			$("#horario").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#horario1").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
		}
		setup();
	});
</script>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
	var qtd = $("#qtd_sugestao").val();
	//1 #ALTERADO em 19/04/2016
	var co_sugestao = $("#co_sugestao").val();
	for(var i=1; i<=qtd; i++){
	$("#horario"+i+"").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
	//2 #ALTERADO em 19/04/2016
	 if(co_sugestao == i){
	 	$("#sugestao_aceita").append("<option class='sugestao_op' id='op_sugestao"+i+"' value="+i+" selected='selected'>Sugestão "+i+"</option>");
	 }else{
	 	$("#sugestao_aceita").append("<option class='sugestao_op' id='op_sugestao"+i+"' value="+i+" >Sugestão "+i+"</option>");
	 }
	}

				//Ao digitar executar essa função
				$("#nome").focus().autocomplete({
					
					source: "autocompletar_nome2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#usuario" ).val( ui.item.matricula);					
					return false;
					}
				  });
 
 					$("#usuario").focus().autocomplete({
					
					source: "autocompletar_matricula2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#usuario" ).val( ui.item.matricula);				
					return false;
					}
				  });
 
			});			
	
</script>

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

	$(function() {

	 //3 #ALTERADO EM 19/04/2016
     var tabs = $( "#tabs" ).tabs({ active: $("#co_sugestao").val()-1 });


  $('#addSugestao').on('click', function(){
 	var ntabs= 0; 
  $(".nome_sugestao").each(function(){
		ntabs++;
	});
  
  ntabs=ntabs+1;
 
  var conteudo = "<div class='div_sugestao' id='sugestao"+ntabs+"'>" +
             "<p/>" +
              "<label>Transporte:</label>" +
              "<select name='transporte' id='transporte"+ntabs+"'>" +
              "  <option class='not_aereo' value=''>Selecione um transporte...</option>" +	  
              "</select>" +
              "<label>Data:</label>" +
              "<input  name='data"+ntabs+"' id='data"+ntabs+"' class='datepicker' type='text' size='12' maxlength='8' value=''/>" +
              "<label>Horário:</label>" +
              " <input id='horario"+ntabs+"' name='horario' class='ui-mask ui-spinner-input' autocomplete='off' role='spinbutton' size='4' value='00:00' style='font-size:12px'/>" +
              "<p></p>" +
              "<div id='info_aereo"+ntabs+"' name='info_aereo'> </div>" +
              "<label>Cidade de embarque:</label>" +
              "<input class='form-field' name='cidade_embarque' id='cidade_embarque"+ntabs+"' type='text' size= '20' maxlength='50' />" +   
			  "              <button name='incluir_trecho' class ='incluir_trecho' id='incluir_trecho"+ntabs+"' style=' padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px'>Incluir Trecho</button>"  + 
			  
              "    <button name='excluir_sugestao' class ='excluir_sugestao' id='excluir_sugestao"+ntabs+"'  style=' padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px'>Excluir Sugestão</button>" + 
              "<div class='tabela' align='center'>" +
               " <table class 'tabelaTrecho' id='tabela"+ntabs+"' name='tabela'>" +
                "  <tr>" +
                 "   <td>Trecho</td>" +
                  "  <td>Tipo de Transporte</td>" +
                   " <td>Cidade</td>" +
                    "<td>Data</td> "+
                    "<td>Hora</td>" +
                    "<td>Cia de Transporte</td>" +
                    "<td>Nº do Vôo</td>" +
                    "<td></td>" +
                  "</tr>" +
                "</table>" +            
             " </div>"  +             
            "</div>";
  
  if(ntabs<=10){
    <!--$( ".addSugestao").before(" <li><a href='#sugestao1' style='font-size:11px'>Sugestão 1</a></li>");
	 
	 $("#addSugestao").before( "<li><a  name='nome_sugestao' class='nome_sugestao' href='#sugestao"+ntabs+"' style='font-size:11px'>Sugestão "+ntabs+"</a></li>" );	
	 //tabs.append($("#sugestao1").clone());
	 tabs.append(conteudo);
	 var tipo_transporte =   "<option class='not_aereo' value=''>Selecione um transporte...</option>" +
                "<option class='aereo' value=1>Aéreo</option>" +
                "<option class='not_aereo' value=2>Terrestre</option>" +
                "<option class='not_aereo' value=3>Veículo Próprio</option>" +
                "<option class='not_aereo' value=4>Veículo da Caixa</option>" +
                "<option class='not_aereo' value=5>Aquático</option>"
	 
	 $("#transporte"+ntabs).html(tipo_transporte);
	 
	 			$("#horario"+ntabs+"").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
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
	  //2 #ALTERADO EM 18/04/2016
	 $("#sugestao_aceita").append("<option class='sugestao_op' id='op_sugestao"+ntabs+"' value="+ntabs+">Sugestão "+ntabs+"</option>");
	 tabs.tabs("refresh").tabs('option', 'active', ntabs-1);
	  
  }else{
   alert("O número máximo de sugestões é 10.");
   tabs.tabs("refresh").tabs('option', 'active', ntabs-2);
   ntabs=ntabs-1;
  }
  
  });
	  $(document).on('click', '#X', function(){
	  var id  = tabs.find( ".ui-tabs-active" ).attr( "aria-controls" ).substring(8,9);
	  var tr = 1;
		$(this).parent().remove(); 
		$(".linha_trecho"+id).each(function(){
			$(this).find("#trecho"+id+"_numero").html(tr++);
		
		});
		if(trecho !=0){
			trecho = trecho-1;
		}
		});
	
	$( document ).on("click",".incluir_trecho", function() {
	
		var id  = tabs.find( ".ui-tabs-active" ).attr( "aria-controls" ).substring(8,9);
		var tre=0;							
		
		var cia_transporte = "";
		var n_voo="";
		
		var tipo_transporte = $("#transporte"+id+" option:selected").text();
		if(tipo_transporte == "Selecione um transporte..."){
			alert("Selecione um tipo de transporte.");
			return false;	
		}
		var cod_tipo_transporte = $("#transporte"+id+" option:selected").val();
		
		var cidade = $("#cidade_embarque"+id).val();
		if(cidade == ""){
			alert("Informe a cidade de embarque.");
			return false;
		}
		var data = $("#data"+id).val();
		var hora = $("#horario"+id).val();

		if(aereo){
			var cia_transporte = $("#cia"+id).val();
			if(cia_transporte == ""){
				alert("Informe a companhia aérea.");
				return false;
			}
			var n_voo = $("#n_voo"+id).val();
			if(n_voo == ""){
				alert("Informe o número do vôo.");
				return false;
			}
		}
		
		$(".linha_trecho"+id).each(function(){
	
				tre++;
	
		});
		
		tre++;
	
		$( "#tabela"+id ).append( 
		
			"<tr class='linha_trecho"+id+"'>" +
			"<td id='trecho"+id+"_numero'>"+tre+"</td>" +
			"<td id='trecho"+id+"_transporte'><input type='hidden' id='cod_transporte' value="+cod_tipo_transporte+">"+tipo_transporte+"</td>" +
			"<td id='trecho"+id+"_cidade'>"+cidade+"</td>" +
			"<td id='trecho"+id+"_data'>"+data+"</td>" +
			"<td id='trecho"+id+"_hora'>"+hora+"</td>" +
			"<td id='trecho"+id+"_cia_transporte'>"+cia_transporte+"</td>" +
			"<td id='trecho"+id+"_n_voo'>"+n_voo+"</td>" +
			"<td id='X'><img src='imagens/delete_16x16.png' style='cursor:pointer;'/> </td>" +
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
		 
		$( "#tipo_a" ).on("click",function() {
			
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'><img src='imagens/info_16x16.png' style='vertical-align:middle'/>² Diária tipo A - quando necessariamente há pernoite e o empregado paga as despesas com hospedagem, alimentação e transporte urbano.</div>");	
			$( "#sugestao" ).show("blind");	
			$( ".sugestao_aceita").show();
				
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

		$( "#tipo_b" ).on("click",function() {
		
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'><img src='imagens/info_16x16.png' style='vertical-align:middle'/>² Diária tipo B - quando o empregado paga as despesas com alimentação e transporte urbano e, se há pernoite, a CAIXA paga a hospedagem.</div>");
			$( "#sugestao" ).show("blind");
			$( ".sugestao_aceita").show();
			
		});
		$( "#tipo_c" ).on("click",function() {
		
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'><img src='imagens/info_16x16.png' style='vertical-align:middle'/>² Diária tipo C - quando a CAIXA paga 1 refeição (almoço ou jantar) e, se há pernoite, a CAIXA paga também a hospedagem.</div>");
			$( "#sugestao" ).show("blind");
			$( ".sugestao_aceita").show();
			
		});
		
		$( "#tipo_sem_diaria" ).on("click",function() {
		
			$( "#info_container").remove();
			$( "#info_diaria" ).append("<div id='info_container'><img src='imagens/info_16x16.png' style='vertical-align:middle'/>² Sem Diária - Não é necessário preencher as sugestões de trechos.</div>");		   
			$( "#sugestao" ).hide("blind");
			$( ".sugestao_aceita").hide();
			
		});
		
<!--$( "#selectable" ).selectable({
<!--selected: function( event, ui ){}
<!--});
  	   $( document ).on("click", ".excluir_sugestao", function(){
		    	var ntabs= 0; 
  $(".nome_sugestao").each(function(){
		ntabs++;
	});
		 if(ntabs==1){
		 alert("Não é possível excluir. Você precisa ter no mínimo uma sugestão.");
		 }else{
		var panelId = tabs.find( ".ui-tabs-active" ).remove().attr( "aria-controls" );
        $( "#" + panelId ).remove();
		
		var id=panelId.substring(8,9);
		
			var num = 1;
			$(".nome_sugestao").each(function(){
			
				$(this).attr("href", "#sugestao"+num);
				$(this).html("Sugestão " + num);
				num++;
			
			});

		ntabs = ntabs-1;
		
		num=1
		var teste = 0;
		$(".div_sugestao").each(function(){	
			$(this).attr("id", "sugestao"+num);
			$(this).find('[name="nome_sugestao"]').attr("href", "#sugestao"+num);
			$(this).find('[name="transporte"]').attr("id", "transporte"+num);
			$(this).find('[name="data"]').attr("id", "data"+num);
			$(this).find('[name="horario"]').attr("id", "horario"+num);
			$(this).find('[name="info_aereo"]').attr("id", "info_aereo"+num);
			$(this).find('[name="cidade_embarque"]').attr("id", "cidade_embarque"+num);
			$(this).find('[name="incluir_trecho"]').attr("id", "incluir_trecho"+num);
			$(this).find('[name="tabela"]').attr("id", "tabela"+num);
			$(this).find('[name="excluir_sugestao"]').attr("id", "excluir_sugestao"+num);		
			num++;	
		});
		
			num=1;
		$("#op_sugestao"+id).remove();
		
		$(".sugestao_op").each(function(){
		
			$(this).html("Sugestão "+num);
			$(this).val(num);
			num++;
			
		});
		
        tabs.tabs( "refresh");	
			}
		
		}); 

});	
	
</script>

<script>
$(function(){

$("#aupg").click(function(){

			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("aupg.asp?co_destacamento="+$("#co_destacamento").val()+ "&evento="+$("#projeto").val()+"&cidade="+$("#cidade").val()+"&uf="+$("#uf").val()+"&matricula="+$("#usuario").val()+"&data_inicio="+$("#periodo_inicio").val()+"&data_fim="+$("#periodo_fim").val()+"&hospedagem="+$("#sugestao_hospedagem").val()+"&diaria="+$("#diaria").val(),"AUPG", "height=520, width=680, scrollbars=yes, toolbar=no, resizable=no, location=no, modal=yes, top="+top+",left="+left+"");

});

$("#salvar").click(function(){
	
	
	var trecho_string="";
	var qtd_sugestoes=0;
	
	var matricula = $("#usuario").val();
	var usuario =  $("#nome").val();
	var periodo_inicio = $("#periodo_inicio ").val();
	var periodo_fim = $("#periodo_fim").val();
	var projeto= $("#projeto").val();
	var cidade = $("#cidade").val();
	var uf = $("#uf").val();
	var diaria = $("#diaria").val();
	var hospedagem = $("#sugestao_hospedagem").val();
	// 3 #ALTERADO EM 18/04/2016 
	var sugestao_aceita = $("#sugestao_aceita").val();
	
	if(matricula == ""){
		alert("Informe o usuário.");
		return false;
	}
	if(usuario == ""){
		alert("Informe o usuário.");
		return false;
	}
	if(periodo_inicio == "" || periodo_fim == ""){
		alert("Informe o período.");
		return false;
	}
	if(projeto == ""){
		alert("Informe o evento.");
		return false;
	}
	if(cidade == ""){
		alert("Informe a cidade.");
		return false;
	}
	if(uf == ""){
		alert("Informe a UF.");
		return false;
	}
	if(diaria == ""){
		alert("Informe o tipo de diária.");
		return false;
	}


		$(".div_sugestao").each(function(){	
		 qtd_sugestoes++;
		 var tr=0;
		 var id = $(this).attr( "id" ).substring(8,9);
		 //alert(id);
		 	
			$(".linha_trecho"+id).each(function(){
				

				var trecho 				= $(this).find("#trecho"+id+"_numero").html();
				var transporte 			= $(this).find("#trecho"+id+"_transporte").find("#cod_transporte").val();
				var cidade_embarque 	= $(this).find("#trecho"+id+"_cidade").html();
				var data 				= $(this).find("#trecho"+id+"_data").html();
				var horario				= $(this).find("#trecho"+id+"_hora").html();
				var cia_transporte 		= $(this).find("#trecho"+id+"_cia_transporte").html();
				var n_voo				= $(this).find("#trecho"+id+"_n_voo").html();
				
				trecho_string 			= trecho+"::"+transporte +"::"+cidade_embarque+"::"+data+"::"+horario+"::"+cia_transporte+"::"+n_voo				
				$("#div_trechos").append("<input type='hidden' value='"+trecho_string+"' id ='v_trecho"+trecho+"' name ='v_trecho"+id+"'>");
				
				//alert($("#v_trecho"+trecho).val());
		
			});
					
		});
			$("#div_trechos").append("<input type='hidden' value="+qtd_sugestoes+" id ='qtd_sugestoes' name ='qtd_sugestoes'>")
			$("#div_trechos").append("<input type='hidden' value="+$("#situacao").val()+" id ='v_situacao' name ='v_situacao'>")
			//alert($("#situacao").val());
			
			//#ALTERADO EM 11/04/2014
			$("#obsEdicao").val($("#observacaoEdicao").val());
			
				$.ajax({
				type: "POST",
				// 4 #ALTERADO EM 18/04/2016
				url: "destacamentos_edicao_con.asp?dt_ini_atdmt="+$("#dt_ini_atdmt").val()+"&dt_prev_conc="+$("#dt_prev_conc").val()+"&sugestao_aceita="+sugestao_aceita,
				data:  $("#formulario").serialize(),
				success: function (data) {
					alert("Edição realizada com sucesso.");
					window.location.assign("destacamento_consultar.asp");
            	},
				error: function(data) { // CASO OCORRA ERRO NA REQUISIÇÃO
					console.log(data.responseText);
					alert("Erro ao editar destacamento.");
 				}	
  			});
			

});

});
</script>
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<%
query = "SELECT * FROM TB_DESTACAMENTOS AS DESTACAMENTO JOIN VW_USUARIOS AS USUARIO ON DESTACAMENTO.CO_MATRICULA = USUARIO.CO_MATRICULA WHERE CO_DESTACAMENTO = "&request("co_destacamento")
destacamento = objConn.execute(query)

'#ALTERADO em 30/11/2015 (adicionado)#=====
dt_ini_atdmt = destacamento("DT_INI_ATDMT")
dt_prev_conc = destacamento("dt_prev_conc")
'===========================================



'#ALTERADO EM 11/04/2014
observacaoEdicao = destacamento("OBS_EDICAO")


Perfil_Acesso("19") 
if not perfil_acesso_siiag then
	response.Redirect("acesso_negado.asp")
end if
response.write "<input type='hidden' id = 'perfil_destacamento_consultar' value=" & perfil_acesso_siiag & ">"
response.write "<input type='hidden' id = 'perfil_destacamento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
%>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos"><span>DESTACAMENTOS</span></div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
             <%			
              	response.write "<li ><a href='destacamentos.asp'><span>Solicitar</span></a></li>"
			  	response.write "<li><a href='destacamento_consultar.asp'><span>Consultar</span></a></li>"
				response.write "<li class='active'><a href='destacamentos_edicao1.asp'><span>Editar</span></a></li>"			  
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li id="opener"><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <div id="dialog" title="Caixa de Ajuda">
            <!--<p>Teste da Ajuda da p&aacute;gina de Destacamentos</p> -->
          </div>

          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px" >
          <legend><span class="titulos">Editar Destacamento</span></legend>
          <p></p>
          <form id="formulario" method="post" action="destacamentos_edicao_con.asp">
          <label>Usu&aacute;rio:</label>
          <input class="form-field"  readonly="readonly" name="usuario" id="usuario" type="text" size="10" maxlength="7" value='<%=destacamento("CO_MATRICULA")%>'/>
          <label>Nome:</label>
          <input class="form-field" readonly="readonly" name="nome" id="nome" type="text" size="50" maxlength="60" value='<%=destacamento("NO_NOME")%>'/>
          <p>
           <label>Período¹:</label>
            <input  name="periodo_inicio" id="periodo_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<%=formatdatetime(destacamento("DT_INICIO"), 2)%>"/>
            a
  			<input  name="periodo_fim" id="periodo_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<%=formatdatetime(destacamento("DT_FIM"), 2)%>"/>
          <p id="info"style="font-size:15px"><img src="imagens/info_16x16.png" style="vertical-align:middle"/>¹ No campo período deve ser informado apenas o primeiro e o último dia de efetivo destacamento.</p>
          </p>
          <p> </p>
          <label for="projeto">Evento:</label>
          <input class="form-field" name="projeto" id="projeto" type="text" size="30" maxlength="60" value="<%=destacamento("DE_PROJETO")%>"/>
          <label for="cidade">Cidade:</label>
          <input class="form-field" name="cidade" id="cidade" type="text" size="30" maxlength="60" value="<%=destacamento("NO_CIDADE")%>"/>
          <label for="uf">UF:</label>
          <input class="form-field" name="uf" id="uf" type="text" size="2" maxlength="2" value="<%=destacamento("SG_UF")%>"/>
          <p> </p>
          <label for="diaria"> Diária²:</label>
          <select class="form-select" name="diaria" id ="diaria">
    
           <option  value="" selected="selected">Selecione um tipo</option>
           <option id="tipo_a" <%if destacamento("CO_TIPO_DIARIA") = "1" then response.write "selected='selected'" end if %>value="1">A</option>
           <option id="tipo_b" <%if destacamento("CO_TIPO_DIARIA") = "2" then response.write "selected='selected'" end if %>value="2">B</option>
           <option id="tipo_c" <%if destacamento("CO_TIPO_DIARIA") = "3" then response.write "selected='selected'" end if %>value="3">C</option>
           <option id="tipo_sem_diaria" <%if destacamento("CO_TIPO_DIARIA") = "4" then response.write "selected='selected'" end if %>value="4">Sem Diária</option>
            
          </select>
          <label for="sugestao_hospedagem">Sugestão de hospedagem:</label>
          <input class="form-field" name="sugestao_hospedagem" id="sugestao_hospedagem" type="text" size="30" maxlength="60" value='<%=destacamento("DE_SUGESTAO_HOSPEDAGEM")%>' />
          <p style="font-size:15px" id="info_diaria">
          <div id="info_container" style="font-size:15px"><img src="imagens/info_16x16.png" style="vertical-align:middle"/>² Nenhum tipo de diária foi previamente selecionado, por favor selecione o Tipo A, B ou C.</div>
          </p>
          <p> </p>
          <label for="observacoes">Observações:</label>
          <p> </p>
          <textarea name="observacoes" id="observacoes" cols="50" rows="5" style="max-width:600px; min-width:600px; max-height:80px; min-height:80px;"><%=destacamento("DE_OBS")%></textarea>
          <p>
          <div id="div_trechos"></div>
          
          <%
          response.write "<input type='hidden' id='co_destacamento' name='co_destacamento' value="&request("co_destacamento")&">"
		  %>
          <!-- '#ALTERADO EM 11/04/2014 -->
          <input type='hidden' id='obsEdicao' name='observacaoEdicao' value="">
          </form>
            <div id="sugestao">
          <p id = "info"style="font-size:15px" align="center"><img src="imagens/info_16x16.png" style="vertical-align:middle"/> Após informar os dados acima, preencha abaixo sugestões para transporte. No caso de transporte aéreo, informe pelo menos duas sugestões.</p>
          </p>
         
          <fieldset class="testess" style="  border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; background-color:#F7F7F7" >
          <legend><span class="titulos">Sugestões de transporte</span></legend>
          <div id="tabs">
           <!-- #INCLUDE FILE ="include/Conexao.asp" --> 
            <%
			
				query1 = "SELECT * FROM TB_DESTACAMENTOS WHERE CO_DESTACAMENTO = "&request("co_destacamento")&" and co_unidade = " & request.Cookies("co_usuario_unidade_siiag")
				query_qtd = "SELECT count(distinct co_sugestao) as quantidade FROM TB_TRECHOS WHERE CO_DESTACAMENTO = "&request("co_destacamento")&" and co_unidade = "&request.Cookies("co_usuario_unidade_siiag")
				qtd_sugestoes = objConn.execute(query_qtd)("quantidade")
	
				response.write "<ul>"
				for i=1 to qtd_sugestoes
					
					response.write 	  "<li><a  name='nome_sugestao' class='nome_sugestao' href='#sugestao"&i&"' style='font-size:11px'>Sugestão "&i&"</a></li>"			
				next
				
				response.write "    <li class='addSugestao' id='addSugestao' style=' background-image:url(imagens/add_16x16.png);background-position:center; background-repeat:no-repeat;'><a  style='font-size:11px;background-position:center; background-repeat:no-repeat; '> &nbsp; </a></li></ul>"	
				
				for i=1 to qtd_sugestoes
					query2 = "SELECT * FROM TB_TRECHOS WHERE CO_DESTACAMENTO = "&request("co_destacamento")&" AND CO_SUGESTAO="&i
						set rs=Server.CreateObject("ADODB.RecordSet")
					
					response.write "<div class='div_sugestao' id='sugestao"&i&"'>"
					%>
                    
              <p/>
              <label for="transporte<%=i%>">Transporte:</label>
              <select name="transporte" id="transporte<%=i%>">
              <option class='not_aereo' value="">Selecione um transporte...</option>        
                <option class='aereo' 	  value=1>Aéreo</option>
                <option class='not_aereo' value=2>Terrestre</option>
                <option class='not_aereo' value=3>Veículo Próprio</option>
                <option class='not_aereo' value=4>Veículo da Caixa</option>
                <option class='not_aereo' value=5>Aquático</option>             
                
              </select>
              <label for="data<%=i%>">Data:</label>
              <input  name="data<%=i%>" id="data<%=i%>" class="datepicker" type="text" size="12" maxlength="8" value="<%Response.Write(Date)%>"/>
              <label for="horario">Horário:</label>
              <input id="horario<%=i%>" name="horario" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" style="font-size:12px"/>
              <p></p>
              <div id="info_aereo<%=i%>" name="info_aereo"> </div>
              <label for="cidade_embarque<%=i%>">Cidade de embarque:</label>
              <input class="form-field" name="cidade_embarque" id="cidade_embarque<%=i%>" type="text" size= "20" maxlength="50" />
              <button name="incluir_trecho" class ="incluir_trecho" id="incluir_trecho<%=i%>" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px">Incluir Trecho</button>
                            <button name="excluir_sugestao" class ="excluir_sugestao" id="excluir_sugestao<%=i%>" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px">Excluir Sugestão</button>
              <div class="tabela" align="center">
                <table  name="tabela<%=i%>" id="tabela<%=i%>" class="tabelaTrecho">
                  <tr >
                    <td>Trecho</td>
                    <td>Tipo de Transporte</td>
                    <td>Cidade</td>
                    <td>Data</td> 
                    <td>Hora</td>
                    <td>Cia de Transporte</td>
                    <td>Nº do Vôo</td>
                    <td></td>
                  </tr>
   
                    <%
					  rs.Open query2, dados_sys
					  
					  if not rs.eof then
					
					   DO UNTIL rs.eof 
						  
						id = rs("CO_SUGESTAO")
						tre = rs("CO_TRECHO")
						cod_tipo_transporte = rs("CO_TIPO_TRANSPORTE")
						data = formatdatetime(rs("DH_HORARIO"), 2)
						query3 = "SELECT DE_TIPO_TRANSPORTE FROM TB_TIPOS_TRANSPORTE WHERE CO_TIPO_TRANSPORTE="&cod_tipo_transporte
						tipo_transporte = objConn.execute(query3)("DE_TIPO_TRANSPORTE")
						cidade = rs("NO_CIDADE")
						hora = formatdatetime(rs("DH_HORARIO"), 4)
						
						if cod_tipo_transporte = 1 then
						
							cia_transporte = rs("NO_CIA_TRANSPORTE")
							n_voo = rs("NU_VOO")
							
							response.write "<tr class='linha_trecho"&id&"'><td id='trecho"&id&"_numero'>"&tre&"</td><td id='trecho"&id&"_transporte'><input type='hidden' id='cod_transporte' value="&cod_tipo_transporte&">"&tipo_transporte&"</td><td id='trecho"&id&"_cidade'>"&cidade&"</td><td id='trecho"&id&"_data'>"&data&"</td><td id='trecho"&id&"_hora'>"&hora&"</td><td id='trecho"&id&"_cia_transporte'>"&cia_transporte&"</td><td id='trecho"&id&"_n_voo'>"&n_voo&"</td><td id='X'><img src='imagens/delete_16x16.png' style='cursor:pointer;'/> </td></tr>"  
							
						else
						
							response.write "<tr class='linha_trecho"&id&"'><td id='trecho"&id&"_numero'>"&tre&"</td><td id='trecho"&id&"_transporte'><input type='hidden' id='cod_transporte' value="&cod_tipo_transporte&">"&tipo_transporte&"</td><td id='trecho"&id&"_cidade'>"&cidade&"</td><td id='trecho"&id&"_data'>"&data&"</td><td id='trecho"&id&"_hora'>"&hora&"</td><td id='trecho"&id&"_cia_transporte'></td><td id='trecho"&id&"_n_voo'></td><td id='X'><img src='imagens/delete_16x16.png' style='cursor:pointer;'/> </td></tr>" 
							
						
						end if
					

						rs.movenext
						
					
					  LOOP
					  
					  end if
					  
					  response.write "</table>"
					  response.write "</div>"
					  response.write "</div>"
					  				
				      next	
					  
					  set rs = nothing
					  
					  response.write "<input type='hidden' id='qtd_sugestao' name='qtd_sugetao' value="&qtd_sugestoes&">"
					 
			%>
               
        
            <!-- DIV "SUGESTAO1" -->
          </div>
          <!-- DIV "TABS" -->
          </fieldset>
          <p> </p>
           </div>
          <div align="center">
            <label>Situação:</label>
            <select class='form-select' name="situacao"  id = "situacao" style="margin-right:15px"/>
				<%
				if perfil_acesso_admin_siiag then
	                query2 = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES ORDER BY DE_SITUACAO"
				else
	                query2 = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES where co_situacao in (1,7) ORDER BY DE_SITUACAO"
				end if
                
                set fs=Server.CreateObject("ADODB.RecordSet")
                fs.Open query2, dados_sys 
                DO UNTIL fs.eof
					CO_SITUACAO=fs("CO_SITUACAO")
					DE_SITUACAO=fs("DE_SITUACAO")
					
					if destacamento("CO_SITUACAO") = CO_SITUACAO then
						response.write "<option selected='selected' value="&CO_SITUACAO&">"&DE_SITUACAO&"</option>"	
					else
						response.write "<option value="&CO_SITUACAO&">"&DE_SITUACAO&"</option>"
					end if		
					
					fs.movenext
                LOOP
                set fs = nothing
                %>
			</select>
	        <label class = "sugestao_aceita" for"sugestao_aceita">Sugestão Aceita:</label>
            <select class = "sugestao_aceita, form-select" name="sugestao_aceita" id="sugestao_aceita" style="margin-right:15px">
            </select>
            <%
            response.write "<input type='hidden' id='co_destacamento' name='co_destacamento' value="&request("co_destacamento")&">"
			'4 #ALTERADO em 19/04/2016
			 response.write "<input type='hidden' id='co_sugestao' name='co_sugestao' value="&destacamento("co_sugestao")&">"
			%>
			<br><br />
             <!--#ALTERADO em 30/11/2015 (adicionado)====================#-->
            <table>
            <%tipo_prazo_demanda = 2%>
            <!-- #INCLUDE FILE ="include_campo_datas.asp" -->
            <!-- '#ALTERADO EM 11/04/2014 -->
			<!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->
            </table>
            <!--=========================================================-->
            <input id='salvar' name='salvar' class="myButton" type="button" value="Salvar" />
    		<% if perfil_acesso_admin_siiag then %>
	            <input  id = "aupg" name="aupg" class="myButton" type="button"  value="AUPG" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:5px; padding-bottom:5px"/>
            <% end if
            if (sucesso="true") then
				response.write ("<script language=""javascript""> window.history.back(); </script>")			
			end if
			%>
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

