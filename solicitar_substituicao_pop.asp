<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"> 

<title>Solicitar Substitui&ccedil;&atilde;o</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="../imagens/siiag-logo.ico" type="image/x-icon"><!--favicon -->

<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	
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

		$( "#opener" ).click(function() {
			$( "#dialog" ).dialog( "open" );
		});
	});
</script>
    
<!-- fecha efeito da janela de ajuda -->

<script>

function Salvar(){

	if($("#perfil_substituicao_solicitar").val()=="False"){
		alert("Você não tem permissão para solicitar substituição.")
		return false;
	}

	
	var gerencia_gerente = document.getElementById("gerentes").value;
	var substituto = $("#substitutos").val();
	var motivo = document.getElementById("motivo").value;
	var data_inicio = document.getElementById("data_inicio").value;
	var data_final = document.getElementById("data_final").value;
	var matricula_logado = document.getElementById("mat_usuario").value;
	//var mat_gerente = document.getElementById("mat_gerente").value;
	//alert(matricula_logado);

	if (gerencia_gerente == "" ||substituto == "" || motivo == "" || data_inicio == "" || data_final == ""){
		alert("Preencha todos os campos para concluir o pedido de substituição");
	}
	else{
		window.location.assign("solicitar_substituicao_pop_con.asp?data_inicio="+data_inicio+"&data_final="+data_final+"&motivo="+motivo+"&substituto="+substituto+"&gerencia_gerente="+gerencia_gerente+"&mat_gerente="+gerencia_gerente);
	}
 
}

</script>


	   

</head>
<body>


<div class="teste"> <!--fundo azul do meio-->

<div class="corposite"> <!--corpo-->
<%
'****** CONEXÃO COM O BANCO DE DADOS

set ds=Server.CreateObject("ADODB.RecordSet")

%>
<div class="container" style="width:600px;">
<br/><br/>
<div class="conteudo2" style="width:500px;height:auto; margin:auto">
<div class="usuariodiv">


  <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:2px;">
  <legend><span class="titulos">Solicitar Substitui&ccedil;&atilde;o</span></legend>
<p class="paragrafoteste">   
    
    		<%
			coordenacao = Request("cogs")			
			%>
            
            
            <%
			matricula = Request("matricula")
			dataInicio = Request("dataInicio")
			dataFim = Request("dataFim")
			%>
    
    <table align="center">
    <tr>
    <td><label>Gerente:</label></td>   
    <td> 

	        <select name="gerentes" id="gerentes" class="form-select" style="width:316px">
              <option  value="">Selecione o Gerente/Coordenador</option>     
              <%
			
				query_coordenadores = "SELECT GS.CO_GS, GS.CO_GERENTE, USUARIO.CO_MATRICULA, USUARIO.NO_NOME FROM VW_GS AS GS JOIN TB_USUARIOS AS USUARIO ON GS.CO_GERENTE=USUARIO.CO_MATRICULA WHERE GS.IC_ATIVO = 1 AND GS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" AND CO_MATRICULA = '"&matricula&"' ORDER BY USUARIO.NO_NOME"
				
				set ds=Server.CreateObject("ADODB.RecordSet")
                ds.Open query_coordenadores, dados_sys 
				
				DO UNTIL ds.eof
				
			%>
              <option value=<%=ds("CO_MATRICULA")%> selected="selected"><%=ds("NO_NOME")%></option>       
            <%
				ds.movenext
			    LOOP
			%>
            
            </select>
      
    </td>
     </tr>
     <tr>
     <td><label>Gerente Substituto:</label></td>
     <td>         	<select id="substitutos" class="form-select" style="width:316px"> 
             
             <%
			 query = "SELECT CO_MATRICULA, NO_NOME FROM VW_USUARIOS WHERE letra = 'C' and (CO_GERENTE = '"&matricula&"') AND (IC_ATIVO = 1) AND (CO_MATRICULA <> '"&matricula&"') AND (CO_CARGO <> 11) ORDER BY NO_NOME"
  			 set ds=Server.CreateObject("ADODB.RecordSet")
           	 ds.Open query, dados_sys
           	 DO UNTIL ds.eof
						MATRICULA_SUBSTITUTO=ds("CO_MATRICULA")
						NOME_SUBSTITUTO=ds("NO_NOME")
						response.write "<option value="&ds("CO_MATRICULA")&">"&NOME_SUBSTITUTO&"</option>"	
				ds.movenext
            LOOP
            set ds = nothing
  
  			set query = nothing

			%>
			
             
              		</select> 
              
              </td>
     </tr>
     <tr>
     <td><label>Motivo:</label></td>
     <td><select id="motivo" class="form-select">
              	<option value="">Selecione um motivo...</option>
                <%
            
					Query4 ="SELECT DE_TIPO_AFASTAMENTO, CO_TIPO_AFASTAMENTO FROM TB_TIPOS_AFASTAMENTO WHERE IC_ATIVO = 1 ORDER BY DE_TIPO_AFASTAMENTO"
			
		 
					set ds=Server.CreateObject("ADODB.RecordSet")
					ds.Open Query4, dados_sys 
					DO UNTIL ds.eof
						TIPO_AFASTAMENTO=ds("DE_TIPO_AFASTAMENTO")
						CO_TIPO_AFASTAMENTO=ds("CO_TIPO_AFASTAMENTO")
						response.write "<option value="&CO_TIPO_AFASTAMENTO&">"&TIPO_AFASTAMENTO&"</option>"							 
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
			  
			  data = DAY(DATE)&"/"&MONTH(DATE)&"/"&YEAR(DATE)
			  
			  %>
              
              
              <input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write dataInicio %>"/></td>
     </tr>
              
     <tr>
     <td><label>Data Final:</label></td>
     <td> <input  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write dataFim %>"/></td>
     </tr>
     
    
    


        <%
              response.write "<input type='hidden' id='mat_usuario' value="&usuario&" />"  
			  
			  if cogs <> "" and cogs <> 0 Then
			  
				Query4 ="SELECT CO_GERENTE FROM VW_GS WHERE (CO_GS = "&cogs&") AND (IC_ATIVO = 1)"
				set ds=Server.CreateObject("ADODB.RecordSet")
				ds.Open Query4, dados_sys 
				matricula_gerente=ds("CO_GERENTE")
				response.write "<input type='hidden' id='mat_gerente' value="& matricula_gerente &" />"
				set ds = nothing

			  End IF
		%>	   
            </p>
  </p>
   
 
    <tr><td colspan="2"><input name="salvar" class="myButton" type="button" value="Salvar" onclick="Salvar();" style="margin-left:40%;"/></td></tr>
    
  </table> 
    
  </fieldset>

</div>

</div> 

<!--include do calendário-->

</div>

</div> <!--fim do corpo-->



</div> <!--teste-->


<%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			response.write ("<script language=""javascript""> alert('Pedido realizado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.assign('destacamento_consultar.asp'); </script>")
			response.write ("<script language=""javascript""> window.close(); </script>")
		end if
		
		%>


</body>
</html>