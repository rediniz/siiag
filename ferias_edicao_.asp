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

	$('#editar').on('click',function(){

			if ($("#gozo").val()=="" || $("#gozo").val()=="0"){
				alert("Preencha os dias de gozo.")
				return false;
			}

			if ($("#parcelas").val()=="" || $("#parcelas").val()=="0"){
				alert("Preencha os dias de parcelas.")
				return false;
			}




			//alert("Editado com Sucesso");
			var matricula = $("#matricula").val();
			var situacao = $("#situacoes").val();
			var data = $(".datepicker").val();
			var gozo = $("#gozo").val();
			var nome = $("#nome").val();
			var parcelas = $("#parcelas").val();
			var diasAbono = $("#diasAbono").val();
			var co_ferias = $("#co_ferias").val();
			var abono;

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

			var confirmacao = window.confirm("Confirmar a Edição?");
			//inclusao das novas datas	
			if (confirmacao ==1){
window.location.assign("ferias_editar_con.asp?matricula="+matricula+"&situacao="+situacao+"&data="+data+"&gozo="+gozo+"&parcelas="+parcelas+"&diasAbono="+diasAbono+"&abono="+abono+"&nome="+nome+"&co_ferias="+co_ferias+"&dt_ini_atdmt="+$("#dt_ini_atdmt").val()+"&dt_prev_conc="+$("#dt_prev_conc").val()+"");
			}

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
<%
co_ferias = request("co_ferias")

set ds=Server.CreateObject("ADODB.RecordSet")
SQL = "SELECT * FROM TB_FERIAS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE CO_FERIAS = " & co_ferias & ""
'response.write SQL
ds.Open SQL, dados_sys
'response.write ds("co_matricula")

'******
%>

    <!--corpo-->
<%	
'#ALTERADO em 08/11/2015 (adicionado)=============
dt_ini_atdmt = ds("DT_INI_ATDMT")
dt_prev_conc = ds("dt_prev_conc")
'==================================================
%>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:0px">
      
          <legend class="style2 style3">Edi&ccedil;&atilde;o de F&eacute;rias </legend>
         
<span class="style4 style2">
            
            <form ACTION="ferias_editar_con.asp" name="formferias" method="POST">
            
            
			<br/>
            <label>Matr&iacute;cula: <% =ds("co_matricula")%> - <% =ds("co_digito")%> </label>
            <!--<input style="border:none;" id="matricula" value="<% =ds("co_matricula")%>"/> -->
 	
              
              <br/>  
              <br/>
                
                
              <label>Nome: <% response.write(DS("NO_nome"))%>
             <!-- <input style="border:none;"  id="nome" value="<% response.write(DS("NO_nome"))%>"/> -->
              </label>
            	
                
              <br/>  
              
                
                
                
              <label>Situação:</label>
              
              <select name="situacoes" id="situacoes" style="margin-right:8px;">
           			<option value="1" <% if DS("CO_situacao")= 1 Then response.Write " selected='selected' " End If%>> Solicitado </option>
                    <option value="2" <% if DS("CO_situacao")= 2 Then response.Write " selected='selected' " End If%>> Confirmado </option>
                    <option value="3" <% if DS("CO_situacao")= 3 Then response.Write " selected='selected' " End If%>> Pendente </option>
                    <option value="5" <% if DS("CO_situacao")= 5 Then response.Write " selected='selected' " End If%>> Gozado </option>
                    <option value="6" <% if DS("CO_situacao")= 6 Then response.Write " selected='selected' " End If%>> N&atilde;o Atendido </option>
                    <option value="7" <% if DS("CO_situacao")= 7 Then response.Write " selected='selected' " End If%>> Cancelado </option>
                    <option value="8" <% if DS("CO_situacao")= 8 Then response.Write " selected='selected' " End If%>> Em Andamento </option>

               </select>
              
             
              
              
             
              <label>Data: </label>
              
              <input class="datepicker" style="margin-top:5px;" name="datepicker" size="8" type="text" value="<% response.write(DS("DT_INICIO"))%>" />
              
              <br/>
              
          
              <div style="border:#000000 solid 0px;">
              
              
               <label>Quantidade de dias de Gozo</label>
   		 		<input class="form-field" style="margin-top:5px;" name="gozo" id="gozo" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(DS("QT_DIAS"))%>"/>
                
                
              
              <label>Parcelas</label>
              <input class="form-field" style="margin-top:5px;" name="parcelas" id="parcelas" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(DS("qt_parcelas"))%>"/>
              
              
              
              <br/>
              <label>Abono:</label>
              
              <input name="sn" type="radio" value="1" id="abono_sim" <% if DS("ic_abono") = "True" Then Response.Write "checked" END IF %>/>Sim
              <input name="sn" type="radio" value="0" id="abono_nao"  <% if DS("ic_abono") = "False" Then Response.Write "checked" END IF %>/> N&atilde;o
             
     
              
              <label style="margin-left:28px;">Dias de Abono</label>
              <input class="form-field" style="margin-top:5px;" name="diasAbono" id="diasAbono" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(DS("dias_abono"))%>"/>
</div>
         
            
<!--#ALTERADO em 29/02/2015 (adicionado)#-->  
<table>
<% 
tipo_prazo_demanda = 3
prazo = dateadd("d",-30 , DS("DT_INICIO")) 
%>
<!-- #INCLUDE FILE ="include_campo_datas.asp" -->
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
