<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Lista de Frequência - Estagiários</title>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
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
<style>
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}

</style>
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

.ui-autocomplete {

	height:120px;
	overflow-y:scroll;
	overflow-x:hidden;
	font-size:12px;
}

</style>


<script>
    $(function() {
    $( ".datepicker" ).datepicker({
    dateFormat: 'mm/yy',
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText: 'Próximo',
    prevText: 'Anterior',
	changeMonth: true,
	changeYear: true
  });
   });
  </script>
  
<script>
$(document).ready(function() {	
    $( "#btnExibir" ).on('click',function(){
	
	//$('#matricula').val();
	//$('#data_inicio').val();
	
	if($("#manha").prop('checked')==true){
		
		$turno = 0;
	
	}
	else{
		$turno = 1;
	}
	
	
window.location.assign("lista_gerar.asp?matricula="+$('#matricula').val()+"&data="+$('#data_inicio').val()+"&turno="+$turno+"&nome="+$("#matricula option:selected").text()+"");	
	//alert($turno);
	//alert($('#matricula').val());
	//alert($('#data_inicio').val());
	
    //alert("certo");
	
 		 });
});		 
 

</script>  


</head>

<body>


<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
<%
  
	Perfil_Acesso("31") 
	response.write "<input type='hidden' id = 'perfil_afastamento_consultar' value=" & perfil_acesso_siiag & ">"
	response.write "<input type='hidden' id = 'perfil_afastamento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
	
	if Tem_Acesso("10") then 'perfil controle
		consultaTodos = true
	elseif perfil_acesso_admin_siiag then
		consultaGS = true
		consultaTodos = false
	else
		consultaGS = false
		consultaTodos = false
	end if

	if not perfil_acesso_siiag then
		response.Redirect("acesso_negado.asp")
	end if

%>  
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >USUÁRIO</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
            <%aba_ativa = 6%>
            <!-- #INCLUDE FILE ="abas_usuarios.asp" -->
            </ul>
          </div>
          </p>
			<div id="submenu" >
            <ul>
                <!--<li> <a href=''><span>Ajuda</span></a></li>-->
            </ul>          
           </div>
        <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; height:450px;" >
          <legend ><span class="titulos" >Folha de Frequência dos Estagiários</span></legend>
         
          
		 
          <table width="477" border="0">
          <tr>
            <td ><label>Nome:</label></td>
            
           
          <td width="479"><select name="nome" class="form-select" id='matricula'>
          	<option value="">Selecione</option>
          <%	
			SQL = "SELECT NO_NOME, CO_MATRICULA FROM [VW_USUARIOS] WHERE IC_ATIVO = '1' AND CO_CARGO = '11'"
			SQL = SQL + " AND CO_MATRICULA <> '' and co_unidade = "& request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_NOME"
			
			set rs=Server.CreateObject("ADODB.RecordSet")
			rs.Open SQL, dados_sys, 3, , 32
			
			do while(rs.eof = false)
				
				nome = rs("NO_NOME")
				response.Write "<option " 
				if matricula = rs("CO_MATRICULA")  Then response.Write "selected='selected'" END IF
				response.Write " value='"& rs("CO_MATRICULA") &"'>" & ucase(nome) & "</option>"
				rs.MoveNext
				
			loop
		  %>
          
          </select>
          </td>
          </tr>
 
          <tr>
          <td width="108"><span class="alinhador">
            <label>De: </label></span></td>
            <td><input <% if data_de <> "" Then Response.Write "value= '"&data_de&"' " End If %>name="data_inicio" type="text" size="10" maxlength="10"  id="data_inicio" class="datepicker"/></td>
          </tr>
           <tr>
                           <td><span class="alinhador">
                   			  <label>Turno:</label></span>
                           </td>   
                              <td>
                              
                                <input type="radio" style="margin-top:10px;margin-left:0px;" class = "turno" name="RadiodoTurno"  id="manha" checked="checked"/>
                            
                             <label style="padding-left:0px">Manhã  </label>
                                <input type="radio" style="margin-left:0px;" class = "turno" name="RadiodoTurno"  id="tarde"  />
                             <label style="padding-left:0px"> Tarde </label>    
                             </td>
                             
                  		
		  </tr>
          <br/>
           <td colspan="2"><input type="button" class='myButton' name="btnExibir" id="btnExibir" value="Exibir" style="margin-left:18%;margin-top:3%;"/></td>
          </tr>
          </table>

          </legend>
          <p></p>
          
          </div>
        </fieldset>
    </div>
  </div>
    </div>
  <!-- #INCLUDE FILE ="rodape.asp" -->
  </div>
  <%
  objConn.Close
  %>
  <!--fim do corpo-->

</div>
<!--teste-->
</body>
</html>

