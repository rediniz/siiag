<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>SIIAG-WEB</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<!--CSS-->
<style type="text/css">
<!--
.style1 {color: #5683C4}
.style3 {font-size: 12px}
.style4 {font-size: 14px}
.style6 {
	font-size: 14px;
	color: #5683C4;
}
.style22 {font-size: 12px; color: #FFFFFF; font-family: Arial, Helvetica, sans-serif; }
.style8 {font-family: Futura, Arial}
-->
</style>
</head>
<body>

<div class="teste"> <!--fundo azul do meio-->

<div class="cabecalhoprincipal"> <!--cabeçalho -->

<div class="cabecalhoinside">

<img src="imagens/topimage4.jpg" class="imagetop"/>


<!--<div class="usuario"> <!-- Aparecera o usuario que esta logado e a matricula do mesmo-->

<!--nao sei se sera div ou span Doubt yet-->

<!--<p> Usu&aacute;rio: Belmondo Rodrigues Aragão Junior <br/> Matr&iacute;cula: E712237</p>
</div>-->


<div class="menu">  <!-- barra laranja e menu -->
</div> <!--fim do barra laranja e do menu-->


<div class="menuinside"> 

<div class="menucentralizado"> <!--menu centralizado -->
<ul class="listamenu"> <!--lista menu -->
 
<li><a href="principal.asp">Pagina Inicial</a><span class="barradeitada">/</span></li>
<li><a href="">Recursos Humanos<img class="setabaixo" src="imagens/setabaixo.png"/></a><span class="barradeitada">/</span></li>
<li><a href="">Recursos Materiais<img class="setabaixo" src="imagens/setabaixo.png"/></a>




<ul class="submenurecursosm"><!-- submenu recursos materiais-->

		<img src="imagens/case_24x24.png" class="imgemprestimos"  /><li><a href="">Empr&eacute;stimos</a></li>
        
		<hr class="hrrecursos" />

		<img src="imagens/wizard_24x24.png" class="imgeventos"/><li><a href="">Eventos e Treinamentos</a></li>
        <hr class="hrrecursos"/>
        
        <img src="imagens/package-x-generic_003.png" class="imgestoque" /><li><a href="estoque.asp"> Estoque</a></li>
	</ul>  <!-- fim do submenu recursos materiais-->

<span class="barradeitada">/</span></li> <!--fim dos recursos materiais -->	


	
<li><a href="">Relat&oacute;rios<img class="setabaixo" src="imagens/setabaixo.png"/></a><span class="barradeitada">/</span></li>	




<!-- menu usuario -->
<li><a href="usuario.asp">Usu&aacute;rios<!--<img class="setabaixo" src="imagens/setabaixo.png"/>--></a>

<!--<ul class="submenuusuario"><!-- submenu usuario-->

<!--<li><a href="">Consultar</a></li>
<li><a href="">Cadastrar</a></li>

</ul>  <!-- fim do submenu usuario-->


</li> <!-- fim do menu usuario -->



</ul>  <!-- fim da lista menu -->

</div> <!--fim menu centralizado -->


</div>
</div>
</div> <!--fim do cabeçalho-->


<!--</div><!-- se fechar aqui também fica legal -->








<div class="corposite"> <!--corpo-->

<div class="container">

<div class="conteudo2">




  
 <div class="aba">
<table width="100%" border="0" cellspacing="0" cellpadding="0" > 
    <tr>
			<!-- INICIO DO ITEM DA ABA -->
                    <td width="3" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td class="abaEsquerdaOn"></td>
                    <td valign="top" class="abaCentroOn" onclick="location.href='estoque.asp'">Manutenção</td>
                    <td class="abaDireitaOn"></td>
            <!-- FIM DO ITEM DA ABA -->
			
			<!-- INICIO DO ITEM DA ABA -->
                    <td width="3">&nbsp;</td>
                    <td class="abaEsquerda"></td>
                    <td valign="top" class="abaCentro" onclick="location.href='estoque_pendentes.asp'">Requisições&nbspPendentes</td>
                    <td class="abaDireita"></td>
            <!-- FIM DO ITEM DA ABA -->
			
			<!-- INICIO DO ITEM DA ABA -->
                    <td width="3">&nbsp;</td>
                    <td class="abaEsquerda"></td>
                    <td valign="top" class="abaCentro" onclick="location.href='estoque_requisicao.asp'">Nova&nbspRequisição</td>
                    <td class="abaDireita"></td>
            <!-- FIM DO ITEM DA ABA -->
			
			<!-- INICIO DO ITEM DA ABA -->
                    <td width="3">&nbsp;</td>
                    <td class="abaEsquerda"></td>
                    <td valign="top" class="abaCentro" onclick="location.href='estoque_relatorios.asp'">Relatórios</td>
                    <td class="abaDireita"></td>
            <!-- FIM DO ITEM DA ABA -->
                  
			<td><div align="right" class="style8"><img src="imagens/help-browser_002.png" width="16" height="16" /> <span class="style4">Ajuda </span></div></td>
    </tr>
</table>
</div>

<table height="68" border="0" align="center" cellpadding="0" cellspacing="0"  class="submenu" >
<tr>
  <td class="submenu"><span class="paragrafoteste style1"><img src="imagens/edit-document_16x16.png" alt="" width="16" height="16" /> <a class="link" style="text-decoration:none" href=""  >EDITAR PRODUTO</a> |</span></td>
  <td class="submenu"><span class="paragrafoteste style1"><img src="imagens/add_16x16.png" alt="" width="16" height="16" /> <a class="link" style="text-decoration:none" href="">CADASTRAR PRODUTO </a> </span></td>
</tr>
  </table>
  <p class="paragrafoteste">
  
  <fieldset style="border-color: #FDF2D0">
  <legend><span class="style1">Informações do produto selecionado</span></legend>
  <p class="paragrafoteste">    <label></label>
  <fieldset style="border-color:#FDF2D0">
  <legend><span class="style6">SIMAC</span></legend>
    <span class="style4">
    <label>Nome 
    
    <input name="textfield" type="text" id="textfield" size="35" />
    </label>
    
    Código
    <label style="padding-right:5px">
    <input name="textfield2" type="text" id="textfield2" size="5" />
    </label>
    Quantidade
    <label>
    <input name="textfield3" type="text" id="textfield3" size="5" />
    </label>
    </span><span class="style3"><label>    </label>
    <label style="padding-left:10px">
     <input  class="btincluiremprestimo" type="submit" name="button" id="button" value="Qtd. Mensais" />
    </label>
    </span>
  </fieldset>
  </p>
  <p><span class="style4">
    <label style="padding-left:12px">Nome
    <input name="textfield4" type="text" id="textfield4" size="35" />
    </label>
  </span>
    <label><span class="style4">Valor
    <input name="textfield5" type="text" id="textfield5" size="5" />
    </span></label>
    <span class="style4">
    <label>Quantidade
    <input name="textfield6" type="text" id="textfield6" size="5" />
    </label>
    <label> Qtd. Mín. 
    <input name="textfield7" type="text" id="textfield7" size="5" />
    </label>
    </span><span style="padding-left:10px">
    <label><span class="style4"> Unidade
    <select name="select" id="select">
      <option selected="selected">unidade</option>
      <option>kilograma</option>
      <option>centimetro</option>
    </select>
    </span></label>
    </span><span style="padding-left:10px">
    <label>
    <input style: vspace="10px"type="checkbox" name="checkbox" id="checkbox" />
    <span class="style4">Ativo</span></label>
&nbsp;</span></p>
  <p style="padding-left:10px">
    <label></label>
  </p>
  <div align="right"></div><p style="padding-left:10px"><label></label>
    <label> 
    <div align="center">
      <input class="btincluiremprestimo" type="submit" name="button2" id="button2" value="Cancelar" />
        <input class="btincluiremprestimo" type="submit" name="button3" id="button3" value="Salvar" />
    </div>
    </label>
    <label></label>
    <div align="center"></div>
  </p>
  </fieldset>
  

  <p><label></label>
  </p>
  <table width="98%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#5683C4" class="submenu3" >
    <tr>
      <th width="24%" height="17" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Nome</span></th>
      <th width="8%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Quantidade</span></th>
      <th width="8%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><p class="style22">Qtd. Mínima</p></th>
      <th width="8%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><p class="style22">Qtd.a liberar</p></th>
      <th width="8%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><p class="style22">Unidade</p></th>
      <th width="8%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Cod. SIMAC</span></th>
      <th width="25%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Nome SIMAC</span></th>
      <th width="7%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Qtd. SIMAC</span></th>
      <th width="4%" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Ativo</span></th>
    </tr>
    <tr>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
    <tr>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
    <tr>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
    <tr>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
      <td align="center" valign="middle" bordercolor="#5683C4" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  </table>
  <p></p>
  <p>&nbsp;</p>
  <p>&nbsp; </p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  </div> 






</div>


</div> <!--fim do corpo-->












































<div class="rodape">  <!--rodape-->


<div class="mensagemrodape">
<h3 class="mensagem">S I I A G - Sistema de Apoio &agrave; Gest&atilde;o  - <!-- ano--> <%=year(date)%></h3>
</div>

</div> <!--rodape-->
</div> <!--teste-->



</body>
</html>