<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Reserva de Equipamentos</title>
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
body{

background:#FFFFFF;

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
		//$("#tabela").hide();
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

<script>
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
		
	//	$( document ).on("click", "#solicitar", function(){
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
 var qtd_recursos = $("#qtd_recursos").val();
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
		
		$(document).on("click","#salvar", function(){
		
		if($("#perfil_emprestimo").val()=="False"){
			alert("Você não tem permissão para solicitar um empréstimo.")
			return false;
		}	
		
		salvar = window.confirm("Confirmar edição?");
		
		if(salvar){
				
			$(".linha").each(function(){
				
				valor = $(this).find("#recurso").val()+":"+$(this).find("#quantidade").html();
				
				//array.push(); 
				$("#teste").append("<input type='hidden' value="+valor+" id='recurso_quantidade' name='recurso_quantidade'>");
	
			});
			
			// $("#formulario").submit();
		
			$.ajax({
				type: "POST",
				url: 'emprestimos_edicao_con.asp',
				data:  $("#formulario").serialize(),
				success: function (data) {
					alert("Edição realizada com sucesso.");
					window.close();
					window.opener.location.reload();
					
						
            	},
				error: function(data) { // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao editar empréstimo.");
 				}	
  			});


} else{
return false;
}
		
		});
				
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
			if(header===false && $("#tabela").html()==""){
				$( "#tabela" ).append( "<tr> <td>Recurso</td> <td>Quantidade</td> <td width='5%'> </td></tr>");
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

<%
co_emprestimo = request("co_emprestimo")
Perfil_Acesso("28") 
if not perfil_acesso_siiag then
	response.Redirect("acesso_negado.asp")
end if
%>
<body>

  <!--fundo azul do meio-->

        <div class="usuariodiv">
          </p>

          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
          <legend><span class="titulos">Editar Reserva</span></legend>
          <p class="paragrafoteste">     
          <form name="formulario" id="formulario" action="emprestimos_edicao_con.asp" method="post" enctype="application/x-www-form-urlencoded">       

          <label> Recursos:</label>
		  <% Combo_Recursos()%>
		  <label for="spinner">Quantidade: </label>
            <input style="width:20px;height:20px;font-size:14px;" id="spinner" name="quantidade" value=0>
            <input  name="adicionarRecurso" class="myButton" type="button"  value="Incluir" id="adicionarRecurso" style="padding-right:10px; padding-left:10px; margin:14px; padding-top:1px; padding-bottom:1px;font-size:14px;"/>

	 <table>
         <tr>
         <td></td>
         <td>
          <div class="tabela" style="margin-bottom:1%; width:100%" >
            <table  name="tabela" id="tabela" width="100%" >
            <%

			query = "SELECT EMPRESTIMO.CO_RECURSO, EMPRESTIMO.QT_RECURSO, RECURSO.DE_RECURSO FROM TB_EMPRESTIMO_RECURSO AS EMPRESTIMO JOIN TB_TIPOS_RECURSOS AS RECURSO ON EMPRESTIMO.CO_RECURSO=RECURSO.CO_RECURSO WHERE CO_EMPRESTIMO = "&co_emprestimo 
			set Ls=Server.CreateObject("ADODB.RecordSet")
			Ls.Open query, dados_sys
			
			if  not Ls.eof then
				response.write "<tr> <td>Recurso</td> <td>Quantidade</td> <td width='5%'> </td></tr>"
			end if
			
			qtd_recurso = 0
			DO UNTIL Ls.eof 
				qtd_recurso = qtd_recurso + 1
				coRecurso = Ls("CO_RECURSO")
				qtRecurso = Ls("QT_RECURSO")
				deRecurso = Ls("DE_RECURSO")
				response.write "<tr class='linha' id='linha'><td ><input type='hidden' value="&coRecurso&" id='recurso' class='recurso'>" & deRecurso & "</td><td class='quantidade' id='quantidade'>" & qtRecurso & "</td><td width='5%'><img id='X'  src='imagens/delete_16x16.png' style='cursor:pointer'></td></tr>"
				Ls.movenext 
			LOOP
			set Ls = nothing
			
			%>
            
            </table>
            <%response.write "<input type='hidden' id='qtd_recurso' name='qtd_recurso' value="&qtd_recurso&">"%>
          </div>
          </td>
          </tr>
   
         	
            <tr>
            <td>
          <label> Local:</label>
          </td>
          <td>
          <select class="form-select" name='local' id="local" width="68">
          <option value="">Selecione um Local</option>
          <%
  
			query1 = "select CO_LOCAL, DE_LOCAL  from TB_LOCAL ORDER BY DE_LOCAL; "
			query2 = "SELECT LOCAL.CO_LOCAL, LOCAL.DE_LOCAL FROM TB_EMPRESTIMO AS EMPRESTIMO JOIN TB_LOCAL AS LOCAL ON EMPRESTIMO.DE_LOCAL=LOCAL.DE_LOCAL WHERE CO_EMPRESTIMO="&request("co_emprestimo") 
			de_local_emp = objConn.execute(query2)("DE_LOCAL")
			
			'set objConn = server.CreateObject("ADODB.Connection") 
			'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
			'objConn.open dados_sys
			set Ls=Server.CreateObject("ADODB.RecordSet")
			Ls.Open query1, dados_sys
			DO UNTIL Ls.eof 
				descricaoLocal=Ls("DE_LOCAL")
				codigoLocal=Ls("CO_LOCAL")
				if de_local_emp = descricaoLocal then
					response.write "<option selected='selected' value='"&  descricaoLocal &"'>"& descricaoLocal &"</option>" 
				else
					response.write "<option value='"&  descricaoLocal &"'>"& descricaoLocal &"</option>" 
				end if
				Ls.movenext 
			LOOP
			set Ls = nothing
		
		%>
</select>
</td>
</tr>
<%
		'#ALTERADO EM 11/04/2016 (select agora traz DE_OBS)
		query = "SELECT NO_NOME,  DE_RESPONSAVEL,CO_MATRICULA_RESPONSAVEL, DE_OBS,DH_INICIO, DH_FIM, DT_INI_ATDMT, DT_PREV_CONC, OBS_EDICAO  FROM TB_EMPRESTIMO LEFT JOIN VW_USUARIOS ON CO_MATRICULA= CO_MATRICULA_RESPONSAVEL WHERE CO_EMPRESTIMO="&request("co_emprestimo")
		resultado = objConn.execute(query)
		
		CO_MATRICULA_RESPONSAVEL = resultado("CO_MATRICULA_RESPONSAVEL")
		
		If isnull(resultado("DE_RESPONSAVEL")) and not isnull(resultado("NO_NOME")) then
			responsavel = resultado("NO_NOME")
		else	
			responsavel = resultado("DE_RESPONSAVEL")
		end if
		
		observacao = resultado("DE_OBS")
		data_inicio = formatdatetime(resultado("DH_INICIO"), 2)
		data_fim = formatdatetime(resultado("DH_FIM"), 2)
		hora_inicio = formatdatetime(resultado("DH_INICIO"), 4)
		hora_fim = formatdatetime(resultado("DH_FIM"), 4)
		
		'#ALTERADO em 01/12/2015 (adicionado)"
		dt_ini_atdmt = resultado("dt_ini_atdmt")
		dt_prev_conc = resultado("dt_prev_conc")
		'=======================================
		
		'#ALTERADO EM 11/04/2016
		observacaoEdicao = resultado("OBS_EDICAO")
	
		set resultado = nothing
%>
		  <tr>
          
          <td>
          <label>Respons&aacute;vel:</label>
          </td>
          <td>
          <%
          	response.write "<input name='responsavel' class='form-field' id='responsavel' type='text'  value='"&responsavel&"'maxlength='100' style='width:428px' />"
		  %>
	        <input type="hidden" name="co_responsavel"  id="co_responsavel"  value="<%=CO_MATRICULA_RESPONSAVEL%>" />          
          </td>
          </tr>

		  <tr>
          <td>
          <label>Per&iacute;odo:</label>
          </td>
          <td>
           <%response.write "<input  name='periodo_inicio' id='periodo_inicio' class='datepicker' type='text' size='8' maxlength='8'  value='"&data_inicio &"' >"%>&nbsp;
           <%response.write "<input id='horario_inicio' name='horario_inicio' class='ui-mask ui-spinner-input' autocomplete='off' role='spinbutton' size='4' value="&hora_inicio&" style='height:20px;' />"%> &nbsp;<label>a</label>&nbsp;
           <%response.write "<input  name='periodo_fim' id='periodo_fim' class='datepicker' type='text' size='8' maxlength='8'  value='"&data_fim&"' />"%>&nbsp;
           <%response.write "<input id='horario_fim' name='horario_fim' class='ui-mask ui-spinner-input' autocomplete='off' role='spinbutton' size='4' value='"&hora_fim&" 'style='height:20px;' />"%></td>
   
   </tr>
	  <tr>
      <td>
          <label >Observa&ccedil;&otilde;es:</label>
   
         </td>
         <td>
          <% response.write "<textarea class='form-field' name='observacoes'  cols='50' rows='5' style='max-width:430px;min-width:430px;max-height:50px;min-height:50px;'>"&observacao&"</textarea>"%>
          </td>
          </tr>
          <tr>
          <td>
          <label>Situação</label>
          </td>
          <td>
               <select id="situacao" name="situacao" class="form-select">
     <%
		
	query1 = "SELECT CO_SITUACAO FROM TB_EMPRESTIMO WHERE CO_EMPRESTIMO = " & request("co_emprestimo") & "" 
	if perfil_acesso_admin_siiag then
		query2 = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES ORDER BY DE_SITUACAO"
	else
		query2 = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES where co_situacao in (1,7) ORDER BY DE_SITUACAO"
	end if
	 
	 resultado1 = objConn.execute(query1)
	 co_situacao_sub = resultado1("CO_SITUACAO")
	 'response.write "<option>"&co_situacao_sub&"</option>"
	 
	 set fs=Server.CreateObject("ADODB.RecordSet")
					fs.Open query2, dados_sys 
					DO UNTIL fs.eof
						CO_SITUACAO=fs("CO_SITUACAO")
						DE_SITUACAO=fs("DE_SITUACAO")
						
						if co_situacao_sub = CO_SITUACAO then
							response.write "<option selected='selected' value="&CO_SITUACAO&">"&DE_SITUACAO&"</option>"	
						else
							response.write "<option value="&CO_SITUACAO&">"&DE_SITUACAO&"</option>"
						end if		
										 
						fs.movenext
						
					LOOP
					set fs = nothing
	 	 	 
	 %>
     </select>
          </td>
          <td>
          <br />
            <div id="recursos_quantidade">
           
           </div>
       
          </td>
          </tr>
          <!--#Alterado em 01/12/2015 (adicionado)==========-->
          <tr>
          <%tipo_prazo_demanda = 6%>
             <!-- #INCLUDE FILE ="include_campo_datas.asp" -->
          </tr>
          <!-- '#ALTERADO EM 11/04/2016 -->
		  <!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->
          <!--==============================================-->
           </table>	
          <br />
                       <div align="center">
          <input  class="myButton" type="button" value="Salvar" id="salvar" name="salvar"/>
          </div>
		  <div id="teste"></div>
          <%response.write "<input type='hidden' value="&request("co_emprestimo")&" id='co_emprestimo' name ='co_emprestimo'>"%>
          </form>
          </fieldset>
         
        </div>
      </div>
      
    </div>
  </div>
  <!--fim do corpo-->
</div>
<!--teste-->
</body>
</html>
<%

Sub Combo_Recursos()

%>
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
%>
	</select>
<%
end Sub
%>