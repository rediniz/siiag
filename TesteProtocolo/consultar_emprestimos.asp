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
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->
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
              <li ><a href='emprestimos.asp'><span>Solicitar</span></a></li>
              <li class='active'><a href='consultaremprestimos.asp'><span>Consultar</span></a></li>
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
  
strQuery = 		"select DE_RECURSO  from TB_TIPOS_RECURSOS ORDER BY DE_RECURSO; " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
set objConn = 	server.CreateObject("ADODB.Connection") 
dados_sys = 	"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs =		Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
 
 			response.Write "<label> Recursos:</label>" 
    		response.Write "<select name='recursos'>"
			
  DO UNTIL rs.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
  
 'atribuindo os valores dos campos as variáveis
	  tipoRecurso=rs("DE_RECURSO")
	    
                response.write "<option value='"& tipoRecurso &"'>"& tipoRecurso &"</option>" 'imprimindo

    rs.movenext 'passando para o proximo elemento da tabela
  
	LOOP
	
		response.Write "</select>&nbsp; &nbsp;" 'fechando o select

objConn.close 
set rs = 		nothing
set objConn = 	nothing 
'fechando todas as conexoes
%>
            <label>Per&iacute;odo</label>
            <select "periodo">
            </select>
            &nbsp;&agrave;&nbsp;
            <select>
            </select>
            &nbsp;&nbsp;
            <label>Situa&ccedil;&atilde;o</label>
            <select name"situacao">
              <option value="todos" selected="selected">Todos</option>
              <option value="solicitado">Socilitado</option>
              <option value="confirmado">Confirmado</option>
              <option value="pendente">Pendente</option>
              <option value="gozado">Gozado</option>
              <option value="natendido">Não Atendido</option>
              <option value="cancelado">Cancelado</option>
              <option value="emandamento">Em Andamento</option>
            </select>
            <!--<img src="imagens/search_24x24.png" class="imgsearch" /></p> -->
          <p class="paragrafoteste">&nbsp;</p>
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
            <table name="tabela">
              <tr>
                <td> Recurso </td>
                <td> Situa&ccedil;&atilde;o </td>
                <td> Local </td>
                <td> Respons&aacute;vel </td>
                <td> Per&iacute;odo </td>
                <td> Observa&ccedil;&atilde;o </td>
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
              <tr>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
                <td> Linha 6 </td>
              </tr>
            </table>
          </div>
          <p class="paragrafoteste">&nbsp;</p>
          </span>
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
