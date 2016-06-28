<%@LANGUAGE="VBScript" CODEPAGE="65001"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Eventos/Treinamentos</title>
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


<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

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
function Pesquisar(){

//var Recurso = document.getElementById("");
	var situacao = document.getElementById("situacoes").value;
	var data_inicial = document.getElementById("data_inicio").value;
	var data_final = document.getElementById("data_final").value;
	var tipo = document.getElementById("tipo").value;
	//var situacao = document.getElementById("");
	
	alert(data_inicial);
	alert(data_final);
	alert(situacao);
	alert(Recurso);
	
	//window.location.assign("consultar_eventos_e_treinamentos.asp?situacao="+situacao+"&data_inicio="+data_inicial+"&data_final="+data_final+"&tipo="+tipo+"");


}
</script>
<script>
$(document).ready(function() {

	$('#pesquisar').on('click',function(){

			var coordenacao = $("#coordenacao").val()
			
			//alert(coordenacao);
			//alert(gerencias);
			//alert(tipo);
			
			window.location.assign("eventos_treinamentos_pendencia.asp?coordenacao="+coordenacao+"");

	});


	$('.edit').on('click',function(){

			if($("#perfil_evento_solicitar").val()=="False"){
				alert("Você não tem permissão para editar.");
				return false;
			}
								
			var co_evento = $(this).parent().parent().find("#co_evento").val()
			/*alert(matricula + nome + data+descricao+dtcriacao+empregadosolicitante+dias);*/
			
			window.location.assign("eventos_e_treinamentos_editar.asp?co_evento="+co_evento)
						
	});


	$('.save').on('click',function(){
			var co_evento = $(this).parent().parent().find("#co_evento").val();
			var qt_presente = $(this).parent().parent().find("#qt_presente").val();

			if (qt_presente == "")
			{ alert("Digite a quantidade de participantes presentes!"); return false;}
			
			var confirmacao = window.confirm("Confirma a prestação de contas?");	
			if (confirmacao == true){ 
		
				$.ajax({
					method: "GET",
					url: "eventos_treinamentos_pendencia_update.asp", // ENDEREÇO DA PÁGINA PARA ONDE OS DADOS SERÃO PASSADOS
					data: {co_evento:co_evento, qt_presente:qt_presente },
					dataType: "html", // TIPO DE DADOS DE RETORNO
					//timeout: 5000, // TEMPO LIMITE PARA AGUARDAR RESPOSTA DA REQUISIÇÃO
					beforeSend: function() { // ANTES DA REQUISIÇÃO
					},
					complete: function() { // LOGO APÓS RECEBER RESPOSTA, TENDO SUCESSO OU NÃO  
					},
					success: function(data) { // CASO RECEBA RESPOTA COM SUCESSO
						alert("Prestação de Contas realizada com sucesso.");
						window.location.reload();
					},
					error: function(data, error){ // CASO OCORRA ERRO NA REQUISIÇÃO
						alert("Erro ao realizar Prestação de Contas.");
					}		
				})
		  }
	});


});
	
	
</script>

</head>
<body>

<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
<%
  
  Perfil_Acesso("7") 
  response.write "<input type='hidden' id = 'perfil_evento_consultar' value=" & perfil_acesso_siiag & ">"
  response.write "<input type='hidden' id = 'perfil_evento_solicitar' value=" & perfil_acesso_admin_siiag  & ">"
  if not perfil_acesso_siiag then
	  response.Redirect ("consultar_eventos_e_treinamentos.asp")
  end if
  
  coordenacao = request("coordenacao")
  
	'situacao = Request("situacao")
	'data_inicio= Request("data_inicio")
	'data_final=Request("data_final")
	'tipo = Request("tipo")

	' VERIFICA SE HÁ ALGUMA PRESTAÇÃO DE CONTAS PENDENTE PARA O USUARIO
	strQuery = "SELECT  " 
	strQuery = strQuery &  " EVENTOS.CO_EVENTO, EVENTOS.DE_EVENTO,  EVENTOS.DH_INICIO, EVENTOS.DH_FIM,  EVENTOS.DH_CRIACAO, EVENTOS.CO_CRIADOR, EVENTOS.QT_PARTICIPANTES,TIPO.DE_TIPO_EVENTO,SITUACOES.DE_SITUACAO,GS.NO_GS,LOCAL.DE_LOCAL "
	strQuery = strQuery &  " FROM TB_EVENTOS AS  EVENTOS "
	strQuery = strQuery &  " INNER JOIN TB_TIPOS_EVENTO AS TIPO ON TIPO.CO_TIPO_EVENTO = EVENTOS.CO_TIPO_EVENTO "
	strQuery = strQuery &  " INNER JOIN TB_SITUACOES AS SITUACOES ON SITUACOES.CO_SITUACAO = EVENTOS.CO_SITUACAO "
	strQuery = strQuery &  " INNER JOIN VW_GS AS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA "
	strQuery = strQuery &  " INNER JOIN TB_LOCAL AS LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL  "
	strQuery = strQuery &  "  WHERE ('" & date() & "' > DH_FIM AND QT_PARTICIPANTES_PRESENTES IS NULL AND EVENTOS.CO_SITUACAO IN (2) ) "	
	strQuery = strQuery &  "  AND ( EVENTOS.CO_EVENTO IN (SELECT CO_EVENTO FROM TB_EVENTO_ORGANIZADORES WHERE CO_MATRICULA = '" & REQUEST.Cookies("co_usuario_siiag") & "') )"
	set ds=Server.CreateObject("ADODB.RecordSet")
	ds.Open strQuery, dados_sys
	if not ds.eof then libera_link = true else libera_link = false end if
	set ds = nothing

%>


  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
       	<div class="titulosModulos" ><span >EVENTOS E TREINAMENTOS - PENDÊNCIA</span> </div>
          <div id='cssmenu'>
           <ul>
           <%			
			if tem_acesso("7") then
				response.write "<li ><a href='eventos_e_treinamentos.asp'><span>Solicitar</span></a></li>"
			end if
			if tem_acesso("26") then
				response.write "<li class='inactive'><a href='consultar_eventos_e_treinamentos.asp'><span>Consultar</span></a></li>"			  
			end if
			response.write "<li class='active'><a href='eventos_treinamentos_pendencia.asp'><span>Prestação de Contas</span></a></li>"			  
			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!--<li><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>

          <p class="paragrafoteste">
        
	     <%   'IF Eh_Perfil_Verificado("1") or Eh_Perfil_Verificado("2") or Eh_Perfil_Verificado("4") then %>
	     <%   IF perfil_acesso_admin_siiag then %>
            <label>Coordenação:</label>
                <select name="coordenacao" id="coordenacao"  class="form-select" style=" width:300px;max-width:300px;min-width:300px;" tabindex="3"  >
                    <option value="">Selecione a Coordenação</option>
                        <%
                        Query3 ="select CO_GS, NO_GS from TB_GS WHERE IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY NO_GS" 
                        set ds=Server.CreateObject("ADODB.RecordSet")
                        ds.Open Query3, dados_sys 
                        DO UNTIL ds.eof
                            response.write "<option value='"& DS("co_gs")  & "'"
                            if cstr(coordenacao)	= cstr(ds("co_gs")) then
                                response.Write(" selected ")
                            end if 						
                            response.Write ">" & UCASE(ds("no_gs")) & "</option>"							 
                            ds.movenext
                        LOOP
                        %>
                </select>
            &nbsp;&nbsp;
            <input name="pesquisar" id="pesquisar"  class="myButton" type="button" value="Pesquisar" />
			<%end if%>

          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Pendências de Prestação de Contas</span></legend>
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
           <!-- #INCLUDE FILE ="eventos_treinamentos_pendencia_con.asp" -->
          </div>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
          </fieldset>
		<br>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Prestação de Contas realizadas no dia</span></legend>
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
          
           <!-- #INCLUDE FILE ="eventos_treinamentos_prest_contas_realizada.asp" -->
           
          </div>
          </p>
          <p class="paragrafoteste">&nbsp;</p>
          </fieldset>


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
