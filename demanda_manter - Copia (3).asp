<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Controle de Demandas</title>
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
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<style>
	.ui-datepicker {
		font-size:12px;
	}
	.datepicker {
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
		font-family: Arial, sans-serif;
		font-size: 0.8em;
	}
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	.ui-menu .ui-menu-item a {
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
		font-family: Arial, sans-serif;
		font-size: 0.8em;
	}
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	.ui-menu .ui-menu-item a {
		height:14px;
		font-size:13px;
	}
	.ui-autocomplete {
		height:200px;
		overflow-y:scroll;
		overflow-x:hidden;
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
	});
</script>

<script>
	$(document).ready(function() {
		$('.X').on('click',function(){
				var co_andamento = $(this).parent().parent().find("#co_andamento").val();
				var co_demanda = $("#co_demanda").val();
				var confirmacao = window.confirm("Tem certeza que desejar excluir este andamento?");	
					
				if (confirmacao == true){ 
					//alert("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"&demanda="+co_demanda+"");
					window.location.assign("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"&demanda="+co_demanda+"");
					//window.open("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"");
				}
		});
		
		$('.X').on('click',function(){		
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
		});

		$('.lista_arquivo').on('click',function(){
				var co_arquivo = $(this).parent().parent().find("#co_seq").val();
				
				//alert("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"&demanda="+co_demanda+"");
				window.location.assign("demanda_download_arquivo.asp?file="+co_arquivo+"");
				//window.open("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"");
		});

		$('.download').on('click',function(){
				var co_arquivo = $(this).parent().parent().find("#co_seq").val();
				
				//alert("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"&demanda="+co_demanda+"");
				window.location.assign("demanda_download_arquivo.asp?file="+co_arquivo+"");
				//window.open("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"");
		});

		$('.download_arquivo_historico').on('click',function(){
				var co_arquivo = $(this).parent().parent().find("#co_seq").val();
				
				//alert("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"&demanda="+co_demanda+"");
				window.location.assign("demanda_download_arquivo_historico.asp?file="+co_arquivo+"");
				//window.open("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"");
		});


		$('.excluir_arquivo').on('click',function(){
				var co_arquivo = $(this).parent().parent().find("#co_seq").val();
				
				//alert("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"&demanda="+co_demanda+"");
				//window.location.assign("demanda_excluir_arquivo.asp?file="+co_arquivo+"");
				//window.open("demanda_andamento_exclusao.asp?co_andamento="+co_andamento+"");
				var confirmacao = confirm('Confirma a exclusão do arquivo?');
				
				if (confirmacao){
					$.ajax({
						method: "POST",
						contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
						url: "demanda_excluir_arquivo.asp?file="+co_arquivo, // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
						dataType: "html", // TIPO DE DADOS DE RETORNO
						//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
						beforeSend: function() { // ANTES DA REQUISIÇÃO
	
						},
						complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
	
						},
						success: function(data) { // CASO RECEBA RESPOSTA COM SUCESSO
							//$('#retorno').html(data);
							location.reload();
						},
						error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
							alert("Erro ao excluir arquivo.");
						}
					})
				}
				
		});

		$('#bt_inconforme').on('click',function(){
		
			//============================================[DIÁLOGO]===========================
			// A div com o conteúdo da janela está lá embaixo
			$( "#div_enviar_inconforme" ).dialog({
				modal: true, // Escurecer o fundo ou não
				dialogClass: "dialogo", //classe para formatar via CSS
				closeText: "Fechar",
				close: function( event, ui ) { 
					},
				height:250,
				width:500,
			});			
			//================================================================================			
	
		});


		
	});
</script>

<script>
	$(document).ready(function() {

	$('#btnSalvar').on('click',function(){
		var codigo = $("#demandas_situacoes").val();
	
		$(".estagiarios").each(function(){
			var matricula = $(this).find("#matriculaEstagiario").html();
			$("#divEstagiarios").append("<input type='hidden' name='v_estagiarios' id='v_estagiarios' value="+matricula+" />");
			
		});
		if (codigo==2){
			if ($("#data_conclusao").val() == '')	{
				alert('Digite uma data de previsão conclusão');
				return false;
			}
			
			if ($("#matResponsavel").val() == '')	{
				alert('Selecione um responsável');
				return false;
			}
			
		}
		if (codigo==7){
			if ($("#data_prev_inicio").val() == '')	{
				alert('Digite uma data de previsão de inicio');
				return false;
			}
		}


		
		$("#formulario").submit();

	});


	$('#editarDesc').on('click',function(){
		
		$("#descricao").removeProp("readonly");
		$("#descricao").focus();
		$("#descricao").css("background-color","#fae3bc");
		$("#salvarDesc").show();
		$("#editarDesc").hide();
	});

	$('#salvarDesc').on('click',function(){

		$("#form_editar").submit();

	});



});
	
</script>
<script>

	$(document).ready(function() {
	

		$(".info").hide();
		var codigo = $("#demandas_situacoes").val();
		if(codigo == 2 ){
			$(".tabela_5").show();
			$(".info").show();
		}
	});
	
</script>
<script>
	$(document).ready(function() {
		$('#demandas_situacoes').on('change',function(){

	
			var codigo = $("#demandas_situacoes").val();
		
				if (codigo==2 ){
					$(".tabela_5").show();						
					$(".info").show();
					
				}
				else{
					if( codigo == 7){
						$(".tabela_5").show();					
						$(".info").hide();
						$(".info2").show();
					}
					else
					{
						$(".tabela_5").show();
						$(".info").hide();
						$(".info2").hide();
						$("#btnSalvar").show();
					}
				}
		});
	});
	
</script>
<script>
	$(document).ready(function() {
		$('#data_conclusao').on('change',function(){
	
			var data = $("#data_conclusao").val();
		
			$("#btnSalvar").show();	

		});
		$('#addResponsavel').on('click', function(){
			$(".cabecalhoTabela").show();
			//alert($("#select1 option:selected").text());
			$("#tabelaResponsaveis").append("<tr><td><img src='imagens/delete_16x16.png' class='X' style='cursor:pointer'/></td><td>"+$("#select1 option:selected").val() +"</td><td>"+ $("#select1 option:selected").text()+"</td></tr>");
		
		});
		$('#addEstagiario').on('click', function(){
		
			if($("#selectEstagiarios option:selected").val() == ""){
			
				alert("Escolha um estagiário.");
				return false;
			}
	
			$(".cabecalhoTabela").show();
			//alert($("#select1 option:selected").text());
			$("#tabelaEstagiarios").append("<tr class='estagiarios'><td><img src='imagens/delete_16x16.png' class='X' style='cursor:pointer'/></td><td id='matriculaEstagiario' >"+$("#selectEstagiarios option:selected").val() +"</td><td>"+ $("#selectEstagiarios option:selected").text()+"</td></tr>");
		
		});

		$('#bt_finalizar').on('click', function(){
			var confirma = false;			
			confirma = window.confirm('Finalizar a demanda?');
			
			if (confirma){
				formulario_teste.co_situacao.value = '3';		
				formulario_teste.submit();
			}
	
		});

		$('#bt_enviar_inconforme').on('click', function(){
			var confirma = false;			
			confirma = window.confirm('Confirmar o envio?');
			
			if (confirma){
				formArquivos.co_situacao.value = '9';	
				$("#div_enviar_inconforme").dialog('close');
				formArquivos.submit();
			}
	
		});


	});
	

</script>
</head>
<body>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <%	
  	demanda = request("demanda")
	'Chama a subrotina para verificar o perfil
	'Perfil_Acesso("15")
	Perfil_Acesso_Cookie("15")
	
   
	query = "SELECT a.co_demanda, B.NO_TIPO, C.NOME, A.DESCRICAO, A.CONCLUSAO_DATA_PREVISTA, D.CO_SITUACAO, D.DE_SITUACAO, A.SOLICITACAO_MATRICULA, E.NO_NOME, F.NO_GS, A.DATA_PREVISAO_INICIO, A.INICIO_DATA, A.TIPO_DEMANDA, A.CO_COORD_DEMANDANTE, G.NO_GS AS NO_COORD_DEMANDANTE "
	query = query & " FROM TB_DEMANDAS A "
	query = query & " INNER JOIN TB_DEMANDAS_TIPOS B ON A.TIPO_DEMANDA = B.CO_TIPO "
	query = query & " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO ULT ON A.CO_DEMANDA = ULT.CO_DEMANDA "
	query = query & " INNER JOIN TB_APLICATIVOS C ON A.CO_APLICATIVO = C.CO_APLICATIVO "
	query = query & " INNER JOIN TB_DEMANDAS_SITUACOES D ON ULT.CO_SITUACAO = D.CO_SITUACAO "
	query = query & " INNER JOIN TB_USUARIOS E ON A.SOLICITACAO_MATRICULA = E.CO_MATRICULA "
	query = query & " INNER JOIN TB_GS F ON E.CO_GS = F.CO_GS "
	query = query & " LEFT JOIN TB_GS G ON A.CO_COORD_DEMANDANTE = G.CO_GS "
	query = query & "  WHERE A.CO_DEMANDA = "& demanda &" "
	
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open query, dados_sys
	co_situacao = rs("co_situacao")
	
	'***** HISTORICO DE ANDAMENTOS ******
	query = "SELECT * from VW_DEMANDAS_HISTORICO where co_demanda = " & demanda & " order by dt_inclusao, co_sequencial "
	set rs_hist=Server.CreateObject("ADODB.RecordSet")
	rs_hist.Open query, dados_sys
	do while not rs_hist.eof
		co_situacao_ultimo =  rs_hist("co_situacao")
		rs_hist.movenext
	loop
	rs_hist.movefirst
	'*************************************
			
%>


  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
		<%
        if not perfil_acesso_siiag then
            response.Write("O seu perfil não permite o acesso a este módulo")
        else
        %>   
        <!-- <div class="titulosModulos" ><span >ESTOQUE</span> </div>  -->
        <p>
        <div id='cssmenu' >
          <ul>
            <li ><a href='demanda_solicitar.asp'><span>Solicitar Demanda</span></a></li>
            <li ><a href='demanda_consultar.asp'><span>Painel de Demandas</span></a></li>
            <li ><a href='demanda_listar.asp'><span>Consultar Demandas</span></a></li>
            <li class='active'><a href='demanda_manter.asp?demanda=<%=demanda%>'><span>Detalhe da Demanda</span></a></li>
          </ul>
        </div>
        </p>
        <div id='submenu'>
          <ul>
            <!--<li><a href='#'><span>Ajuda</span></a></li>-->
          </ul>
        </div>
		 <% if perfil_acesso_admin_siiag then  %>
                <table width="100%" border="0">
                <tr>
                <%
                 primeira = true
                 do while not rs_hist.eof
                    if not primeira then %>
                    <td align="center"> <img src="imagens/etapa_seta.png" width="20" height="15" /></td>
                <%
                    end if
                %>
                    <td align="center"> <img src="imagens/etapa_demanda_aguard_analise.png" width="50" height="50" title="<%=rs_hist("dt_inclusao") & " - " & rs_hist("co_matricula")%>" /><br><label style="font-size:12px;"><%=rs_hist("de_situacao")%><br><%=rs_hist("dt_inclusao")%></label>  
                    </td>
        
                <%
                    primeira = false
                    rs_hist.movenext
                loop
                %>
                </tr>
                </table>
		<% end if %>

        <% 
			if co_situacao_ultimo = "8" and ( trim(cstr(rs("SOLICITACAO_MATRICULA"))) = trim(cstr(request.Cookies("co_usuario_siiag"))) or perfil_acesso_admin_siiag ) then %>
		        <br>
                <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
                <legend><span class="titulos" >Fase de Teste</span></legend>
                <form action='demanda_manter_con.asp' id='formulario_teste' >
                <input type="hidden" name="co_demanda" id="co_demanda" value="<%=demanda%>" />
                <input type="hidden" name="demandas_situacoes" id="co_situacao" value="" />


                <table border="0" width="450px"  align="center">
                  <tr>
                    <td colspan="1" align="center" valign="middle"><input type="button" class="myButton" id="bt_finalizar" value="FINALIZAR DEMANDA" /></td>
                    <td colspan="1" align="center"><input type="button" class="myButton" value="COMUNICAR INCORFORMIDADE" id="bt_inconforme" />
                    <textarea class=" form-field" id="Motivo" name="Motivo" style="display:none;" ></textarea>
                    </td>                    
                  </tr>
                </table>
                
            </form>
            </fieldset>
            <BR>
		<%end if%>
        
        <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos" >Informa&ccedil;&otilde;es gerais da demanda</span></legend>
		<form name="form_editar" id="form_editar" action="demanda_manter_editar_con.asp" method="post" >
        <input type="hidden" name="co_demanda" id="co_demanda" value="<%=demanda%>" />
        <table border="0" width="750px;">
          <tr>
            <td width="400" colspan="2" ><label> <strong> Dados do Solicitante: </strong> </label></td>
          </tr>
          <tr>
            <td width="150" colspan="1" >
            	<label>Matr&iacute;cula/Nome: </label>
            </td>
            <td width="400" colspan="1" >
<input class="form-field" name="nome" id="nomeSolicitante" type="text" size="8" value="<%=rs("SOLICITACAO_MATRICULA") %>" readonly="readonly" style=" width:60px;" /> - <input class="form-field" name="nome" id="nomeSolicitante" type="text" size="20" value="<%=rs("NO_NOME") %>" readonly="readonly" style=" width:310px;" />
            </td>
          </tr>
          <tr>
            <td width="150"><label>Coordena&ccedil;&atilde;o: </label></td>
            <td><input class="form-field" name="nome" id="nomeSolicitante" type="text" size="20" value="<%=rs("NO_GS") %>" readonly="readonly" style=" width:400px;" /></td>
          </tr>
          <tr>
            <td width="150"><label>Coordena&ccedil;&atilde;o Demandante: </label></td>
			<td><input class="form-field"  id="co_coord_demandante" name="co_coord_demandante" type="text" size="20" value="<%=rs("NO_COORD_DEMANDANTE") %>" readonly="readonly" style=" width:400px;" /></td>
          </tr>

          <tr>
            <td width="400" colspan="2"><br></td>
          </tr>
		</table>
         <table border="0" width="750px;">          
          <tr>
            <td width="400" colspan="2" ><label> <strong> Dados da Demanda: </strong></label></td>
          </tr>
          <tr>
            <td width="200"><label>Código:</label></td>
            <td width="27" style="margin-top:5px; max-width:50px; min-width:50px; " class="form-field" name="nome" id="codigoDemanda" type="text" size="3" maxlength="3"><input type="hidden" name="codigo_demanda" id="codigo_demanda" value="<%=rs("co_demanda")%>"  /><%= rs("co_demanda") %> </td>
          </tr>
          <tr>
            <td width="150"><label>Tipo:</label></td>
            <td width="27" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100"><input type="hidden" name="tipo_demanda" id="tipo_demanda" value="<%=rs("tipo_demanda")%>"  /><%= rs("NO_TIPO") %> </td>
          </tr>
          <tr>
            <td width="150"><label>Nome do Aplicativo:</label></td>
            <td width="27" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" ><%= rs("NOME") %> </td>
          </tr>
          <tr>
            <td width="150"  valign="top"><label>Descrição: </label></td>
            <td width="27" colspan="2"><textarea readonly="readonly"  style="margin-top:5px; max-width:500px; min-width:500px; max-height:100px;min-height:100px;" class="form-field" name="descricao" id="descricao" size="60" rows="5" cols="50"><%=rs("DESCRICAO") %></textarea>
            </td>
          </tr>
		  <tr>
          <td></td>
          <td colspan="1" align="center">
          <%if co_situacao = "1" or perfil_acesso_admin_siiag then %>
	          <button id='editarDesc' class="myButton" type="button">Editar descrição</button><button id='salvarDesc' class="myButton" type="button" style="display:none;">Salvar descrição</button>
          <%end if%>
          </td>
          </tr>
		  <tr>
          <td></td>
          </tr>

          <tr>
            <td width="400" colspan="3" ><label> <strong>Arquivos anexados:</strong></label></td>
          </tr>
          <tr>
          <td></td>
          <td colspan="1">
             <div class='tabela' style=" border:#000000 solid 0px;">
				<%
                query = "SELECT * FROM TB_DEMANDAS_ARQUIVOS WHERE CO_DEMANDA = " & demanda & ""
                
                set res=Server.CreateObject("ADODB.RecordSet")
                    res.Open query, dados_sys
                    
                if res.eof then
                    response.write "Nenhum arquivo foi anexado a esta demanda."
                else
                %>
                    <label></label>
                    <table style="margin-top:4px; width:500px;"  border="0">
                        <tr>
                            <td style="width:320px;" >Nome</td>
                            <td style="width:70px;" >Matrícula</td>
                            <td style="width:100px;" >Envio</td>
                            <td style="width:10px;" ></td>
                        </tr>
                        <%
                        do while not res.eof 
                        %>
                            <tr>
                                <td>
                                    <input type="hidden" id='co_seq' name='co_seq' value="<%=res("co_sequencial")%>" />
                                    <img src="imagens\down_16x16.png" class="download" style="cursor:pointer;" title="download arquivo"  />
                                    <label class="lista_arquivo" style="cursor:pointer;" title="download arquivo"><%=res("no_arquivo")%></label>
                                </td>
                                <td><%=res("co_matricula")%></td>
                                <td><%=res("dt_inclusao")%></td>
                                <td>
						        <%if co_situacao = "1" or perfil_acesso_admin_siiag then %>
	                                <img class="excluir_arquivo" src="imagens\delete_16x16.png" style="cursor:pointer;" title="deletar arquivo" />
                                <% end if %>
                                </td>
                            </tr>
                       <%
                            res.movenext
                        loop
                        res.close
                       %>
                    </table>
                <%
                end if
                %>
       		 </div>
			<%if not(co_situacao = "3" or co_situacao = "4" or co_situacao = "5") then %>
                <iframe src="demanda_manter_arquivos.asp?demanda=<%=demanda%>" scrolling="no"  frameborder="0" width="auto" height="auto" ></iframe>
            <%end if%>
          </td>
         </tr>
        </table>
		</form>
       </fieldset>
       
        <% if perfil_acesso_admin_siiag then %>
		        <br>
                <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
                <legend><span class="titulos" >Incluir Andamento</span></legend>
                <form action='demanda_manter_con.asp' id='formulario' >
                <input type="hidden" name="co_demanda" id="co_demanda" value="<%=demanda%>" />

                <table border="0" width="600px">
                  <tr>
                    <td width="210"><label>Situa&ccedil;&atilde;o: </label></td>
                    <td width="390" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" >
                    <select class="form-select" style="max-width:380px; min-width:380px;;margin-top:5px;height:auto;" id="demandas_situacoes" name='demandas_situacoes'>
                        <% 
							querySituacao = "SELECT * FROM TB_DEMANDAS_SITUACOES ORDER BY DE_SITUACAO"
							
							  set ss=Server.CreateObject("ADODB.RecordSet")
							  ss.Open querySituacao, dados_sys
								
								do while not ss.eof 
									if ss("CO_SITUACAO") = rs("CO_SITUACAO") then 
										response.write "<option value="& ss("CO_SITUACAO")&" selected='selected'> "& ss("DE_SITUACAO")&"</option>"
									else
										response.write "<option value="&ss("CO_SITUACAO")&"> "&ss("DE_SITUACAO")&"</option>"
									end if
									ss.movenext	
								loop
								ss.close
								set ss = nothing
                        %>
                      </select></td>
                  </tr>
                  <tr>
               		<td valign="top"><label>Motivo/Observação:</label></td>
                      <td>
						<textarea class=" form-field" id="Motivo" name="Motivo" style="width:370px; height:50px;"></textarea>
                      </td>
                  </tr>
                
                  <!-- <input />-->
                </table>
                
                <table border="0" width="600px" class="tabela_5"  <% if rs("co_situacao") <> 2 then response.write " style='display:none;' " %>>
                  <tr>
                    <td colspan="4">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="4">&nbsp;</td>
                  </tr>
                  <div >
                      <tr class="info2">
                        <td width="200px"  id="label1"><label>Data Prevista para In&iacute;cio: </label></td>
                        <td   size="10" maxlength="10" ><input name="data_prev_inicio" id="data_prev_inicio" type="text" class="datepicker" size="10"  value="<%=rs("DATA_PREVISAO_INICIO")%>" /></td>
                      </tr>
                      <tr class="info">
                        <td   id="label1"><label>Data de In&iacute;cio: </label></td>
                        <td   size="10" maxlength="10" ><input name="data_inicio" id="data_inicio" type="text" class="datepicker" size="10" readonly="readonly" value="<%=rs("INICIO_DATA")%>" /></td>
                      </tr>
                      <tr class="info">
                        <td   id="label1"><label>Data Prevista para Conclus&atilde;o: </label></td>
                        <td   size="10" maxlength="10" ><input name="data_conclusao" id="data_conclusao" type="text" class="datepicker" size="10"  value="<%=rs("CONCLUSAO_DATA_PREVISTA")%>" /></td>
                      </tr>
                      <tr class="info">
                        <td   id="label2"><label>Respons&aacute;vel TI:</label></td>
                        <td >
                        <select class="form-select" style="margin-top:5px;max-width:310px; min-width:310px;" id="matResponsavel" name="matResponsavel">
                            <option value=""  id="option1">Selecione o Respons&aacute;vel</option>
                            <%
                                set ss=Server.CreateObject("ADODB.RecordSet")
                                query = "SELECT  TOP 1 mat_responsavel from tb_demandas_responsaveis where co_demanda = " & demanda
                                ss.Open query, dados_sys
                                if not ss.eof then
                                    responsavel = ss("mat_responsavel")
                                else 
                                    responsavel = ""
                                end if
                                ss.close
        
                                query = "SELECT  * from vw_demandas_empregados_ti order by no_nome "
                                ss.Open query, dados_sys
                                
                                do while not ss.eof
                                    Response.Write "<option value = '" & ss("co_matricula") & "' "
                                    if cstr(trim(ss("co_matricula"))) = trim(cstr(responsavel)) then
                                        response.write " selected='selected' "
                                    end if
                                    Response.Write " >" & ss("no_nome") & "</option>"
                                ss.movenext
                                loop
                            %>
        
                            </select>
                          </td>
                          <td>
                          <!--<button id='addResponsavel' class="myButton">Adicionar</button>-->
           
                        </td>
                      </tr>
                            </div>
                      </td></tr>
                       <tr class="info">
                        <td   id="label2"><label>Estagiários:</label></td>
                        <td  style="margin-top:5px;"><select class="form-select" style="margin-top:5px;" id="selectEstagiarios">
                            <option value=""  >Selecione o Estagiário</option>
                            <%
								set ss=Server.CreateObject("ADODB.RecordSet")
                                query = "SELECT  * from vw_demandas_ESTAGIARIOS_ti order by no_nome "
                                ss.Open query, dados_sys
                                
                                do while not ss.eof
                                    Response.Write "<option value = '" & ss("co_matricula") & "' "
                                    Response.Write " >" & ucase(ss("no_nome")) & "</option>"                             
									ss.movenext
                                loop
                                ss.close
                                set ss = nothing
                            %>
                            </select>
                          </td>
                          <td>
                          <img src="imagens/add_16x16.png" id="addEstagiario" style="cursor:pointer; margin-left:5px" />
                          <!--<button id='addEstagiario' class="myButton" type="button">Adicionar</button>-->
           
                        </td>
                      </tr>
                      
                      <tr><td colspan="3">       <div class='tabela info' align="center">
                                    <table id='tabelaEstagiarios' width="300px" style="margin-top:10px">
                                    <tr class="cabecalhoTabela">
                                    <td></td><td width="10%" >Matrícula</td><td>Nome</td>
                                    </tr>
                                    <%
                                    queryEstagiarios = "SELECT MAT_ESTAGIARIO, NO_NOME FROM TB_DEMANDAS_RESPONSAVEIS A INNER JOIN TB_USUARIOS B ON A.MAT_ESTAGIARIO = B.CO_MATRICULA WHERE CO_DEMANDA="&demanda
                                                
                                                set fs=Server.CreateObject("ADODB.RecordSet")
                                                fs.Open queryEstagiarios, dados_sys
                                                    
                                                do while not fs.eof 
                                                
                                                    matricula =  ucase(trim(fs("MAT_ESTAGIARIO")))
                                                    nome = fs("no_nome")
                
                    
                                                    response.write "<tr class='estagiarios'><td><img src='imagens/delete_16x16.png' class='X' style='cursor:pointer'/></td><td id='matriculaEstagiario'>"&fs("MAT_ESTAGIARIO")&"</td><td>"&nome&"</td></tr>"
                                                    fs.movenext	
                                                loop
												fs.close
												set fs = nothing
                                    %>
                                    </table>
         
                            </div></td>
                       </tr>
                  <tr>
                  </tr>
                  <tr>
                    <td colspan="4">
                  </tr>
                  <tr>
                    <td colspan="4">&nbsp;</td>
                  </tr>
                  <tr>
                    <td colspan="4" align="center"><button class='myButton' name="btnSalvar" id="btnSalvar" style="" type="button">Salvar</button>
                    </td>
                  </tr>
                </table>
               <div id='divEstagiarios' >
               </div> 
            </form>
            </fieldset>
		<%end if%>

		<br>
        <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos" >Histórico de Andamentos</span></legend>

		<table name='tabela' class="tabela" style=" width:70%;">
        <tr>
        	<td width='15%'>Data</td>
            <td width='25%'>Situação</td>
            <td width='11%'>Matrícula</td>
            <td width='25%'>Observação</td>
            <td width='5%'></td>
        </tr> 
        <%
			query = "SELECT  * from VW_DEMANDAS_HISTORICO where co_demanda = " & demanda & " order by dt_inclusao desc, co_sequencial desc "
			set ss=Server.CreateObject("ADODB.RecordSet")
			ss.Open query, dados_sys
			do while not ss.eof
				
			
			
		%>
        <tr>
        	<td width='15%'><%=ss("DT_INCLUSAO")%> - <%=FormatDateTime(ss("HR_INCLUSAO"),4)%></td>
            <td width='25%'><%=ss("DE_SITUACAO")%></td>
            <td width='11%'><%=ss("CO_MATRICULA")%></td>
            <td width='25%' style=" text-align:left;">
			<%=ss("OBSERVACAO")%>
            <%
				query = "SELECT  * from TB_DEMANDAS_HISTORICO_ARQUIVOS where co_sequencial_historico = " & ss("co_sequencial") & ""
				set rs_arq=Server.CreateObject("ADODB.RecordSet")
				rs_arq.Open query, dados_sys
				do while not rs_arq.eof
			%>
					<input type="hidden" id='co_seq' name='co_seq' value="<%=rs_arq("co_sequencial")%>" />
					<img src="imagens\down_16x16.png" class="download_arquivo_historico" style="cursor:pointer;" title="download arquivo"  />
					<label class="download_arquivo_historico" style="cursor:pointer;" title="download arquivo"><%=rs_arq("no_arquivo")%></label>
			<%
				rs_arq.movenext
				loop            
			%>
            </td>
            <td width="5%">
            <% if perfil_acesso_admin_siiag then %>
             <img src='imagens\delete_16x16.png' class = 'X' id='X' title='Excluir Andamento' style='cursor:pointer;' /> 
            <input type='hidden' name='co_andamento' id='co_andamento' value='<%=ss("co_sequencial")%>'/>
            <%end if%>
            </td>
        </tr> 
		<%
			
			ss.movenext
			loop
			ss.close
			set ss = nothing
		
		%>
		</table>	        
		<%
		end if
        %>
		</fieldset>
        <br>
      </div>
    </div>
    <!--fim do corpo-->
    <%
				sucesso = request("sucesso")
				
				if sucesso <> "" then
					response.write "<script> alert('demanda editada com sucesso');</script>"
					response.write "<script> window.close();</script>"
				end if
				
			%>
    <!-- #INCLUDE FILE ="rodape.asp" -->
  </div>
</div>


<% if co_situacao_ultimo = "8" then %>
 <!-- DIV QUE VIRA DIALOG -->
<div  align="center" id="div_enviar_inconforme" title="Registrar Inconformidade" class="msg-dialog" style="display:none;">
    <div id="formulario" >
        <form id='formArquivos' name='formArquivos' method="post" enctype="multipart/form-data" action="demanda_enviar_inconformidade.asp">
	    <label>Descreva abaixo a inconformidade encontrada no aplicativo.</label>
        <table border="0" width="400px" >
          <tr>
            <td valign="top" align="center"><br><textarea class=" form-field" id="Motivo_Inconforme" name="Motivo_Inconforme" style="width:370px; height:50px;"></textarea>
            </td>
          </tr>
		<tr><td>
                <input type="hidden" name="co_demanda" id="co_demanda" value="<%=demanda%>" />
                <input type="hidden" name="co_situacao" id="co_situacao" value="" />
                <input type="hidden" name="qtd_arquivo" id="qtd_arquivo" value="1" />
                <label>Adicionar arquivo:</label>
                <input type="file" class="arquivo" id="arquivo1" name="arquivo1" style="margin-left:0px"/>
                <div id="arquivos" style="margin-bottom:5px; margin-left:0px; border:#000 solid 0px;">
                </div>
		</td></tr>
		<tr><td>
            <input type="button" value= "Enviar" id="bt_enviar_inconforme" class="myButton"/>
		</td></tr>
        </table>
       </form>		
    </div>
</div>
<!-- FIM DIV QUE VIRA DIALOG -->
<%end if%>

<!--teste-->
</body>
</html>
