<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Estoque-Pendentes</title>
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!-- Favicon -->
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="submenu.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <p>
        <div id='cssmenu'>
          <ul>
            <li ><a href='estoque.asp'><span>Manutenção</span></a></li>
            <li class='active'><a href='estoque_pendentes.asp'><span>Requisições Pendentes</span></a></li>
            <li><a href='estoque_requisicao.asp'><span>Nova Requisição</span></a></li>
          </ul>
        </div>
        </p>
        <div id='submenu'>
          <ul>
            <li class='active'><a href='index.html'><span>Todos</span></a></li>
            <li><a href='#'><span>Recuperação de crédito</span></a></li>
            <li><a href='#'><span>Aplicação</span></a></li>
            <li><a href='#'><span>Ajuda</span></a></li>
          </ul>
        </div>
        <p class="paragrafoteste">
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Pedidos</span></legend>
        <div align="center">
          <input  name="atualizar" class="myButton" type="button"  value="Atualizar" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px"/>
        </div>
        <div class="tabela" align="center">
          <table  name="tabela">
            <tr>
              <td> Motivo </td>
              <td > Material </td>
              <td> Qtd. Solicitada </td>
              <td> Qtd. a Liberar </td>
              <td> Qtd. Disponível </td>
              <td> Unidade </td>
              <td> Solicitante </td>
              <td> Coordenação </td>
              <td> Solicitado em </td>
            </tr>
            <tr>
              <td > Linha 1 </td>
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
              <td > Linha 2 </td>
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
              <td > Linha 3 </td>
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
              <td > Linha 4 </td>
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
              <td > Linha 5 </td>
              <td> Linha 5 </td>
              <td> Linha 5 </td>
              <td> Linha 5 </td>
              <td> Linha 5 </td>
              <td> Linha 5 </td>
              <td> Linha 5 </td>
              <td> Linha 5 </td>
              <td> Linha 5 </td>
            </tr>
          </table>
        </div>
        <div align="center">
          <input  name="atender" class="myButton" type="button"  value="Atender" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px"/>
          <input  name="rejeitar" class="myButton" type="button"  value="Rejeitar" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px"/>
          <input  name="restaurar" class="myButton" type="button"  value="Restaurar" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px"/>
          <input  name="confirmar" class="myButton" type="button"  value="Confirmar Alterações" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px"/>
        </div>
        </fieldset>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
