<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Reserva de Equipamentos</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="scripts/jquery.mousewheel.js"></script>
<script src="scripts/globalize.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.button.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.timepicker.js"></script>
<script src="scripts/jquery.ui.mask.js"></script>
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

<style>
	#X {
	cursor:pointer
	}
	
	.ui-datepicker {
		font-size:12px;
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
</style>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
		$("#tabela").hide();
		//Ao digitar executar essa função
		$("#responsavel").focus().autocomplete({			
			source: "autocompletar_nome.asp",
			minlength: 2,
			select: function( event, ui ) {
			$( "#responsavel" ).val( ui.item.nome);					
			$( "#co_responsavel" ).val( ui.item.matricula);					
			return false;
			}
		});
	});
</script>
    
<script>
	$(function() {
		$("#culture").change(function() {
			$( "input" ).timepicker( "option", "culture", $( this ).val() );
		});
		function setup() {
	
			$("#horario_inicio").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#horario_fim").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
		}
		setup();
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
		function pedido (recurso, quantidade){
			this.recurso = recurso;
			this.quantidade = quantidade;
		}
		
		$( "#dialog" ).dialog({
			autoOpen: false,
		});

		$( "#opener" ).click(function() {
			$( "#dialog" ).dialog( "open" );
		});
		
//	    $( document ).on("click", "#solicitar", function(){
//		array = new Array();
//		
//		
//		$(".linha").each(function(){
//		pedido1 = new pedido ($(this).find("#recurso").html(), $(this).find("#quantidade").html());
//		//alert(pedido1.recurso + ", " + pedido1.quantidade);
//		array.push(pedido1.recurso+":"+pedido1.quantidade);
//		//alert( "Recurso: " + $(this).find("#recurso").html() + " - Quantidade: " + $(this).find("#quantidade").html()  );
//		$("#recursos_quantidade").append(
//		"<input type='hidden' id = 'recursoQuantidade' value="+ $(this).find("#recurso").html()+","+$(this).find("#quantidade").html()+">"			
//		);
//		
//		});		
//		
//		for(i = 0; i<array.length; i++){
//		
//		alert(array[i]);
//		
//		}
//       			
//       	window.location.assign("emprestimos_solicitar_teste.asp?recursos="+array.join("."))
//
//		});
		
	});
</script>
     
<script language="javascript" type="text/javascript">
	var qtd_recursos = 0;
	var array  = new Array();
 
	$(document).ready(function() {
		// Remover linha da tabela
		$('#tabela').on('click', '#X', function(){
			$(this).parent().parent().remove(); 
			qtd_recursos--;
			if(qtd_recursos == 0){
				$("#nenhum").show();
				$("#tabela").hide();
			}
		});
		
		// Spinner
		var spinner = $( "#spinner" ).spinner({
			spin: function( event, ui ) {
				if ( ui.value < 0 ) {
					$( this ).spinner( "value", 0 );
					return false;
				}
			}			
		});
		
		
		//Clicar em Solicitar
		$(document).on("click","#solicitar", function(){
			var qt;
		
			if($("#perfil_emprestimo").val()=="False"){
				alert("Você não tem permissão para solicitar um empréstimo.")
				return false;
			}	

			qt = 0;
			$(".linha").each(function(){
				qt = qt + 1;
			});
			if (qt==0){
				alert("Selecione o recurso que deseja solicitar.");
				return false;
			}

			if($("#local").val()==""){ 
				alert("Selecione um local");
				return false;
			}

			if($("#responsavel").val()==""){ 
				alert("Escolha um responsável");
				return false;
			}

			solicitar = window.confirm("Confirmar solicitação?");
		
			if(solicitar){
				$(".linha").each(function(){
					valor = $(this).find("#recurso").val()+":"+$(this).find("#quantidade").html();
					//array.push(); 
					$("#teste").append("<input type='hidden' value="+valor+" id='recurso_quantidade' name='recurso_quantidade'>");
				});
			
	
				$.ajax({
					type: "POST",
					url: 'emprestimos_solicitar.asp',
					data:  $("#formulario").serialize(),
					success: function (data) {
						alert("Solicitação realizada com sucesso.");
						window.location.assign("emprestimos.asp");
					},	
					error: function (data) {
						alert("Erro na gravação da solicitação.");
					},	
				});
				
				//formulario.submit();
				
				
			} else{
				return false;
			}
		});// fim solicitar	
	});
	
	$(function() {
		var header = false;
		$( "#adicionarRecurso" ).click(function() {
			$("#tabela").show();

			var recurso = $("#recursos option:selected").text();
	  	 	var codRecurso = $("#recursos option:selected").val();
		 	var quantidade = $("#spinner").val();

			if(quantidade == 0){
				alert("A quantidade de recursos não pode ser zero.");
			} else { 
				$("#nenhum").hide();
				qtd_recursos++;
				if(header===false){
					$( "#tabela" ).append( "<tr><td>Recurso</td> <td>Quantidade</td> <td width='5%'> </td></tr>");
					header=true;
				} 

				$( "#tabela" ).append(
					"<tr class='linha' id='linha'>" +
					"<td ><input type='hidden' value="+codRecurso+" id='recurso' class='recurso'>" + recurso + "</td>" +
					"<td class='quantidade' id='quantidade'>" + quantidade + "</td>" +
					"<td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td>" +
					"</tr>");					
				}			
			});				
	});
</script>
  
<!-- fecha efeito da janela de ajuda -->
</head>
<body>

	<div class="teste2">
		<!--fundo azul do meio-->
		<!-- #INCLUDE FILE ="topo.asp" -->
		<%
			Perfil_Acesso("6") 
			if not  perfil_acesso_siiag then
				response.Redirect ("consultar_emprestimos.asp")
			end if
        %>
  		<div class="corposite">
    		<!--corpo-->
    		<div class="container">
      			<div class="conteudo2">
      				<div class="titulosModulos" ><span >RESERVA DE EQUIPAMENTOS</span> </div>
        				<div class="usuariodiv" style=" min-height:515px;">
          					<div id='cssmenu'>
            					<ul>
									<%			
									response.write "<li class='active'><a href='emprestimos.asp'><span>Solicitar</span></a></li>"
									if tem_acesso("27") then
										response.write "<li class='inactive'><a href='consultar_emprestimos.asp'><span>Consultar</span></a></li>"			  
									end if			
									%>
            					</ul>
          					</div>
                        </p>
                        <div id='submenu'>
                            <ul>
                                <!--<li><a href='index.html'><span>Termo de Responsabilidade</span></a></li>-->
                                <!-- <li id="opener"><a href='#'><span>Ajuda</span></a></li>-->
                            </ul>
                        </div>
                        <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
                            <legend><span class="titulos">Solicitar Reserva de Equipamentos</span></legend>
                            <p class="paragrafoteste">     
                                <form name="formulario" id="formulario" action="emprestimos_solicitar.asp" method="post" enctype="application/x-www-form-urlencoded">       

                                    <label> Recursos:</label>
 
                                    <select class='form-select' name='recursos' id='recursos' style="margin-left:23px">
									<%
                                        strQuery = "select CO_RECURSO, DE_RECURSO  from TB_TIPOS_RECURSOS ORDER BY DE_RECURSO; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
                                        set rs=Server.CreateObject("ADODB.RecordSet")
                                        rs.Open strQuery, dados_sys
                                                    
                                        DO UNTIL rs.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
                                            'atribuindo os valores dos campos as variáveis
                                            tipoRecurso=rs("DE_RECURSO")	  
                                            codRecurso=rs("CO_RECURSO")
                                              
                                            response.write "<option value='"& codRecurso &"'>"& tipoRecurso &"</option>" 'imprimindo     
                                          
                                            rs.movenext 'passando para o proximo elemento da tabela
                                            
                                        LOOP
                                        set rs = nothing
                                        'fechando todas as conexoes
                                    %>
                                    </select>
                                    <label for="spinner">Quantidade: </label>
                                    <input style="width:20px;height:20px;font-size:14px;" id="spinner" name="quantidade" value=0>
                                    <input  name="adicionarRecurso" class="myButton" type="button"  value="Incluir" id="adicionarRecurso" style="padding-right:10px; padding-left:10px; margin:14px; padding-top:1px; padding-bottom:1px;font-size:14px;"/>

                                    <div class="tabela" style="margin-left:9.9%; margin-bottom:1%; width:46%" >
                                    <p align="center" id="nenhum" > Nenhum recurso incluído. </p>
                                    <table  name="tabela" id="tabela" width="40%" >
        
                                    </table>
                                </div>
                                <table>
                                    <tr>
                                        <td>
                                            <label> Local:</label>
                                        </td>
                                        <td>
                                            <select class="form-select" name='local' id="local" width="68">
                                                <option value="">Selecione um Local</option>
                                                <%
                                                    strQuery = "select CO_LOCAL, DE_LOCAL  from TB_LOCAL where co_unidade = "& request.Cookies("co_usuario_unidade_siiag") &" and ativo = 1 ORDER BY DE_LOCAL; " 
                                                    'set objConn = server.CreateObject("ADODB.Connection") 
                                                    'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                                                    'objConn.open dados_sys
                                                    set Ls=Server.CreateObject("ADODB.RecordSet")
                                                    Ls.Open strQuery, dados_sys
                                                    
                                                    DO UNTIL Ls.eof 
                                                        descricaoLocal=Ls("DE_LOCAL")
                                                        codigoLocal=Ls("CO_LOCAL")
                                                    
                                                        response.write "<option value='"& descricaoLocal &"'>"& descricaoLocal &"</option>" 
                                                        Ls.movenext 
                                                    LOOP
                                                    
                                                    set Ls = nothing
                                                    set objConn = nothing 
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <label>Respons&aacute;vel:</label>
                                        </td>
                                        <td>
                                            <input name="responsavel" class="form-field" id="responsavel" type="text"  maxlength="100" style="width:428px" />
                                            <input type="hidden" name="co_responsavel"  id="co_responsavel"  />          
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <label>Per&iacute;odo:</label>
                                        </td>
                                        <td>
                                            <input  name="periodo_inicio" id="periodo_inicio" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>" >
                                            <input id="horario_inicio" name="horario_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" style="height:20px;" /> &nbsp;<label>a</label>&nbsp;<input  name="periodo_fim" id="periodo_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>" />
                                            <input id="horario_fim" name="horario_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="00:00" style="height:20px;" />
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                            <label >Observa&ccedil;&otilde;es:</label>
                                        </td>
                                        <td>
                                            <textarea class="form-field" name="observacoes" cols="50" rows="5" style="max-width:430px;min-width:430px;max-height:50px;min-height:50px;"></textarea>       
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <br />
                                            <div id="recursos_quantidade">
       
                                            </div>
                                            <div align="center">
                                                <input name="solicitar" class="myButton" type="button" value="Solicitar" id="solicitar" name="solicitar"/>
                                            </div>
                                        </td>
                                    </tr>
                                </table>	
                                <br />
                                <div id="teste"></div>
                                <div id="documentos_quantidade"></div>
                            </form>
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