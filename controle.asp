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

	$('#pesquisar').on('click',function(){

			var enderecoLogico = $("#endLogico").val()
			var gerencias = $("#gerencias").val()
			var tipo = $("#tipo").val()
			
			//alert(enderecoLogico);
			//alert(gerencias);
			//alert(tipo);
			
			window.location.assign("controle.asp?enderecoLogico="+enderecoLogico+"&gerencia="+gerencias+"&tipo="+tipo+"");

	});

});
</script>  



<script>
$(document).ready(function() {

	$('.X_old').on('click',function(){

			var co_equipamento = $(this).parent().parent().find("#co_equipamento").val();
			var confirmacao = window.confirm("Tem certeza que desejar excluir este equipamento?");	
				
			if (confirmacao == true){ 
					window.location.assign("controle_exclusao.asp?co_equipamento="+co_equipamento+"");
			} 

	});
	
	$('.X').on('click',function(){
			var co_equipamento = $(this).parent().parent().find("#co_equipamento").val();
			var confirmacao = window.confirm("Tem certeza que desejar excluir este equipamento?");	

			if (confirmacao == true){ 
		
				$.ajax({
					method: "GET",
					url: "equipamentos_exclusao.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					data: {co_equipamento:"" + co_equipamento + "" },
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						alert("Exclusão realizada com sucesso.");
						window.location.reload();
					},
					error: function(data, error){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao excluir equipamento.");
					}		
				})
		  }
	});
	
	
});
</script>  


<body>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- fazendo o include do topo aqui -->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <%	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("30")
%>
  <div class="corposite">
    <!--corpo-->
<%
if not perfil_acesso_siiag then
		response.write "<p align='center'><span style='color:#FFFFFF'>O seu perfil <b>" & perfil_acesso_siiag_desc & "</b> não permite o acesso a este módulo</span></p>"
else
%>     
    <div class="container2">
      <div class="conteudo2">
       <div class="titulosModulos"><span>CONTROLE DE EQUIPAMENTOS</span></div>
            <div id='cssmenu'>
            <ul>
              <li class='active'><a href='controle.asp'><span>Consultar Equipamentos</span></a></li>
			  <%if tem_acesso("11") then%>
	              <li class='inactive'><a href='adiciona_equipamentos.asp'><span>Cadastrar Equipamento</span></a></li>
			  <%end if%>
            </ul>
          </div>
      <h3 class="titulos" align="center">Informe os dados para Consulta</h3>
		<table border="0" width="100%">
        <tr>
		<td>
          <label>Endere&ccedil;o L&oacute;gico : </label><input class='form-field' name="endLogico" id="endLogico" type="text" size="10px"/>
        </td>
        <td>
          <label>Coordenação : </label>
          <select id='gerencias' class='form-select' >
             <option value=''>Selecione</option>
             
            <%		gerencia = request("gerencia")
					if gerencia = "" then gerencia = 0 end if
                    set rs=Server.CreateObject("ADODB.RecordSet")
                    query ="SELECT CO_GS, NO_GS FROM VW_GS WHERE(IC_ATIVO = 1) and co_unidade ="&request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_GS"
                    rs.Open query, dados_sys 
                    DO WHILE NOT rs.eof
                        CO_GS=rs("CO_GS")
                        NO_GS=rs("NO_GS")
                        response.write "<option value="&CO_GS&"  "
						if cint(gerencia) = cint(co_gs) then response.write " selected " end if
						response.write ">"&NO_GS&"</option>"
                        rs.movenext
                    LOOP
                    set rs = nothing
                    
            %>
          </select>

        </td>
        
              		
      <!-- <div align="left" style="margin-left:10px;">-->
        
        	<td>
            <label>Tipo : </label>
            	<select id="tipo" class="form-select">
                      	<option value=''>Selecione</option>
              <option value='MICRO' <%if ucase(request("tipo")) =  "MICRO" THEN %> selected="selected" <%END IF%>>Micro</option>
                    <option value='SERVIDOR'  <%if ucase(request("tipo")) =  "SERVIDOR" THEN %> selected="selected" <%END IF%> >Servidor</option>
                    <option value='IMPRESSORA' <%if ucase(request("tipo")) =  "IMPRESSORA" THEN %> selected="selected" <%END IF%>>Impressora</option>
                    <option value-'NOTEBOOK' <%if ucase(request("tipo")) =  "NOTEBOOK" THEN %> selected="selected" <%END IF%>>Notebook</option>
                    <option value-'DATASHOW' <%if ucase(request("tipo")) =  "DATASHOW" THEN %> selected="selected" <%END IF%>>Data Show</option>
                </select>    
            </td>
            
          <td><input type="button" value="Pesquisar" id="pesquisar" class="myButton"/></td>
          
            
           <% if tem_acesso("10") then%>
            <!--<td class="myButton" style="padding:3px; text-align:center; cursor:pointer;" valign="middle" onclick="window.navigate('adiciona_equipamentos.asp');" ><a href="adiciona_equipamentos.asp" title="Adicionar Equipamento" style="height:18px;"><img src="imagens/add_16x16.png"/></a>Adicionar Equipamento</td> -->
           <%end if%>
          </tr>
           </table>
      <!--</div>-->
     	<div class="resultado">
        <!-- #INCLUDE FILE ="controle_con.asp" --> <!-- incluindo o arquivo que faz a consulta e o retorno de resultados-->
        </div>
<%end if%>            
      </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->


<%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Item excluído com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.reload(); </script>")
		
				
		end if
		
		%>
		
</body>
</html>


