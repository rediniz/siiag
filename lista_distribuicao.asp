<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Lista de Distribuição</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

<script type="text/javascript">
	$(document).ready(function() {
		
		$("#resultado").hide();
		$("#copiado").hide();
		
		$(document).on("change", "#tipo", function() {
			
			if($("#tipo").val() == "" ){
				alert("Informe o tipo de lista.");
				return false;
			}
				
			$.ajax({
				url: "lista_distribuicao_con.asp",
				data: $("#formulario").serialize(),
				dataType: "html",
				success: function(data){
							
					$("#lista").html(data);
					$("#copiado").hide();
					$("#resultado").show();
					
								  
				},
				error: function(data){
					alert(data.responseText);								
				}						
			})  
			  
		});
		
		$("#copiar").click(function(){
			
			if($("#lista").html() == ""){
				alert("Nenhuma lista foi gerada.");
				return false;
			}
			
			var lista =  $("#lista").text();
			$("input").select();
			window.clipboardData.setData('Text', lista);
			$("#copiado").show();
			
  		});
		
		function Copiar(){
		
			if($("#lista").html() == ""){
				alert("Nenhuma lista foi gerada.");
				return false;
			}
			
			var lista =  $("#lista").text();
			$("input").select();
			window.clipboardData.setData('Text', lista);
			alert("A lista foi copiada.");
			
		}
	
	});
 
</script>
</head>
<body>
<% response.Expires = 0 %>
<div class="teste2"> 
  <!--fundo azul do meio--> 
  
  <!-- #INCLUDE FILE ="topo.asp" -->
  
  <div class="corposite"> 
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="titulosModulos"><span>LISTA DE DISTRIBUIÇÃO</span></div>
        <div class="usuariodiv" style="min-height:540px; margin:10px">
          </p>
          <p class="paragrafoteste">
          <form  id="formulario" name="formulario">
            <table>
              <tr>
                <td><label>Tipo de lista:</label></td>
              </tr>
              
                <td width=""><select class="form-select" id="tipo" name="tipo">
                    <option value="">Selecione...</option>
                    <option value = "1">Empregados</option>
                    <option value = "2">Estagiários</option>
                    <option value = "3">Todos</option>
                    <option value=""></option>
                    <option value = "4">Empregados da Coordenação</option>
                    <option value = "5">Estagiários da Coordenação</option>
                    <option value = "6">Todos da Coordenação</option>
                    <option value=""></option>
                    <option value = "7">Coordenações</option>
                    <option value = "8">Coordenadores</option>
                    <option value=""></option>
                    <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
                    <option value = "9">Agências da SR Norte e Sul do Ceará</option>
                    <option value = "10">Agências da SR Fortaleza</option>
                    <option value = "11">Agências do SR Maranhão</option>
                    <option value = "12">Agências do SR Piauí</option>
                    <option value = "13">Agências do CE/PI/MA</option>  
                    <option value=""></option>  
                    <option value = "14">SR CE/PI/MA</option>
                    <option value=""></option>
                    <%end if%>
                    <option value = "15">Todas as GIFUG</option>    
                    <option value = "16">Gerências Nacionais</option>
                    <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
                    <option value=""></option>
                    <option value = "17">Grupos de acesso - Pagamento FGTS</option>
                    <%end if%>
                                      
                  </select></td>
            </table>
            </p>
            <!--
            <button class="myButton" id="gerar_lista" name="gerar_lista" style="margin-left:8px"  type="button">Gerar Lista</button>-->
            </p>
          </form>
          <div id="resultado">
            <table>
              <tr>
                <td>Resultado:</td>
              </tr>
              <tr>
                <td><textarea class="form-field" name="lista" id="lista" style="width:680px; height:200px" disabled="disabled"></textarea></td>
              </tr>
            </table>
            </p>
            <button class="myButton" id="copiar" name="copiar" style="margin-left:8px"  type="button">Copiar Lista</button>
            </p>
            <div id="copiado"><p style="color:#090">A lista foi copiada para a área de transferência.</p></div>
          </div>
          <p class="paragrafoteste">&nbsp;</p>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo--> 
  <!-- #INCLUDE FILE ="rodape.asp" --> 
</div>
<!--teste-->
</body>
</html>
