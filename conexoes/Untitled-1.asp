<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>

<link rel=”stylesheet” type=”text/css” href=”tabela.css” />

<script type="text/vbscript">

if Request("
Function myFunction()
Dim texto
texto = request.Form("textfield4")
window.alert(texto)
End Function

</script>

</head>


<body>

<script type="text/vbscript">

Function myFunction()
window.alert("teste")
End Function

</script>


<p><div id='cssmenu'>
<ul>
   <li class='active'><a href='Untitled-3.html'><span>Manutenção</span></a></li>
   <li ><a href='Untitled-4.html'><span>Requisições Pendentes</span></a></li>
   <li><a href='#'><span>Nova Requisição</span></a></li>
   <li class='last'><a href='#'><span>Relatórios</span></a></li>
</ul>
</div></p>
<div id='submenu'>
<ul>
   <li class='active'><a href='index.html'><span>Editar Produto</span></a></li>
   <li><a href='#'><span>Cadastrar Produto</span></a></li>
   <li><a href='#'><span>Ajuda</span></a></li>
</ul>
</div>
<div class="testess" float:left>
  <fieldset style="border: #C90  medium" style="border-width:0.5px" class="testess">
    <legend>teste</legend>
    <p>
      <label for="textfield">Nome:</label>
      <input class="form-field" type="text" name="textfield" id="textfield" />
    </p>

  <p><label for="textfield2">Matrícula:</label>
    <input class="form-field" type="text" name="textfield2" id="textfield2" />
  </p>
      <label for="radio">Ativo:</label>
    <input type="radio" name="radio" id="radio" value="radio" />


    <label for="select">Cidade:</label>
    <select style="color:#666" name="select" id="select">
                     <% 

strQuery = "select NO_UF from TB_UF; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=RENATO;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

' Agora iremos exibir os dados do Recordset gerado pela consulta SQL
'Vamos percorrer o recordset até chegar no final do arquivo
DO UNTIL rs.eof
'atribuindo os valores dos campos as variáveis
  Codigo=rs("NO_UF")

' escrevendo os campos em uma tabela para exibição via um Browser
  'cellstart="<td align=""top"">"
   response.write "<option >" & Codigo & "</option>"

  rs.movenext

LOOP


objConn.close 
set rs = nothing
set objConn = nothing 
%>
    </select>

  <p>
    <label for="textfield4">Cargo:</label>
    <input class="form-field" type="text" name="textfield4" id="textfield4" />
  </p>
  <p>
    <label for="textfield5">Telefone:</label>
    <input  class="form-field" type="text" name="textfield5" id="textfield5" />
  </p>
  </fieldset>

</div>
<p>
  <a href="Untitled-1.asp?action=myFunction()"  class="myButton" onclick="myFunction()">Salvar</a>
</p>

<% 
If Request("radio") Then

response.Write"<p>Testando radio</p>"

End if


%>
<div class="tabela" >
                <table >
                <tr >
                <td>Código</td>
                <td>Nome</td>
                <td>Gerente</td>
                <td>Macro</td>
                <td>Ativo</td>
                <td>Unidade</td>
                </tr>
                   <% 

strQuery = "select * from TB_GS; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=RENATO;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

' Agora iremos exibir os dados do Recordset gerado pela consulta SQL
'Vamos percorrer o recordset até chegar no final do arquivo
DO UNTIL rs.eof
'atribuindo os valores dos campos as variáveis
  Codigo=rs("CO_GS")
  Nome=rs("NO_GS")
  Codigo_Gerente=rs("CO_GERENTE")
  Macro=rs("CO_MACRO_PROCESSO")
  Ativo=rs("IC_ATIVO")
  Unidade=rs("CO_UNIDADE")

' escrevendo os campos em uma tabela para exibição via um Browser
  'cellstart="<td align=""top"">"
   response.write "<tr>"
   response.write "<td>" & Codigo & "</td>"
   response.write "<td>" & Nome & "</td>"
   response.write "<td>" & Codigo_Gerente & "</td>"
   response.write "<td>" & Macro & "</td>"
   If Ativo = "Verdadeiro" Then
  response.write "<td>Sim</td>"
End If
 
   response.write "<td>" & Unidade & "</td>"
   response.write "</tr>"
  rs.movenext

LOOP


objConn.close 
set rs = nothing
set objConn = nothing 
%>
                </table>
</div>



</body>
</html>
