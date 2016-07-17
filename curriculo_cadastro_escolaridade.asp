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
	
	var spinner = $( ".spinner" ).spinner({
		spin: function( event, ui ) {
			if ( ui.value < 0 ) {
				$( this ).spinner( "value", 0 );
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
	
	function carregarSituacoes(){
		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=carregarSituacoes",
			//data: $("#areaConhecimento").val(),
			success: function(data) {
				$("#situacao").html(data);
			},
			error: function(data){
				alert("Erro ao carregar situações.");
				console.log(data.responseText);
			}
		})
	};

	carregarAreasConhecimento();
	carregarModalidades();
	carregarMetodologias();
	carregarSituacoes();
	
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
		$.ajax({
			method: "POST",
			url: "curriculo_con.asp?acao=solicitarCadastroEscolaridade",
			data: $("#formularioCadastroEscolaridade").serialize(),
			success: function(data) {
				 arquivo = new FormData();
				 arquivo.append("documento", $("#documento")[0].files[0]);
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
							 alert("Solicitação de cadastro de escolaridade realizada com sucesso.");
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
  		response.Redirect ("curriculo_consultar.asp")
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
				response.write "<li class='active'><a href='curriculo_cadastro_escolaridade.asp'><span>Cadastro de Escolaridade</span></a></li>"
				if Tem_Acesso("14") then
					response.write "<li class='inactive'><a href='curriculo_modalidade_complementar.asp'><span>Modalidade Complementar</span></a></li>"
				end if
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li id="opener"><a href='#'><span>Consultar</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
            <legend class="testea"><span class="titulos">Solicitar</span></legend>
            <p></p>
            <form method="post" name="formularioCadastroEscolaridade" id="formularioCadastroEscolaridade" enctype="multipart/form-data">
              <table>
                <tr>
                  <td align="left" style="text-align:left"><label>Matrícula do empregado:</label></td>
                  <td><input type="text" id="matriculaEmpregado" name="matriculaEmpregado" class="form-field" size="10"/></td>
                  <td><label>Nome do empregado:</label></td>
                  <td><input type="text" id="nomeEmpregado" name="nomeEmpregado" class="form-field" size="50"/></td>
                </tr>
                <tr>
                  <td><label>Modalidade:</label></td>
                  <td colspan="3"><select id="modalidade" name="modalidade" class="form-select">
                      <option value="">Selecione uma modalidade...</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Área conhecimento:</label></td>
                  <td colspan="3"><select id="areaConhecimento" name="areaConhecimento" class="form-select">
                      <option value="">Selecione uma área de conhecimento...</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Área concentração:</label></td>
                  <td colspan="3"><select id="areaConcentracao" name="areaConcentracao" class="form-select">
                      <option value="">Selecione uma área de concentração...</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Nome do Curso:</label></td>
                  <td colspan="3"><input type="text" id="nomeCurso" name="nomeCurso" class="form-field" size="95"/></td>
                </tr>
                <tr>
                  <td><label>Metodologia:</label></td>
                  <td colspan="3"><select id="metodologia" name="metodologia" class="form-select">
                      <option value="">Selecione uma metodologia...</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Situação:</label></td>
                  <td colspan="3"><select id="situacao" name="situacao" class="form-select">
                      <option value="1">Selecione uma situação...</option>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Data Início:</label></td>
                  <td colspan="3"><input id="dataInicio" name="dataInicio" class="datepicker" type="text" size="8" maxlength="10"/></td>
                </tr>
                <tr>
                  <td><label>Data Conclusão:</label></td>
                  <td colspan="3"><input id="dataConclusao" name="dataConclusao" class="datepicker" type="text" size="8" maxlength="10"/></td>
                </tr>
                <tr>
                  <td><label>Carga Horária:</label></td>
                  <td colspan="3"><input style="width:20px;height:20px;font-size:14px;" id="cargaHoraria" name="cargaHoraria" class="spinner" value=0 ></td>
                </tr>
                <tr>
                  <td><label>Documento:</label></td>
                  <td colspan="3"><input type="file" id="documento" name="documento" size="50"></td>
                </tr>
                <tr>
                  <td colspan="4" align="center"><br />
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
