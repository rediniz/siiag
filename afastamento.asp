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
<script type="text/javascript">
	//#Alterado: não está sendo mais utilizado
	function salvar(){

		if($("#perfil_afastamento").val()=="False"){
			alert("Você não tem permissão para solicitar afastamentos.")
			return false;
		}
	
		if (form_editar.matricula.value == '') {alert('Digite a matrícula do usuário.'); form_editar.matricula.focus(); return false;}
		if (form_editar.nome.value == '') {alert('Digite o nome do usuário.'); form_editar.matricula.focus(); return false;}
	    if (form_editar.data_inicio.value == '') {alert('Digite a data inicial.'); form_editar.matricula.focus(); return false;}
		if (form_editar.data_fim.value == '') {alert('Digite a data final.'); form_editar.matricula.focus(); return false;}
		if (form_editar.tipo_afastamento.value == '') {alert('Selecione um tipo de afastamento.'); form_editar.tipo_afastamento.focus(); return false;}

		if ($("#tipo_afastamento").val() == "37" || $("#tipo_afastamento").val() == "13"){
			var dt_1 = new Date(form_editar.data_inicio.value.substring(3,5) + "/" + form_editar.data_inicio.value.substring(0,2) + "/" + form_editar.data_inicio.value.substring(7,10));
			var dt_2 = new Date(form_editar.data_fim.value.substring(3,5) + "/" + form_editar.data_fim.value.substring(0,2) + "/" + form_editar.data_fim.value.substring(7,10));	
			var qt_dias_solicitado;
			qt_dias_solicitado = Date.dateDiff('d',dt_1 , dt_2);
			
			if ($("#qt_dias_TRE").val() <= qt_dias_solicitado ){
				alert("Você não tem folgas TRE suficiente para esta solicitação");
				return false;
			}
		}
		
		var resposta = confirm("Confirma solicitação de afastamento?");
		if (resposta){
			form_editar.flag_salvar.value = "1";
			form_editar.submit();
			return true;
		}
	}
	
	
	// datepart: 'y', 'm', 'w', 'd', 'h', 'n', 's'
	Date.dateDiff = function(datepart, fromdate, todate) {	
	  datepart = datepart.toLowerCase();	
	  var diff = todate - fromdate;	
	  var divideBy = { w:604800000, 
					   d:86400000, 
					   h:3600000, 
					   n:60000, 
					   s:1000 };	
	  
	  return Math.floor( diff/divideBy[datepart]);
	}

</script>
<script type="text/javascript" language="javascript">
	$(document).ready(function(){
		
		// Spinner
		var spinner = $( "#quantidadeHoras" ).spinner({
			spin: function( event, ui ) {
				if ( ui.value < 0 ) {
					$( this ).spinner( "value", 0 );
					return false;
				}
			}			
		});
		
		//#Alterado: adicionado.
		necessitaDocumento = false;
		
		//Ao digitar executar essa função
		$("#nome").focus().autocomplete({
			source: "autocompletar_nome.asp",
			minlength: 2,
			select: function( event, ui ) {
				$( "#nome" ).val( ui.item.nome);
				$( "#digito" ).val( ui.item.digito);
				$( "#matricula" ).val( ui.item.matricula);	
				$("#tipo_afastamento").val("");
				//$("#tipo_afastamento").prop("disabled",false);
				$("#linha_tre").hide();
				return false;
			}
		});
 
 		$("#matricula").focus().autocomplete({
			source: "autocompletar_matricula.asp",
			minlength: 2,
			select: function( event, ui ) {
				$( "#nome" ).val( ui.item.nome);
				$( "#digito" ).val( ui.item.digito);
				$( "#matricula" ).val( ui.item.matricula);
				$("#tipo_afastamento").val("");
				//$("#tipo_afastamento").prop("disabled",false);				
				$("#linha_tre").hide();
				return false;
			}
		}); 

		
		$("#tipo_afastamento").on("change", function(){
				var matricula = $("#matricula").val();
				//alert(matricula);
				
				//#Alterado: adicionado (ajustar os co_tipo que precisam de documento aqui, caso precise).
				var necessitamDocumento = ["13","69", "7","4", "8","11","51","52","50","3","5","36","37","16", "17", "10", "14", "12", "25", "6", "18"];
				var documentoOpcional = ["13", "4", "7"];

				if ($("#tipo_afastamento").val() == "37" || $("#tipo_afastamento").val() == "13")
				{		
					$("#linha_tre").show();
					$.ajax({
						method: "POST",
						contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
						url: "tre_consulta_folga.asp?co_usuario="+ matricula, // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
						dataType: "html", // TIPO DE DADOS DE RETORNO
						//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
						beforeSend: function() { // ANTES DA REQUISIÇÃO
	
						},
						complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
	
						},
						success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
							//$('#retorno').html(data);
							$('#qt_dias_TRE').val(data);
						},
						error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
							alert("Erro ao carregar TRE.");
						}
					})
				}
				else{
					$("#linha_tre").hide();
				}
				
				//#Alterado: adicionado.
				if(necessitamDocumento.indexOf($("#tipo_afastamento").val()) > -1){
					$("#linhaDocumento").show();
					
					if(documentoOpcional.indexOf($("#tipo_afastamento").val()) == -1){
						necessitaDocumento = true;
						alert("Para o tipo de afastamento selecionado, é obrigatório o envio de documento digitalizado. Informe o documento a ser enviado no campo logo abaixo.");			}
				}else{
					$("#linhaDocumento").hide();
					necessitaDocumento = false;
				}

				if($("#tipo_afastamento").val() == "17"){
					$("#linhaQuantidadeHoras").show();
				}else{
					$("#linhaQuantidadeHoras").hide();	
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
<!-- efeito da janela de ajuda -->

<script>
	$(function() {
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
		
		/*dialogo do solicitar*/
		$( "#dialog2" ).dialog({
			autoOpen: false,
			show: {
				effect: "blind",
				duration: 1000
			},
			hide: {
				effect: "explode",
				duration: 500
			}
		});/*dialogo do solicitar*/

		$( "#opener" ).click(function() {
			$( "#dialog" ).dialog( "open" );
		});
		
		/*dialogo do solicitar*/
		$( "#solicitar" ).click(function() {
			$( "#dialog2" ).dialog( "open" );
		});
		/*dialogo do solicitar*/
	});
</script>
<!-- fecha efeito da janela de ajuda -->

<!-- <Salvar> -->
<script>



//#Alterado: adicionado, aproveitando o código da função salvar() que já existia.
$(document).on("click","#solicitar", function(){
	
		if($("#perfil_afastamento").val()=="False"){
			alert("Você não tem permissão para solicitar afastamentos.")
			return false;
		}
		
		if (!confirm("Confirma solicitação de afastamento?")){
			return false;
		}
	
		if(necessitaDocumento && $("#documento").val() == ""){
			alert("É obrigatório o envio de documento digitalizado para o tipo de afastamento selecionado."); 
			return false;
		}
		if (form_editar.matricula.value == '') {alert('Digite a matrícula do usuário.'); form_editar.matricula.focus(); return false;}
		if (form_editar.nome.value == '') {alert('Digite o nome do usuário.'); form_editar.matricula.focus(); return false;}
	    if (form_editar.data_inicio.value == '') {alert('Digite a data inicial.'); form_editar.matricula.focus(); return false;}
		if (form_editar.data_fim.value == '') {alert('Digite a data final.'); form_editar.matricula.focus(); return false;}
		if (form_editar.tipo_afastamento.value == '') {alert('Selecione um tipo de afastamento.'); form_editar.tipo_afastamento.focus(); return false;}
		//document.write("TESTE");
		
		//Set the two dates
		//var y2k  = new Date(2014, 8, 11);
		//var today= new Date();
		if ($("#tipo_afastamento").val() == "37" || $("#tipo_afastamento").val() == "13"){
			var dt_1 = new Date(form_editar.data_inicio.value.substring(3,5) + "/" + form_editar.data_inicio.value.substring(0,2) + "/" + form_editar.data_inicio.value.substring(7,10));
			var dt_2 = new Date(form_editar.data_fim.value.substring(3,5) + "/" + form_editar.data_fim.value.substring(0,2) + "/" + form_editar.data_fim.value.substring(7,10));	
			var qt_dias_solicitado;
			qt_dias_solicitado = Date.dateDiff('d',dt_1 , dt_2);
			
			if ($("#qt_dias_TRE").val() <= qt_dias_solicitado ){
				alert("Você não tem folgas TRE suficiente para esta solicitação");
				return false;
			}
		}
			
	documentos = new FormData();
	$(".documento").each(function(){
		if($(this).val() != ""){
			documentos.append("documento", this.files[0]);
		}
	});
	
	if($("#tipo_afastamento").val() == "17"){
		$.ajax({
			method: "POST",
			url: "acompanhamento_medico.asp?acao=consultarSaldo&matricula="+$("#matricula").val(),
			success: function(data) {
				var objeto = $.parseJSON(data.responseText),
					saldo  = objeto.saldo;
				if($("#quantidadeHoras").val() > saldo){
					alert("A quantidade de horas informada é maior do que o seu saldo de horas atual.");
					return false;
				}
			},
			error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
				alert("Erro ao carregar saldo de horas para Acompanhamento Médico.");
				console.log(data.responseText);
			}
		})
	}
	
	$.ajax({
		url: "afastamento_salvar.asp?"+$("#formulario").serialize(),
		data: documentos,
		cache: false,
		contentType: false,
		processData: false,
		type: 'POST',
		success: function (response) {
			console.log(response.responseText);
	 		alert("Afastamento solicitado com sucesso.");
		},
		error: function (error) {
			alert("Erro ao solicitar afastamento");
	 		console.log(error.responseText);
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
  		response.Redirect ("afastamento_consultar.asp")
  	end if
%>
<div class="teste2"> 
  <!--fundo azul do meio--> 
  <!-- #INCLUDE FILE ="topo.asp" -->
  <%
			flag = Request("flag_salvar")
			tipo = request.Cookies("co_usuario_unidade_siiag")
			matricula = Request("matricula")
			nome = request("nome")
			data_inicio = request("data_inicio")
			data_fim = request("data_fim")
			tipo_afast = request("tipo_afastamento")
			usuario = request.Cookies("co_usuario_siiag")
			data = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			'Response.Write "Tipo: " & data
			
			SQL = "SELECT A.CO_MATRICULA, A.NO_NOME, (B.QT_DIAS - B.QT_DIAS_UTILIZADO) AS QT_DISP FROM VW_USUARIOS A LEFT JOIN VW_TRE B ON A.CO_MATRICULA =  B.CO_MATRICULA  WHERE A.CO_MATRICULA = '" & matricula & "'"
			set rs=Server.CreateObject("ADODB.RecordSet")
			rs.Open SQL, dados_sys, 3, ,32

				
			if(rs.eof = true) then
				%>
  <script type="text/javascript">
					//comentado só para facilitar o trabalho
					//	alert("Matricula inválida.");
				</script>
  <%
				flag = 0
			else
				qt_disp = rs("qt_disp")
			end if
			
			 '#Alterado: removido o código de salvar que tinha aqui.
				%>
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos" ><span >AFASTAMENTOS</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <%			
				response.write "<li class='active'><a href='afastamento.asp'><span>Solicitar</span></a></li>"
				if Tem_Acesso("14") then
					response.write "<li class='inactive'><a href='afastamento_consultar.asp'><span>Consultar</span></a></li>"
				end if
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!--<li id="opener"><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:420px;">
            <legend class="testea"><span class="titulos">Solicitar Afastamento</span></legend>
            <p></p>
            <form action="afastamento.asp" method="post" name="form_editar" id="formulario" target="_self" enctype="multipart/form-data">
              <table>
                <tr>
                  <td><label>Usu&aacute;rio:</label></td>
                  <td><input class="form-field" name="matricula" id="matricula" value="<%=request.Cookies("co_usuario_siiag")%>" type="text" size="10" maxlength="7" />
                    <label>-</label>
                    <input class="form-field" name="digito" id="digito" value="<%=request.Cookies("co_usuario_dv_siiag")%>" type="text" size="1" maxlength="1" /
          								
                    <label> Nome:</label>
                    <input class="form-field" name="nome" id="nome" value="<%=request.Cookies("no_usuario_siiag")%>"  type="text" size="50" maxlength="60" /></td>
                </tr>
                <input type="hidden" name="flag_salvar" id="flag_salvar" value="0"/>
                <tr>
                  <td><label>Tipo:</label></td>
                  <td><select name='tipo_afastamento' id='tipo_afastamento'   class='form-select'  >
                      <option value=''>Selecione o tipo de afastamento</option>
                     		<%
												strQuery = 		"select CO_TIPO_AFASTAMENTO, DE_TIPO_AFASTAMENTO,CO_CAIXA  from TB_TIPOS_AFASTAMENTO WHERE IC_ATIVO = 1 ORDER BY DE_TIPO_AFASTAMENTO;" 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
												set Ls=			Server.CreateObject("ADODB.RecordSet")
												Ls.Open strQuery, dados_sys

												'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 												'Vamos percorrer o recordset até chegar no final do arquivo
 		
  												DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
													'atribuindo os valores dos campos as variáveis
	  												descricaoAfastamento=Ls("DE_TIPO_AFASTAMENTO")
	  												codigoAfastamento=Ls("CO_TIPO_AFASTAMENTO")
													coCaixa = Ls("CO_CAIXA")

                									response.write "<option value='"& codigoAfastamento &"'>"& descricaoAfastamento &" - "&coCaixa &"</option>" 'imprimindo
    												Ls.movenext 'passando para o proximo elemento da tabela
												LOOP
		
												objConn.close 
												set Ls = 		nothing
												set objConn = 	nothing 
												'fechando todas as conexoes
											%>
                    </select></td>
                </tr>
                <!-- <#Alterado: adicionado> -->
                 <tr id="linhaDocumento" style="display:none">
                  <td><label> Documento: </label></td>
                  <td colspan="4"><input type="file" name='documento' id='documento' class='documento' size="34" /></td>
                </tr>
                 <!-- </#Alterado> -->
                <tr style="display:none;" id="linha_tre">
                  <td><label>Folgas Disponíveis:</label></td>
                  <td><input  name="qt_dias_TRE" id="qt_dias_TRE"  class="form-field" readonly="readonly" type="text" size="8" maxlength="8" value="<%= QT_DISP %>"/></td>
                </tr>
                <tr>
                  <td><label>Início:</label></td>
                  <td><input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write(Date) %>"/>
                    <label>Fim:</label>
                    <input  name="data_fim" id="data_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>
                    <label></label></td>
                </tr>
                <tr id="linhaQuantidadeHoras" style="display:none">
                    <td><label for="quantidadeHoras">Quantidade<br /> de horas: </label></td>
                    <td><input style="width:20px;height:20px;font-size:14px;" id="quantidadeHoras" name="quantidadeHoras" value=0></td>
                </tr>
                <tr>
                  <td><br/></td>
                  <td><br/>
                  <!--#Alterado: removida a ação "onClick", agora chama a ação por jQuery-->
                    <input name="Botao_Solicitar" class="myButton" type="button" value="Solicitar" id="solicitar" />
                  </td>
                </tr>
              </table>
            </form>
            <div id="retorno" > </div>
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
