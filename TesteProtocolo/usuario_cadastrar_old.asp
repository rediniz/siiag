<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Usu&aacute;rio</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<!--CSS-->
<style type="text/css">
<!--
.style2 {
	font-size: 14
}
.style3 {
	color: #5683C4
}
-->
</style>
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='usuario.asp'><span>Visualização</span></a></li>
              <li class='active'><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Informações do Usu&aacute;rio</legend>
          <p/>
          <label >Matr&iacute;cula: </label>
          <input class='form-field' name='matricula' id='matricula' type='text'  size='10' maxlength='100'  />
          <p/>
          <label >Nome: </label>
          <input class='form-field' name='nome' id='nome' type='text'  size='54' maxlength='100' />
          <br/>
          <br/>
          <label > Coordena&ccedil;&atilde;o: </label>
          <input class='form-field' name='coordenacao' id='coordenacao' type='text'  size='50' maxlength='50' readonly='readonly' />
          <br/>
          <br/>
          <label >Cargo: </label>
          <input class='form-field' name='cargo' id='cargo' type='text'  size='30' maxlength='30' readonly='readonly' />
          <br/>
          <br/>
          <label >Nascimento: </label>
          <input class='form-field' name='nascimento' id='nascimento' type='text'  size='8' maxlength='8' readonly='readonly' />
          <br/>
          <br/>
          <label >Admissão: </label>
          <input class='form-field' name='admissao' id='admissao' type='text'  size='10' maxlength='10'  readonly='readonly' />
          <label>Início: </label>
          <input class='form-field' name='inicio' id='inicio' type='text'  size='10' maxlength='10' readonly='readonly' />
          <br/>
          <br/>
          <label >Jornada:</label>
          <input class='form-field' name='jornada' id='jornada' type='text'  size='10' maxlength='10'  readonly='readonly' />
          </span>
          <p> <span >
            <label style="float:left; "> Ativo:</label>
            <input  type='checkbox' name='ativo' value='ativo' id='ativo' />
            <br/>
            <label for="gerente" style="text-align:right;">Gerente ou Substituto:</label>
            <input type='checkbox' name='gerente' value='gerenteousubstituto' id='gerente' />
          </fieldset>
        </div>
      </div>
      <!-- #INCLUDE FILE ="calendario.asp" -->
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
