<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Afastamentos</title>
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
              <li ><a href='afastamento.asp'><span>Solicitar</span></a></li>
              <li class='active' ><a href='afastamento_consultar.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;" >
          <legend ><span class="titulos" >Consultar Afastamento</span></legend>
          <label for="situacao" style="padding-top:10px"><br />
          Situação: </label>
          <select name="situacao" id="situacao">
            <option>Todos</option>
            <option>Solicitado</option>
            <option>Confirmado</option>
            <option>Pendente</option>
            <option>Gozado</option>
            <option>Não Atendido</option>
            <option>Cancelado</option>
            <option>Em Andamento</option>
          </select>
          <label>Nome:</label>
          <select name="nome">
            <option>Todos</option>
          </select>
          <label>De: </label>
          <select name="data_de">
            <option>20/11/2013</option>
          </select>
          <label> a: </label>
          <select name="data_a">
            <option>20/11/2013</option>
          </select>
          </legend>
          <p></p>
          <div class="tabela" >
            <table>
              <tr>
                <td width="10%"> Código </td>
                <td width="35%" > Usuário </td>
                <td width="21%"> Tipo </td>
                <td width="12%"> Data Início </td>
                <td width="11%"> Data Fim </td>
                <td width="11%"> Situação </td>
              </tr>
              <tr>
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
              </tr>
              <tr>
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
              </tr>
              <tr>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
                <td> Linha 5 </td>
              </tr>
            </table>
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
