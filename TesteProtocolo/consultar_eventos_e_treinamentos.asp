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
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
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
          <div id='cssmenu'>
            <ul>
              <li><a href='eventos_e_treinamentos.asp'><span>Solicitar</span></a></li>
              <li  class='active'><a href='consultar_eventos_e_treinamentos.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Consultar Eventos e Treinamentos</span></legend>
          <p class="paragrafoteste">
            <label>Tipo:</label>
            <select name"tipo">
              <option value="todos" selected="selected">Todos</option>
              <option value="solicitado">Audiconfer&ecirc;ncia</option>
              <option value="confirmado">Confraterniza&ccedil;&atilde;o</option>
              <option value="pendente">Evento Externo</option>
              <option value="gozado">Palestra</option>
              <option value="natendido">Reuni&atilde;o</option>
              <option value="cancelado">Treinamento</option>
              <option value="emandamento">Visita Externa</option>
              <option value="emandamento">Visita Interna</option>
            </select>
            &nbsp;&nbsp;
            <label>Situa&ccedil;&atilde;o:</label>
            <select "situacao">
              <option value="todos" selected="selected">Todos</option>
              <option value="solicitado">Socilitado</option>
              <option value="confirmado">Confirmado</option>
              <option value="pendente">Pendente</option>
              <option value="gozado">Gozado</option>
              <option value="natendido">Não Atendido</option>
              <option value="cancelado">Cancelado</option>
              <option value="emandamento">Em Andamento</option>
            </select>
            &nbsp;&nbsp;
            <label>Por Per&iacute;odo: </label>
            <select name="por_periodo">
              <option value="todos" selected="selected">Todos</option>
              <option value="solicitado">Janeiro</option>
              <option value="confirmado">Fevereiro</option>
              <option value="pendente">Mar&ccedil;o</option>
              <option value="gozado">Abril</option>
              <option value="natendido">Maio</option>
              <option value="cancelado">Junho</option>
              <option value="emandamento">Julho</option>
              <option value="emandamento">Agosto</option>
              <option value="emandamento">Setembro</option>
              <option value="emandamento">Outubro</option>
              <option value="emandamento">Novembro</option>
              <option value="emandamento">Dezembro</option>
            </select>
            <label>à</label>
            <select name="periodo_a">
              <option value="todos" selected="selected">Todos</option>
              <option value="solicitado">Janeiro</option>
              <option value="confirmado">Fevereiro</option>
              <option value="pendente">Mar&ccedil;o</option>
              <option value="gozado">Abril</option>
              <option value="natendido">Maio</option>
              <option value="cancelado">Junho</option>
              <option value="emandamento">Julho</option>
              <option value="emandamento">Agosto</option>
              <option value="emandamento">Setembro</option>
              <option value="emandamento">Outubro</option>
              <option value="emandamento">Novembro</option>
              <option value="emandamento">Dezembro</option>
            </select>
            &nbsp;&nbsp;
            <input name="incluir" class="myButton" type="button" value="Procurar" />
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
            <table  >
              <tr>
                <td width="8%">Tipo Evento</td>
                <td width="10%" >Situa&ccedil;&atilde;o</td>
                <td width="8%">Criador</td>
                <td width="10%" >Evento</td>
                <td width="10%">Per&iacute;odo</td>
                <td width="17%" >Local</td>
                <td width="25%" >Iniciativa</td>
                <td width="25%" >Qtd de Participantes</td>
                <td width="25%" >Cria&ccedil;&atilde;o</td>
              </tr>
              <tr>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
                <td> Linha 1 </td>
              </tr>
              <tr>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
                <td> Linha 2 </td>
              </tr>
              <tr>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
                <td> Linha 3 </td>
              </tr>
              <tr>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
                <td> Linha 4 </td>
              </tr>
              <tr>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
              </tr>
              <tr>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
              </tr>
            </table>
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
