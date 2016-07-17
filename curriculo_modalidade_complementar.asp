<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Solicitar Afastamento</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.mousewheel.js"></script>
<script src="scripts/globalize.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.timepicker.js"></script>
<script src="scripts/jquery.ui.mask.js"></script>
<style>
.ui-datepicker {
	font-size: 12px;
}
.datepicker {
	height: 15px;
	border: 1px solid #b5cce2;
	background: #edf4fc;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	color: #666;
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
	padding: 6px;
	width: auto;
}
.datepicker:focus {
	background: #fff;
	color: #000000;
	outline: none;
	padding: 6px;
	box-shadow: 0 0 5px #9ecaed;
}
.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce;
	font-weight: bold;
	color: #c77405;
}
.ui-widget {
	font-family: Arial, sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}
.ui-menu .ui-menu-item a {
	height: 14px;
	font-size: 13px;
}
.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce;
	font-weight: bold;
	color: #c77405;
}
.ui-widget {
	font-family: Arial, sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}
.ui-menu .ui-menu-item a {
	height: 14px;
	font-size: 13px;
}
.ui-autocomplete {
	height: 200px;
	overflow-y: scroll;
	overflow-x: hidden;
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
$(document).ready(function(e) {
	
	$(function() {
		$("#culture").change(function() {
			$( "input" ).timepicker( "option", "culture", $( this ).val() );
		});
		function setup() {
	
			$("#cargaHoraria").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
		}
		setup();
	});
		
	$( ".spinnerDecimal" ).spinner({
		step: 1.00,
        numberFormat: "n",
		culture: "en-EN",
		spin: function( event, ui ) {
			if ( ui.value < 0 ) {
				$( this ).spinner( "value", 0 );
				return false;
			}
			if ( ui.value > 100.00 ) {
				$( this ).spinner( "value", 100.00 );
				return false;
			}
		}			
	});
	
	function carregarAreasConhecimento(){
		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=carregarAreasConhecimento",
			//data: $("#areaConhecimento").val(),
			success: function(data) {
				$("#areaConhecimento").html(data);
			},
			error: function(data){
				alert("Erro ao carregar áreas de conhecimento.");
				console.log(data.responseText);
			}
		})
	};
	
	function carregarModalidades(){
		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=carregarModalidades",
			//data: $("#areaConhecimento").val(),
			success: function(data) {
				$("#modalidade").html(data);
			},
			error: function(data){
				alert("Erro ao carregar modalidades.");
				console.log(data.responseText);
			}
		})
	};
	
	function carregarMetodologias(){
		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=carregarMetodologias",
			//data: $("#areaConhecimento").val(),
			success: function(data) {
				$("#metodologia").html(data);
			},
			error: function(data){
				alert("Erro ao carregar metodologias.");
				console.log(data.responseText);
			}
		})
	};
	
		
	function carregarTiposMediadores(){
		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=carregarTiposMediadores",
			//data: $("#areaConhecimento").val(),
			success: function(data) {
				$("#tipoMediador").html(data);
			},
			error: function(data){
				alert("Erro ao carregar tipos de mediadores.");
				console.log(data.responseText);
			}
		})
	};
	
	carregarAreasConhecimento();
	carregarModalidades();
	carregarMetodologias();
	carregarTiposMediadores();
	
	$("#nomeEmpregado").focus().autocomplete({
			source: "autocompletar_nome.asp",
			minlength: 2,
			select: function( event, ui ) {
				$( "#nomeEmpregado" ).val( ui.item.nome);
				$( "#matriculaEmpregado" ).val( ui.item.matricula);
				return false;
			}
		});
 
	$("#matriculaEmpregado").focus().autocomplete({
		source: "autocompletar_matricula.asp",
		minlength: 2,
		select: function( event, ui ) {
			$( "#matriculaEmpregado" ).val( ui.item.matricula);
			$( "#nomeEmpregado" ).val( ui.item.nome);
			return false;
		}
	});
	
	$("#modalidade").on("change", function(){
	});
	
	$("#areaConhecimento").on("change", function(){
		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=carregarAreasConcentracao",
			data: {
				areaConhecimento:$("#areaConhecimento").val()
			},
			success: function(data) {
				$("#areaConcentracao").html(data);
			},
			error: function(data){
				alert("Erro ao carregar áreas de concentração.");
				console.log(data.responseText);
			}
		})
	});
	
	$("#solicitar").on("click", function(){
		var empregados = "";
		$(".linhaEmpregado").each(function(index, element) {
			
            var matriculaEmpregado = $(this).find("#colMatriculaEmpregado").html(),
				nomeEmpregado 	   = $(this).find("#colNomeEmpregado").html();
				
				empregados = empregados + matriculaEmpregado+":"+nomeEmpregado+",";
        });
		
		empregados = empregados.substr(0, empregados.length-1);
		
		$("#empregados").val(empregados);

		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=solicitarModalidadeComplementar",
			data: $("#formularioModalidadeComplementar").serialize(),
			success: function(data) {
				 arquivo = new FormData();
				 
				 $(".documento").each(function(){
					 arquivo.append("documento", $(this)[0].files[0]);
				 });

				 var retorno = $.parseJSON(data),
				 	 idRetorno = retorno.id;
				 if(idRetorno){
					 $.ajax({
						 url: "curriculo_con.asp?acao=enviarDocumento&id="+idRetorno,
						 data: arquivo,
						 cache: false,
						 contentType: false,
						 processData: false,
						 type: 'POST',
						 success: function (data) {
							 alert("Solicitação de modalidade complementar realizada com sucesso.");
						 },
						 error: function (jqXHR, textStatus, errorThrown) {
							 alert("Erro ao enviar documento.");
							 console.log(textStatus + " " + errorThrown);
						 }
					 });
				 }
			},
			error: function(data){
				alert("Erro ao solicitar cadastro de escolaridade.");
				console.log(data.responseText);
			}
		})
	});
	
	$("#adicionarEmpregado").on("click", function(){
		if($("#matriculaEmpregado").val() != "" || $("#nomeEmpregado").val() != ""){
			
			var existente = false;
			
			$(".linhaEmpregado").each(function(){
				if($(this).find("#colMatriculaEmpregado").html() === $("#matriculaEmpregado").val()){
					alert("Este empregado já foi adicionado.");
					existente = true;
					return false;
			   }
		   	});
		    
			if(!existente){
				$("#tabelaEmpregados").append("<tr class='linhaEmpregado'><td id='colMatriculaEmpregado'>"+$("#matriculaEmpregado").val()+"</td><td id='colNomeEmpregado'>"+$("#nomeEmpregado").val()+"</td><td><img class='removerEmpregado' src='imagens/delete_16x16.png' style='cursor:pointer;'></img></td></tr>");
				$("#matriculaEmpregado").val("");
				$("#nomeEmpregado").val("");
			}
		}
	});
	
	$(document).on("click",".removerEmpregado", function(){
		if(window.confirm("Remover empregado?")){
			$(this).parent().parent().remove();	
		}
	});
	
	$("#iniciativa").on("change", function(){
		if($("#iniciativa").val() == 3){
			$(".iniciativaCaixa").show();
			$(".iniciativaPessoal").hide();
		}else{
			$(".iniciativaCaixa").hide();
			$(".iniciativaPessoal").show();
		}
	});
	
	$("#frequencia").on("change", function(){
		var valorPorcentagem = $("#frequencia").val().replace("%", "").trim() + "%";
		$("#frequencia").val(valorPorcentagem);
	});
	
	$("#adicionarDocumento").on("click", function(){
		$(this).parent().parent().before("<tr><td colspan='6'><input type='file' id='documento' name='documento' class='documento' size='50'></td></tr>");
	});
	
	$("#custeioCaixa").on("change", function(){
		if($("#custeioCaixa").prop("checked") === true){
			$(".custeadoCaixa").show();	
		}else{
			$(".custeadoCaixa").hide();	
		}
	});
	
	
});
</script>
<!-- </Salvar> -->
</head>

<body>
<%
	Perfil_Acesso("3") 
	'response.write "<input type='hidden' id = 'perfil_afastamento_consultar' value=" & perfil_acesso_siiag & ">"
  	'response.write "<input type='hidden' id = 'perfil_afastamento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
   
  	if not perfil_acesso_siiag then
  		response.Redirect ("principal.asp")
  	end if
%>
<div class="teste2"> 
  <!--fundo azul do meio--> 
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos" ><span >ATUALIZAÇÃO CURRICULAR</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <%			
				response.write "<li class='inactive'><a href='curriculo_cadastro_escolaridade.asp'><span>Cadastro de Escolaridade</span></a></li>"
				if Tem_Acesso("14") then
					response.write "<li class='active'><a href='curriculo_modalidade_complementar.asp'><span>Modalidade Complementar</span></a></li>"
				end if
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu' >
            <ul>
              <!-- <li id="opener" style="font-size:14px; font-weight:bold;" class="active"><a href='#'><span>Cursos de Iniciativa Pessoal/Unidade</span></a></li>
              <li id="opener" style="font-size:14px; font-weight:bold;"><a href='#'><span>Cursos de Iniciativa Caixa</span></a></li>-->
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
            <legend class="testea"><span class="titulos">Solicitar</span></legend>
            <p></p>
            <form method="post" name="formularioModalidadeComplementar" id="formularioModalidadeComplementar" enctype="multipart/form-data">
              <label>Iniciativa do curso:</label>
              <select id="iniciativa" name="iniciativa" class="form-select">
                <option value="1">Pessoal</option>
                <option value="2">Unidade</option>
                <option value="3">Caixa</option>
              </select>
              <br />
              <br />
              <fieldset>
                <legend class="testea"><span class="titulos">Empregado(s)</span></legend>
                <input type="hidden" id="empregados" name="empregados" />
                <table>
                  <tr>
                    <td align="left" style="text-align:left"><label>Matrícula do empregado:</label></td>
                    <td><input type="text" id="matriculaEmpregado" name="matriculaEmpregado" class="form-field" size="10"/></td>
                    <td colspan="0"><label>Nome do empregado:</label></td>
                    <td colspan="4"><input type="text" id="nomeEmpregado" name="nomeEmpregado" class="form-field" size="50"/></td>
                    <td><button type="button" id="adicionarEmpregado" name="adicionarEmpregado" class="myButton">Adicionar</button></td>
                  </tr>
                </table>
                <div class="tabela" style="margin-top:10px">
                  <table id="tabelaEmpregados">
                    <tr>
                      <td width="15%">Matrícula</td>
                      <td width="85%">Empregado</td>
                      <td></td>
                    </tr>
                  </table>
                </div>
              </fieldset>
              <br />
              <table border="0">
                <tr class="iniciativaPessoal iniciativaUnidade">
                  <td><label>Área conhecimento:</label></td>
                  <td colspan="6"><select id="areaConhecimento" name="areaConhecimento" class="form-select">
                      <option value="1">Selecione uma área de conhecimento...</option>
                    </select></td>
                </tr>
                <tr class="iniciativaPessoal iniciativaUnidade">
                  <td><label>Área concentração:</label></td>
                  <td colspan="6"><select id="areaConcentracao" name="areaConcentracao" class="form-select">
                      <option value="1">Selecione uma área de concentração...</option>
                    </select></td>
                </tr>
                <tr class="iniciativaPessoal iniciativaUnidade">
                  <td><label>Modalidade:</label></td>
                  <td colspan="6"><select id="modalidade" name="modalidade" class="form-select">
                      <option value="1">Selecione uma modalidade...</option>
                    </select></td>
                </tr>
                <tr class="iniciativaPessoal iniciativaUnidade">
                  <td><label>Metodologia:</label></td>
                  <td colspan="6"><select id="metodologia" name="metodologia" class="form-select">
                      <option value="1">Selecione uma metodologia...</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Nome do Curso:</label></td>
                  <td colspan="6"><input type="text" id="nomeCurso" name="nomeCurso" class="form-field" size="95"/></td>
                </tr>
                <tr class="iniciativaCaixa">
                  <td><label>Código do Curso:</label></td>
                  <td colspan="6"><input type="text" id="codigoCurso" name="codigoCurso" class="form-field" size="10"/></td>
                </tr>
                <tr>
                  <td><label>Instituição Ministrante:</label></td>
                  <td colspan="6"><input type="text" id="instituicaoMinistrante" name="instituicaoMinistrante" class="form-field" size="95"/></td>
                </tr>
                <tr>
                  <td><label>Data Início:</label></td>
                  <td colspan="6"><input id="dataInicio" name="dataInicio" class="datepicker" type="text" size="8" maxlength="10"/></td>
                </tr>
                <tr>
                  <td><label>Data Conclusão:</label></td>
                  <td colspan="6"><input id="dataConclusao" name="dataConclusao" class="datepicker" type="text" size="8" maxlength="10"/></td>
                </tr>
                <tr>
                  <td><label>Carga Horária:</label></td>
                  <td colspan="6"><input  id="cargaHoraria" name="cargaHoraria" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" style="height:20px;" ></td>
                </tr>
                <tr>
                  <td><label>Custeio Caixa:</label></td>
                  <td><input type="checkbox" id="custeioCaixa" name="custeioCaixa"/></td>
                </tr>
                <tr class="custeadoCaixa" style="display:none">
                  <td><label>Investimento CAIXA <br />
                      por empregado:</label></td>
                  <td colspan="0"><input id="investimentoCaixa" name="investimentoCaixa" class="form-field" type="text" size="10"/></td>
                  <td><label>Nº do compromisso:</label></td>
                  <td colspan="0" align="left"><input id="numeroCompromisso" name="numeroCompromisso" class="form-field" type="text" size="10"></td>
                  <td colspan="0"><label>CPF/CNPJ <br />
                      do ministrante:</label></td>
                  <td colspan="0"><input type="text" id="documentoMinistrante" name="documentoMinistrante" size="20" class="form-field"/></td>
                </tr>
                <tr>
                  <td><label>Nota:</label></td>
                  <td colspan="6"><input type="text" id="nota" name="nota" class="spinnerDecimal" size="10" style="height:20px"/></td>
                </tr>
                <tr>
                  <td><label>Conceito:</label></td>
                  <td colspan="6"><input type="text" id="conceito" name="conceito" class="form-field" size="10"/></td>
                </tr>
                <tr>
                  <td><label>Frequência:</label></td>
                  <td colspan="6"><input type="text" id="frequencia" name="frequencia" class="form-field" size="10"/></td>
                </tr>
                <tr>
                  <td><label>Mediador:</label></td>
                  <td colspan="6"><select id="mediador" name="mediador" class="form-select">
                      <option value="">Selecione uma opção...</option>
                      <option value="1">Interno</option>
                      <option value="2">Externo</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Tipo de mediador:</label></td>
                  <td colspan="6"><select id="tipoMediador" name="tipoMediador" class="form-select">
                      <option value="1">Selecione um tipo de mediador...</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Resultado final:</label></td>
                  <td colspan="6"><select id="resultadoFinal" name="resultadoFinal" class="form-select">
                      <option value="">Selecione um resultado...</option>
                      <option value="1">APTO</option>
                      <option value="2">NÃO APTO</option>
                    </select></td>
                </tr>
              </table>
              <table id="documentos">
              <tr><td><label>Documentos:</label></td></tr>
                <tr>
                  <td colspan="6"><input type="file" id="documento" name="documento" class="documento" size="50"></td>
                </tr>
                <tr><td><button id="adicionarDocumento" name="adicionarDocumento" type="button" class="myButton" style="padding:5px; font-size:10px"><img src="imagens/add_16x16.png" style="vertical-align:middle"/> ADICIONAR OUTRO ARQUIVO</button></td></tr>
              </table>
              <table>
                <tr>
                  <td colspan="6" align="center"><br />
                    <button id="solicitar" name="solicitar" type="button" class="myButton">Solicitar</button></td>
                </tr>
              </table>
            </form>
          </fieldset>
          <br>
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
