<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
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
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon"><!--favicon -->

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


function chamarSubstitutos(){

 var gerencia_gerente = document.getElementById("gerentes").value;
 var gerente = document.getElementById("gerentes").selectedIndex.html;
 
 if (gerencia_gerente != ""){
 window.location.assign("substituicao.asp?cogs="+gerencia_gerente);

	}

}



</script>

<script>

function Salvar(){

 var gerencia_gerente = document.getElementById("gerentes").value;
 var substituto = document.getElementById("substitutos").value;
 var motivo = document.getElementById("motivo").value;
 var data_inicio = document.getElementById("data_inicio").value;
 var data_final = document.getElementById("data_final").value;
 var matricula_logado = document.getElementById("mat_usuario").value;
 var mat_gerente = document.getElementById("mat_gerente").value;
 
 
 if (gerencia_gerente == "" ||substituto == "" || motivo == "" || data_inicio == "" || data_final == ""){
 
 alert("Preencha todos os campos para concluir o pedido de substituição");
 
 }
 else{
 
  window.location.assign("substituicao_con.asp?data_inicio='"+data_inicio+"'&data_final='"+data_final+"'&motivo="+motivo+"&substituto='"+substituto+"'&gerencia_gerente="+gerencia_gerente+"&mat_gerente='"+mat_gerente+"'");
 
 }
 
/* alert(gerencia_gerente);
 alert(substituto);
 alert(motivo);
 alert(data_inicio);
 alert(data_final);*/
 

}

</script>


	   

</head>
<body>

<div class="teste"> <!--fundo azul do meio-->

<!-- #INCLUDE FILE ="topo.asp" -->



<div class="corposite"> <!--corpo-->
<%
'****** CONEXÃO COM O BANCO DE DADOS
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
			
'******
%>
<div class="container">

<div class="conteudo">

<div class="usuariodiv">

<div id='cssmenu'>
<ul>
   <li class='active'><a href='substituicao.asp'><span>Solicitar</span></a></li>
   <li ><a href='consultar_substituicao.asp'><span>Consultar</span></a></li>   
</ul>
</div></p>
<div id='submenu'>
<ul>
   <li id="opener"><a href='#'><span>Ajuda</span></a></li>
</ul>
</div>

<div id="dialog" title="Caixa de Ajuda">
	<p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
</div>

  <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
  <legend><span class="titulos">Solicitar Substitui&ccedil;&atilde;o</span></legend>
<p class="paragrafoteste">   
    
    		<%
			coordenacao = Request("cogs")
			
			%>
    
    <table>
    <tr>
    <td><label>Gerente:</label></td>   
    <td> 
    <select id="gerentes" class="form-select"  onchange="chamarSubstitutos();" style="width:316px">
              	  <option <% IF coordenacao=""   Then Response.Write "selected='selected'"  END IF %>value="0"></option>
                  <option <% IF coordenacao="5"  Then Response.Write "selected='selected'"  END IF %>value="5">Adriana Alves da Silva</option>
                  <option <% IF coordenacao="3"  Then Response.Write "selected='selected'"  END IF %>value="3">Alexandre Pinheiro Moreira</option>
                  <option <% IF coordenacao="7"  Then Response.Write "selected='selected'"  END IF %>value="7">Andrea Vieira Novais</option>
                  <option <% IF coordenacao="16" Then Response.Write "selected='selected'"  END IF %>value="16">Francisco Vinícius de Souza Nobre</option>
                  <option <% IF coordenacao="6"  Then Response.Write "selected='selected'"  END IF %>value="6">Jose Milton Alves</option>
                  <option <% IF coordenacao="9"  Then Response.Write "selected='selected'"  END IF %>value="9">Katia Maria Bastos Freire</option>
                  <option <% IF coordenacao="4"  Then Response.Write "selected='selected'"  END IF %>value="4">Paula Farias Lóscio</option>
                  <option <% IF coordenacao="2"  Then Response.Write "selected='selected'"  END IF %>value="2">Regina Lucia Oliveira Teles</option>
                  <option <% IF coordenacao="1"  Then Response.Write "selected='selected'"  END IF %>value="1">Ricardo de Castro Gonçalves</option>
    </select>

    </td>
     </tr>
     <tr>
     <td><label>Gerente Substituto:</label></td>
     <td>         <select id="substitutos" class="form-select" style="width:316px"> 
              <option value=" "> </option>
              
              <%
			  
			  cogs = Request("cogs")
			  'SELECT * FROM VW_USUARIOS WHERE (CO_GS = 6) AND (IC_ATIVO = 1) AND (CO_DIGITO <> 0) AND (CO_MATRICULA <> 'C022942')ORDER BY NO_NOME
			  
			  if cogs <> "" Then
			  
			 
			 Query4 ="SELECT CO_MATRICULA, NO_NOME FROM VW_USUARIOS WHERE (CO_GS = "&cogs&") AND (IC_ATIVO = 1) AND (CO_DIGITO <> 0) ORDER BY NO_NOME"
			
		 
            set ds=Server.CreateObject("ADODB.RecordSet")
            ds.Open Query4, dados_sys 
            DO UNTIL ds.eof
				MATRICULA_SUBSTITUTO=ds("CO_MATRICULA")
				NOME_SUBSTITUTO=ds("NO_NOME")
				response.write "<option value="&MATRICULA_SUBSTITUTO&">"&NOME_SUBSTITUTO&"</option>"
				ds.movenext
            LOOP
            set ds = nothing
			 

			  End IF
			  
			  
			  %>
             
              </select> </td>
     </tr>
     <tr>
     <td><label>Motivo:</label></td>
     <td><select id="motivo" class="form-select">
              	<option value=" "> </option>
                <%
            
					Query4 ="SELECT DE_TIPO_AFASTAMENTO, CO_TIPO_AFASTAMENTO FROM TB_TIPOS_AFASTAMENTO ORDER BY DE_TIPO_AFASTAMENTO"
			
		 
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
              
              
              <input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write data %>"/></td>
     </tr>
              
     <tr>
     <td><label>Data Final:</label></td>
     <td> <input  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8" value="<% Response.Write data %>"/></td>
     </tr>
     
    
    </table>


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
   
  <div align="left">
    <input name="salvar" class="myButton" type="button" value="Salvar" onclick="Salvar();" style="margin-left:7px"/>
    </div>
    
  </fieldset>

</div>

</div> 

<!--include do calendário-->

</div>

</div> <!--fim do corpo-->

<!-- #INCLUDE FILE ="rodape.asp" -->

</div> <!--teste-->


<%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Pedido realizado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
		
				
		end if
		
		%>


</body>
</html>