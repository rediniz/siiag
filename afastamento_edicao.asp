<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!-- #INCLUDE FILE = "include/f_Usuario.asp" -->
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
width:auto;
overflow-y:scroll;
overflow-x:hidden;
}
</style>

<script type="text/javascript">
	$(document).on("click","#salvar", function(){
		
		
		salvar = window.confirm("Confirmar edição?");
		
		if(salvar){
			
		if($("#ic_aviso_assinado").prop("checked")==false || $("#ic_requerimento").prop("checked")==false){
			alert("Não é possível finalizar esse pedido até que todos os requerimentos sejam cumpridos.");
			return false;
		}
		
		if($("#ic_aviso_assinado").prop("checked")==false || $("#ic_requerimento").prop("checked")==false){
			alert("Não é possível finalizar esse pedido até que todos os requerimentos sejam cumpridos.");
			return false;
		}
			
		if($("#tipo_afastamento").val() == "17"){
			$.ajax({
				method: "POST",
				url: "acompanhamento_medico.asp?acao=consultarSaldo&matricula="+$("#matricula").val(),
				success: function(data) {
					var objeto = $.parseJSON(data),
						saldo  = objeto.saldo;
					if($("#quantidadeHoras").val() > parseInt(saldo, 10)){
						alert("Você não tem saldo suficiente de horas para esta solicitação.");
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
				type: "POST",
				url: 'afastamento_edicao_con.asp',
				data:  $("#formulario").serialize(),
				success: function (data) {
					alert("Edição realizada com sucesso.");
					if($("#situacao").val() == 2){
						atualizarSaldoHoras($("#matricula").val(), $("#co_afastamento").val(), $("#quantidadeHoras").val());
					}else{
						window.opener.location.reload();
						window.close();
					}
            	},	
				error: 	function (data) {
					console.log(data.responseText);
					alert("Erro ao editar afastamento.");
            	}		    
  			});
			//formulario.submit();
			

		} else{
			return false;
		}
		
		function atualizarSaldoHoras(matricula, afastamento, quantidadeHoras){
			$.ajax({
			method: "POST",
			url: "acompanhamento_medico.asp?acao=debitarHoras&matricula="+matricula+"&quantidadeHoras="+quantidadeHoras+"&afastamento="+afastamento,
			success: function(data) {
					alert("Saldo de horas para Acompanhamento Médico atualizado.");
					window.opener.location.reload();
					window.close();
			},
			error: function(data){
				alert("Erro ao atualizar saldo de horas para Acompanhamento Médico.");
				console.log(data.responseText);
			}
		})
		}
		
		});
				

</script>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
		
		var spinner = $( "#quantidadeHoras" ).spinner({
			spin: function( event, ui ) {
				if ( ui.value < 0 ) {
					$( this ).spinner( "value", 0 );
					return false;
				}
			}			
		});
				//Ao digitar executar essa função
				$("#nome").focus().autocomplete({
					
					source: "autocompletar_nome2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#matricula" ).val( ui.item.matricula);					
					return false;
					}
				  });
 
 					$("#matricula").focus().autocomplete({
					
					source: "autocompletar_matricula2.asp",
					minlength: 2,
					select: function( event, ui ) {
					$( "#nome" ).val( ui.item.nome);
					$( "#matricula" ).val( ui.item.matricula);				
					return false;
					}
				  }); 
		$("#tipo_afastamento").on("change", function(){
			  var matricula = $("#matricula").val();
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
</head>
<body>

  <!--fundo azul do meio-->
  
  <%
  	Perfil_Acesso("3") 
   	if not  perfil_acesso_siiag then
  		response.Redirect ("afastamento_consultar.asp")
  	end if
  
	'#ALTERADO EM 30/11/2015 (select agora pega as datas de inicio e prev_conc da demanda)#
  	query = "SELECT USUARIO.CO_MATRICULA, USUARIO.CO_DIGITO, USUARIO.NO_NOME,  AFASTAMENTO.CO_TIPO_AFASTAMENTO, AFASTAMENTO.OBS_EDICAO, AFASTAMENTO.DT_INICIO, AFASTAMENTO.DT_FIM, AFASTAMENTO.CO_SITUACAO, AFASTAMENTO.DT_INI_ATDMT, AFASTAMENTO.dt_prev_conc, AFASTAMENTO.ATESTADO_DIGITALIZADO, AFASTAMENTO.ATESTADO_DEVOLVIDO, AFASTAMENTO.QTD_HORAS_ACOMPANHAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTO JOIN VW_USUARIOS AS USUARIO ON USUARIO.CO_MATRICULA = AFASTAMENTO.CO_MATRICULA INNER JOIN TB_SITUACOES SIT ON AFASTAMENTO.CO_SITUACAO = SIT.CO_SITUACAO WHERE CO_AFASTAMENTO="&request("co_afastamento")
	
	resultado 					= objConn.execute(query)
	co_matricula 				= resultado("CO_MATRICULA")
	co_digito	 				= resultado("CO_DIGITO")
	no_nome						= resultado("NO_NOME")
	co_tipo_afastamento 		= resultado("CO_TIPO_AFASTAMENTO")
	dt_inicio 					= resultado("DT_INICIO")
	dt_fim 						= resultado("DT_FIM")
	co_situacao					= resultado("CO_SITUACAO")
	atestado_digitalizado		= resultado("ATESTADO_DIGITALIZADO")
	atestado_devolvido			= resultado("ATESTADO_DEVOLVIDO")
	qtdHorasAcompanhamento		= resultado("QTD_HORAS_ACOMPANHAMENTO")
	tsAtestadoDigitalizado		= resultado("ATESTADO_DIGITALIZADO")
	tsAtestadoDevolvido			= resultado("ATESTADO_DEVOLVIDO")
	
	'#ALTERADO EM 30/11/2015 (adicionado)#
	dt_ini_atdmt = resultado("DT_INI_ATDMT")
	dt_prev_conc = resultado("dt_prev_conc")
	'#ALTERADO EM 11/04/2014
	observacaoEdicao = resultado("OBS_EDICAO")
  
  %>
  
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; text-align:center">
          <legend class="testea"><span class="titulos">Afastamento</span></legend>
          <p></p>
          <form method="post" name="formulario" id="formulario" action="afastamento_edicao_con.asp"  >
		<center>
          <table border="0">
          <tr>
          <td align="left">
          <label>Usu&aacute;rio:</label>
          </td>
          <td align="left">
          <label><%=co_matricula%>-<%=co_digito%></label>
         <!--<input  style="border:none;"   readonly="readonly" name="matricula" id="matricula" type="text" size="10" maxlength="7" value="<%=co_matricula%>" /> -->
         <input type="hidden" name="matricula" id="matricula" value="<%=co_matricula%>" />
         </td>
         </tr>
         <tr>
         <td align="left">
          <label>Nome:</label>
          </td>
          <td align="left">
          <label><%=no_nome%></label>
         <!-- <input style="border:none;"  readonly="readonly" name="nome" id="nome" type="text" size="50" maxlength="60" value="<%=no_nome%>"/></td> -->
          </tr>
          <tr>
          <td align="left">
         <label>Tipo:</label></td>
         <td align="left">

    	<select id = 'tipo_afastamento' name='tipo_afastamento' class='form-select'>
<%
			if (co_tipo_afastamento = "37" or co_tipo_afastamento = "13") or co_situacao = "7" then
				strQuery = 		"select CO_TIPO_AFASTAMENTO, DE_TIPO_AFASTAMENTO, CO_CAIXA  from TB_TIPOS_AFASTAMENTO WHERE IC_ATIVO = 1 and co_tipo_afastamento = " & co_tipo_afastamento & "  ORDER BY DE_TIPO_AFASTAMENTO; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 	
			else
				strQuery = 		"select CO_TIPO_AFASTAMENTO, DE_TIPO_AFASTAMENTO, CO_CAIXA  from TB_TIPOS_AFASTAMENTO WHERE IC_ATIVO = 1  ORDER BY DE_TIPO_AFASTAMENTO; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
			end if
			set Ls=			Server.CreateObject("ADODB.RecordSet")
			Ls.Open strQuery, dados_sys
			
			 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
			 'Vamos percorrer o recordset até chegar no final do arquivo
					
			  DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
			  
			 'atribuindo os valores dos campos as variáveis
				  descricaoAfastamento=Ls("DE_TIPO_AFASTAMENTO")
				  codigoAfastamento=Ls("CO_TIPO_AFASTAMENTO")
				  CO_CAIXA = Ls("CO_CAIXA")
							if co_tipo_afastamento = codigoAfastamento then
								response.write "<option selected='selected' value='"& codigoAfastamento &"'>"& descricaoAfastamento &" - "&CO_CAIXA&"</option>" 'imprimindo
							
							else
								response.write "<option value='"& codigoAfastamento &"'>"& descricaoAfastamento &" - "&CO_CAIXA&"</option>" 'imprimindo
							end if
			
			
				Ls.movenext 'passando para o proximo elemento da tabela
			  
				LOOP
			
			objConn.close 
			set Ls = 		nothing
			set objConn = 	nothing 
			'fechando todas as conexoes
%>
    </select>  
     </tr>   
    
   	<tr>
    <td align="left"> <label>Início:</label>     </td>   
      <td align="left">    
      <%IF (co_situacao = "2" AND (co_tipo_afastamento = "37" or co_tipo_afastamento = "13")) or co_situacao = "7" then 	%> 
            <label><%=dt_inicio %></label>      
            <input  type="hidden" name="data_inicio" id="data_inicio"  value="<%=dt_inicio %>" />            
	  <%else%>
            <input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<%=dt_inicio %>" />
      <%end if%>
      
            <label>Fim:</label>
      <%IF (co_situacao = "2" AND (co_tipo_afastamento = "37" or co_tipo_afastamento = "13")) or co_situacao = "7" then 	%> 
            <label><%=dt_fim %></label>      
            <input  type="hidden" name="data_fim" id="data_fim"  value="<%=dt_fim %>" />
	  <%else%>
            <input  name="data_fim" id="data_fim" class="datepicker" type="text" size="8" maxlength="8"  value="<%=dt_fim %>" />
      <%end if%>
      
       
          <label></label>             

      </td>
    </tr>
    <tr id="linhaQuantidadeHoras" <% if co_tipo_afastamento <> 17 then %> style="display:none" <% end if %>>
      <td><label for="quantidadeHoras">Quantidade<br /> de horas: </label></td>
      <td><%if isnull(qtdHorasAcompanhamento) then qtdHorasAcompanhamento = 0 end if %><input style="width:20px;height:20px;font-size:14px;" id="quantidadeHoras" name="quantidadeHoras" value=<%=qtdHorasAcompanhamento%>></td>
    </tr>
    <tr>
        <td colspan="2"><input type="checkbox"  id="atestadoDigitalizado" name="atestadoDigitalizado"  value = "1" <% if tsAtestadoDigitalizado = "True" Then Response.Write "checked" END IF %>/><label for="atestadoDigitalizado">Atestado digitalizado e email encaminhado à GIPES</label>
        </td>
    </tr>
    <tr>
        <td colspan="2"><input type="checkbox"  id="atestadoDevolvido" name="atestadoDevolvido"  value = "1" <% if tsAtestadoDevolvido = "True" Then Response.Write "checked" END IF %>/><label for="atestadoDevolvido">Atestado devolvido ao empregado</label>
        </td>
    </tr>
   	<tr>
   	  <td align="left"><label>Situação:</label></td>
   	  <td align="left">               <select class="form-select" id='situacao' name='situacao'>
     <%
		'IF Tem_Acesso("14") OR Eh_Perfil_Verificado("2") THEN
		if perfil_acesso_admin_siiag then
		  ' se confirmado, só poderá mudar para cancelado
			if co_situacao = "2" then	
				query = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES WHERE co_situacao in (2,7) ORDER BY DE_SITUACAO"
			elseif co_situacao = "7" then	
				query = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES WHERE co_situacao in (7) ORDER BY DE_SITUACAO"
			else
				query = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES  ORDER BY DE_SITUACAO"
			end if 
		else
		  ' se confirmado, só poderá mudar para cancelado
			if co_situacao = "2" then	
				query = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES WHERE co_situacao in (2) ORDER BY DE_SITUACAO"
			elseif co_situacao = "7" then	
				query = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES WHERE co_situacao in (7) ORDER BY DE_SITUACAO"
			else
				query = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES WHERE co_situacao in (" & co_situacao & ",1,7) ORDER BY DE_SITUACAO"
			end if 
	 	End If

			set fs=Server.CreateObject("ADODB.RecordSet")
			fs.Open query, dados_sys 
			DO UNTIL fs.eof
				CO_SITUACAO_s=fs("CO_SITUACAO")
				DE_SITUACAO=fs("DE_SITUACAO")
				
				if co_situacao = CO_SITUACAO_s then
					response.write "<option selected='selected' value="&CO_SITUACAO_s&">"&DE_SITUACAO&"</option>"	
				else
					response.write "<option value="&CO_SITUACAO_s&">"&DE_SITUACAO&"</option>"
				end if		
								 
				fs.movenext
			
			LOOP
			set fs = nothing

	 %>
     </select>
     </td>
 	  </tr>
<!-- #ALTERADO EM 30/11/2015 (adicionado)# -->
<%tipo_prazo_demanda = 1%>
<!-- #INCLUDE FILE ="include_campo_datas.asp" -->
<!-- '#ALTERADO EM 11/04/2014 -->
<!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->
          <tr>
          <td colspan="2" align="center">
          <br/>
          <input name="salvar" class="myButton" type="button" value="Salvar" id="salvar" />          </td>
	</tr>
   </table>
   </center>
   <%
   		response.write "<input type='hidden' id='co_afastamento' name='co_afastamento' value="&request("co_afastamento")&"> "
   %>
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
