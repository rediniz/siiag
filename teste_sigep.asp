<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<title>Solicitar F&eacute;rias</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<%
 mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i))
				End If
                %>
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

.alinhador{
/*border:#000000 solid 1px;*/
width:351px;




}
.datepicker1 {			
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
.datepicker11 {			height:15px;
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
</style>

<script type="text/javascript" language="javascript">

	$(document).ready(function(){
var abono=false;
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
				  
				
 

 
 $("#abono_sim").on("click", function(){ 
 $("#diasAbono").prop("disabled", false);
 });
 
 
 $("#abono_nao").on("click", function(){ 
 $("#diasAbono").val("");
 $("#diasAbono").prop("disabled", true);
 
 });
		
/*$("#solicitar").on("click", function(){ 

 if($("#mat_usuario").val() != "C054423" || $("#mat_usuario").val() != "C097105"){
 alert("Você não está autorizado a solicitar férias.")
 
 }
 });*/	
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
<script src="scripts/jquery.ui.core.js"></script>
<!-- efeito da janela de ajuda -->

    
 <script>
 

 
 function habilitaDias()		
	{
		var ativo = document.getElementById("1").value;
		//alert(tipoProtocolo);
		
		//alert(ativo);	
			if (ativo == 1){
			
				$("#quantDias").prop("disabled", false);
				 
			}else{
				$("#quantDias").prop("disabled",true);
	
			}
		}
		
	
 
 </script> 
   


 
 
 <script>

	$(document).ready(function() { 
		
		$('#solicitar').on('click',function(){	
		
		if($("#perfil_ferias").val()=="False"){
			alert("Você não tem permissão para solicitar férias.")
			return false;
		}
		
		
		
			var usuario_logado = $("#mat_usuario").val()  //pegando matricula logada
			
			var IC_GERENTE = $("#ic_gerente").val()
			
			
			var matricula = $("#matricula").val()  
			var nome = $("#nome").val()
			var data_inicio = $("#data_inicio").val()
			var gozo = $("#gozo").val()
			var parcelas = $("#parcelas").val()	
			var diasAbono = $("#diasAbono").val()
			var observacao = $("#observacao").val()
			var abono;   
					
			if (diasAbono != "" ){
			
			abono = 1;
			
			
			}
			else{
			
			abono = 0;
			
			}
			    
			
			//if (IC_GERENTE == false){
			
			//	alert("Desculpe, somente coordenadores e substitutos tem permissão para fazer esse pedido.");
							
			//}
			
			//else{
            
			
			
			
			// comeco dos testes para ver se ha algum campo necessario vazio
			if (matricula == ""){
			
			alert("Digite uma matricula");
			
			}
			else if (nome == ""){
			
			alert("Digite um nome");
			
			
			}
			
			else if (data_inicio == ""){
			
			alert("Digite uma data");
			
			}
			
			else if (gozo == ""){
			
			alert("Digite os dias de gozo");
			}
			
			// fim da checagem de campos
			
		
		
		
			
		
		
		//comeco da segunda checagem
		    if (matricula != "" && nome != "" && data_inicio != "" && gozo != "" && parcelas != ""){
			
		    window.location.assign("ferias_con.asp?matricula="+matricula+"&nome="+nome+"&data_inicio="+data_inicio+"&gozo="+gozo+"&parcelas="+parcelas+"&diasAbono="+diasAbono+"&abono="+abono+"&observacao="+observacao+"");
		
			
			} 
		//fim da segunda checagem
		
		
		//} //fim do else
		
		
		});

	
	});

 
 
 </script>
    
<!-- fecha efeito da janela de ajuda -->
</head>
<body>
<%
  
  Perfil_Acesso("2")
   
  response.write "<input type='hidden' id = 'perfil_ferias' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_ferias_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
   
  if not  perfil_acesso_admin_siiag then
  
  response.Redirect ("consultar_ferias.asp?situacao=1")
    
  end if

%>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >FÉRIAS</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <%			
			  
			  ' Efetua a Conexão
			mat = Request.ServerVariables("LOGON_USER")
	i = InStr(mat,"\")
	If i > 0 Then
		dominio = UCase(Left(mat,i-1))
		usuario = UCase(Right(mat,Len(mat)-i))
	else
		usuario = ""
	End If
	matricula = usuario
		query = "SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA='"&matricula&"'"
		'resultado = conexao.execute(query)
		set rs=Server.CreateObject("ADODB.RecordSet")
		rs.Open query, dados_sys
		
	
		If rs.eof Then
		
		response.write "nao deu"
		
		else
		
		response.write "deu"
		
		end if
			  
			  
			  if perfil_acesso_admin_siiag then
              	response.write "<li class='active'><a href='ferias.asp'><span>Solicitar</span></a></li>"
			  	response.write "<li ><a href='consultar_ferias.asp?situacao=1'><span>Consultar</span></a></li>"	  
			  else
			  	response.write "<li class='active'><a href='consultar_ferias.asp?situacao=1'><span>Consultar</span></a></li>"			  
			  end if			
			 %>
              
            </ul>
          </div>
          </p>
          
          
          
          
        
          
          <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos" >Solicitar F&eacute;rias</span></legend>
          <form>
          <table width="653" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="129"><span class="alinhador">
                <label>Usu&aacute;rio:</label>
              </span></td>
              <td width="524"><span class="alinhador">
                <input class="form-field" name="matricula" id="matricula" type="text" size="10" maxlength="7" />
                <label></label>
                </span></td>
            </tr>
            <tr>
              <td height="18"><span class="alinhador">
                <label>Nome:</label>
              </span></td>
              <td><span class="alinhador">
                <input style="margin-top:5px;" class="form-field" name="nome" id="nome" type="text" size="43" maxlength="100" />
              </span></td>
            </tr>
            <tr>
              <td><span class="alinhador">
                <label>In&iacute;cio das F&eacute;rias:</label>

              </span></td> 
              <td><span class="alinhador">
                <input   style="margin-top:5px" name="data_inicio" id="data_inicio" class="datepicker" type="text" size="10" maxlength="8"  value="<% Response.Write(Date) %>"/>
                <label></label>
              </span></td>
            </tr>
            <tr>
              <td><span class="alinhador">
                <label>Gozo:</label>
              </span></td>
              <td><span class="alinhador">
                <input  style="margin-top:5px" class="form-field" name="gozo" id="gozo" type="text" size="1" maxlength="2" />
                <label style="margin-left:10px">
                
                
              Parcelas:
              </label>
              <select name="parcelas" id="parcelas" class='form-select'>
              <option> 01 </option>
              <option> 02 </option>
              <option> 03 </option>
              <option> 04 </option>
              <option> 05 </option>
              <option> 06 </option>
              <option> 07 </option>
              <option> 08 </option>
              <option> 09 </option>
              <option> 10 </option>
              </select>
              </span></td>
              
            </tr>
            <tr>
              <td><span class="alinhador">
                <label>Abono:</label></span></td>
              <td><span class="alinhador">
        
          </label>
                 <input type="radio" style="margin-top:10px;margin-left:0px;" class = "abono" name="RadiodoAbono"  id="abono_nao" value="1" id="RadiodaJornada_0" checked="checked"/>
                              <label style="padding-left:0px">        
          N&atilde;o 
          </label>
          
          <input type="radio" style="margin-left:0px;" class = "abono" name="RadiodoAbono"  id="abono_sim"  />
          <label style="padding-left:0px">
          Sim          </label>
                 <label >Quantidade de Dias:</label>
          
          <input style="margin-left:1px; padding-left:0px" class="form-field" name="diasAbono" id="diasAbono" type="text" size="1" maxlength="3" disabled="disabled" />          </tr>
          </table>
          
          
          
          <div class="alinhador"> <!--comeco alinhador -->
          <label style="margin-top:8px">
            Observa&ccedil;&atilde;o:
            </label>
            <p/>
            <!--  <input class="form-field" name="quantidade" type="t size="50" maxlength="100" />    -->
<textarea  class="form-field" name="observacoes" id="observacao" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px; margin-left:5px"></textarea></td>
          <p/>
        <input  style="margin-top:7px;margin-left:5px;" name="solicitar" id="solicitar" class="myButton" type="button" value="Solicitar"/>
        
        
        
        
        
        
        <!-- #INCLUDE FILE ="usuario_logado.asp" -->
        
        
        
           
          </div> <!--fecha alinhador -->
             
                     <% response.write "<input type='hidden' id='mat_usuario' value="&usuario&" />" 
					 	response.write "<input type='hidden' id='ic_gerente' value="&IC_GERENTE&" />"
					 
					 
					 %>
        </form>
        </fieldset>
    
          
        
          
          
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>


<%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Pedido realizado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
		
				
		end if
		
		%>





<!--teste-->
</body>
</html>
