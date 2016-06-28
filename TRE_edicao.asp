<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Edição de TRE</title>
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
				//alert(matricula);
	//			alert(nome);
	//			alert(situacao);
	//			alert(data);
	//			alert(gozo);
	//			alert(parcelas);
	//			alert(diasAbono);
	//			alert(abono);
	//			alert(co_ferias);
	//			
				
				
				
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
			var confirmacao = window.confirm("Confirmar a Edição?");
			
			if (confirmacao ==1){
				//window.location.assign("ferias_editar_con.asp?matricula="+matricula+"&situacao="+situacao+"&data="+data+"&gozo="+gozo+"&parcelas="+parcelas+"&diasAbono="+diasAbono+"&abono="+abono+"&nome="+nome+"&co_ferias="+co_ferias+"");
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


	$('#bt_salvar').on('click',function(){
	
		var qt_add = $("#inputAddQtd").val();
		var arquivo = $("#arquivo1").val();
		
		if (qt_add <= 0 || qt_add == "")
		{
			alert("Preencha a quantidade de dias!");
			return false;
		}
		
		/*if (arquivo == "")
		{
			alert("Selecione um arquivo");
			return false;
		}*/
		
		$("#form").submit();
	
	});
	
});

</script>

</head>

<body>
  <!--fundo azul do meio-->

<!--'****** CONEXÃO COM O BANCO DE DADOS -->
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
co_usuario = request("co_usuario")

set ds=Server.CreateObject("ADODB.RecordSet")
strQuery = 	"SELECT * FROM VW_TRE WHERE co_matricula = '" & co_usuario & "'  " 	
'response.write SQL
ds.Open strQuery, dados_sys
'response.write ds("co_matricula")

'******
%>

    <!--corpo-->
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:0px">
      
          <legend class="style2 style3">Edi&ccedil;&atilde;o de TRE </legend>
         
<span class="style4 style2">
            

            <table border="0">
            <tr>
            <td width="130px">
    	        <label>Matr&iacute;cula:</label>
            <!--<input style="border:none;" id="matricula" value="<% =ds("co_matricula")%>"/> -->
			</td>
            <td>
	            <label><% =ds("co_matricula")%> - <% =ds("co_digito")%> </label>            
            </td>
			</tr>
            <tr>
            <td>                
             <label>Nome:</label>
			</td>
            <td>                
             <label><% response.write(DS("NO_nome"))%></label>

			</td>

			</tr>
            <tr>
            <td>          
               <label>Folgas disponíveis:</label>
			</td>
            <td>          
				<label><%=ds("qt_dias") - ds("qt_dias_utilizado")%></label>
			</td>
            </tr>

			<tr>
			<td style="text-align:center;" colspan="2">	
            <br>		
       	        <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:0px">
		        <legend class="style2 style3">Incluir folgas</legend>
                <form  ENCtype="multipart/form-data" method="post" target="_self" action="TRE_salvar_arquivo.asp" name="form" id="form" >
                <input type="hidden" name="co_matricula" id="co_matricula" value="<% =ds("co_matricula")%>" >
                <center>
                    <table border="0" style="text-align:center">
                    <tr>
                    <td style="vertical-align:middle; text-align:left" >       
                        <label>Quantidade:</label>
                    </td>
                    <td style="vertical-align:middle; text-align:left;" >       
                        <input  class="form-field" name="inputAddQtd" type="text" id="inputAddQtd" size="1"   width="2px" maxlength="4" style="margin-left:0px" style="clear:right"/>
                    </td>
                    </tr>
                    <tr>
                    <td style="vertical-align:middle; text-align:left;" >       
                        <label>Arquivo declaração TRE:</label>
                    </td>
                    <td style="vertical-align:middle; text-align:left;" >       
                         <input type="file" class="arquivo" id="arquivo1" name="arquivo1" style="display:'';"/> 
                    </td>
                    </tr>
    
                    <tr>
                    <td style="vertical-align:middle; text-align:center" colspan="2" >       
                       <input class="myButton" type="button" id="bt_salvar" name="bt_salvar" value="Salvar"  />
                    </td>
                    </tr>
    
                    </table>
                </center>
                </form>
                </fieldset>
			</td>
            </tr>

			</table>
			<br>
            <table>
            <tr>
            <td colspan="2">          
              <iframe name="frame_extrato" id="frame_extrato"  src="tre_historico.asp?co_matricula=<%=co_usuario%>&nao_exibir_adiciona_folga=1"  frameborder="0"  width="450" height="135">
			</td>
			</tr>
			</table>    
    
            
            
            

    <div id="receberLink"></div>
     
     <div align="center">
     <p/>
    <!-- <input type = "submit" class="myButton" id='salvar' style='margin:16px;' value="Salvar" > -->
    <input type = "button" class="myButton" id='editar'  value="Confirmar Edi&ccedil;&atilde;o"/ >
    
     </div>
<input type="hidden" name="co_ferias" id="co_ferias" value="<%=co_ferias%>"/>

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
