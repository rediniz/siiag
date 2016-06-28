<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Eventos e Treinamentos</title>
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

<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<style>

#X {
cursor:pointer
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

</style>

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
    $( "#tabss" ).tabs();
  });
</script>

<%

set objConn = server.CreateObject("ADODB.Connection") 
dados_gifug = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
dados_siiag = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"

%>

<script language="javascript" type="text/javascript">
  
  $(function() {
  
  $('.table').on('click', '#X', function(){
		$(this).parent().remove(); 
		});
  	
  	$( "#incluirResponsavel" ).click(function() {
	
	   var matricula = $("#responsavel_matricula").val();
	   var usuario = $("#responsavel_usuario").val();	   
	    
				$( "#tabela_responsavel" ).append( 
							"<tr>" +
							"<td>" + matricula + "</td>" +
							"<td>" + usuario + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
								
	 	$( "#incluirPublico" ).click(function() {
	
	   var publico = $("#publico_alvo").val();
	   
				$( "#tabela_publico" ).append( 
							"<tr>" +
							"<td>" + publico + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
		$( "#incluirServico" ).click(function() {
	
	   var tipo = $("#tipo_servico").val();
	   var quantidade = $("#quantidade_servico").val();
	   var observacao = $("#observacao_servico").val();
	   
				$( "#tabela_servicos" ).append( 
							"<tr>" +
							"<td>" + tipo + "</td>" +
							"<td>" + observacao + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
		$( "#incluirRecurso" ).click(function() {
	
	   var tipo = $("#tipo_recurso").val();
	   var quantidade = $("#quantidade_recurso").val();
	   var observacao = $("#observacao_recurso").val();
	   
				$( "#tabela_recurso" ).append( 
							"<tr>" +
							"<td>" + tipo + "</td>" +
							"<td>" + quantidade + "</td>" +
							"<td>" + observacao + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
				
	  $( "#incluirMaterial" ).click(function() {
	
	   var nome = $("#materiais").val();
	   var quantidade = $("#quantidade_material").val();
	   
				$( "#tabela_material" ).append( 
							"<tr>" +
							"<td>" + nome + "</td>" +
							"<td>" + quantidade + "</td>" +
							"<td> ? </td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
		$( "#incluirArquivo" ).click(function() {
	
	   var recurso = $("#recursos").val();
	   var quantidade = $("#spinner").val();
	   
				$( "#tabela" ).append( 
							"<tr>" +
							"<td>" + recurso + "</td>" +
							"<td>" + quantidade + "</td>" +
							"<td id='X'><img src='imagens/delete_16x16.png' /> </td>" +
							"</tr>");
				});
		
		
		$( "#salvar" ).click(function() {
		
		// Dados gerais
		var descricao = $("#descricao").val();
		var iniciativa = $("#iniciativa").val();
		alert(iniciativa);
		
		});		
	});
  
</script>
<!-- efeito da janela de ajuda -->
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
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE file ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='eventos_e_treinamentos.asp'><span>Solicitar</span></a></li>
              <li ><a href='consultar_eventos_e_treinamentos.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li id="opener"><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <div id="dialog" title="Caixa de Ajuda">
            <p>Teste da Ajuda da p&aacute;gina de Destacamentos</p>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
          <legend><span class="titulos">Eventos e Treinamentos</span></legend>
          <p class="paragrafoteste">
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; padding-bottom:0">
          <!-- dados da inclusão -->
          <legend><span class="titulos">Dados da Inclus&atilde;o</span></legend>
          <p class="paragrafoteste">
            <%
 mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i))
				End If
				
				
strQuery = "select NO_NOME,CO_GS from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_gifug = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_gifug
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_gifug

nome = rs("NO_NOME")
codigoGerencia = rs("CO_GS")
consultaUnidade = "select CO_UNIDADE,CO_GS from TB_GS where CO_GS='" & codigoGerencia & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_gifug
set consultar=Server.CreateObject("ADODB.RecordSet")
consultar.Open consultaUnidade, dados_sys
Unidade=consultar("CO_UNIDADE")

objConn.close 
set rs = nothing
set consultar = nothing
set objConn = nothing
%>
            <img src="imagens/X000000.png"  height="19" width="19"/>&nbsp;
            <label>Matr&iacute;cula: <%=usuario%></label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <label>Unidade:
            <% response.Write Unidade %>
            </label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <label>Data: </label>
            <label name="data">
            <% response.Write DAY(DATE()) &"/"& MONTH(DATE()) &"/"& YEAR(DATE()) %>
            </label>
          </p>
          </fieldset>
          <!-- fim do dados da inclusão -->
          <p><img src="imagens/info_16x16.png" /> <span class="style1">Entre com os dados abaixo para Eventos. Para Treinamento, basta substituir o Tipo para "Treinamento".</span></p>
          <label for="descricao">Descri&ccedil;&atilde;o:</label>
          <input name="descricao" id ="descricao" class="form-field" type="text" size="99" maxlength="1024" />
          <br/>
          <br/>
          <label for="iniciativa" >Iniciativa:</label>
          <select name="iniciativa" id="iniciativa">
            <option value="Aplicacao" selected="selected">Aplica&ccedil;&atilde;o</option>
            <option value="ArecadacaoeRepasse">Arrecada&ccedil;&atildeo e Repasse</option>
            <option value="Cadastro">Cadastro</option>
            <option value="Gerencia">Ger&ecirc;ncia</option>
            <option value="InformacaoeGestao">Informa&ccedil;&otilde;es e Apoio &agrave; Gest&atilde;o</option>
            <option value="MonitoramentoeAvaliacao">Monitoramento e Avalia&ccedil;&atildeo da Gest&atilde;o</option>
            <option value="Pagamento">Pagamento</option>
            <option value="Recuperacao">Recupera&ccedil;&atildeo de Cr&eacute;dito</option>
            <option value="Relacionamento">Relacionamento com Cliente</option>
          </select>
          &nbsp;&nbsp;
          <label>Tipo do Evento:</label>
          <select name="tipo_evento" id="tipo_evento">
            <option value="Audioconferencia">Audioconfer&ecirc;ncia</option>
            <option value="Confraternizacao">Confraterniza&ccedil;&atilde;o</option>
            <option value="EventoExterno">Evento Externo</option>
            <option value="Palestra">Palestra</option>
            <option value="Reunicao">Reuni&atilde;o</option>
            <option value="Treinamento">Treinamento</option>
            <option value="VisitaExterna">Visita Externa</option>
            <option value="VisitaInterna">Visita Interna</option>
          </select>
          <br/>
          <br/>
          <label>Per&iacute;odo:</label>
           <input  name="periodo_de" id="periodo_de" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>
           <input  name="periodo_a" id="periodo_a" class="datepicker" type="text" size="8" maxlength="8"  value="<% Response.Write(Date) %>"/>

          <label for="horario_de" style="margin-left:10px;">Horário do evento:</label>
          <input type="text" class="form-field" name="horario_de" id="horario_de" style="width:50px;" maxlength="5"/>
          <input type="text" class="form-field" name="horario_ate" id="horario_ate" size="4px" style="width:50px;" maxlength="5"/>
          <p></p>
          <label for="local">Local:</label>
          <select name="local">
            <%

strQuery = "select DE_LOCAL from TB_LOCAL ORDER BY DE_LOCAL" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_siiag = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_siiag
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_siiag

DO UNTIL rs.eof 
  
	  	response.write "<option>"+rs("DE_LOCAL")+"</option>"
		
		rs.movenext 'passando para o proximo elemento da tabela
		
LOOP

objConn.close 
set rs = nothing
set objConn = nothing

%>
          </select>
          <p/>
          <label for="qtd_participantes">Quantidade de Participantes:</label>
          <input type="text" class="form-field" name="qtd_participantes" id="qtd_participantes" style="width:20px;" maxlength="5"/>
          <p></p>
          <label for="desc_participantes">Descrição dos participantes para a agenda:</label>
          <input type="text" class="form-field" name="desc_participantes" id="desc_participantes" style="width:200px;" maxlength="50px"/>
          <br/>
          <br/>
          <label>Situa&ccedil;&atilde;o:</label>
          <select name="Situacao" id="situacao">
            <option value="todos" selected="selected">Todos</option>
            <option value="solicitado">Socilitado</option>
            <option value="confirmado">Confirmado</option>
            <option value="pendente">Pendente</option>
            <option value="gozado">Gozado</option>
            <option value="natendido">Não Atendido</option>
            <option value="cancelado">Cancelado</option>
            <option value="emandamento">Em Andamento</option>
          </select>
          &nbsp;&nbsp; <br />
          <p></p>
          <p align="center" class="style1"> <img src="imagens/info_16x16.png" /> Inclua os dados em cada aba clicando em Incluir. Por fim, clique em Salvar.</p>
          <fieldset style="border:none;">
          <div id="tabss">
            <ul>
              <li><a href="#responsaveis" style="font-size:11px">Responsáveis/Facilitadores</a></li>
              <li><a href="#publico" 	  style="font-size:11px">Público Alvo</a></li>
              <li><a href="#servicos" 	  style="font-size:11px">Servi&ccedil;os</a></li>
              <li><a href="#recursos" 	  style="font-size:11px">Recursos</a></li>
              <li><a href="#material"  	  style="font-size:11px">Material</a></li>
              <li><a href="#arquivos"     style="font-size:11px">Arquivos</a></li>
              <li><a href="#observacoes"  style="font-size:11px">Observações</a></li>
            </ul>
            <div id="responsaveis"> <img src="imagens/info_16x16.png"/> <span style="font-size:12px; margin-bottom:4px">Informe os responsáveis pelo evento ou, no caso de treinamentos, os 			facilitadores.</span>
              <p></p>
              <label for="usuario" >Usuário:</label>
              <input class="form-field" name="responsavel_matricula" type="text" size="7" maxlength="7" id="responsavel_matricula" style="font-size:12px"/>
              <input class="form-field" name="responsavel_usuario" type="text" size="40" maxlength="100" id="responsavel_usuario" style="font-size:12px"/>
              <input  name="incluirResponsavel" class="myButton" type="button"   value="Incluir" id="incluirResponsavel" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              
              <div class="tabela" align="center">
                <table class="table" id="tabela_responsavel">
                  <tr>
                    <td style="width:20%"> Código/Matrícula </td>
                    <td> Nome </td>
                    <td style="width:5%"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="publico">
              <label for="publico">P&uacute;blico:</label>
              <select name="incluirPublico" id="publico_alvo" style="font-size:12px;">
                <%

strQuery = "select DE_PUBLICO_ALVO from TB_PUBLICO_ALVO ORDER BY DE_PUBLICO_ALVO" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_siiag = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_siiag
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_siiag

DO UNTIL rs.eof 
  
	  	response.write "<option>"+rs("DE_PUBLICO_ALVO")+"</option>"
		rs.movenext 'passando para o proximo elemento da tabela
  
LOOP

objConn.close 
set rs = nothing
set objConn = nothing

%>
              </select>
              <input  name="incluirPublico" class="myButton" type="button"  value="Incluir" id = "incluirPublico" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <div class="tabela" align="center">
                <table class="table" id="tabela_publico">
                  <tr>
                    <td style="width:20%"> Público </td>
                    <td style="width:0.8%"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="servicos"> <img src="imagens/info_16x16.png" /> <span style="font-size:12px;">Servi&ccedil;os que dever&atilde;o ser contratados para o evento.</span>
              <p></p>
              <label for="tipo">Tipo:</label>
              <select style="font-size:12px;" id="tipo_servico">
                <%

strQuery = "select DE_TIPO from TB_TIPOS_CONTRATACAO ORDER BY DE_TIPO" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_siiag = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_siiag
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_siiag

DO UNTIL rs.eof 
  
	  	response.write "<option>"+rs("DE_TIPO")+"</option>"
		rs.movenext 'passando para o proximo elemento da tabela
  
LOOP

objConn.close 
set rs = nothing
set objConn = nothing

%>
              </select>
              <input  name="incluir_servico" class="myButton" type="button"  value="Incluir" id="incluirServico" style="padding-right:10px; padding-left:10px; margin:0px; margin-bottom:0px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p></p>
              <p>
                <label style="margin-bottom:4px;" for="observacoes">Observações:</label>
              <p/>
              <textarea name="observacoes" id="observacao_servico" cols="60" rows="2" style="font-size:12px; margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
              <div class="tabela" align="center">
                <table class="table" id="tabela_servicos">
                  <tr>
                    <td> Tipo </td>
                    <td> Observação </td>
                    <td style="width:5%"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="recursos">
              <label for="tipo">Tipo:</label>
              <select style="font-size:12px;" id="tipo_recurso">
                <%

strQuery = "select DE_RECURSO from TB_TIPOS_RECURSOS ORDER BY DE_RECURSO" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_siiag = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_siiag
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_siiag

DO UNTIL rs.eof 
	  	response.write "<option>"+rs("DE_RECURSO")+"</option>"
		rs.movenext 'passando para o proximo elemento da tabela
LOOP

objConn.close 
set rs = nothing
set objConn = nothing

%>
              </select>
              <label for "quantidade">Quantidade:</label>
              <input name="quantidade_recurso" id="quantidade_recurso" class="form-field" type="text" size="2" maxlength="5" style="font-size:12px"/>
              <input  name="imprimir_termo_recurso" class="myButton" type="button"  id="imprimir_termo_recurso"value="Imprimir termo" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <input  name="incluir_recurso" class="myButton" type="button" value="Incluir" id="incluirRecurso" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p/>

              <label for="observacoes">Observações sobre o empréstimo:</label>
              <p/>
              <textarea name="observacoes" cols="60" rows="2"  id="observacao_recurso" style="font-size:12px; padding-top:5px;margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
              <p></p>
              <div class="tabela" align="center">
                <table class="table" id="tabela_recurso">
                  <tr>
                    <td> Descrição </td>
                    <td> Quantidade </td>
                    <td> Observação </td>
                    <td style="width:5%" id="remover"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="material">
              <label for="tipo">Material:</label>
              <select style="font-size:12px;" id="materiais">
                <%

strQuery = "select NO_MATERIAL from TB_ESTOQUE_MATERIAL WHERE IC_ATIVO=1 ORDER BY NO_MATERIAL" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_siiag = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_siiag
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_siiag

DO UNTIL rs.eof   
	  	response.write "<option>"+rs("NO_MATERIAL")+"</option>"
		rs.movenext 
LOOP

objConn.close 
set rs = nothing
set objConn = nothing

%>
              </select>
              <label for "quantidade_material">Quantidade:</label>
              <input name="quantidade_material" id = "quantidade_material" class="form-field" type="text" size="2" maxlength="5" style="font-size:12px"/>
              <input  name="incluirMaterial" class="myButton" type="button"  value="Incluir" id="incluirMaterial" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p></p>
              <div class="tabela" align="center">
                <table class="table" id="tabela_material">
                  <tr>
                    <td> Nome </td>
                    <td> Quantidade </td>
                    <td> Disponíveis </td>
                    <td style="width:5%"></td>
                  </tr>
                </table>
              </div>
            </div>
            <div id="arquivos">
              <label for="tipo">Tipo:</label>
              <input class="form-field" name="tipo" id="tipo_arquivo" type="text" size="35" maxlength="100" style="font-size:12px"/>
              <input  name="procurar" class="myButton" type="button"  value="Procurar" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <input  name="incluir" class="myButton" type="button"  value="Incluir" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>
              <p></p>
              <div class="tabela" align="center">
                <table >
                  <tr>
                    <td> Link </td>
                    <td> Nome </td>
                  </tr>
                  <tr>
                    <td>Linha 1</td>
                    <td>Linha 1</td>
                </table>
              </div>
            </div>
            <div id="observacoes"> <img src="imagens/info_16x16.png" /> <span style="font-size:12px;">Use este espaço para dar mais informações ao Apoio.</span>
              <p></p>
              <textarea name="observacoes" cols="70" rows="5" style="font-size:12px;margin-bottom:0px;max-width:400px;min-width:400px;max-height:100px;min-height:100px;"></textarea>
            </div>
          </div>
          <!-- Fim da div Tabs -->
          <p/>
          <div align="center">
            <input name="incluir" class="myButton" type="button" value="Salvar" id="salvar" />
          </div>
          </fieldset>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
          </fieldset>
          <script language="javascript">
</script>
        </div>
      </div>
       <!--include calendario-->
    </div>
  </div>
 
  <!-- #INCLUDE file ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
