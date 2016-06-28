<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
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



			var confirmacao = window.confirm("Confirmar a Edição?");
			
			if (confirmacao ==1){

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
			
			if (diasAbono != ""){
			
			abono = 1;
			}
			else{
			abono = 0;
			}
			
			//alert(matricula);
			//alert(nome);
			//alert(situacao);
			//alert(data);
			//alert(gozo);
			//alert(parcelas);
			//alert(diasAbono);
			//alert(abono);
			
			
			
			
			//var nome = $(this).parent().parent().find("#nome").html()
//			var data = $(this).parent().parent().find("#data").html()
//			var descricao = $(this).parent().parent().find("#descricao").html()
//			var dtcriacao= $(this).parent().parent().find("#dtcriacao").html()
//			var empregadosolicitante = $(this).parent().parent().find("#empregadosolicitante").html()
//			var dias = $(this).parent().parent().find("#dias").html()
//			var qt_parcelas = $(this).parent().parent().find("#qt_parcelas").val()
//			var dias_gozo = $(this).parent().parent().find("#dias_gozo").val()
//			
//			var ic_abono = $(this).parent().parent().find("#ic_abono").val()
//			
//			var situacao = $(this).parent().parent().find("#situacao").val()
			
			window.location.assign("pend_ferias_edicao.asp?matricula="+matricula+"&situacao="+situacao+"&data="+data+"&gozo="+gozo+"&parcelas="+parcelas+"&diasAbono="+diasAbono+"&abono="+abono+"&nome="+nome+"&co_ferias="+co_ferias+"");
			
			}
			
			

		});
	});
	
</script>  


<script>
$(document).ready(function() {


$("#abono_nao").on("click", function(){ 
 $("#diasAbono").val("");
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
<%
'****** CONEXÃO COM O BANCO DE DADOS

set ds=Server.CreateObject("ADODB.RecordSet")
			
'******
%>

 
    <!--corpo-->
  
    
        
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:0px">
      
          <legend class="style2 style3">Edi&ccedil;&atilde;o de F&eacute;rias </legend>
         
<span class="style4 style2">
            
            <form ACTION="ferias_editar_con.asp" name="formferias" method="POST">
            
            
			<br/>
            <label>Matr&iacute;cula:</label><input style="border:none;" disabled="disabled" id="matricula" value="<% response.write(request("matricula"))%>"/>
 	
              
              <br/>  
              <br/>
                
                
              <label>Nome: <input style="border:none;" disabled="disabled" id="nome" value="<% response.write(request("nome"))%>"/> </label>
            	
                
              <br/>  
              
                
                
                
              <label>Situação:</label>
              
              <select name="situacoes" id="situacoes" style="margin-right:8px;">
           			<option value="1" <% if request("situacao")= 1 Then response.Write " selected='selected' " End If%>> Solicitado </option>
                    <option value="2" <% if request("situacao")= 2 Then response.Write " selected='selected' " End If%>> Confirmado </option>
                    <option value="3" <% if request("situacao")= 3 Then response.Write " selected='selected' " End If%>> Pendente </option>
                    <option value="5" <% if request("situacao")= 5 Then response.Write " selected='selected' " End If%>> Gozado </option>
                    <option value="6" <% if request("situacao")= 6 Then response.Write " selected='selected' " End If%>> N&atilde;o Atendido </option>
                    <option value="7" <% if request("situacao")= 7 Then response.Write " selected='selected' " End If%>> Cancelado </option>
                    <option value="8" <% if request("situacao")= 8 Then response.Write " selected='selected' " End If%>> Em Andamento </option>

               </select>
              
             
              
              
             
              <label>Data: </label>
              
              <input class="datepicker" style="margin-top:5px;" name="datepicker" size="10" maxlength="10" type="text" value="<% response.write(request("data"))%>" />
              
              <br/>
              
          
              <div style="border:#000000 solid 0px;">
              
              
               <label>Quantidade de dias de Gozo</label>
   		 		<input class="form-field" style="margin-top:5px;" name="gozo" id="gozo" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(request("gozo"))%>"/>
                
                
              
              <label>Parcelas</label>
              <input class="form-field" style="margin-top:5px;" name="parcelas" id="parcelas" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(request("qt_parcelas"))%>"/>
              
              
              
              <br/>
              <label>Abono:</label>
              
              <input name="sn" type="radio" value="1" id="abono_sim" <% if request("ic_abono") = "True" Then Response.Write "checked" END IF %>/>Sim
              <input name="sn" type="radio" value="0" id="abono_nao"  <% if request("ic_abono") = "False" Then Response.Write "checked" END IF %>/> N&atilde;o
             
     
              
              <label style="margin-left:28px;">Dias de Abono</label>
              <input class="form-field" style="margin-top:5px;" name="diasAbono" id="diasAbono" size="1" style="max-width:2px;max-width:2px;" type="text" value="<% response.write(request("diasdeabono"))%>"/>
             
              
    
    		</div>
    
    
    
            
            
            

    <div id="receberLink"></div>
     
     <div align="center">
     <p/>
    <!-- <input type = "submit" class="myButton" id='salvar' style='margin:16px;' value="Salvar" > -->
    <input type = "button" class="myButton" id='editar'  value="Confirmar Edi&ccedil;&atilde;o"/ >
    
     </div>
<input type="hidden" name="co_ferias" id="co_ferias" value="<% response.write(request("co_ferias"))%>"/>
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
			
			response.write ("<script language=""javascript""> alert('F&eacute;rias editado com sucesso.'); </script>")
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
