<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Estoque</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="submenu.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="imagetoolbar" content="no">
<script src="scripts/jquery-1.9.1.js"></script>
</head>
<body>
<div class="teste2">
<!--fundo azul do meio-->
<!-- #INCLUDE FILE ="topo.asp" -->
<!--#include file="Conexao.asp"-->
<%
dim obj
set obj = new Conexao
%>
<div class="corposite">
  <!--corpo-->
  <div class="container">
    <div class="conteudo2">
      <p>
      <div id='cssmenu' >
        <ul>
          <li class='active'><a href='estoque.asp'><span>Manutenção</span></a></li>
          <li ><a href='estoque_pendentes.asp'><span>Requisições Pendentes</span></a></li>
          <li><a href='estoque_requisicao.asp'><span>Nova Requisição</span></a></li>
        </ul>
      </div>
      </p>
      <div id='submenu'>
        <ul>
          <li class='active'><a href=''><span>Editar Produto</span></a></li>
          <li><a href='estoque_cadastrar.asp'><span>Cadastrar Produto</span></a></li>
          <li><a href='#'><span>Ajuda</span></a></li>
        </ul>
      </div>
      <p class="paragrafoteste">
      <div class="testess">
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Informações do produto selecionado</span></legend>
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; background:#F8F8F8">
        <legend><span class="titulos" >SIMAC</span></legend>
        <span >
        <label>Nome:
        <input  class="form-field" name="nome_simac" type="text" id="nome_simac" size="35" />
        </label>
        <label style="padding-right:5px"> Código:
        <input class="form-field" name="codigo_simac" type="text" id="codigo_simac" size="5" />
        </label>
        <label> Quantidade: </label>
        <input class="form-field" name="quantidade_simac" type="text" id="quantidade_simac" size="5" />
        </span><span>
        <label> </label>
        <label style="padding-left:10px">
        <input  name="qtd_mensais" class="myButton" type="button"  value="Qtd. Mensais" style="padding-top:1px; padding-bottom:1px;"/>
        </label>
        </span>
        </fieldset>
        <p><span>
          <label for="nome" >Nome: </label>
          <input class="form-field" name="nome" type="text" id="nome" size="35" />
          </span>
          <label for="valor"><span>Valor: </span></label>
          <input class="form-field" name="valor" type="text" id="valor" size="5" />
          <span>
          <label for="quantidade">Quantidade: </label>
          <input class="form-field" name="quantidade" type="text" id="quantidade" size="5" />
          <label for="qtd_min"> Qtd. Mín.: </label>
          <input class="form-field" name="qtd_min" type="text" id="qtd_min" size="5" />
          </span><span style="padding-left:10px">
          <label for "unidade"> Unidade:</label>
          <select name="unidade" id="unidade">
            <option selected="selected">unidade</option>
            <option>kilograma</option>
            <option>centimetro</option>
          </select>
          </span> 
        <span>
        <label for="ativo"><span >Ativo:</span></label>
        <input style: vspace="10px"type="checkbox" name="ativo" id="ativo" />
        <p>
        <div align="center" style="padding-top:10px">
          <input  name="cancelar" class="myButton" type="button" value="Cancelar" >
          <input  name="salvar" class="myButton" type="button"  value="Salvar" />
        </div>
        </p>
        </span>
        </fieldset>
        <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos">Produtos Cadastrados</span></legend>
        <div align="center" style="padding-bottom:10px">
          <input style: vspace="10px"type="checkbox" name="checkbox_materiais_ativos" id="checkbox_materiais_ativos" />
          <label for="checkbox_materiais_ativos"><span >Apenas materiais ativos</span></label>
          <input style: vspace="10px"type="checkbox" name="checkbox_colunasSIMAC" id="checkbox_colunasSIMAC" />
          <label for="checkbox_colunasSIMAC"><span >Exibir colunas SIMAC</span></label>
        </div>
        <div class="tabela" style="margin-left:0.8%;" >
          <table>
            <tr>
              <td width="31%">Nome</td>
              <td width="7%" >Qtd.</td>
              <td width="7%">Qtd. Mínima</td>
              <td width="7%">Unidade</td>
              <td width="8%">Cód. SIMAC</td>
              <td width="28%">Nome SIMAC</td>
              <td width="7%">Qtd. SIMAC</td>
              <td width="5%">Ativo</td>
            </tr>
            <% 
					
strQuery = 		"select NO_MATERIAL, QT_QUANTIDADE, QT_QTDE_MINIMA, CO_UNIDADE, CO_SIMAC, DE_SIMAC, QT_QTDE_SIMAC, IC_ATIVO  from 			TB_ESTOQUE_MATERIAL; " 
set objConn = 	server.CreateObject("ADODB.Connection") 
dados_sys = 	"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=			Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
  DO UNTIL rs.eof
  
 'atribuindo os valores dos campos as variáveis
  Nome =		rs("NO_MATERIAL")
  Qtd =			rs("QT_QUANTIDADE")
  Qtd_min =		rs("QT_QTDE_MINIMA")
  Unidade =		rs("CO_UNIDADE")
  Cod_SIMAC =	rs("CO_SIMAC")
  De_SIMAC =	rs("DE_SIMAC")
  Qt_SIMAC =	rs("QT_QTDE_SIMAC")
  Ativo =		rs("IC_ATIVO")  
   
' escrevendo os campos em uma tabela para exibição via um Browser
  'cellstart="<td align=""top"">"
  
   response.write "<tr>"
   response.write "<td>" & Nome & "</td>"
   response.write "<td>" & Qtd & "</td>"
   response.write "<td>" & Qtd_min & "</td>"
   response.write "<td>" & Unidade & "</td>"
   response.write "<td>" & Cod_SIMAC & "</td>"
   response.write "<td>" & De_SIMAC & "</td>"
   response.write "<td>" & Qt_SIMAC & "</td>"
   
     If Ativo = "True" Then
  response.write "<td>Sim</td>"
  else
   response.write "<td>Não</td>"
End If
 response.write "</tr>"
  rs.movenext
  
LOOP

objConn.close 
set rs = nothing
set objConn = nothing 
%>
          </table>
        </div>
        </fieldset>
        <p></p>
        <p></p>
        <p></p>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
