<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Edi&ccedil;&atilde;o de Jornada</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.mousewheel.js"></script>
<script src="scripts/globalize.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery.ui.button.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.timepicker.js"></script>
<script src="scripts/jquery.ui.mask.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<!--CSS-->

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

.ui-mask ui-spinner-input {

font-size:16px;

}
</style>

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
    <style type="text/css">
    <!--
        .style2 {
            font-size: 14
        }
        .style3 {
            color: #5683C4
        }


	.tipoarea{
	/*border:#000000 solid 1px;*/ float:left;
	
	}
	
	.destinoConteudo{
	/*border:#000000 solid 1px;*/
	float:right;
	
	
	}
	
	.responsavelFile{/*border:#000000 solid 1px;*/float:left;margin-top:15px;}
	
	#receberLink{/*border:#000000 solid 1px;*/ float:left;margin-top:15%;}
	
	.arOficio{/*border:#000000 solid 1px;*/}
	
	.arOficio label{margin-left:28%;}
	.arOficio input{margin-left:21%;margin-bottom:10%;}
	
	
-->

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

body{

background:#FFFFFF;

}

    </style>
  
<script>
$(document).ready(function() {

	$('#salvar').on('click',function(){



			var confirmacao = window.confirm("Confirmar a Edição?");
			
			if (confirmacao ==1){

	//			//alert("Editado com Sucesso");
	//			
	//			var CO_MATRICULA = $("#CO_MATRICULA").val();
	//			var NO_NOME = $("#NO_NOME").val();
	//			var CO_SITUACAO = $("#CO_SITUACAO").val();
	//			var DH_ENTRADA = $("#DH_ENTRADA").val();
	//			var DH_SAIDA = $("#DH_SAIDA").val();
	//			var DH_VIGENCIA = $("#DH_VIGENCIA").val();
	//			var CO_JORNADA = $("#CO_JORNADA").val();
	//	
	//			window.location.assign("jornada_editar_con.asp?CO_MATRICULA="+CO_MATRICULA+"&NO_NOME="+NO_NOME+"&CO_SITUACAO="+CO_SITUACAO+"&DH_ENTRADA="+DH_ENTRADA+"&DH_SAIDA="+DH_SAIDA+"&DH_VIGENCIA="+DH_VIGENCIA+"&CO_JORNADA="+CO_JORNADA+"&nome="+nome+"");

			$("#formulario").submit()
			
		//	$.ajax({
//		
//       			data: $("#formulario").serialize(), // DADOS A SEREM PASSADOS PARA O SERVIDOR
//       			url: "jornada_editar_con.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
//        		dataType: "html", // TIPO DE DADOS DE RETORNO
//				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
//				beforeSend: function() { // ANTES DA REQUISIÇÃO
//        			//$("#carregando").show(); 
//        		},
//        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
//            		//$("#carregando").hide();  
//            	},
//        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
//          			alert("Jornada editada com sucesso."); 	
//					window.close();
//        		},
//		 		error: function(data){ // CASO OCORRA ERRO NA REQUISIÇÃO
//					alert("Erro ao alterar jornada.");  
// 				}
//		
//	     		})
			
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

    
    	<script>
	$(function() {
		$("#culture").change(function() {
			$( "input" ).timepicker( "option", "culture", $( this ).val() );
		});
		function setup() {

			$("#horario_inicio").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#horario_fim").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#intervalo_inicio").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
			$("#intervalo_fim").timepicker({ ampm: false, seconds: false, culture: "de-DE"});
		}
		setup();
	});
	</script>

</head>

<body>
  <!--fundo azul do meio-->

<!--'****** CONEXÃO COM O BANCO DE DADOS -->
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<%
CO_JORNADA = Request("codigo")

Perfil_Acesso_cookie("23") 
if not perfil_acesso_siiag then
	response.Redirect ("acesso_negado.asp")
end if


set ds=Server.CreateObject("ADODB.RecordSet")

'#Alterado em 01/12/2015 (select simplificado e agora traz dt_ini_atdmt e dt_prev_conc)
SQL = "SELECT * FROM TB_JORNADA AS JORNADA INNER JOIN VW_USUARIOS AS USUARIOS ON JORNADA.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE JORNADA.CO_JORNADA = "&CO_JORNADA&""
'response.write SQL
ds.Open SQL, dados_sys

'#ALTERADO em 01/12/2015 (adicionado)#
dt_ini_atdmt = ds("dt_ini_atdmt")
dt_prev_conc = ds("dt_prev_conc")

'#ALTERADO EM 11/04/2014
observacaoEdicao = ds("OBS_EDICAO")

%>

 <!--corpo-->
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Edição de Jornada</span></legend>
          <p class="paragrafoteste">
          <form  id="formulario" name="formulario" action="jornada_editar_con.asp">
          <table>
          <tr>
          <td align="left"><label>Colaborador:</label> </td>
          <td align="left"><input class="form-field"  readonly="readonly" name="matricula" id="matricula"  type="text" size="7" maxlength="7" value="<% =ds("CO_MATRICULA")%>"/><input class="form-field" name="nome" id="nome"   readonly="readonly" type="text" size="50" maxlength="70" style="margin-left:10px" value="<% response.write(DS("NO_NOME"))%>" /></td>
          </tr>
          <tr>
          <td><label>Hora de Entrada:</label></td>
           <td><input id="horario_inicio" name="horario_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="<%=FORMATdatetime(ds("DH_ENTRADA"), 4)%>"/>
            <label style = "margin-left:20px; margin-right:13px">Hora de Sa&iacute;da:</label>
            <input id="horario_fim" name="horario_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="<%=FORMATdatetime(ds("DH_SAIDA"), 4)%>"/>
            
          </td>
            
          </tr>
          <tr>
          <td>  <label>Início do intervalo:</label></td>
            
          <td><input id="intervalo_inicio" name="intervalo_inicio" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="<%=FORMATdatetime(ds("DH_INTERVALO_INICIO"), 4)%>"/>
            <label style = "margin-left:20px" >Fim do intervalo:</label>
            <input id="intervalo_fim" name="intervalo_fim" class="ui-mask ui-spinner-input" autocomplete="off" role="spinbutton" size="4" value="<%=FORMATdatetime(ds("DH_INTERVALO_FIM"), 4)%>"/> </td>
          </tr>
          <tr>
          <td>  <label>A partir de:</label></td>
          <td>  <input  name="data" id="data" class="datepicker" type="text" size="8" maxlength="8" value="<%=ds("DH_VIGENCIA")%>"/></td>
          </tr>
           <tr>
          <td>  <label>Situação:</label></td>
          <td>  <select id="situacao" name="situacao" class="form-select">
     <%
		
	query1 = "SELECT CO_SITUACAO FROM TB_JORNADA WHERE CO_JORNADA = " & request("codigo") & "" 
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
     </select></td>
          </tr>
          
          <!--#Alterado em 01/12/2015 (adicionado)================-->
          <%tipo_prazo_demanda = 4%>
          <!-- #INCLUDE FILE ="include_campo_datas.asp" -->
          <!--======================================================-->
          <!-- '#ALTERADO EM 11/04/2014 -->
		  <!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->
          </p>
          </table>

          <input type="hidden" name="co_jornada" id="co_jornada" value=<%=request("codigo")%>> 
          </form>
          </p>
          <div align="center">
         <button class="myButton" id="salvar" name="salvar" style="margin-left:8px">Salvar</button>
          </div>
          </p>
          </fieldset>
    
     </div>
    
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
		
				response.write ("<script language=""javascript""> alert('Erro na edição da jornada.'); </script>")
		
			end if	
				
		end if
		
		%>
<!--teste-->
</body>
</html>
