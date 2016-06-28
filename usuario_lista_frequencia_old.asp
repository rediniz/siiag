<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Usu&aacute;rio</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
<script src="scripts/jquery.autocomplete.js" language="javascript"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--<script src="scripts/jquery-1.9.1.js"></script> -->
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
-->
</style>

<script language="javascript">
<!--
	function marcarCargos(){
		if(document.getElementById('chk_cargo_todos').value == '0' ){
			document.getElementById('chk_aux_servicos').checked = 'true';
			document.getElementById('chk_estagiario').checked = 'true';
			document.getElementById('chk_gerente_filial').checked = 'true';
			document.getElementById('chk_aprendiz').checked = 'true';
			document.getElementById('chk_aux_operacional').checked = 'true';
			document.getElementById('chk_junior').checked = 'true';
			document.getElementById('chk_coordenador').checked = 'true';
			document.getElementById('chk_tbn').checked = 'true';
			document.getElementById('chk_pleno').checked = 'true';
			document.getElementById('chk_terceirizado').checked = 'true';
			document.getElementById('chk_senior').checked = 'true';
			document.getElementById('chk_escrituario').checked = 'true';
			document.getElementById('chk_secretario').checked = 'true';
			
			document.getElementById('botao_cargo').value = 'Desmarcar todos';
			document.getElementById('chk_cargo_todos').value = '1';
			
		} 
		else if(document.getElementById('chk_cargo_todos').value == '1'){
		 	document.getElementById('chk_aux_servicos').checked = '';
			document.getElementById('chk_estagiario').checked = '';
			document.getElementById('chk_gerente_filial').checked = '';
			document.getElementById('chk_aprendiz').checked = '';
			document.getElementById('chk_aux_operacional').checked = '';
			document.getElementById('chk_junior').checked = '';
			document.getElementById('chk_coordenador').checked = '';
			document.getElementById('chk_tbn').checked = '';
			document.getElementById('chk_pleno').checked = '';
			document.getElementById('chk_terceirizado').checked = '';
			document.getElementById('chk_senior').checked = '';
			document.getElementById('chk_escrituario').checked = '';
			document.getElementById('chk_secretario').checked = '';
			
			document.getElementById('botao_cargo').value = 'Marcar todos';
			document.getElementById('chk_cargo_todos').value = '0';
		}
		return true;
	}
	
	function marcarCoordenacoes(){
		if(document.getElementById('chk_coordenacao_todos').value == '0' ){
			document.getElementById('chk_aplicacao').checked = 'true';
			document.getElementById('chk_gerencia').checked = 'true';
			document.getElementById('chk_pagamento').checked = 'true';
			document.getElementById('chk_arrecadacao').checked = 'true';
			document.getElementById('chk_apoio').checked = 'true';
			document.getElementById('chk_recuperacao').checked = 'true';
			document.getElementById('chk_cadastro').checked = 'true';
			document.getElementById('chk_monitoramento').checked = 'true';
			document.getElementById('chk_relacionamento').checked = 'true';
			
			document.getElementById('botao').value = 'Desmarcar todos';
			//document.getElementById('coor_desmarcar').style.display = '';
			document.getElementById('chk_coordenacao_todos').value = '1';
		} 
		else if(document.getElementById('chk_coordenacao_todos').value == '1'){
		 	document.getElementById('chk_aplicacao').checked = '';
			document.getElementById('chk_gerencia').checked = '';
			document.getElementById('chk_pagamento').checked = '';
			document.getElementById('chk_arrecadacao').checked = '';
			document.getElementById('chk_apoio').checked = '';
			document.getElementById('chk_recuperacao').checked = '';
			document.getElementById('chk_cadastro').checked = '';
			document.getElementById('chk_monitoramento').checked = '';
			document.getElementById('chk_relacionamento').checked = '';
			
	//		document.getElementById('l_marcar').value = 'Desmarcar todos:';
			document.getElementById('botao').value = 'Marcar todos';
			//document.getElementById('coor_desmarcar').style.display = 'none';
			document.getElementById('chk_coordenacao_todos').value = '0';
		}
		return true;
	}
	
	function marcarCampos(){
		if(document.getElementById('chk_campo_todos').value == '0' ){
			document.getElementById('chk_matricula').checked = 'true';
			document.getElementById('chk_nome').checked = 'true';
			document.getElementById('chk_coordenacao').checked = 'true';
			document.getElementById('chk_assinatura').checked = 'true';
			
			document.getElementById('botao_campo').value = 'Desmarcar todos';
			//document.getElementById('coor_desmarcar').style.display = '';
			document.getElementById('chk_campo_todos').value = '1';
		} 
		else if(document.getElementById('chk_campo_todos').value == '1'){
		 	document.getElementById('chk_matricula').checked = '';
			document.getElementById('chk_nome').checked = '';
			document.getElementById('chk_coordenacao').checked = '';
			document.getElementById('chk_assinatura').checked = '';
			
			
	//		document.getElementById('l_marcar').value = 'Desmarcar todos:';
			document.getElementById('botao_campo').value = 'Marcar todos';
			//document.getElementById('coor_desmarcar').style.display = 'none';
			document.getElementById('chk_campo_todos').value = '0';
		}
		return true;
	}
	
	function verifica_coordenacao(){
		if(document.getElementById('chk_coordenacao_todos').value == '1'){
			document.getElementById('chk_coordenacao_todos').value = '0';
			document.getElementById('botao').value = 'Marcar todos'
		}
	}
	
	function verifica_cargos(){
		if(document.getElementById('chk_cargo_todos').value == '1'){
			document.getElementById('chk_cargo_todos').value = '0';
			document.getElementById('botao_cargo').value = 'Marcar todos'
		}
	}


	function exibir() {
		if (document.getElementById('chk_aplicacao').checked == '' && document.getElementById('chk_gerencia').checked == '' && 	document.getElementById('chk_pagamento').checked == '' && document.getElementById('chk_arrecadacao').checked == '' && document.getElementById('chk_apoio').checked == '' && document.getElementById('chk_recuperacao').checked == '' && document.getElementById('chk_cadastro').checked == '' && document.getElementById('chk_monitoramento').checked == '' && document.getElementById('chk_relacionamento').checked == '') {
		
			alert ("Nenhuma Coordenação foi marcada!");
		}
		
		else if(document.getElementById('chk_matricula').checked == '' && document.getElementById('chk_nome').checked == '' && document.getElementById('chk_coordenacao').checked == '' && document.getElementById('chk_assinatura').checked == ''){
		
			alert ("Nenhum Campo foi marcado!");
		}
		
		else if (document.getElementById('chk_aux_servicos').checked == '' && document.getElementById('chk_estagiario').checked == '' && document.getElementById('chk_gerente_filial').checked == '' && document.getElementById('chk_aprendiz').checked == '' && document.getElementById('chk_aux_operacional').checked == '' && document.getElementById('chk_junior').checked == '' && document.getElementById('chk_coordenador').checked == '' && document.getElementById('chk_tbn').checked == '' && document.getElementById('chk_pleno').checked == '' && document.getElementById('chk_terceirizado').checked == '' && document.getElementById('chk_senior').checked == '' && document.getElementById('chk_escrituario').checked == '' && document.getElementById('chk_secretario').checked == ''){
		
			alert ("Nenhum Cargo foi marcado!");
		}
		else {
		document.form_exibir.submit();
		}
	}

-->
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

<style type="text/css">
.check {
font-family:verdana;
font-size:13px;
color:#666666;
}

body {
font-family:verdana;
font-size:15px;
}

a {color:#333; text-decoration:none}
a:hover {color:#ccc; text-decoration:none}

#mask {
  position:absolute;
  left:0;
  top:0;
  z-index:9000;
  background-color:#000;
  display:none;
}
  
#boxes .window {
  position:absolute;
  left:0;
  top:0;
  width:440px;
  height:200px;
  display:none;
  z-index:9999;
  padding:20px;
}

#boxes #dialog {
  width:375px; 
  height:203px;
  padding:10px;
  background-color:#ffffff;
}

#boxes #dialog1 {
  width:375px; 
  height:203px;
}

#dialog1 .d-header {
  background:url(login-header.png) no-repeat 0 0 transparent; 
  width:375px; 
  height:150px;
}

#dialog1 .d-header input {
  position:relative;
  top:60px;
  left:100px;
  border:3px solid #cccccc;
  height:22px;
  width:200px;
  font-size:15px;
  padding:5px;
  margin-top:4px;
}

#dialog1 .d-blank {
  float:left;
  background:url(login-blank.png) no-repeat 0 0 transparent; 
  width:267px; 
  height:53px;
}

#dialog1 .d-login {
  float:left;
  width:108px; 
  height:53px;
}

#boxes #dialog2 {
  background:url(notice.png) no-repeat 0 0 transparent; 
  width:326px; 
  height:229px;
  padding:50px 0 20px 25px;
}
.close{display:block; text-align:right;}

</style>
</head>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<body>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
<%	
  	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("10")
	'Response.write request.Cookies("perfil_acesso_siiag_desc")
%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >USUÁRIO</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='usuario.asp'><span>Consultar</span></a></li>
              
              <%if (perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag")) then %>
              <li ><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
              <%end if %>
			<% if tem_acesso("10") then 'MODULO APOIO then %>
                          <li class='active' ><a href='usuario_lista_frequencia.asp'><span>Lista de Usu&aacute;rios</span></a></li>
            <% end if %>
            </ul>
          </div>
          </p>
		<%
		if not perfil_acesso_siiag then
			response.write "<label>     Acesso negado.</label>"
			response.End()
		end if
		%>
        
        <%
			flag = Request("flagCargos")
			response.Write(flag)
		%>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Lista de Usu&aacute;rios</legend>
          <p/>
          <form name="form_exibir" id="form_exibir" action="usuario_relatorio_frequencia.asp" method="post" target="_blank" >
          <table border="0" width="100%">
            <tr>
                <td width="9%" >
	            <label >T&iacute;tulo: </label></td> <td colspan="3">
					 <input class='form-field' name='f_titulo' id='f_titulo' type='text'  size='50' maxlength='100'  value= '<%=titulo%>' tabindex="1" />
   
                 </td>


<!--                <td >
	            <label >Data: </label></td> <td>
          		<%'data = Date()%>
<input name="f_data" type="text" size="10" maxlength="10"  id="f_data" class="datepicker" value="<%'=replace(data,"-","/")%>"/>
	           <%' if data <> "" Then Response.Write "value= '"&data&"' " End If %>     
				</td> -->
            </tr>
            
            <tr> <td>&nbsp;   </td> </tr>
            
            <tr>
                <td colspan="6" class="check">
                
                 <fieldset class="testess" style=" border-color: #999999; border:#999999 1px solid; border-radius:4px;">
          		<legend >Coordena&ccedil;&otilde;es:</legend>
                 <table>  <font size="2">
                	 <tr>
	                     <td width="200"> <input  type='checkbox' name='chk_aplicacao' id='chk_aplicacao' onclick="return(verifica_coordenacao())"/> Aplicação </td>
    		             <td> <input  type='checkbox' name='chk_gerencia' id='chk_gerencia' onclick="return(verifica_coordenacao())" /> Gerência </td>
             			 <td> <input  type='checkbox' name='chk_pagamento' id='chk_pagamento' onclick="return(verifica_coordenacao())"/> Pagamento </td> </tr>
                      <tr>
                      		<td> <input  type='checkbox' name='chk_arrecadacao' id='chk_arrecadacao' onclick="return(verifica_coordenacao())"/> Arrecadação e Repasse </td>
                   			<td width="240"> <input  type='checkbox' name='chk_apoio' id='chk_apoio' onclick="return(verifica_coordenacao())"/> Informações e Apoio à Gestão </td>
                   			<td> <input  type='checkbox' name='chk_recuperacao' id='chk_recuperacao' onclick="return(verifica_coordenacao())"/> Recuperação de Crédito </td> </tr>
                      <tr>
                      		<td> <input  type='checkbox' name='chk_cadastro' id='chk_cadastro' onclick="return(verifica_coordenacao())"/> Cadastro </td>
                            <td> <input  type='checkbox' name='chk_monitoramento' id='chk_monitoramento' onclick="return(verifica_coordenacao())"/>  Monitoramento e Avaliação da Gestão </td>
                   			<td > <input  type='checkbox' name='chk_relacionamento' id='chk_relacionamento' onclick="return(verifica_coordenacao())"/> Relacionamento com Clientes </td>
                    </font>
				</table>
                
				<input  type='hidden' name='chk_coordenacao_todos' id='chk_coordenacao_todos' value="0" /> <br />
               <input type="button" name="botao" id="botao" onclick="return(marcarCoordenacoes())" value="Marcar Todos"/>
               
                </td>
               
             </fieldset>   
            </tr>
			<tr> <td>&nbsp;   </td> </tr>
            <tr>
                <td colspan="6" class="check">
                 <fieldset class="testess" style=" border-color: #999999; border:#999999 1px solid; border-radius:4px;">
          		<legend >Campos:</legend>
                   <table>
                   <tr>
                   <td width="170"> <input  type='checkbox' name='chk_matricula' id='chk_matricula' /> Matrícula </td>
                   <td width="170"> <input  type='checkbox' name='chk_nome' id='chk_nome' /> Nome </td>
                   <td width="170"> <input  type='checkbox' name='chk_coordenacao' id='chk_coordenacao' /> Coordenação </td>
                   <td > <input  type='checkbox' name='chk_assinatura' id='chk_assinatura' /> Assinatura </td>
				</tr>
                </table>
                
               <input  type='hidden' name='chk_campo_todos' id='chk_campo_todos' value="0" /> </br>
               <input type="button" name="botao_campo" id="botao_campo" onclick="return(marcarCampos())" value="Marcar Todos"/>
               
                </td>
               
             </fieldset>   
            </tr>
            
            <tr> <td>&nbsp;   </td> </tr>
            <form action="usuario_lista_frequencia.asp" method="post" name="form_cargos" target="_self">
            <tr>
                <td colspan="6" class="check">
                 <fieldset class="testess" style=" border-color: #999999; border:#999999 1px solid; border-radius:4px;">
          		<legend>Cargos:</legend>
                	<table>
                    <tr>
                    
                   <td width="200"></td>
                   <td> <input  type='checkbox' name='chk_aux_servicos' id='chk_aux_servicos' onclick="return(verifica_cargos())"/> Auxiliar de Serviços Gerais </td>
                   <td> <input  type='checkbox' name='chk_gerente_filial' id='chk_gerente_filial' onclick="return(verifica_cargos())"/> Gerente de Filial </td>  </tr>
                   
                   <tr>
                       <td > <input  type='checkbox' name='chk_aprendiz' id='chk_aprendiz' onclick="return(verifica_cargos())"/> Adolescente Aprendiz  </td>
                       <td width="240"> <input  type='checkbox' name='chk_aux_operacional' id='chk_aux_operacional' onclick="return(verifica_cargos())"/> Auxiliar Operacional </td>
                       <td></td>
                   </tr>
                   <tr>
                   <td> <input  type='checkbox' name='chk_junior' id='chk_junior' onclick="return(verifica_cargos())"/> Assistente Júnior </td>
                   <td> <input  type='checkbox' name='chk_coordenador' id='chk_coordenador' onclick="return(verifica_cargos())"/> Coordenador </td>
                   <td> <input  type='checkbox' name='chk_tbn' id='chk_tbn' onclick="return(verifica_cargos())"/> Técnico Bancário Novo </td> </tr>
                   <tr>
                   <td> <input  type='checkbox' name='chk_pleno' id='chk_pleno' onclick="return(verifica_cargos())"/> Assistente Pleno  </td>
                   <td> <input  type='checkbox' name='chk_escrituario' id='chk_escrituario' onclick="return(verifica_cargos())"/> Escrituário  </td>
                   <td> <input  type='checkbox' name='chk_terceirizado' id='chk_terceirizado' onclick="return(verifica_cargos())"/> Terceirizado(a) </td> </tr>
                   <tr>
                   <td> <input  type='checkbox' name='chk_senior' id='chk_senior' onclick="return(verifica_cargos())"/> Assistente Senior  </td>
                   <td> <input  type='checkbox' name='chk_estagiario' id='chk_estagiario' onclick="return(verifica_cargos())"/> Estagiário  </td> </tr>
			    </table>
                
               
               <input  type='hidden' name='chk_cargo_todos' id='chk_cargo_todos' value="0" /> </br> 
               <input type="button" name="botao_cargo" id="botao_cargo" value="Marcar todos" onclick="return(marcarCargos())"/>
               
               
                </td>
             </fieldset>   
             </form>
            </tr>
            
            
            <tr>
                <td>&nbsp;  </td>
            </tr>
            
            <tr><td colspan="5">
             <input  type='checkbox' name='chk_ausentes' id='chk_ausentes' /> Exibir funcionários ausentes
            </td></tr>
            
            <tr>
                <td>&nbsp;  </td>
            </tr>
            <tr>
                <td align="center" colspan="7">
	            <INPUT type="button" value="Exibir" class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" onclick="return(exibir())">
				</td>
            </tr>
            </table>
          </form>
          </fieldset>
        </div>
      </div>
    </div>

  </div>



  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>


</body>
</html>
