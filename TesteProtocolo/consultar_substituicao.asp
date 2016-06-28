<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Substitui&ccedil;&atilde;o</title>
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
              <li><a href='substituicao.asp'><span>Solicitar</span></a></li>
              <li  class='active'><a href='consultar_substituicao.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Consultar Substitui&ccedil;&otilde;es</span></legend>
          <p class="paragrafoteste">
            <label>Exibir Apenas :</label>
            <select name"exibir_apenas">
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
            <label>Coordenador</label>
            <select name"coordenador">
              <option value="todos" selected="selected">Todas GS&prime;s</option>
              <option value="solicitado">Aplica&ccedil;&atilde;o</option>
              <option value="confirmado">Arreca&ccedil;&atilde;o e Repasse</option>
              <option value="pendente">Cadastro</option>
              <option value="gozado">Ger&ecirc;ncia</option>
              <option value="natendido">Informa&ccedil;&otilde;es e Apoio &agrave; Gest&atilde;o</option>
              <option value="cancelado">Monitoramento</option>
              <option value="emandamento">Pagamento</option>
              <option value="emandamento">Recupera&ccedil;&atilde;o de Cr&eacute;dito</option>
              <option value="emandamento">Relacionamento com o Cliente</option>
            </select>
            &nbsp;&nbsp;
            <label>Per&iacute;odo :</label>
            <input name="periodo_de" type="text" value="13/01/1993" size="10" maxlength="10" />
            <input name="periodo_a" type="text" value="13/01/1993" size="10" maxlength="10" />
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
            <table name="tabela" >
              <tr>
                <td> C&oacute;digo </td>
                <td> Gerente </td>
                <td> Substituto </td>
                <td> De </td>
                <td> Até </td>
                <td> Situa&ccedil;&atilde;o </td>
                <td> Motivo </td>
              </tr>
              <tr>
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
              </tr>
              <tr>
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
              </tr>
              <tr>
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
