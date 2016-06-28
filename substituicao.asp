<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->

<%
coord_soli = request("coord_soli")
matricula_coord = request("matricula_coord")
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Solicitar Substitui&ccedil;&atilde;o</title>
<!--CSS -->
<%if coord_soli <> 1 then%>
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<%end if%>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="../imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->

<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<style>
.ui-datepicker {
	font-size: 12px;
}
.datepicker {
	height: 15px;
	border: 1px solid #b5cce2;
	background: #edf4fc;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	color: #666;
	box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
	padding: 6px;
	width: auto;
}
.datepicker:focus {
	background: #fff;
	color: #000000;
	outline: none;
	padding: 6px;
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

<script type="text/javascript">
	$(document).ready(function() {

	    $(document).on("change", "#gerentes", function() {

	        $.ajax({
	            url: "substituicao_consulta_colaborador.asp?gerente=" + $("#gerentes").val(),
	            dataType: "html", // TIPO DE DADOS DE RETORNO
	            //timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
	            beforeSend: function() { // ANTES DA REQUISIÇÃO
	            },
	            complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO
	                //$("#carregando").hide();  
	            },
	            success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
	                $("#substitutos").html(data);
	            },
	            error: function(data) { // CASO OCORRA ERRO NA REQUISIÇÃO
	                alert("Erro ao carregar substitutos.");
	            }
	        })
	    });
	});
</script>
<script type="text/javascript">
	$(document).ready(function() {

    $(document).on("click", "#salvar", function() {

        //#ALTERADO em 12/04/2016 (método inteiro)
        var empregado = $("#empregados").val();
        var substituto = $("#substitutos").val();
        var motivo = $("#motivo").val();
        var data_inicio = $("#data_inicio").val();
        var data_final = $("#data_final").val();
        var matricula_logado = $("#mat_usuario").val();
        //var mat_gerente = document.getElementById("mat_gerente").value;
        //alert(matricula_logado);

        if (empregado == "" || substituto == "" || motivo == "" || data_inicio == "" || data_final == "") {
            alert("Preencha todos os campos para concluir o pedido de substituição.");
        }

        $.ajax({

            url: "substituicao_con.asp?data_inicio=" + $("#data_inicio").val() + "&data_final=" + $("#data_final").val() + "&motivo=" + $("#motivo").val() + "&substituto=" + $("#substitutos").val() + "&empregado=" + $("#empregados").val() + "",
            dataType: "html",
            beforSend: function() {},
            complete: function() {},
            success: function(data) {
                alert('Pedido realizado com sucesso.');
                if ($("#soli_h").val() == '1') {
                    parent.salvar_tudo();
                }
				
				window.location.assign("consultar_substituicao.asp");
            },
            error: function(data) {
                alert("Existe uma substituição neste período para o empregado informado.");
            }
        });
    });

    $("#empregados").on("change", function() {
		var gerente = false;
		if($(this).val() == "C022903"){
			gerente = true;
		}
			$.ajax({
				url: "substituicao_consulta_empregados.asp?empregado="+$(this).val()+"&gerente="+gerente,
				success: function(data) {
					$("#substitutos").html(data);
				},
				error: function(data) {
					console.log(data.responseText);
					alert("Erro ao carregar empregados.");
				}
        	});
    });
});
</script>
</head>
<%

coord_soli = request("coord_soli")
matricula_coord = request("matricula_coord")

if coord_soli <> 1 then%>

<body>
<%end if%>
<%if coord_soli = 1 then%>
<div id="iframe_class" style="width:520px; height:250px;">
  <%end if%>
  <%if coord_soli <> 1 then%>
  <div class="teste2">
    <%end if%>
    <!--fundo azul do meio-->
    
    <%if coord_soli <> 1 then%>
    
    <!-- #INCLUDE FILE ="topo.asp" -->
    
    <%end if%>
    <%
	
	Perfil_Acesso("5") 
	if not  perfil_acesso_siiag then
		response.Redirect ("consultar_substituicao.asp")
	end if
  
	if tem_acesso_admin_cookie("24") then ' VISAO UNIDADE
		consultaTodos = true
		consultaGS = false
	elseif request.Cookies("co_usuario_co_visao") = "2" then ' VISAO COORDENACAO
		consultaGS = true
		consultaTodos = false
	elseif request.Cookies("co_usuario_co_visao") = "1" then ' VISAO USUARIO
		consultaGS = false
		consultaTodos = false
	end if  
%>
    <div class="corposite"> <!--corpo-->
      <%
'****** CONEXÃO COM O BANCO DE DADOS

set ds=Server.CreateObject("ADODB.RecordSet")

%>
      <div class="container">
        <div class="conteudo2">
          <%if coord_soli <> 1 then%>
          <div class="titulosModulos" ><span >SUBSTITUIÇÃO</span> </div>
          <div class="usuariodiv">
            <div id='cssmenu'>
              <ul>
                <%			
		response.write "<li class='active'><a href='substituicao.asp'><span>Solicitar</span></a></li>"
		if tem_acesso("24") then
			response.write "<li><a href='consultar_substituicao.asp'><span>Consultar</span></a></li>"			  
		end if			
	 %>
              </ul>
            </div>
            </p>
            <div id='submenu'>
              <ul>
                <!--<li id="opener"><a href='#'><span>Ajuda</span></a></li>-->
              </ul>
            </div>
            <%end if%>
            <!--<div id="dialog" title="Caixa de Ajuda">
	<p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
</div>-->
            
            <fieldset class="testess" <%if coord_soli <> 1 then%>style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; height:440px;"<%end if%>>
              <legend><span class="titulos">Solicitar Substitui&ccedil;&atilde;o</span></legend>
              <input type='hidden' id="soli_h" value='<%=coord_soli%>'>
              <p class="paragrafoteste">
                <%
			coordenacao = Request("cogs")			
			%>
                
              
              <table>
                <tr>
                  <td><label>Empregado a ser substituído:</label></td>
                  <td><select <%if matricula_coord <> "" then%> disabled="disabled" <%end if%> name="empregados" id="empregados" class="form-select">
                      <option value="" selected="selected">Selecione um empregado...</option>
                     
                      <option value="C022903">ANDREA VIEIRA NOVAIS</option>
                      <%
				matriculaUsuario = Session("v_Usuario_Matricula")
				
				' (remove a matrícula de quem irá ser substituido da lista de substitutos)
				queryColaboradores = "SELECT * FROM VW_USUARIOS WHERE CO_GS = (SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '"&matriculaUsuario&"') AND IC_ATIVO=1 AND LETRA = 'C' ORDER BY NO_NOME"
				
				set ds=Server.CreateObject("ADODB.RecordSet")
                ds.Open queryColaboradores, dados_sys 
				
				DO UNTIL ds.eof
				
			%>
                      <option value=<%=ds("CO_MATRICULA")%>><%=ds("NO_NOME")%></option>
                      <%
				ds.movenext
			    LOOP
				ds.movefirst
			%>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Empregado substituto:</label></td>
                  <td><select id="substitutos" class="form-select">
                      <option value="">Selecione um empregado...</option>
                      <%
              	DO UNTIL ds.eof	
				%>
                      <option value=<%=ds("CO_MATRICULA")%>><%=ds("NO_NOME")%></option>
                      <%
				ds.movenext
			    LOOP
				ds.close
			%>
                    </select></td>
                </tr>
               
                <tr>
                  <td><label>Motivo:</label></td>
                  <td><select id="motivo" class="form-select">
                      <option value="">Selecione um motivo...</option>
                     <%
            
						Query4 ="SELECT DE_TIPO_AFASTAMENTO, CO_TIPO_AFASTAMENTO, CO_CAIXA FROM TB_TIPOS_AFASTAMENTO WHERE IC_ATIVO = 1 ORDER BY DE_TIPO_AFASTAMENTO"
				
			 
						set ds=Server.CreateObject("ADODB.RecordSet")
						ds.Open Query4, dados_sys 
						DO UNTIL ds.eof
							TIPO_AFASTAMENTO=ds("DE_TIPO_AFASTAMENTO")
							CO_TIPO_AFASTAMENTO=ds("CO_TIPO_AFASTAMENTO")
							CO_CAIXA = ds("CO_CAIXA")
							response.write "<option value="&CO_TIPO_AFASTAMENTO&">"&TIPO_AFASTAMENTO&" - "&CO_CAIXA&"</option>"							 
							ds.movenext
						LOOP
						set ds = nothing
           			 %>
                    </select></td>
                </tr>
                <tr>
                  <td><label>Data In&iacute;cio:</label></td>
                  <td><%
			  
			  data = DAY(DATE)&"/"&MONTH(DATE)&"/"&YEAR(DATE)
			  
			  %>
                    <input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8" value="<%' Response.Write data %>"/></td>
                </tr>
                <tr>
                  <td><label>Data Final:</label></td>
                  <td><input  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8" value="<% 'Response.Write data %>"/></td>
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
                <input name="salvar" class="myButton" type="button" value="Salvar" onclick="Salvar();" id="salvar" style="margin-left:7px"/>
              </div>
            </fieldset>
          </div>
        </div>
        
        <!--include do calendário--> 
        
      </div>
    </div>
    <!--fim do corpo-->
    <%if coord_soli <> 1 then%>
    <!-- #INCLUDE FILE ="rodape.asp" -->
    <%end if%>
    <%if coord_soli <> 1 then%>
  </div>
  <!--teste-->
  <%end if%>
  <%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			response.write ("<script language=""javascript""> alert('Pedido realizado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
		end if
		
		%>
  <%if coord_soli = 1 then%>
</div>
<%end if%>
<%if coord_soli <> 1 then%>
</body>
<%end if%>
</html>