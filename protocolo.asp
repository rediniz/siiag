<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Inclus&atilde;o de Protocolo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<script type="text/javascript" src="jquery-1.9.1.js" ></script>
<script type="text/javascript" src="jquery-ui-1.10.3.custom.js" ></script>

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
    </style>

    
<script language="javascript">
	var ar = false;

	$(function() {
		
		$("#numeroAR").on("focusout", function(){			
			if($("#gs_usuario").val() == 3){
				if($("#numeroAR").val().length < 13){
					alert ("Informe no mínimo 13 caracteres alfanuméricos para o campo AR.");
					//$("#numeroAR").focus();
					return false
				}
			}
		});
	
//		var ar = false;
		$(document).ready(function(){
					//Ao digitar executar essa função
					$("#responsavelProtocolo").focus().autocomplete({
	
						source: "autocompletar_nome2.asp",
						minlength: 2,
						select: function( event, ui ) {
							$( "#responsavelProtocolo" ).val( ui.item.nome);
							$( "#f_responsavel_matricula" ).val( ui.item.matricula);
							return false;
						}
	
					  });
					
		 });
	
	});

	//$(function() {
	
	// Função que habilita ou desabilita o textbox com o número do AR
	function adicionarAR()
	{
			if(ar == false){
				$("#numeroAR").prop("disabled", false);
				ar = true;
			} else{
				$("#numeroAR").val("");
				$("#numeroAR").prop("disabled", true);
				ar = false;
			}
	
	}


	// Habilita o checkbox "Adicionar AR" se o tipo de protocolo for Ofício
	function habilitaAR()		
	{
		var tipoProtocolo = document.getElementById("tipoProtocolo").value;
		//alert(tipoProtocolo);
		
			
			if (tipoProtocolo == 2 || tipoProtocolo == 12){
			
				$("#add_AR").prop("disabled", false);
				 
			}
			
			else{
				$("#add_AR").prop("disabled",true);
				$("#add_AR").prop("checked", false);
				$("#numeroAR").val("");
				$("#numeroAR").prop("disabled", true);
				ar = false;
	
			}
			
	}			


</script>
<script language="javascript">
	function validaCampos()
	{
	
		
		if($("#tipoProtocolo").val() == ""){
			alert ("Informe o tipo de protocolo.");
			return false
		}
		
		if($("#areaProtocolo").val() == ""){
			alert ("Informe a area do protocolo.");
			return false
		}
		
		if($("#destinoProtocolo").val() == ""){
			alert ("Informe o destino.");
			return false
		}
		
		if($("#conteudoProtocolo").val() == ""){
			alert ("Informe o conteúdo.");
			return false
		}
		
		if($("#f_responsavel_matricula").val() == ""){
			alert ("Informe o responsável.");
			return false
		}
	
		if($("#add_AR").prop("checked")==true){
			if($("#numeroAR").val() == ""){
				alert ("Informe o número da AR.");
				return false
			}
			if($("#gs_usuario").val() == 3){
				if($("#numeroAR").val().length < 13){
					alert ("Informe no mínimo 13 caracteres alfanuméricos para o campo AR.");
					return false
				}
			}
	
		}
	
		document.getElementById("responsavelProtocolo").value = document.getElementById("f_responsavel_matricula").options[document.getElementById("f_responsavel_matricula").selectedIndex].text;
		formProtocolo.submit();
		//alert("teste");
		
	}
</script>
</head>

<body>

<div class="teste2" >
  <!--fundo azul do meio-->
<!-- #INCLUDE FILE ="topo.asp" -->
<!-- #INCLUDE FILE ="include/conexao_protocolo.asp" -->
<%
	Perfil_Acesso_Cookie("17")    
	if not perfil_acesso_siiag then
		response.Redirect("acesso_negado.asp")
	end if  
'****** CONEXÃO COM O BANCO DE DADOS
'set objConn = server.CreateObject("ADODB.Connection") 
'dados_sys = "Provider=sqloledb;Data Source=ce7180sr001;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
'objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
			
'******
%>
  <div class='corposite' >
 
    <!--corpo-->
    <div class='container'  >
     <div class='conteudo2' style='height:550px; border:#FF0000 solid 0px;'  >
     <div class="titulosModulos" ><span >PROTOCOLO</span> </div>
      
        <div class='usuariodiv' style="border:#FF0000 solid 0px;" >
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='protocolo.asp'><span>Inclus&atilde;o</span></a></li>
              <li><a href='protocolo_consultar.asp'><span>Consulta</span></a></li>
              <li><a href='protocolo_editar.asp'><span>Editar AR - Ofício</span></a></li>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
      
          <legend class="style2 style3">Inclus&atilde;o de Protocolo </legend>
         
<span class="style4 style2">
            
            <form ACTION="protocolo_salvar.asp" name="formProtocolo" method="POST" >

             <table width="200" border="0" cellspacing="4" cellpadding="0"  align="left">
            <tr>
              <td><label>Tipo: </label></td>
              <td><select style="margin-left:2px;padding-right:2.5px;" id="tipoProtocolo" name="tipoProtocolo" onchange="habilitaAR();" class="form-select">
                   <option value="">Selecione o Tipo de Protocolo</option>
					<%
                    Query3 ="select CO_TIPO, DE_TIPO from TB_PROTOCOLO_TIPO ORDER BY DE_TIPO" 
                    ds.Open Query3, dados_sys 
                    DO UNTIL ds.eof
                        tipoProtocolo=ds("DE_TIPO")
                        codigoTipoProtocolo=ds("CO_TIPO")
                        response.write "<option name ="&codigoTipoProtocolo&" value="& codigoTipoProtocolo &">"&tipoProtocolo&"</option>"							 
                        ds.movenext
                    LOOP
                    set ds = nothing
                    %>
            
	            </select>
              </td>
             <td><label>&Aacute;rea: </label></td>
              <td>    
            <select id="areaProtocolo"  name="areaProtocolo" class="form-select">
            <option  value="">Selecione a &Aacute;rea do Protocolo</option>
            <%
            
            Query4 ="select CO_AREA,NO_AREA from TB_PROTOCOLO_AREAS ORDER BY NO_AREA" 
            'set objConn = server.CreateObject("ADODB.Connection") 
            'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
            'objConn.open dados_sys
            set ds=Server.CreateObject("ADODB.RecordSet")
            ds.Open Query4, dados_sys 
            DO UNTIL ds.eof
				codigoArea=ds("CO_AREA")
				nomeArea=ds("NO_AREA")
				response.write "<option value="& codigoArea &">"&nomeArea&"</option>"							 
				ds.movenext
            LOOP
            set ds = nothing
            %>
            </select></td>
            </tr>
            <tr>
              <td align="right"><p>&nbsp;</p>              </td>
              <td colspan="4"><p>
                <input type="checkbox" name="add_AR" id="add_AR" disabled="disabled" onchange="adicionarAR()" />
                <label>Adicionar AR ao ofício</label>
              </p>
                <p>
                <input type="hidden" id='gs_usuario' value="<%=request.Cookies("co_usuario_gs_siiag")%>" />
                                  <label>Nº AR</label>
                <%
				if request.Cookies("co_usuario_gs_siiag") = 3 or request.Cookies("co_usuario_gs_siiag") = 4 or request.Cookies("co_usuario_gs_siiag") = 6 then
				%>
                  <input class="form-field" type="text" name="numeroAR" id="numeroAR" disabled="disabled" size="10px" maxlength="20" style="width:165px; margin-bottom:5px"/><br /><span style="font-size:12px; color:#F00; margin-top:10px">* O campo aceita no mínimo 13 caracteres alfanuméricos.</span>
                  <%
				  else
				  %>
                  <input class="form-field" type="text" name="numeroAR" id="numeroAR" disabled="disabled" size="10px" maxlength="9" style="width:85px;"/>
                  <%
				  end if
				  %>
                </p></td>
            </tr>
            <tr>
     		  <td> <label>Destino:</label></td>
              <td colspan="3"><input class="form-field" name="destinoProtocolo" id="destinoProtocolo" type="text" size="75" maxlength="100" onchange="ChamarLink();" /></td>
            </tr>
            <tr>
              <td><label>Conte&uacute;do: </label></td>
              <td colspan="3"><textarea class="form-field" name="conteudoProtocolo" id="conteudoProtocolo" style="max-height:39px;min-height:39px;max-width:470px;min-width:470px;" onchange="ChamarLink();"  ></textarea></td>
            </tr>
            <tr>
              <td align="right"> <label>Respons&aacute;vel:</label></td>
              <td colspan="3">
              <select name="f_responsavel_matricula" id="f_responsavel_matricula" class="form-select"  maxlength="300" style="width:485px"  >
              <option value="">Selecione um Responsável</option>
              <%
				'Query4 = "SELECT * FROM GIFUG.DBO.TB_USUARIOS where  IC_ATIVO = 1 ORDER BY NO_NOME" 
				Query4 = "SELECT * FROM siiag_web.dbo.VW_USUARIOS where CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY NO_NOME" 
				set ds=Server.CreateObject("ADODB.RecordSet")
				ds.Open Query4, dados_sys 
				DO UNTIL ds.eof
					response.write "<option value="& ds("CO_MATRICULA") &">"& ucase(ds("NO_NOME")) &"</option>"							 
					ds.movenext
				LOOP
				set ds = nothing
			%>
              </select>
              <input class="form-field" name="responsavelProtocolo" id="responsavelProtocolo" size="75" maxlength="300" type="hidden" onchange="ChamarLink();" />
              </td>
            </tr>
            <tr>
              <td align="center" colspan="4">
     <div align="center">
	    <input type = "button" class="myButton" id='salvar2' style='margin:16px;' value="Salvar" onclick="javascript: validaCampos();">
     </div>
              
              </td>
            </tr>
          </table> 
          


</form>      
</fieldset>

    </div> <!-- fim div usuariodiv -->
  </div> <!-- fim div conteudo2 -->
</div><!-- fim div container -->
</div><!-- fim div comporsite -->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div><!-- fim div teste -->

<% objConn.close%>
  <!--fim do corpo-->


        <%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	
		
		if ( sucesso="true" ) then
			
			'response.write("<p style='color:green; font-size: 16px'>Protocolo incluído com sucesso.</p>")
			response.write ("<script language=""javascript""> alert('Protocolo "  & request("area") & " - " & request("nu_prot") & " incluído com sucesso!'); </script>")
		
		else 
		
			if( sucesso="false" ) then
		
				response.write ("<script language=""javascript""> alert('Erro na inclusão do protocolo.'); </script>")
		
			end if	
				
		end if
		
		%>
<!--teste-->
</body>
</html>
