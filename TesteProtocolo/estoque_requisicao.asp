<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Nova Requisi&ccedil;&atilde;o - Estoque</title>
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
      <div id='cssmenu' >
        <ul>
          <li ><a href='estoque.asp'><span>Manutenção</span></a></li>
          <li ><a href='estoque_pendentes.asp'><span>Requisições Pendentes</span></a></li>
          <li class='active'><a href='estoque_requisicao.asp'><span>Nova Requisição</span></a></li>
        </ul>
      </div>
      </p>
      <div id='submenu'>
        <ul>
          <li><a href='#'><span>Ajuda</span></a></li>
        </ul>
      </div>
      <p class="paragrafoteste">
      <div class="testess">
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Lista de produtos</span></legend>
        <div  align="center" style="padding-bottom:5px; padding-top:-5px">
          <label>Filtro de Produtos</label>
          <input class="form-field" name="filtro" type="text" size="35" maxlength="100" />
          <input name="atualizar" class="myButton" type="button"  value="Atualizar" style="padding-right:10px; padding-left:10px; margin:10px; padding-top:1px; padding-bottom:1px"/>
        </div>
        <div class="tabela" style="margin-left:0.8%;" >
          <table  name"tabela_produtos">
            <tr>
              <td width="31%"> Nome </td>
              <td width="7%" > Qtd. </td>
              <td width="7%"> Qtd. Mínima </td>
              <td width="7%"> Unidade </td>
              <td width="8%"> Cód. SIMAC </td>
              <td width="28%"> Nome SIMAC </td>
              <td width="7%"> Qtd. SIMAC </td>
              <td width="5%"> Ativo </td>
            </tr>
            <tr>
              <td > Envelope Médio de Uso Externo - Postagem Franqueada</td>
              <td> 24 </td>
              <td> 400</td>
              <td> unidade</td>
              <td> 11019 </td>
              <td>&nbsp;</td>
              <td> 0</td>
              <td> Sim </td>
            </tr>
            <tr>
              <td > Fita Adesiva - Propileno para empacotamento</td>
              <td> 1</td>
              <td> 6</td>
              <td> unidade</td>
              <td> 71484</td>
              <td>&nbsp;</td>
              <td> 0 </td>
              <td> Sim </td>
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
            </tr>
          </table>
        </div>
        <div align="center">
          <input name="adicionar" class="myButton" type="button"  value="Adicionar" style="padding-right:10px; padding-left:10px; margin:10px; padding-top:1px; padding-bottom:1px"/>
        </div>
        </fieldset>
        </p>
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Pedidos</span></legend>
        <div class="tabela" style="margin-left:0.8%;" >
          <table name="tabela_pedidos" >
            <tr>
              <td width="31%"> Nome </td>
              <td width="7%" > Qtd. </td>
              <td width="7%"> Qtd. Mínima </td>
              <td width="7%"> Unidade </td>
              <td width="8%"> Cód. SIMAC </td>
              <td width="28%"> Nome SIMAC </td>
              <td width="7%"> Qtd. SIMAC </td>
              <td width="5%"> Ativo </td>
            </tr>
            <tr>
              <td > Envelope Médio de Uso Externo - Postagem Franqueada</td>
              <td> 24 </td>
              <td> 400</td>
              <td> unidade</td>
              <td> 11019 </td>
              <td>&nbsp;</td>
              <td> 0</td>
              <td> Sim </td>
            </tr>
            <tr>
              <td > Fita Adesiva - Propileno para empacotamento</td>
              <td> 1</td>
              <td> 6</td>
              <td> unidade</td>
              <td> 71484</td>
              <td>&nbsp;</td>
              <td> 0 </td>
              <td> Sim </td>
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
            </tr>
          </table>
        </div>
        <div align="center">
          <input name="apagar" class="myButton" type="button"  value="Apagar todos os pedidos" style="padding-right:10px; padding-left:10px; margin:10px; padding-top:1px; padding-bottom:1px"/>
        </div>
        </fieldset>
        <div align="center" style="padding-top:10px">
          <input  name="cancelar" class="myButton" type="button" value="Cancelar" >
          <input  name="salvar" class="myButton" type="button"  value="Salvar" />
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
