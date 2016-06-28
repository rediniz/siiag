<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Edição de F&eacute;rias</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<!--CSS-->
<style type="text/css">
<!--
.style2 {
	font-size: 14
}
.style3 {
	color: #5683C4
}
.tipoarea {
	/*border:#000000 solid 1px;*/ float: left;
}
.destinoConteudo {
	/*border:#000000 solid 1px;*/
	float: right;
}
.responsavelFile {/*border:#000000 solid 1px;*/
	float: left;
	margin-top: 15px;
}
#receberLink {/*border:#000000 solid 1px;*/
	float: left;
	margin-top: 15%;
}
.arOficio {/*border:#000000 solid 1px;*/
}
.arOficio label {
	margin-left: 28%;
}
.arOficio input {
	margin-left: 21%;
	margin-bottom: 10%;
}
-->
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
body {
	background: #FFFFFF;
}
</style>
<script language="javascript">
	function validaCampos()
	{
	
		formProtocolo.submit();
		
	}
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
$(document).ready(function() {
	
	//#Alterado em 01/12/2015 (a edição agora é feita com ajax)=====================================
	$('#editar').on('click',function(){
		//#ALTERADO EM 10/05/2016
		if($("#situacao").val() == 2){
			if($("#maisDe50Anos").val() == "True" && parseInt($("#gozo").val()) < 30){
				if($("#ic_aviso_assinado").prop("checked")==false || $("#ic_requerimento").prop("checked")==false){
					alert("Não é possível finalizar esse pedido até que todos os requerimentos sejam cumpridos.");
					return false;
				}
			}else if($("#ic_aviso_assinado").prop("checked")==false){
				alert("Não é possível finalizar esse pedido até que todos os requerimentos sejam cumpridos.");
				return false;
			}
		}
	//----------------------------------------------------------------------------------------------
		if ($("#gozo").val()=="" || $("#gozo").val()=="0"){
				alert("Preencha os dias de gozo.")
				return false;
			}

			if ($("#parcelas").val()=="" || $("#parcelas").val()=="0"){
				alert("Preencha os dias de parcelas.")
				return false;
			}

			var abono;
			var diasAbono = $("#diasAbono").val();		

			if (document.getElementById('abono_sim').checked)
			{ 
				//alert('sim'); 
				abono = 1;
				if (diasAbono == "" || diasAbono == "0")
				{
				 alert('Você selecionou Abono SIM. Para isso digite a quantidade de dias de abono.');
				 return false;
				}
			}else if (document.getElementById('abono_nao').checked)
			{ 
				//alert('nao');
				abono = 0;
			}
			
			salvar = window.confirm("Confirmar edição?");
			
		
		if(salvar){
			$.ajax({
				type: "POST",
				url: "ferias_editar_con.asp?abono="+abono,
				data:  $("#formferias").serialize(),
				success: function (data) {
					alert("Edição realizada com sucesso.");
					window.close();
            	},	
				error: 	function (data) {
					alert(data.responseText);
					alert("Erro ao editar férias.");
            	}		    
  			});
		} else{
			return false;
		}
		//=======================================================================

		});
});
	
</script>
<script>
$(document).ready(function() {

	$("#abono_nao").on("click", function(){ 
		 $("#diasAbono").val("0");
		 $("#diasAbono").prop("disabled", true);
	});
	
	 $("#abono_sim").on("click", function(){ 
		 $("#diasAbono").prop("disabled", false);
	});

});
</script>
<style>
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
</head>

<body>
<!--fundo azul do meio--> 

<!--'****** CONEXÃO COM O BANCO DE DADOS --> 
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
co_ferias = request("co_ferias")

set ds=Server.CreateObject("ADODB.RecordSet")
SQL = "SELECT * FROM TB_FERIAS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE CO_FERIAS = " & co_ferias & ""
'response.write SQL
ds.Open SQL, dados_sys
'response.write ds("co_matricula")

'#ALTERADO EM 11/04/2014
observacaoEdicao = ds("OBS_EDICAO")
'******
%>

<!--corpo-->
<%	
		'#ALTERADO em 30/11/2015 (adicionado)=============
		dt_ini_atdmt = ds("DT_INI_ATDMT")
		dt_prev_conc = ds("dt_prev_conc")
		'==================================================
		
'#ALTERADO EM 16/06/2016--------------------------------------
 queryIdade = "select CAST(DATEDIFF(DAY, DT_NASCIMENTO, '"&ds("dt_inicio")&"') / 365.25 AS INTEGER) AS idade from tb_usuarios where co_matricula = '"&ds("co_matricula")&"'"
idade = cint(objConn.execute(queryIdade)("idade"))
maisDe50Anos = false

if idade >= 50 then
	maisDe50Anos = true
end if

	%>
    	<input type="hidden" id="maisDe50Anos" name="maisDe50Anos" value="<%=maisDe50Anos%>" />
    <%
	
'#ALTERADO EM 22/05/2016--------------------------------------
queryCoordenadorGerente = "SELECT CO_CARGO FROM VW_USUARIOS WHERE CO_MATRICULA =  '"&ds("co_matricula")&"'"
coCargo = objConn.execute(queryCoordenadorGerente)("CO_CARGO")
if coCargo = 1 or coCargo = 2 then
	coordenadorOuGerente = true
end if
'--------------------------------------------------------------
	%>
    	<input type="hidden" id="coordenadorOuGerente" name="coordenadorOuGerente" value="<%=coordenadorOuGerente%>" />

</p>
<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:0px">
<legend class="style2 style3">Edi&ccedil;&atilde;o de F&eacute;rias </legend>
<span class="style4 style2">
<form ACTION="ferias_editar_con.asp" name="formferias" id="formferias" method="POST">
  
  <!--#Alterado em 30/11/2015 (todos os itens do formulário estão agora em uma tabela para melhor formatação) -->
  <table>
    <tr>
      <td><label>Matr&iacute;cula:</label></td>
      <td><% =ds("co_matricula")%>
        -
        <% =ds("co_digito")%>
        
        <!--<input style="border:none;" id="matricula" value="<% =ds("co_matricula")%>"/> --></td>
    </tr>
    <tr>
      <td><label>Nome:</label></td>
      <td><% response.write(DS("NO_nome"))%></td>
      <!-- <input style="border:none;"  id="nome" value="<% response.write(DS("NO_nome"))%>"/> -->
      
        </label>
    </tr>
    <tr>
      <td><label>Situação:</label></td>
      <td><select name="situacao" id="situacao" style="margin-right:8px;">
          <%
				'if perfil_acesso_admin_siiag then
	                query2 = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES ORDER BY DE_SITUACAO"
				'else
	                'query2 = "SELECT CO_SITUACAO, DE_SITUACAO FROM TB_SITUACOES where co_situacao in (1,7) ORDER BY DE_SITUACAO"
				'end if
                
                set fs=Server.CreateObject("ADODB.RecordSet")
                fs.Open query2, dados_sys 
                DO UNTIL fs.eof
					CO_SITUACAO=fs("CO_SITUACAO")
					DE_SITUACAO=fs("DE_SITUACAO")
					
					if ds("CO_SITUACAO") = CO_SITUACAO then
						response.write "<option selected='selected' value="&CO_SITUACAO&">"&DE_SITUACAO&"</option>"	
					else
						response.write "<option value="&CO_SITUACAO&">"&DE_SITUACAO&"</option>"
					end if		
					
					fs.movenext
                LOOP
                set fs = nothing
                %>
        </select></td>
    </tr>
    <tr>
      <td><label>Data: </label></td>
      <td><input class="datepicker" style="margin-top:5px;" name="data" id="data" size="8" type="text" value="<% response.write(DS("DT_INICIO"))%>" /></td>
    </tr>
    <tr>
      <td><label>Dias de Gozo:</label></td>
      <td><input class="form-field" style="margin-top:5px;" name="gozo" id="gozo" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(DS("QT_DIAS"))%>"/><label style="margin-left:20px">Parcelas:</label><input class="form-field" style="margin-top:5px;" name="parcelas" id="parcelas" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(DS("qt_parcelas"))%>"/></td>
    </tr>
    <tr>
      <td><label>Abono:</label></td>
      <td><input name="sn" type="radio" value="1" id="abono_sim" <% if DS("ic_abono") = "True" Then Response.Write "checked" END IF %>/>
        Sim
        <input name="sn" type="radio" value="0" id="abono_nao"  <% if DS("ic_abono") = "False" Then Response.Write "checked" END IF %>/>
        N&atilde;o <label style="margin-left:20px">Dias de Abono:</label><input class="form-field" style="margin-top:5px;" name="diasAbono" id="diasAbono" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(DS("dias_abono"))%>"/></td>
    </tr>
    <tr>
    <!--#ALTERADO EM 10/05/2016-->
      <td colspan="3"><input type="checkbox"  id="ic_aviso_assinado" name="ic_aviso_assinado"  value = "1" <% if DS("ic_aviso_assinado") = "True" Then Response.Write "checked" END IF %>/><label for="ic_aviso_assinado">Aviso de férias</label>
     <% if coordenadorOuGerente = "True" then %>
          <input type="checkbox"  id="ic_substituicao" name="ic_substituicao"  style="margin-right:-2px" value = "1" <% if DS("ic_substituicao") = "True" Then Response.Write "checked" END IF %>/><label for"ic_substituicao" style="padding-left:6px">Substituição</label>
    <%
	end if
	%>
     <% if maisDe50Anos and cint(ds("qt_dias")) < 30 then %>
<input type="checkbox"  id="ic_requerimento" name="ic_requerimento"  value = "1" <% if DS("ic_requerimento") = "True" Then Response.Write "checked" END IF %>/><label for="ic_requerimento">Requerimento parcelamento/pecúnia</label>
    <% end if %>
    </td>
    </tr>
    <!-------------------------------------->
    <% 
			  '#Alterado em 17/03/2016 -------------------------------
			  tipo_prazo_demanda = 3
			  '-------------------------------------------------------
			  %>
    <!-- #INCLUDE FILE ="include_campo_datas.asp" --> 
    <!-- '#ALTERADO EM 11/04/2014 --> 
    <!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->
    
  </table>
  <div id="receberLink"></div>
  <div align="center">
    <p/>
    <!-- <input type = "submit" class="myButton" id='salvar' style='margin:16px;' value="Salvar" > -->
    <input type = "button" class="myButton" id='editar'  value="Confirmar Edi&ccedil;&atilde;o"/ >
  </div>
  <input type="hidden" name="co_ferias" id="co_ferias" value="<%=co_ferias%>"/>
</form>
</div>
</div>
<% objConn.close%>
<!--fim do corpo-->
</div>
<%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Edição realizada com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
			response.write ("<script language=""javascript""> window.close(); </script>")
		
		else 
		
			if( sucesso="false" ) then
		
				response.write ("<script language=""javascript""> alert('Erro na edição das f&eacute;rias.'); </script>")
		
			end if	
				
		end if
		
		%>
<!--teste-->
</body>
</html>
