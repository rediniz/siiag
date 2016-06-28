<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Empr&eacute;stimo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->

<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	
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
function Pesquisar(){
	//var Recurso = document.getElementById("");
	var situacao = document.getElementById("situacoes").value;
	var data_inicial = document.getElementById("data_inicio").value;
	var data_final = document.getElementById("data_final").value;
	var Recurso = document.getElementById("recurso").value;
	//var situacao = document.getElementById("");
	
	//alert(data_inicial);
	//alert(data_final);
	//alert(situacao);
	//alert(Recurso);
	
	window.location.assign("consultar_emprestimos.asp?situacao="+situacao+"&data_inicio="+data_inicial+"&data_final="+data_final+"&recurso="+Recurso+"");
}
</script>

</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
      	<div class="titulosModulos" ><span >EMPRÉSTIMOS</span> </div>
          <div id='cssmenu'>
            <ul>
              <li ><a href='emprestimos.asp'><span>Solicitar</span></a></li>
              <li class='active'><a href='consultar_emprestimos.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li><a href='index.html'><span>Termo de Responsabilidade</span></a></li>
              <li><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Consultar Empr&eacute;stimo</span></legend>
          <p class="paragrafoteste">

			<%
                situacao = Request("situacao")
                data_inicio= Request("data_inicio")
                data_final=Request("data_final")
                recurso = Request("recurso")
            %>

          	<label> Recursos:</label>
    		<select name='recursos' id="recurso">
            
              <option <% if recurso="" Then Response.Write "selected='selected'" END IF%> value="">Todos</option>	 
              <option <% if recurso="22" Then Response.Write "selected='selected'" END IF%> value="22">Aparelho de Audio-Conferência</option>	 
              <option <% if recurso="25" Then Response.Write "selected='selected'" END IF%> value="25">Cadeiras</option>
              <option <% if recurso="3" Then Response.Write "selected='selected'" END IF%> value="3" >Caixa de Som</option>
              <option <% if recurso="4" Then Response.Write "selected='selected'" END IF%> value="4">Câmera Fotográfica</option>
              <option <% if recurso="20" Then Response.Write "selected='selected'" END IF%> value="20">Cartão Impresso</option>
              <option <% if recurso="21" Then Response.Write "selected='selected'" END IF%> value="21">Cartão via e-mail</option>
              <option <% if recurso="18" Then Response.Write "selected='selected'" END IF%> value="18">Convite Impresso</option>
              <option <% if recurso="19" Then Response.Write "selected='selected'" END IF%> value="19">Convite via e-mail</option>
              <option <% if recurso="16" Then Response.Write "selected='selected'" END IF%> value="16">Crachá</option>
              <option <% if recurso="0" Then Response.Write "selected='selected'" END IF%> value="0">Data Show</option>
              <option <% if recurso="15" Then Response.Write "selected='selected'" END IF%> value="15">Folha de Frequencia</option>     
              <option <% if recurso="13" Then Response.Write "selected='selected'" END IF%> value="13">Microfone com Fio</option>
              <option <% if recurso="12" Then Response.Write "selected='selected'" END IF%> value="12">Microfone sem Fio</option>
              <option <% if recurso="1" Then Response.Write "selected='selected'" END IF%> value="1">Notebook</option>   
              <option <% if recurso="23" Then Response.Write "selected='selected'" END IF%> value="23">Pincel</option>
              <option <% if recurso="6" Then Response.Write "selected='selected'" END IF%> value="6">Ponto Lógico</option>
              <option <% if recurso="24" Then Response.Write "selected='selected'" END IF%> value="24">Pulpito</option>     
              <option <% if recurso="17" Then Response.Write "selected='selected'" END IF%> value="17">Suporte p/ Flip-Chart</option>
              <option <% if recurso="26" Then Response.Write "selected='selected'" END IF%> value="26">Telão</option>
              <option <% if recurso="27" Then Response.Write "selected='selected'" END IF%> value="27">Toalha de mesa</option>
              

			</select>&nbsp; &nbsp;
 			
            
            
            <label>Per&iacute;odo: de</label>
            <input <% if data_inicio <> "" Then Response.Write "value= '"&data_inicio&"' " End If %> name="data_inicio" id="data_inicio" class="datepicker" type="text" size="8" maxlength="8"/>
            <label>&nbsp;a&nbsp;</label>
            <input <% if data_final <> "" Then Response.Write "value= '"&data_final&"' " End If %>  name="data_final" id="data_final" class="datepicker" type="text" size="8" maxlength="8"/>
            &nbsp;&nbsp;
            <label>Situa&ccedil;&atilde;o</label>
            
            <select name="exibir_apenas" id="situacoes" class="form-select" style="width:100px;"> 
              <option <% if situacao="" Then Response.Write "selected='selected'" END IF%> value="">Todos</option>	 
              <option <% if situacao="1" Then Response.Write "selected='selected'" END IF%> value="1">Socilitado</option>
              <option <% if situacao="2" Then Response.Write "selected='selected'" END IF%> value="2" >Confirmado</option>
              <option <% if situacao="3" Then Response.Write "selected='selected'" END IF%> value="3">Pendente</option>
              <option <% if situacao="5" Then Response.Write "selected='selected'" END IF%> value="5">Gozado</option>
              <option <% if situacao="6" Then Response.Write "selected='selected'" END IF%> value="6">Não Atendido</option>
              <option <% if situacao="7" Then Response.Write "selected='selected'" END IF%> value="7">Cancelado</option>
              <option <% if situacao="8" Then Response.Write "selected='selected'" END IF%> value="8">Em Andamento</option>
            </select>
            <!--<img src="imagens/search_24x24.png" class="imgsearch" /></p> -->
          <input type="submit" name="button" id="button" class="myButton" value="Pesquisar" onclick="Pesquisar();" />
          <br/>
          <br/>
          <div class="tabela" >
          
          <!-- #INCLUDE FILE ="consulta_emprestimo_con.asp" -->
            
          </div>
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
