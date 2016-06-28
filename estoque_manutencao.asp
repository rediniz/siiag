<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Estoque</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="submenu.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<meta http-equiv="imagetoolbar" content="no">
<script src="scripts/jquery-1.9.1.js"></script>
<style>
#tabela tr {
	cursor:pointer;
}
</style>
<script type="text/javascript" language="javascript">
var editar = false
var simac = true
var adicionar = false;
var subtrair = false;
$(document).ready(function(){

	$("#editar").attr("disabled", true);
	$("#salvar").attr("disabled", true);
	$("#inputAddQtd").attr("disabled", true);
	$("#inputSubQtd").attr("disabled", true)

	if($("#pag").val() == ""){
		$("#pag").val(1);
	}


	$("#filtro").on("keyup", function(){
		//window.location.assign("estoque_requisicao.asp?filtro="+$("#filtro").val());
		
			$.ajax({
				method: "POST",
				data: {
				filtro: $("#filtro").val()
				},
       			contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
       			url: "estoque_cadastrados.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        			$("#carregando").show(); 
					$("#tabela").hide();
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		$("#carregando").hide();  
					$("#tabela").show();
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          			$('#tabela').html(data);	  
        		},
		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro.");
 				}
		
      		})
	});


	$("#carregando").hide();
	$.ajax({
		method: "POST",		
		data: {
			simac : document.getElementById("check_simac").checked,
			ativo : document.getElementById("check_ativos").checked
		},		
		contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
		url: "estoque_cadastrados.asp?pag="+$("#pag").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
		dataType: "html", // TIPO DE DADOS DE RETORNO
		//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
		beforeSend: function() { // ANTES DA REQUISIÇÃO
			$("#carregando").show();
		},
		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
			$("#carregando").hide();  
		},
		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
			$('#tabela').html(data);	  
		},
		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
			alert("Erro.");
		}	
	})

	$("#bt_imprimir" ).on("click", function() {
		alert("imprimir");
		$("#carregando").hide();

	
	});
		
	$( "#check_simac" ).on("click", function() {
	
		if(simac){
			$(".coluna_simac").each(function(){
				$(this).hide();
			});
			simac=false;
		}else{
			$(".coluna_simac").each(function(){
				$(this).show();
			});
			simac=true;
		}
	
	});

	$( "#check_ativos" ).on("click", function() {
		
			$.ajax({
				method: "POST",	
				data: {
				simac : document.getElementById("check_simac").checked,
				ativo : document.getElementById("check_ativos").checked
				},
				contentType: "application/x-www-form-urlencoded; charset=utf-8; code=65001", 
				url: "estoque_cadastrados.asp?pag="+$("#pag").val(), // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
				dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
					$("#tabela").hide();
					$("#carregando").show();
				},
				complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
					$("#carregando").hide();  
					$("#tabela").show(); 
				},
				success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
					$('#tabela').html(data);
						  
				},
				error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro.");
				}
		})
	});
	
	$(document).on("click", "#tabela #material", function(){
	
		if(editar){
			$("#salvar").trigger("click");
			editar = false;
		}
		
		$("#editar").attr("disabled", false);
		$("#salvar").attr("disabled", false);
		
		$(this).select();
		
		codigo =  $(this).find("#codigo").val();
		nome = $(this).find("#nome").html();
		valor = $(this).find("#valor").val();
		qtd = $(this).find("#qtd").html();
		qtd_min = $(this).find("#qtd_min").html();
		unidade = $(this).find("#unidade").html();
		ativo = $(this).find("#ativo").html();
		
		nome_simac = $(this).find("#nome_simac").html();
		cod_simac = $(this).find("#cod_simac").html();
		qtd_simac = $(this).find("#qtd_simac").html();
		
		$("#codigo").val(codigo);
		$("#nome").val(nome);
		$("#valor").val(valor);
		$("#qtd").val(qtd);
		$("#qtd_min").val(qtd_min);
		$("#unidade option:selected").html(unidade);
		if(ativo == "Sim"){
			document.getElementById("ativo").checked = true;
		}else{
			$("#ativo").removeAttr("checked");
		}
			
		$("#nome_simac").val(nome_simac);
		$("#cod_simac").val(cod_simac);
		$("#qtd_simac").val(qtd_simac);
		
		
		$("#codigo").attr("disabled", true);
		$("#nome").attr("disabled", true);
		$("#valor").attr("disabled", true);
		$("#qtd").attr("readonly", true);
		$("#qtd_min").attr("disabled", true);
		$("#unidade").attr("disabled", true);
		$("#ativo").attr("disabled", true);
		$("#radioSubtrair").attr("disabled", true);	
		$("#radioAdicionar").attr("disabled", true);
		$("#radioSubtrair").attr("checked", false);	
		$("#radioAdicionar").attr("checked", false);
		$("#nome_simac").attr("disabled", true);
		$("#cod_simac").attr("disabled", true);
		$("#qtd_simac").attr("disabled", true);	

		$('#frame_extrato').attr('src','estoque_historico.asp?co_material=' + codigo);

		$("#field_info").show();
	});
	

	
	$("#salvar").click(function(){
	
		salvar = window.confirm("Salvar alterações no material?");
		
		if(salvar){
					
			if(document.getElementById("ativo").checked == true){
				$("#ativo_valor").val("1");
			} else{
				$("#ativo_valor").val("0");
			}
			$.ajax({
					data: $("#formulario").serialize(),
					url: "estoque_editar_con.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
						//$("#tabela").hide();
						//$("#carregando").show();
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
						//$("#carregando").hide();  
						//$("#tabela").show(); 
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						alert("Material editado com sucesso.");	
						window.location.reload();
					},
					error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao editar material.");
					}
			})
			//formulario.submit();
		
		} else{
		
			return false;
		}
	
	});
	
	
	$("#editar").click(function(){
	
	if( $("#perfil_estoque").val() == 'False' ){
		alert("Você não tem permissão para editar um material.");
		return false;
	}
	
	$("#editar").hide()
	$("#salvar").show()
	
	editar = true;
	
	$("#addQuantidade").show();
	$("#subQuantidade").show();
	
	$("#codigo").attr("disabled", false);
	$("#nome").attr("disabled", false);
	$("#valor").attr("disabled", false);
	$("#qtd").attr("readonly", true);
	$("#qtd_min").attr("disabled", false);
	$("#unidade").attr("disabled", false);
	$("#ativo").attr("disabled", false);
	$("#radioSubtrair").attr("disabled", false);	
	$("#radioAdicionar").attr("disabled", false);
	$("#nome_simac").attr("disabled", false);
	$("#cod_simac").attr("disabled", false);
	$("#qtd_simac").attr("disabled", false);
	
	});
	
	$("#addQuantidade").on("click", function(){
	
		$("#inputAddQtd").show();
		$("#inputSubQtd").hide();
		subtrair = false;
		adicionar = true;
	});
	
	$("#subQuantidade").on("click", function(){
	
		$("#inputSubQtd").show();
		$("#inputAddQtd").hide();
		subtrair = true;
		adicionar = false;
	
	});
	
	$("#radioAdicionar").on("change", function(){
	
		if($(this).prop("checked")==true){
			$("#inputAddQtd").prop("disabled", false);
			$("#inputSubQtd").prop("disabled", true);
			$("#inputSubQtd").val("");
		}

	});
	
	$("#radioSubtrair").on("change", function(){
	
		if($(this).prop("checked")==true){
			$("#inputAddQtd").prop("disabled", true);
			$("#inputAddQtd").val("");
			$("#inputSubQtd").prop("disabled", false);
			
		}

	});
	$(document).on("keyup","#inputAddQtd", function(){
		
		if(!($.isNumeric($(this).val()))){
			$(this).val("");
		};
		
	});
	$(document).on("keyup","#inputSubQtd", function(){
		
		if(!($.isNumeric($(this).val()))){
			$(this).val("");
		};
		
	});
	
		});
		
	</script>
</head>
<body>
<%
	response.write "<input id='pag' type='hidden' value=" & request("pag") & " >"
%>
<%
	Perfil_Acesso("10")	   
	response.write "<input type='hidden' id = 'perfil_estoque' value=" & perfil_acesso_siiag & ">"
	if not perfil_acesso_siiag then
		response.Redirect("estoque_requisicao.asp")
	end if
%>
<div class="teste2">
<!--fundo azul do meio-->
<!-- #INCLUDE FILE ="topo.asp" -->
<!--#include file="include/Conexao.asp"-->
<%
'dim obj
'set obj = new Conexao
%>
<div class="corposite">
  <!--corpo-->
  <div class="container">
    <div class="conteudo2">
      <div class="titulosModulos" ><span >ESTOQUE</span> </div>
      <p>
      <div id='cssmenu' >
        <ul>
          <li><a href='estoque_requisicao.asp'><span>Novo Pedido</span></a></li>
          <li ><a href='estoque_pendentes.asp'><span>Pedidos</span></a></li>
          <li class='active'><a href='estoque_manutencao.asp'><span>Manutenção</span></a></li>
        </ul>
      </div>
      </p>
      <div id='submenu'>
        <ul>
          <li class='active'><a href='estoque_manutencao.asp'><span>Editar Material</span></a></li>
          <li><a href='estoque_cadastrar.asp'><span>Cadastrar Material</span></a></li>
          <!--<li><a href='#'><span>Ajuda</span></a></li>-->
        </ul>
      </div>
      <p class="paragrafoteste">
      <div class="testess">
        <form id="formulario"  name="formulario" >
          <!--<fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; display:none;" id="field_info">
          <legend><span class="titulos">Informações do material selecionado</span></legend> -->
          
          <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; background:#F8F8F8; display:none;" id="field_info">
          <legend><span class="titulos" >Informações do material selecionado</span></legend>
          <span>
          <label>Nome SIMAC:
          <input  class="form-field" name="nome_simac" type="text" id="nome_simac" size="35"  disabled="disabled"/>
          </label>
          <label style="padding-right:5px">Código SIMAC:
          <input class="form-field" name="cod_simac" type="text" id="cod_simac" size="5" disabled="disabled"/>
          </label>
          <label>Quantidade SIMAC: </label>
          <input class="form-field" name="qtd_simac" type="text" id="qtd_simac" size="5" disabled="disabled"/>
          </span><span>
          <label> </label>
          </span>
    
          <p><span>
            <label for="nome" >Nome: </label>
            <input class="form-field" name="nome" type="text" id="nome" size="30" disabled="disabled"/>
            </span>
            <label for="valor"><span>Valor: </span></label>
            <input class="form-field" name="valor" type="text" id="valor" size="2" width = "2px" disabled="disabled"/>
            <span>
            <label for="quantidade">Qtd.: </label>
            <input class="form-field" name="qtd" type="text" id="qtd" size="1"   width="2px" maxlength="4"  readonly="readonly" style="clear:right"/>
            
            <label for="qtd_min"> Qtd. Mín.: </label>
            <input class="form-field" name="qtd_min" type="text" id="qtd_min" size="1" maxlength="4"  disabled="disabled"/>
            </span><span style="padding-left:10px">
            <label for "unidade">Unidade: </label>
            <select class="form-select" id="unidade" name="unidade"  disabled="disabled">
            <%

				strQuery = 		"select CO_UNIDADE, DE_UNIDADE FROM TB_ESTOQUE_UNIDADE WHERE(IC_ATIVO = 1); " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
				set Ls=			Server.CreateObject("ADODB.RecordSet")
				Ls.Open strQuery, dados_sys
				
				 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
				 'Vamos percorrer o recordset até chegar no final do arquivo
						
					DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
					
						'atribuindo os valores dos campos as variáveis
						CO_UNIDADE=Ls("CO_UNIDADE")
						DE_UNIDADE=Ls("DE_UNIDADE")
						
						response.write "<option value='"& CO_UNIDADE &"'>"& DE_UNIDADE &"</option>" 'imprimindo
						
						Ls.movenext 'passando para o proximo elemento da tabela
					
					LOOP
				
				objConn.close 
				set Ls = 		nothing
				set objConn = 	nothing 
				'fechando todas as conexoes
			%>
            </select>
            <input type='hidden' id = "ativo_valor" name= "ativo_valor" value='' />
            </span> 
          <span>
          <label for="ativo"><span >Ativo:</span></label>
          <input style: vspace="10px"type="checkbox" name="ativo" id="ativo" disabled="disabled"/>
          <div id='adicionaSubtrai'>
            <table border="0" width="600">
                <tr>
                    <td>
                        <input type="radio" class='radioQtd'id="radioAdicionar" name='radioAdicionar'  value='1' disabled="disabled" />
                        <img src="imagens/add_16x16.png"/>
                    </td>
                    <td>       
                        <label>Adicionar quantidade:</label>
                    <input  class="form-field" name="inputAddQtd" type="text" id="inputAddQtd" size="1"   width="2px" maxlength="4" style="margin-left:6px" style="clear:right"/>
                    </td>
                    <td>
                    	<input type="radio"  class='radioQtd' id="radioSubtrair" name='radioAdicionar' value='2' disabled="disabled"/>
                   		<img src="imagens/sub_16x16.png"/> 
                    </td>
                    <td>
                    	<label>Subtrair quantidade:</label>
                    	<input   class="form-field" name="inputSubQtd" type="text" id="inputSubQtd" size="1"   width="2px" maxlength="4" style="margin-left:6px" style="clear:right"/>
                    </td>
               </tr>
            </table>
          </div>
            <div align="center" style="padding-top:10px">
                <input name="editar" id="editar" class="myButton" type="button"  value="Editar" />
                <input name="salvar" id="salvar" class="myButton" type="button"  value="Salvar" style="display:none;"/>
            </div>

			<br>
	       <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; display:;" id="field_info">
          <legend><span class="titulos">Extrato Material</span></legend>
            <table border="0" width="100%">
                <tr>
                    <td  align="center">
                    <iframe name="frame_extrato" id="frame_extrato"  src="estoque_historico.asp?co_material=<%=co_material%>"  frameborder="0"  width="800" height="135">
                    </iframe>
                    </td>
                </tr>
            </table>
            </fieldset>
          
          
          <p>
            <input type='hidden'  id = "codigo" name="codigo" value='' disabled="disabled"/>
        </form>

        </p>
        </span>
	    </fieldset>

        <BR>          
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Materiais Cadastrados</span></legend>

        <div  align="center" style="padding-bottom:5px; padding-top:-5px">
        <label>Filtro de Materiais:</label>
        <input class="form-field" id = "filtro" name="filtro" type="text" size="35" maxlength="100" />
        </div>

        <div align="center" style="padding-bottom:10px">
          <label for="check_ativos"><span>Apenas materiais ativos</span></label>
          <%
		 if request("ativo") <> "false" then
		 	response.write  "<input style: vspace='10px' type='checkbox' name='check_ativos' id='check_ativos' checked='checked'/>"
		 else
		 	response.write  "<input style: vspace='10px' type='checkbox' name='check_ativos' id='check_ativos' />"
		 end if
		 %>
          <label for="check_simac"><span>Exibir colunas SIMAC</span></label>
          <%
		  	  
		  if request("simac") <> "false" then
		 	response.write  "<input style: vspace='10px' type='checkbox' name='check_simac' id='check_simac'  checked='checked'/>"
		  else
		 	response.write  "<input style: vspace='10px' type='checkbox' name='check_simac' id='check_simac' />"
		  end if	 
		 %>
        </div>
        <div class="tabela" id="tabela" style="margin-left:0.8%;" > </div>
        <div id="carregando" align="center"> <img src="imagens/carregando.gif" /> </div>
        </fieldset>
        <p></p>
        <p></p>
        <p></p>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
