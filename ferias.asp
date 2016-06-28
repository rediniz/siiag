<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<title>Solicitar F&eacute;rias</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<%
 mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i))
				End If
                %>
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
</style>
<style>
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
.alinhador {
	/*border:#000000 solid 1px;*/
	width: 351px;
}
.datepicker1 {
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
.datepicker11 {
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
</style>
<script type="text/javascript" language="javascript">

$(document).ready(function(){
	var abono=false;
	//Ao digitar executar essa função
	$("#nome").focus().autocomplete({
		source: "autocompletar_nome.asp",
		minlength: 2,
		select: function( event, ui ) {
			$( "#nome" ).val( ui.item.nome);
			$( "#digito" ).val( ui.item.digito);
			$( "#matricula" ).val( ui.item.matricula);					
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
			return false;
		}
	});

	$("#abono_sim").on("click", function(){ 
		$("#diasAbono").prop("disabled", false);
	});

	$("#abono_nao").on("click", function(){ 
		$("#diasAbono").val("0");
		$("#diasAbono").prop("disabled", true);
	});	
});				
</script>
<script>
 function carregaDatePicker (){
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
}
  </script>
<script src="scripts/jquery.ui.core.js"></script>
<!-- efeito da janela de ajuda -->
<script>
function habilitaDias(){
	var ativo = document.getElementById("1").value;
	if (ativo == 1){
	
		$("#quantDias").prop("disabled", false);
		 
	}else{
		$("#quantDias").prop("disabled",true);	
	}
}
</script>
<script>
$(document).ready(function(e) {
    carregaDatePicker();
	function verificarSubstituicao(){
			//Checa se usuário é coordenador
			$.ajax({
			url: "ferias_substituicao.asp?acao=checarCoordenador",
			data:{
				matriculaFerias: $("#matricula").val(),
			},
			success: function(data) {
				if(data == "sim"){
					if(window.confirm("Solicitar substituição?")){
						preencherFormularioSubstituicao();				  
						$("#substituicaoDialog" ).dialog({
							modal: true,
							dialogClass: "dialogo",
							closeText: "Fechar",
							width:'auto'
						});
						$("#substituicaoDialog").dialog("open");
					}else{
						window.location.assign("consultar_ferias.asp");	
					}
				}else{
					window.location.assign("consultar_ferias.asp");
				}
			},
			error: function(data) {
				console.log(data.responseText);
				alert("Erro ao checar coordenador.");
			}
		});
	};
	function preencherFormularioSubstituicao(){
		//Checa se usuário é coordenador
		$.ajax({
		url: "ferias_substituicao.asp?acao=carregarSubstituicao",
		data:{
			matriculaFerias: $("#matricula").val(),
			nomeFerias: $("#nome").val(),
			dataInicioFerias:$("#data_inicio").val(),
			diasDeGozo: $("#gozo").val()
		},
		success: function(data) {
			$("#substituicaoDialog").html(data);
			carregaDatePicker();
		},
		error: function(data) {
			console.log(data.responseText);
			alert("Erro ao carregar formulário de substituição.");
		}
	});
	}
	$("#solicitar").on("click", function(){
		if($("#perfil_ferias").val()=="False"){
			alert("Você não tem permissão para solicitar férias.")
			return false;
		}

			var usuario_logado = $("#mat_usuario").val()  //pegando matricula logada	
			var IC_GERENTE = $("#ic_gerente").val()
			var matricula = $("#matricula").val()  		
			var nome = $("#nome").val()
			var data_inicio = $("#data_inicio").val()
			var gozo = $("#gozo").val()
			var parcelas = $("#parcelas").val()	
			var diasAbono = $("#diasAbono").val()
			var observacao = $("#observacao").val()
			var abono_sim = $("#abono_sim").val()
			var abono_nao = $("#abono_nao").val()
			var abono;   

			if (matricula == ""){
				alert("Digite uma matricula");
			}
			else if (nome == ""){
				alert("Digite um nome");
			}
			else if (data_inicio == ""){
				alert("Digite uma data");
			}
			else if (gozo == ""){
				alert("Digite os dias de gozo");
			}

			prazoCritico = false;
			var diferenca = calculaDiferenca(data_inicio);
			if(diferenca <= 0){
				alert("Data de início inválida.");
				return false;
			}else if(diferenca <= 7){
				prazoCritico = true;
				alert("Atenção, prazo crítico! \nFavor contatar a coordenação Monitoramento e Apoio à Gestão para confirmar a viabilidade do gozo de férias no período solicitado.");
			}

			if (document.getElementById('abono_sim').checked)
			{ 
				//alert('sim'); 
				abono = 1;
				if (diasAbono == "" || diasAbono == "0")
				{
				 alert('Digite a quantidade de dias de abono.');
				 return false;
				}
			}else if (document.getElementById('abono_nao').checked)
			{ 
				abono = 0;
			}
			
		if (matricula != "" && nome != "" && data_inicio != "" && gozo != "" && parcelas != ""){
			 $.ajax({
				url: "ferias_con.asp",
				data: {
					matricula:matricula,
					nome:nome,
					data_inicio:data_inicio,
					gozo:gozo,
					parcelas:parcelas,
					diasAbono:diasAbono,
					abono:abono,
					observacao:observacao,
					prazoCritico:prazoCritico
				},
				success: function(data) {
					alert('Solicitação de férias realizada com sucesso.');
					verificarSubstituicao();
				},
				error: function(data) {
					console.log(data.responseText);
					alert("Erro ao solicitar férias.");
				}
             });
		}	
	});
});
 </script>
<script>
	function calculaDiferenca(data_inicio){
		var dataAtual = new Date();				
		var data = data_inicio.split("/");
		var data1 = new Date(dataAtual.getMonth() + 1 + "/" + dataAtual.getDate() + "/"+ dataAtual.getFullYear());
		var data2 = new Date(data[1]+"/"+data[0]+"/"+data[2]);
		var diferenca = (( data2.getTime() - data1.getTime()) / (24*60*60*1000));
		return diferenca;
	}
</script>
		<script type="text/javascript">
            $(document).ready(function() {
        
                $(document).on("click", "#salvarSubstituicao", function() {
            
                    var empregado	 	 = $("#empregado").val();
                    var substituto 	 	 = $("#substituto").val();
                    var motivo       	 = $("#motivo").val();
                    var data_inicio  	 = $("#data_inicio").val();
                    var data_final   	 = $("#data_final").val();
                    var matricula_logado = $("#mat_usuario").val();
            
                    if (empregado == "" || substituto == "" || motivo == "" || data_inicio == "" || data_final == "") {
                        alert("Preencha todos os campos para concluir o pedido de substituição.");
                    }
            
                    $.ajax({
                        url: "substituicao_con.asp",
                        data: $("#form_substituicao").serialize(),
                        success: function(data) {
                            alert('Pedido de substituição realizado com sucesso.');
							$("#substituicaoDialog").dialog("close");
							$("#substituicaoDialog").html("");
							window.location.assign("consultar_ferias.asp");
                        },
                        error: function(data) {
							console.log(data.responseText);
                            alert("Erro ao solicitar substituição.");
                        }
                    });
                });
            });
        </script>
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<%
  Perfil_Acesso("2")
  if not  perfil_acesso_siiag then
	  response.Redirect ("consultar_ferias.asp")
  end if
  response.write "<input type='hidden' id = 'perfil_ferias' value=" & perfil_acesso_siiag & ">"
  'response.write "<input type='hidden' id = 'perfil_ferias_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
%>
<div class="teste2"> 
  <!--fundo azul do meio--> 
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos" ><span >FÉRIAS</span> </div>
        <div class="usuariodiv" style="min-height:540px;">
          <div id='cssmenu'>
            <ul>
              <%			
			  response.write "<li class='active'><a href='ferias.asp'><span>Solicitar</span></a></li>"
			  if tem_acesso_cookie("20") then
			  	response.write "<li ><a href='consultar_ferias.asp'><span>Consultar</span></a></li>"	  
			  end if			
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!--<li><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>
<!-- *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* AQUI COMEÇA O SCRIPT DO CHOQUE DE FÉRIAS *_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_* -->
       
<script>
function concomitantes(){
	var matricula = $("#matricula").val()  
	var data_inicio = $("#data_inicio").val()
	var gozo = $("#gozo").val()
	
	//window.navigate('verificar_ferias_concomitantes.asp?matricula=' + matricula + '&data_inicio=' + data_inicio + '&gozo=' + gozo)
	
	$.ajax({
		url: 'verificar_ferias_concomitantes.asp?matricula=' + matricula + '&data_inicio=' + data_inicio + '&gozo=' + gozo, 
		dataType: 'html', // TIPO DE DADOS DE RETORNO
		//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
		beforeSend: function() { // ANTES DA REQUISIÇÃO
		},
		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
			//$("#carregando").hide();
		},
		success: function(data) { // CASO RECEBA RESPOSTA COM SUCESSO
			$("#div_concomitantes").show();
			$('#div_concomitantes').html(data);
		},
		error: function(data) { // CASO OCORRA ERRO NA REQUISIÇÃO
			alert('Erro na checagem de férias. Verifique se a matricula e o gozo foram informados corretamente.');
			//alert('verificar_ferias_concomitantes.asp?matricula=' + matricula + '&data_inicio=' + data_inicio + '&gozo=' + gozo)
			//alert(matricula);
		}
	});
	
}
function enter_gozo (event){

	var chCode = ('charCode' in event) ? event.charCode : event.keyCode;

	if(chCode == '13'){
		concomitantes();
	}
}
</script> 
          
    <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
 
    <div id="div_concomitantes" style="border:#000 solid 0px; float:right; position:static; vertical-align:top; margin-top:13px; display:none">
    
    </div>        

            <legend><span class="titulos" >Solicitar F&eacute;rias</span></legend>
            <form id="formFerias">
              <table width="653" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="129"><span class="alinhador">
                    <label>Usu&aacute;rio:</label>
                    </span></td>
                  <td width="524"><span class="alinhador">
                    <input class="form-field" name="matricula" id="matricula" type="text" size="10" maxlength="7" />
                    <label>-</label>
                    <input class="form-field" name="digito" id="digito" type="text" size="1" maxlength="1" />
                    </span></td>
                </tr>
                <tr>
                  <td height="18"><span class="alinhador">
                    <label>Nome:</label>
                    </span></td>
                  <td><span class="alinhador">
                    <input style="margin-top:5px;" class="form-field" name="nome" id="nome" type="text" size="43" maxlength="100" />
                    </span></td>
                </tr>
                <tr>
                  <td><span class="alinhador">
                    <label>In&iacute;cio das F&eacute;rias:</label>
                    </span></td>
                  <td><span class="alinhador">
                    <input   style="margin-top:5px" name="data_inicio" id="data_inicio" class="datepicker" type="text" size="10" maxlength="8"  value="<% Response.Write(Date) %>"/>
                    <label></label>
                    </span></td>
                </tr>
     
                <tr>
                  <td><span class="alinhador">
                    <label>Gozo:</label>
                    </span></td>
                  <td><span class="alinhador">
                    <input  style="margin-top:5px" class="form-field" name="gozo" id="gozo" type="text" size="1" maxlength="2" />
                   <!-- <input style="margin-top:7px;margin-left:5px;" name="verif_disp" id="verif_disp" class="myButton" type="button" value="Verificar Disponibilidade" onclick="concomitantes()"/>-->
                    <label style="margin-left:10px"> Parcelas: </label>
                    <select name="parcelas" id="parcelas" class='form-select'>
                      <option> 01 </option>
                      <option> 02 </option>
                      <option> 03 </option>
                      <option> 04 </option>
                      <option> 05 </option>
                      <option> 06 </option>
                      <option> 07 </option>
                      <option> 08 </option>
                      <option> 09 </option>
                      <option> 10 </option>
                    </select>
                    </span></td>
                </tr>
                <tr>
                  <td><span class="alinhador">
                    <label>Abono:</label>
                    </span></td>
                  <td><span class="alinhador">
                    </label>
                    <input type="radio" style="margin-top:10px;margin-left:0px;" class = "abono" name="RadiodoAbono"  id="abono_nao"  checked="checked"/>
                    <label style="padding-left:0px">N&atilde;o</label>
                    <input type="radio" style="margin-left:0px;" class = "abono" name="RadiodoAbono"  id="abono_sim" />
                    <label style="padding-left:0px">Sim</label>
                    <label >Quantidade de Dias:</label>
                    <input style="margin-left:1px; padding-left:0px" class="form-field" name="diasAbono" id="diasAbono" type="text" size="1" maxlength="3" disabled="disabled" value="0" />
                </tr>
              </table>
              <div class="alinhador"> <!--comeco alinhador -->
                <label style="margin-top:8px"> Observa&ccedil;&atilde;o: </label>
                <p/>
                <!--  <input class="form-field" name="quantidade" type="t size="50" maxlength="100" />    -->
                <textarea  class="form-field" name="observacoes" id="observacao" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px; margin-left:5px"></textarea>
                </td>
                <p/>
                <input  style="margin-top:7px;margin-left:5px;" name="solicitar" id="solicitar" class="myButton" type="button" value="Solicitar"/>
              </div>
              <!--fecha alinhador -->      
              <% 
				  response.write "<input type='hidden' id='mat_usuario' value=" & usuario & " />" 
				  response.write "<input type='hidden' id='ic_gerente' value=" & request.Cookies("ic_gerente_siiag") & " />" 
			  %>
            </form>
          </fieldset>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo--> 
  <!-- #INCLUDE FILE ="rodape.asp" --> 
</div>
<%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		if (sucesso="true") then		
			response.write ("<script language=""javascript""> alert('Pedido realizado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.navigate('ferias.asp'); </script>")			
		end if
		
		%>
<!--teste-->
</body>

<!--DIV QUE VIRA DIALOG-->
<div id="substituicaoDialog" title="Solicitar Substituição" class="msg-dialog" style="display:none;"></div>
<!--FIM DA DIV QUE VIRA DIALOG-->
</html>
