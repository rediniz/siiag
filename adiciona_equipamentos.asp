<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<title>Monitoramento de Equipamentos</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
</head>

<script>
	$(document).ready(function() {
		$('#inserir').on('click',function(){
			//$("#formulario").submit();
	
			$.ajax({
					method: "GET",
					url: "adiciona_equipamentos_con.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					data: $("#formulario").serialize(),
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						alert("Cadastro realizado com sucesso.");
						window.location.assign("controle.asp");
					},
					error: function(data, error){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao cadastrar equipamento.");
					}		
			})
		});
	});
</script>  

<body>
	<div class="teste2">
  		<!--fundo azul do meio-->
  		<!-- fazendo o include do topo aqui -->
  		<!-- #INCLUDE FILE ="topo.asp" -->
		
<%	'Chama a subrotina para verificar o perfil
		Perfil_Acesso("11")
%>
  		<div class="corposite">
    	<!--corpo-->

<%
		if not  perfil_acesso_siiag then
			response.write "<p align='center'><span style='color:#FFFFFF'>O seu perfil <b>" & perfil_acesso_siiag_desc & "</b> não permite o acesso a este módulo</span></p>"
		else
%>    
			<div class="container2">
                <div class="conteudo2">
                <div class="titulosModulos"><span>CONTROLE DE EQUIPAMENTOS</span></div>
                <div id='cssmenu'>
                    <ul>
					  <%if tem_acesso("30") then%>
                        <li class='inactive'><a href='controle.asp'><span>Consultar Equipamentos</span></a></li>
            		   <%end if%>
                        <li class='active'><a href='adiciona_equipamentos.asp'><span>Cadastrar Equipamento</span></a></li>
                    </ul>
                </div>
                    
                <h3 class="titulos" align="center">Informe os dados abaixo para inser&ccedil;&atilde;o</h3>
          
                <form id="formulario" name="formulario" action="adiciona_equipamentos_con.asp">
                    <table width="400" height="516" border="0" align="center" cellpadding="0">
                        <tr>
                            <td width="129" height="40"><label>Endereço L&oacute;gico:</label></td>
                            <td width="265"><input class='form-field' name="endLogico" id="endLogico" type="text" maxlength="11"/></td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>Usu&aacute;rio:</label></td>
                            <td><input class='form-field' name="usuario" id="usuario" type="text"/></td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>Ger&ecirc;ncia:</label></td>
                            <td>
                                <select id='gerencia' name="gerencia" class='form-select' style="width:158px;">
                                    <option value=''>Selecione Ger&ecirc;ncia</option>        
                                    <%                  
                                        query ="SELECT CO_GS, NO_GS FROM VW_GS WHERE(IC_ATIVO = 1) and co_unidade ="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_GS"
    
                                        set rs=Server.CreateObject("ADODB.RecordSet")
                                        rs.Open query, dados_sys 
                                        DO UNTIL rs.eof
                                            CO_GS=rs("CO_GS")
                                            NO_GS=rs("NO_GS")
                                            cogs=rs("CO_GS")
                                            response.write "<option value="&CO_GS&">"&NO_GS&"</option>"
                                            rs.movenext
                                        LOOP
                                        set rs = nothing                  
                                    %>
                                </select>
                            </td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>Marca:</label></td>
                            <td><input class='form-field' name="marca" id="marca" type="text"/></td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>Modelo:</label></td>
                            <td><input class='form-field' name="modelo" id="modelo" type="text"/></td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>N&uacute;mero de S&eacute;rie:</label></td>
                            <td><input class='form-field' name="numSerie" id="numSerie" type="text"/></td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>Tipo:</label></td>
                            <td>
                                <select id="tipo" name = "tipo" class="form-select" style="width:160px;">
                                    <option value=''>Selecione o Tipo</option>
                                    <option value='MICRO'>Micro</option>
                                    <option value='SERVIDOR'>Servidor</option>
                                    <option value='IMPRESSORA'>Impressora</option>
                                    <option value-'NOTEBOOK'> Notebook</option>
                                    <option value-'DATASHOW'> Data Show</option>
                                </select>
                            </td>
                        </tr>    
                        
                        <tr>
                            <td height="40"><label>HD:</label></td>
                            <td><input class='form-field' name="hd" id="hd" type="text"/></td>
                        </tr>
                  
                        <tr>
                            <td height="40"><label>Ram:</label></td>
                            <td><input class='form-field' name="ram" id="ram" type="text"/></td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>Clock:</label></td>
                            <td><input class='form-field' name="clock" id="clock" type="text"/></td>
                        </tr>
             
                        <tr>
                            <td height="40"><label>Sistema Operacional:</label></td>
                            <td><input class='form-field' name="sisOp" id="sisOp" type="text"/></td>
                        </tr>
                 
                        <tr height="40">
                            <td colspan="2"><input type="button" value="Inserir Equipamento" id="inserir" style="margin-left:70px;" class="myButton"/></td>
                        </tr>
                    </table>
                </form>
                <br/>
                <br/>
            </div>     
    
            <%end if%>
      	</div>
		<!--fim do corpo-->
		<!-- #INCLUDE FILE ="rodape.asp" -->
	</div>
	<!--teste-->
</body>
</html>
