<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Mudan&ccedil;as</title>
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
              <li><a href='jornada.asp'><span>Solicitar</span></a></li>
              <li  class='active'><a href='consultar_jornada.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos">Consultar Altera&ccedil;&otilde;es de Jornada de Trabalho</span></legend>
          <p class="paragrafoteste">
            <label>Colaborador:</label>
            <input name="txt_matr_colaborador" type="text" size="10" maxlength="7" />
            <input name="txt_nome_colaborador" type="text" size="10" maxlength="7" />
            <label>Hor&aacute;rio:</label>
            <input name="txt_horario_inicio" type="text" size="3" maxlength="2" />
            <input name="txt_horario_fim" type="text" size="3" maxlength="2" />
            <%
  
strQuery = "select CO_GS, NO_GS  from TB_GS ORDER BY NO_GS; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set Ls=Server.CreateObject("ADODB.RecordSet")
Ls.Open strQuery, dados_sys

 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
 
 			response.Write "<label> Coordenação:</label>" 
    		response.Write "<select name='coordenacao'>"
			
  DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
  
 'atribuindo os valores dos campos as variáveis
	  nomeGerencia=Ls("NO_GS")
	  codigoGerencia=Ls("CO_GS")
	  
                response.write "<option value='"& codigoGerencia &"'>"& nomeGerencia &"</option>" 'imprimindo
               
    Ls.movenext 'passando para o proximo elemento da tabela
  
	LOOP
	
		response.Write "</select>" 'fechando o select

objConn.close 
set Ls = nothing
set objConn = nothing 
'fechando todas as conexoes
%>
            <br/>
            <br/>
            <label>Situa&ccedil;&atilde;o:</label>
            <select name="situacao">
              <option value="todos" selected="selected">Todos</option>
              <option value="solicitado">Socilitado</option>
              <option value="confirmado">Confirmado</option>
              <option value="pendente">Pendente</option>
              <option value="gozado">Gozado</option>
              <option value="natendido">Não Atendido</option>
              <option value="cancelado">Cancelado</option>
              <option value="emandamento">Em Andamento</option>
            </select>
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
            <table  >
              <tr>
                <td> C&oacute;digo </td>
                <td> Usu&aacute;rio </td>
                <td> Entrada </td>
                <td> Sa&iacute;da </td>
                <td> Vig&ecirc;ncia </td>
                <td> Situa&ccedil;&atilde;o </td>
                <td> Ger&ecirc;ncia </td>
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
