<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Editar Substituição</title>
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
<script type="text/javascript">
	$(document).ready(function() {
	
		$(document).on("change", "#gerentes", function() {
		
      		$.ajax({
		
       			
       			url: "substituicao_consulta_gerente.asp?gerente="+$("#gerentes").val(), 
        		dataType: "html", // TIPO DE DADOS DE RETORNO
				//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
				beforeSend: function() { // ANTES DA REQUISIÇÃO
        		},
        		complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
            		//$("#carregando").hide();  
            	},
        		success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
          		$("#substitutos").html(data);		  
        		},
		 		error: function(data) { // CASO OCORRA ERRO NA REQUISIÇÃO
					alert("Erro ao carregar substitutos.");
 				}
      		})
  
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
$(document).ready(function() {
	
	
	    //1 #ALTERADO em 18/04/2016-----------------------
		var empregado = $("#co_empregado").val();
		var substituto = $("#co_substituto").val();
		var gerente = false;
		if(empregado == "C022903"){
			gerente = true;
		}
			$.ajax({
				url: "substituicao_consulta_empregados.asp?gerente="+gerente+"&edicao=true&empregado="+empregado+"&substituto="+substituto,
				success: function(data) {
					//alert(data);
					$("#substitutos").html(data);
				},
				error: function(data) {
					console.log(data.responseText);
					alert("Erro ao carregar empregados.");
				}
        	});
		//---------------------------------------------------

	$('#salvar').on('click',function(){



			var confirmacao = window.confirm("Salvar a edição?");
			
			if (confirmacao ==1){
			
			var gerente = $("#gerentes").val();
			var substituto = $("#substitutos").val();
			var motivo = $("#motivo").val();
			var data_inicio = $("#data_inicio").val();
			var data_fim = $("#data_fim").val();
			var situacao = $("#situacao").val();			
			var co_substituicao = $("#co_substituicao").val();
			var co_tipo_afastamento = $("#co_substituicao").val();				
					
			   	$.ajax({
		
       			
					url: "substituicao_edicao_con.asp",
					dataType: "html", // TIPO DE DADOS DE RETORNO
						//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
					},
					data: $("#formSubstituicao").serialize(),
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
						//$("#carregando").hide();  
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						alert("Substituição editada com sucesso.");
						window.close();
					},
					error: function(data) { // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao editar substituição.");
					}
      		})


			
			}
	

		});
});
	
</script>  

  

<style>


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

</head>

<body>
  <!--fundo azul do meio-->

<!--'****** CONEXÃO COM O BANCO DE DADOS -->
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<%
Perfil_Acesso("25") 
if not perfil_acesso_siiag then
	response.Redirect ("acesso_negado.asp")
end if
%>

    <!--corpo-->
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:0px">
      
          <legend class="style2 style3">Editar Substituição</legend>
         
<span class="style4 style2">
            
<form  name="formSubstituicao" id="formSubstituicao" action='substituicao_edicao_con.asp' method="POST">
            
<table>
    <tr>
    <td><label>Empregado a ser substituído:</label></td>   
    <td> 

    <%
			'#ALTERADO EM 12/04/2016 (todo esse asp)	
			querySubstituicao = "select * from tb_substituicoes WHERE CO_SUBSTITUICAO = "&request("co_substituicao")&""
			
			resultado = objConn.execute(querySubstituicao)	
				
			queryEmpregado = "SELECT SUBSTITUICAO.CO_GERENTE, USUARIO.NO_NOME FROM TB_SUBSTITUICOES AS SUBSTITUICAO JOIN VW_USUARIOS AS USUARIO ON SUBSTITUICAO.CO_GERENTE= USUARIO.CO_MATRICULA WHERE CO_SUBSTITUICAO = "&request("co_substituicao")&""
			
			resultado2  = objConn.execute(queryEmpregado)
			
		    co_empregado  =  resultado2("CO_GERENTE")
			'2 #ALTERADO em 18/04/2016
			response.write("<input type='hidden' id='co_empregado' name='co_empregado' value="&co_empregado&">")
			no_empregado  =  resultado2("NO_NOME")
			co_substituto =  resultado("CO_SUBSTITUTO")
			'3 #ALTERADO em 18/04/2016
			response.write("<input type='hidden' id='co_substituto' name='co_substituto' value="&co_substituto&">")
					
			'#ALTERADO em 01/12/2015 (adicionado)=====
			dt_ini_atdmt = resultado("dt_ini_atdmt")
			dt_prev_conc = resultado("dt_prev_conc")
			'=========================================
			
			'#ALTERADO EM 11/04/2016
			observacaoEdicao = resultado("OBS_EDICAO")


			response.write "<label>" & co_empregado & "</label> - <input style='border:none;width:312px' disabled='disabled' id='matricula' value='" & no_empregado&"' width='300px'/>"

	%>
	
      
    </td>
     </tr>
     <tr>
     <td><label>Empregado Substituto:</label></td>
     <td>         <select id="substitutos" name="substitutos" class="form-select" style="width:316px">
               <%
				matriculaUsuario = Session("v_Usuario_Matricula")
				queryColaboradores = "SELECT * FROM VW_USUARIOS WHERE CO_GS = (SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '"&matriculaUsuario&"') AND IC_ATIVO=1 AND LETRA = 'C'"
				
				set ds=Server.CreateObject("ADODB.RecordSet")
                ds.Open queryColaboradores, dados_sys 
				
				DO UNTIL ds.eof
				
			%>
              <option <%if ds("CO_MATRICULA") = co_substituto then%> selected="selected" <%end if%> value=<%=ds("CO_MATRICULA")%>><%=ds("NO_NOME")%></option>       
            <%
				ds.movenext
			    LOOP
				ds.close
			%>
              
              </select></td>
     </tr>
     <tr>
     <td><label>Motivo:</label></td>
     <td><select id="motivo" name='motivo' class="form-select">
              	<option value="">Selecione um motivo...</option>
                     <%
            
					Query1 ="SELECT AFASTAMENTO.DE_TIPO_AFASTAMENTO, AFASTAMENTO.CO_TIPO_AFASTAMENTO FROM TB_TIPOS_AFASTAMENTO AS AFASTAMENTO JOIN TB_SUBSTITUICOES AS SUBSTITUICAO ON AFASTAMENTO.CO_TIPO_AFASTAMENTO=SUBSTITUICAO.CO_TIPO_AFASTAMENTO WHERE SUBSTITUICAO.CO_SUBSTITUICAO="&request("co_substituicao")&""
					
					resultado1 = objConn.execute(Query1)
					co_tipo = resultado1("CO_TIPO_AFASTAMENTO")
					
					Query2 = "SELECT DE_TIPO_AFASTAMENTO, CO_TIPO_AFASTAMENTO, CO_CAIXA FROM TB_TIPOS_AFASTAMENTO ORDER BY DE_TIPO_AFASTAMENTO"
			
		 
					set ds=Server.CreateObject("ADODB.RecordSet")
					ds.Open Query2, dados_sys 
					DO UNTIL ds.eof
						TIPO_AFASTAMENTO=ds("DE_TIPO_AFASTAMENTO")
						CO_TIPO_AFASTAMENTO=ds("CO_TIPO_AFASTAMENTO")
						CO_CAIXA=ds("CO_CAIXA")
						
						if co_tipo = CO_TIPO_AFASTAMENTO then
							response.write "<option selected='selected' value="&CO_TIPO_AFASTAMENTO&">"&TIPO_AFASTAMENTO&" - "&CO_CAIXA&"</option>"	
						else
							response.write "<option value="&CO_TIPO_AFASTAMENTO&">"&TIPO_AFASTAMENTO&" - "&CO_CAIXA&"</option>"
						end if
						
						ds.movenext
					LOOP
					set ds = nothing
            %>
              </select> </td>
     </tr>
     <tr>
     <td>     <label>Data &Iacute;nicio:</label></td>
     <td>     
              <%
				  query = "Select dt_inicio, dt_fim from tb_substituicoes where co_substituicao="&request("co_substituicao")&""
				  data_inicio = objConn.execute(query)("dt_inicio")
				  data_fim = objConn.execute(query)("dt_fim")		  
			  %>
              
              
              <input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write data_inicio %>"/></td>
     </tr>
              
     <tr>
     <td><label>Data Final:</label></td>
     <td> <input  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write data_fim %>"/></td>
     </tr>
     <tr>
     <td><label>Situação:</label></td>
     <td>
     <select id='situacao' name='situacao'  class="form-select">
     <%
		
	 query1 = "SELECT CO_SITUACAO FROM TB_SUBSTITUICOES WHERE CO_SUBSTITUICAO = " & request("co_substituicao") & "" 
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

						response.write "<option "
						if co_situacao_sub = CO_SITUACAO then
							response.write " selected='selected' "
						end if
						response.write " value="&CO_SITUACAO&">"&DE_SITUACAO&"</option>"	
									 
						fs.movenext
						
					LOOP
					set fs = nothing
	 	 	 
	 %>
     </select>
     
     </tr>
     <!--#Alterado em 01/12/2015 (adicionado) ===========-->
    <%tipo_prazo_demanda = 5%>
    <!-- #I NCLUDE FILE ="include_campo_datas.asp" -->
    <!--=================================================-->
    
    <!-- '#ALTERADO EM 11/04/2016 -->
	<!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->

    
    </table>
    <br />
 
  <%
  response.write "<input type='hidden' id='co_substituicao' name='co_substituicao' value="&request("co_substituicao")&">"
  %>
</form>  
   <div align="center">
    <button class="myButton" id="salvar">Salvar</button>
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
			
			response.write ("<script language=""javascript""> alert('Substituição editado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
			response.write ("<script language=""javascript""> window.close(); </script>")
		
		else 
		
			if( sucesso="false" ) then
		
				response.write ("<script language=""javascript""> alert('Erro na edição da substituição'); </script>")
		
			end if	
				
		end if
		
		%>
<!--teste-->
</body>
</html>
