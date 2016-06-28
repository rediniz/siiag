<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>SIIAG-WEB</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<style type="text/css">
<!--
.style1 {
	color: #5683C4
}
.style3 {
	font-size: 12px
}
.style4 {
	font-size: 14px
}
-->
</style>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="submenu.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="teste">
<!--fundo azul do meio-->
<!-- #INCLUDE FILE ="topo.asp" -->
<div class="corposite">
  <!--corpo-->
  <div class="container">
    <div class="conteudo2">
      <p>
      <div id='cssmenu' >
        <ul>
          <li class='active'><a href='estoque.asp'><span>Manutenção</span></a></li>
          <li ><a href='estoque_pendentes.asp'><span>Requisições Pendentes</span></a></li>
          <li ><a href='estoque_requisicao.asp'><span>Nova Requisição</span></a></li>
        </ul>
      </div>
      </p>
      <div id='submenu'>
        <ul>
          <li><a href='estoque.asp'><span>Editar Produto</span></a></li>
          <li class='active'><a href='estoque_cadastrar.asp'><span>Cadastrar Produto</span></a></li>
          <li><a href=''><span>Ajuda</span></a></li>
        </ul>
      </div>
      <p class="paragrafoteste">
      <div class="testess">
        <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="style1">Informações sobre o produto</span></legend>
        <p>
          <label for="nome" style="float:left; text-align:right;">Nome:</label>
          <input name="nome" type="text" class="form-field" id="nome"   style="display:inline-block;" size="70" maxlength="100" />
        </p>
        <label  for="quantidade" style="float:left; text-align:right;">Quantidade:</label>
        <input name="quantidade" type="text" class="form-field" id="quantidade"  style="display:inline-block;" size="10" maxlength="20" />
        <p>
        <p>
          <label for="qtd_min"  style="float:left; text-align:right;">Quantidade Mínima:</label>
          <input name="qtd_min" type="text" class="form-field" id="qtd_min" style="display:inline-block" size="10" maxlength="20" />
        </p>
        <label for="valor" style="float:left; text-align:right;">Valor:</label>
        <input name="valor" type="text" class="form-field" id="valor" style="display:inline-block" size="10" maxlength="20" />
        </p>
        <p>
          <label for="unidade"  style="float:left; text-align:right;">Unidade:</label>
          <label for="unidade"></label>
          <select name="unidade" id="unidade" style="margin-left:-10px">
            <option>unidade</option>
          </select>
        </p>
        <div  align="center" style="padding-bottom:5px; padding-top:-5px">
          <label></label>
        </div>
        </fieldset>
        <fieldset style="border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="style1">SIMAC</span></legend>
        <p>
          <label for="descricao_simac" style="float:left; text-align:right;">Descrição:</label>
          <input name="descricao_simac" type="text" class="form-field" id="descricao_simac"     style="display:inline-block;" size="70" maxlength="100" />
        </p>
        <label  for="quantidade_simac" style="float:left; text-align:right;">Quantidade:</label>
        <input name="quantidade_simac" type="text" class="form-field" id="quantidade_simac"  style="display:inline-block;" size="10" maxlength="20" />
        <p>
          <label for="codigo_simac" style="float:left; text-align:right;">Código:</label>
          <input name="codigo_simac" type="text" class="form-field" id="codigo_simac" style="display:inline-block" size="10" maxlength="20" />
        </p>
        </fieldset>
        <div align="center" style="padding-top:10px">
          <input  name="limpar" class="myButton" type="button" value="Limpar" >
          <input  name="adicionar" class="myButton" type="button"  value="Adicionar" />
        </div>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
