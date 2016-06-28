<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Reparos</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="scripts/jquery.ui.draggable.js"></script>
<script src="scripts/jquery.ui.sortable.js"></script>

<%
'perfil CONSULTA
 Perfil_Acesso("37") 
  if not  perfil_acesso_siiag then
	  response.Redirect ("acesso_negado.asp")
  end if
  acesso_editar       = tem_acesso_cookie("38")	' REPAROS editar
  response.write "<input type='hidden' id = 'perfil_reparos_editar' value=" & acesso_editar  & ">"
  %>

	
<style>
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
	
	.ui-dialog .ui-dialog-title {
	text-align: center;
	width: 100%;
	color: #666;
    }
</style>    
<!-- efeito da janela de ajuda -->

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
		
		$(document).ready(function() {
			$( "#info_show" ).dialog({
			  autoOpen: false,
			  height: 'auto',
			  width: 600,
			  modal: true,
			  resizable: true,
			  autoResize:true
			});
		});
		
		$('.cancelar').on("click", function(){
			$("#divCancelamento" ).dialog({
				modal: true,
				dialogClass: "dialogo",
				closeText: "Fechar",
				width:'auto'
			});
			$("#codigoCancelamento").val($(this).parent().parent().find("#co_reparo").val());
			$("#divCancelamento").dialog("open");
		});
		
		$('#botaoCancelar').on("click", function(){
			if(window.confirm("Confirmar pedido de cancelamento?")){
				var codigo = $("#codigoCancelamento").val(),
					motivo = $("#motivoCancelamento").val();
				
				if(motivo == ""){
					alert("Informe o motivo do cancelamento.");
					return false;
				}
				
				$.ajax({
					url: "cancelar_demanda.asp",
					data:{
						tipo:"reparo",
						codigo:codigo,
						motivo:motivo
					},
					success: function(data) {
						alert("Solicitação de cancelamento concluída com sucesso.");
					},
					error: function(data) {
						console.log(data.responseText);
						alert("Erro ao solicitar cancelamento.");
					}
				});
			}
		});
		
		
		$(document).on("click", ".edit", function(){
	    //alert($("#perfil_reparos_editar").val());
		if($("#perfil_reparos_editar").val()=="False"){
				alert("Você não tem permissão para editar.");
				return false;
		}
		
		var linha = $(this).parent().parent();
		var co_reparo = linha.find("#co_reparo").val();
	
		//alert(co_reparo);
		//window.location.assign("reparos_consultar_edicao.asp?co_reparo="+co_reparo);
		
		$.ajax({
	      
		  
		  
			url: "reparos_consultar_edicao.asp?co_reparo="+co_reparo,
			success: function(data){
			  $("#info_show").html(data);
			  $("#info_show").dialog("option", "title", "Informações Detalhadas");
			  $("#info_show").dialog("open");
			},
			error: function(data){
				alert("Ocorreu um erro na consulta.");  
			}
       })  

	
	});
	});
</script>

<script>
$(document).ready(function() {
		$('.pesquisar').on('click',function(){
			var situacao = $("#situacao").val();
			var nome =  $("#nomeResponsavel").val();
			var data_inicio = $("#data_inicio").val();
			var data_fim = $("#data_fim").val();
			var tipo = $("#tipo").val();

			window.location.assign("reparos_consultar.asp?dataSolicitacaoInicial="+data_inicio+"&dataSolicitacaoFinal="+data_fim+"&tipo="+tipo+"&situacao="+situacao+"&no_responsavel="+nome);
		});
	});
</script>

<script>
	$(document).ready(function() {
		$('#btnOrdenar').on('click',function(){
			document.getElementById('visuOrdenacao').style.display = "";
			document.getElementById('inputPrioridade').style.display = "";
		});
	});
</script>

<script type="text/javascript" language="javascript">

	$(document).ready(function(){

				//Ao digitar executar essa função
				$("#nomeResponsavel").focus().autocomplete({
					
					source: "autocompletar_nome.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nomeResponsavel" ).val( ui.item.nome);				
					return false;
					}
				  });
	
			});
	</script>

<script type="text/javascript" language="javascript">

	
</script>
<%
    co_reparo = request("co_reparo")
	situacao = Request("situacao")
	data_inicio= Request("data_inicio")
	nomeSolicitante = Request("nomeSolicitante")
	coSolicitante = Request("coSolicitante")
  
%>
</head>
<body>
	<div class="teste2">
		<!--fundo azul do meio-->
        
		<!-- #INCLUDE FILE="topo.asp" -->
	
		<div class="corposite">
			<!--corpo-->
  			<div class="container">
    			<div class="conteudo2">
				    <div class="titulosModulos" ><span >REPAROS</span> </div>          
      				
      				<p>
      					<div id='cssmenu' >
        					<ul>
                            <li ><a href='reparos.asp'><span>Solicitar</span></a></li>						
						    <li class='active'><a href='reparos_consultar.asp'><span>Consultar</span></a></li>
								
     						</ul>
          				</div>
          			</p>
  
        			<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:450px;">
          			<legend><span class="titulos" >Listar Demanda</span></legend>
           <div id="info_show" ></div>
          				<table border="0" width="100%">
                       
                            <tr> 
                                <td width="">
                                     <label>Situação </label>
                                </td>
                                <td width="">
                                    <select class="form-select" style="max-width:150px; min-width:150px;" id="situacao">
                                    <option value="">Todos</option>
                     
                                            <%  
												'#Alterado em 08/12/2015 (usando agora a TB_SITUACOES original)
                                                Query4 ="SELECT * FROM TB_SITUACOES" 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys ="Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set ds=Server.CreateObject("ADODB.RecordSet")
                                                ds.Open Query4, dados_sys
                                                DO UNTIL ds.eof
                                                    co_sit=ds("CO_SITUACAO")
                                                    de_sit=ds("DE_SITUACAO")
                                                    response.write "<option value='" & co_sit  & "'   "
                                                    if cstr(situacao) = cstr(co_sit)  Then response.Write "selected='selected'" END IF											
                                                    response.write " > " & de_sit & "</option>"							
                                                    ds.movenext
                                                LOOP
                                                set ds = nothing
             
                                            %> 
              
                                        </select>
                                   </td>
                                               <td width="">
                                     <label>Tipo de reparo: </label>
                                </td>
                                
                                <td width="">
                                    <select class="form-select" style="max-width:150px; min-width:150px;" id="tipo">
                                    <option value="">Selecione...</option>
                     
                                            <%  
                                                Query4 ="SELECT * FROM TB_TIPO_REPAROS" 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set ds=Server.CreateObject("ADODB.RecordSet")
                                                ds.Open Query4, dados_sys
                                                DO UNTIL ds.eof
                                                    co_sit=ds("CO_TIPO")
                                                    de_sit=ds("DE_TIPO")						
                                                    response.write "<option value='" & co_sit  & "'   "
                                                    if cstr(situacao) = cstr(co_sit)  Then response.Write "selected='selected'" END IF											
                                                    response.write " > " & de_sit & "</option>"							
                                                    ds.movenext
                                                LOOP
                                                set ds = nothing
             
                                            %> 
              
                                        </select>
                                   </td>
          						</tr>
                                <tr>
          						<td width=""><label>Nome do Solicitante: </label></td>   
								<td width="">
                                   <input  type="text" class="form-field" id="nomeResponsavel" name="nomeResponsavel" size="70"/>                        
                                </td>
      
       							<td width="">
                                	<label>Data da solicitação: </label>
                                </td> 
       							<td width="">
                                	 <input name="data_inicio" id="data_inicio" class="datepicker" type="text" size="10" maxlength="10" style="max-width:70px; min-width:70px;"/> a
                                    <input name="data_fim" id="data_fim" class="datepicker" type="text" size="10" maxlength="10" style="max-width:70px; min-width:70px;"/>
                                </td>   
                                </tr>
                                <tr>       
          						<td width="" >
                                	<input type="submit" class='myButton pesquisar' style="padding-left:3px;padding-right:3px;margin-left:10px" name="btnPesquisar" id="btnPesquisar"  value="Pesquisar" /> 
                                </td>
          					</tr>
          				</table>
          
          				<br/>
          				<br/>
          				<div class="tabela" >
                             <!-- #INCLUDE FILE="reparos_consultar_con.asp" -->
          				</div>
        			</fieldset>  
				<%'end if%>
    			</div>
                    <%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Reparo editado com sucesso.'); </script>")
	
		end if
		
		%>
  			</div>
  			<!--fim do corpo-->
  			<!-- #INCLUDE FILE="rodape.asp" -->
		</div>
	</div>
	<!--teste-->
<div id="divCancelamento" class="msg-dialog" style="display:none;" title="Cancelar">
	<input type="hidden" id="codigoCancelamento"/>
    <label>Motivo do cancelamento:</label><br />
    <textarea  class="form-field" name="motivoCancelamento" id="motivoCancelamento" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px; margin-left:5px"></textarea><br />
    <input  style="margin-top:7px;margin-left:5px;" name="botaoCancelar" id="botaoCancelar" class="myButton" type="button" value="Cancelar"/>
</div>
</body>
</html>
