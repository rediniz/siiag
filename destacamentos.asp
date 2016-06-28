<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Destacamento</title>
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

//#Alterado em 21/03/2016 -------------------------------------------------------------
function subtraiDiasCorridos(data, dias) {

	var date = criarData(data);
	
	while(dias > 0){
		if(date.getDay() > 0 && date.getDay() < 6){
			dias = dias - 1;
		}
		date = new Date(date.setDate(date.getDate() - 1));
	}
	return date;
};
//-------------------------------------------------------------------------------------
//#Alterado em 17/03/2016 -------------------------------------------------------------
function subtraiDiasUteis (data, dias) {

	var date = criarData(data);
	
	while(dias > 0){
		if(date.getDay() > 0 && date.getDay() < 6){
			dias = dias - 1;
		}
		date = new Date(date.setDate(date.getDate() - 1));
	}
	
	while(date.getDay() == 0 || date.getDay() == 6){
		date = new Date(date.setDate(date.getDate() - 1));
	}
	return date;
};

function criarData(data){
	var d = data.split("/");
	data = new Date(d[1]+"/"+d[0]+"/"+d[2]);
	return data;
}

function checaPrazoCriticoUtil(solicitacao, inicio){
	
	var gozoMenos9 = subtraiDiasUteis(inicio, 9);
	
	if(solicitacao > gozoMenos9){
		return true;
	}
	
	return false;
}
//#Alterado em 21/03/2016--------------------------------------------------------------
function checaPrazoCriticoCorrido(solicitacao, inicio){
	
	var gozoMenos9 = subtraiDiasCorridos(inicio, 9);
	
	if(solicitacao > gozoMenos9){
		return true;
	}

	return false;
}
//----------------------------------------------------------------------------------
</script>
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
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete({
					
					source: "autocompletar_nome2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#digito" ).val( ui.item.digito);
					$( "#usuario" ).val( ui.item.matricula);					
					return false;
					}
				  });
 
 				$("#usuario").focus().autocomplete({
					
					source: "autocompletar_matricula2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#digito" ).val( ui.item.digito);
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
  $("#aupg").click(function(){
			
			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			
			window.open("aupgVisualizar.asp?evento="+$("#projeto").val()+"&diaria="+$("#diaria").val()+"&cidade="+$("#cidade").val()+"&uf="+$("#uf").val()+"&matricula="+$("#usuario").val()+"&data_inicio="+$("#periodo_inicio").val()+"&data_fim="+$("#periodo_fim").val(),"AUPG", "height=520, width=680, scrollbars=yes, toolbar=no, resizable=no, location=no, modal=yes, top="+top+",left="+left+"");
			

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

    $( "#data"+ntabs ).datepicker({
    dateFormat: 'dd/mm/yy',
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText: 'Próximo',
    prevText: 'Anterior'
  });
			

  
  if(ntabs<=10){
    <!--$( ".addSugestao").before(" <li><a href='#sugestao1' style='font-size:11px'>Sugestão 1</a></li>");
	 
	 $("#addSugestao").before( "<li><a  name='nome_sugestao' class='nome_sugestao' href='#sugestao"+ntabs+"' style='font-size:11px'>Sugestão "+ntabs+"</a></li>" );	
	 //tabs.append($("#sugestao1").clone());
	 tabs.append(conteudo);
	 var tipo_transporte = $("#transporte1").html();
	 
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

	 $("#sugestao_aceita").append("<option class='sugestao_op' id='op_sugestao"+ntabs+"' >Sugestão "+ntabs+"</option>");
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
			
			$(this).find("#trecho"+id).html(tr++);
		
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
			num++;
			
		});
		
        tabs.tabs( "refresh");	
			}
		
		}); 

});	
	
</script>

<script>
$(function(){

$("#salvar").click(function(){

	 if($("#perfil_destacamento").val()=="False"){
		alert("Você não tem permissão para solicitar destacamentos.")
		return false;
	}	
	
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
		alert("Informe o projeto.");
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
		
		//#Alterado em 20/03/2016-----------------------------------------------
		
		if(checaPrazoCriticoCorrido(new Date(), periodo_inicio) && (diaria != 4)){
			alert("Atenção, prazo crítico! \nFavor contatar a coordenação Informação e Apoio à Gestão para confirmar a viabilidade do destacamento no período solicitado.");
			$("#prazoCritico").val("true");
		}
		//-----------------------------------------------------------------------
		$("#formulario").submit(); 
		
		//alert($("#eGerente").val());

});

});
</script>
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<%
  
  Perfil_Acesso("1") 
  response.write "<input type='hidden' id = 'perfil_destacamento_consultar' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_destacamento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"

%>
<div class="teste">
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
			response.write "<li class='active'><a href='destacamentos.asp'><span>Solicitar</span></a></li>"
			response.write "<li><a href='destacamento_consultar.asp'><span>Consultar</span></a></li>"			  
			 %>
            </ul>
          </div>
          </p>
         <div id='submenu'>
            <ul>
              <!--<li id="opener"><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
         </div>
          <!--  <div id="dialog" title="Caixa de Ajuda">
            <p></p>
          </div>-->
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px" >
          <legend><span class="titulos">Solicitar Destacamento</span></legend>
          <p></p>
          <form id="formulario" method="post" action="destacamento_solicitar.asp">
          <!--#Alterado em 21/03/2016---------------------------------------------------------->
          <input type="hidden" id="prazoCritico" name="prazoCritico"  value="false"/>     
          <!------------------------------------------------------------------------------------>
          <label>Usu&aacute;rio:</label>
			<% if perfil_acesso_admin_siiag then%>
	            <input class="form-field" name="usuario" id="usuario" type="text" size="10" maxlength="7" />
            <%else%>
                <input class="form-field" name="usuario" id="usuario" type="text" size="10" maxlength="7" readonly="readonly" value="<%=request.Cookies("co_usuario_siiag")%>" />
            <%end if%>
          <label>-</label>
			<% if perfil_acesso_admin_siiag then%>
	            <input class="form-field" name="digito" id="digito" type="text" size="1" maxlength="10" />
            <%else%>
    	        <input class="form-field" name="digito" id="digito" type="text" size="1" maxlength="10"  readonly="readonly" value="<%=request.Cookies("co_usuario_dv_siiag")%>"/>
            <%end if%>
          <label>Nome:</label>
			<% if perfil_acesso_admin_siiag then%>
	          <input class="form-field" name="nome" id="nome" type="text" size="50" maxlength="60" />
			<%else%>
	          <input class="form-field" name="nome" id="nome" type="text" size="50" maxlength="60" readonly="readonly" value="<%=request.Cookies("no_usuario_siiag")%>" />
            <%end if%>
          <p>
           <label>Período¹:</label>
            <input  name="periodo_inicio" id="periodo_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<%Response.Write(Date)%>"/>
            a
  			<input  name="periodo_fim" id="periodo_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<%Response.Write(Date)%>"/>
          <p id="info"style="font-size:15px"><img src="imagens/info_16x16.png" style="vertical-align:middle"/>¹ No campo período deve ser informado apenas o primeiro e o último dia de efetivo destacamento.</p>
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
          <select class="form-select" name="diaria" id ="diaria">
           <option  value="" selected="selected">Selecione um tipo</option>
            <option id="tipo_a" value="1">A</option>
            <option id="tipo_b" value="2">B</option>
            <option id="tipo_c" value="3">C</option>
            <option id="tipo_sem_diaria" value="4">Sem Diária</option>
            
            <%
		'	sql_diaria = "SELECT CO_TIPO_DIARIA, DE_TIPO_DIARIA FROM TB_TIPOS_DIARIA ORDER BY DE_TIPO_DIARIA"
'			set ds=Server.CreateObject("ADODB.RecordSet")			  
'			ds.Open sql_diaria, dados_sys 
'			
'			DO UNTIL ds.eof
'				response.write "<option id='tipo_"&ds("DE_TIPO_DIARIA")&"' value="& ds("CO_TIPO_DIARIA") & ">" & ds("DE_TIPO_DIARIA") & "</option>"
'				ds.movenext
'			LOOP	

			%>
          </select>
          <label for="sugestao_hospedagem">Sugestão de hospedagem:</label>
          <input class="form-field" name="sugestao_hospedagem" id="sugestao_hospedagem" type="text" size="30" maxlength="60" />
          <p style="font-size:15px" id="info_diaria">
          <div id="info_container" style="font-size:15px"><img src="imagens/info_16x16.png" style="vertical-align:middle"/>² Nenhum tipo de diária foi previamente selecionado, por favor selecione o Tipo A, B ou C.</div>
          </p>
          <p> </p>
          <label for="observacoes">Observações:</label>
          <p> </p>
          <textarea name="observacoes" id="observacoes" cols="50" rows="5" style="max-width:600px; min-width:600px; max-height:80px; min-height:80px;"></textarea>
          <p>
          <div id="div_trechos"></div>
    
    		</form>
           
            <div id="sugestao">
          <p id = "info"style="font-size:15px" align="center"><img src="imagens/info_16x16.png" style="vertical-align:middle"/> Após informar os dados acima, preencha abaixo sugestões para transporte. No caso de transporte aéreo, informe pelo menos duas sugestões.</p>
          </p>
         
          <fieldset class="testess" style="  border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; background-color:#F7F7F7" >
          <legend><span class="titulos">Sugestões de transporte</span></legend>
          <div id="tabs">
            <ul>
              <li><a class="nome_sugestao" href="#sugestao1" style="font-size:11px">Sugestão 1</a></li>
              <li class="addSugestao" id="addSugestao" style=" background-image:url(imagens/add_16x16.png);background-position:center; background-repeat:no-repeat;"><a  style="font-size:11px;background-position:center; background-repeat:no-repeat; "> &nbsp; </a></li>
            </ul>
            
            <div class='div_sugestao' id="sugestao1">
              <p/>
              <label for="transporte1">Transporte:</label>
              <select name="transporte" id="transporte1">
              <option class='not_aereo' value="">Selecione um transporte...</option>        

                <option class='aereo' 	  value=1>Aéreo</option>
                <option class='not_aereo' value=2>Terrestre</option>
                <option class='not_aereo' value=3>Veículo Próprio</option>
                <option class='not_aereo' value=4>Veículo da Caixa</option>
                <option class='not_aereo' value=5>Aquático</option>
               
                
              </select>
              <label for="data1">Data:</label>
              <input  name="data1" id="data1" class="datepicker" type="text" size="12" maxlength="8" value="<%Response.Write(Date)%>"/>
              <label for="horario">Horário:</label>
              <input id="horario1" name="horario" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" style="font-size:12px"/>
              <p></p>
              <div id="info_aereo1" name="info_aereo"> </div>
              <label for="cidade_embarque1">Cidade de embarque:</label>
              <input class="form-field" name="cidade_embarque" id="cidade_embarque1" type="text" size= "20" maxlength="50" />
              <button name="incluir_trecho" class ="incluir_trecho" id="incluir_trecho1" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px">Incluir Trecho</button>
                            <button name="excluir_sugestao" class ="excluir_sugestao" id="excluir_sugestao1" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px">Excluir Sugestão</button>
              <div class="tabela" align="center">
                <table  name="tabela1" id="tabela1" class="tabelaTrecho">
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

            <input  name="aupg" id="aupg" class="myButton" type="button"  value="AUPG" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px"/>
            
         
            <input id='salvar' name='salvar' class="myButton" type="button" value="Salvar" onclick="Salvar();"/>
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
