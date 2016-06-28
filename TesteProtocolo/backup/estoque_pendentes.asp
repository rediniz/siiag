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
.style22 {font-size: 12px; color: #FFFFFF; font-family: Arial, Helvetica, sans-serif; }
.style23 {color: #000000}
.style4 {font-size: 14px}
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
                    <td class="abaEsquerda"></td>
                    <td valign="top" class="abaCentro" onclick="location.href='estoque.asp'">Manutenção</td>
                    <td class="abaDireita"></td>
            <!-- FIM DO ITEM DA ABA -->
			
			<!-- INICIO DO ITEM DA ABA -->
                    <td width="3">&nbsp;</td>
                    <td class="abaEsquerdaOn"></td>
                    <td valign="top" class="abaCentroOn" onclick="location.href='estoque_pendentes.asp'">Requisições&nbspPendentes</td>
                    <td class="abaDireitaOn"></td>
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
            
			<td><div align="right"><span class="style8"><img src="imagens/help-browser_002.png" alt="" width="16" height="16" /> <span class="style4">Ajuda</span></span></div></td>
    </tr>
</table>
</div>

  <table height="68" border="0" align="center" cellpadding="0" cellspacing="0"  class="submenu" >
    <tr>
      <td align="center" valign="baseline" class="submenu"><div align="center"><span class="paragrafoteste style1">TODOS </span></div></td>
      <td width="10" class="submenu"><span class="paragrafoteste style1">|</span></td>
      <td width="0" class="submenu"><span class="paragrafoteste style1">RECUPERAÇÃO DE CRÉDITO</span></td>
    </tr>
  </table>
  <fieldset>
  <legend><span class="style1">Pedidos</span></legend>
  <table height="68" border="0" align="right" cellpadding="0" cellspacing="0"  class="submenu" style="padding:6px">
    <tr>
      <td align="center" valign="top" class="submenu"><div align="center"><img src="imagens/adobe_16x16.png" width="16" height="16" /> Relatório<span class="style1">|</span><img src="imagens/refresh_16x16.png" width="16" height="16" /> Atualizar</div></td>
    </tr>
  </table >
  <table width="100%" cellpadding="0" cellspacing="0" bordercolor="#5683C4" class="submenu3" border="0">
    <tr >
      <th height="17" align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Motivo</span></th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Material</span></th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><p class="style22">Qtd.Solicitada</p>
        </th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><p class="style22">Qtd.a liberar</p>
        </th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><p class="style22">Qtd.disponível</p>
        </th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Unidade</span></th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Solicitante</span></th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Coordenação</span></th>
      <th align="center" valign="middle" bordercolor="#5683C4" bgcolor="#5683C4"><span class="style22">Solicitado em</span></th>
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
  <table height="68" border="0" align="center" cellpadding="0" cellspacing="0"  class="submenu" style="padding:6px">
    <tr>
      <td align="center" valign="top" class="submenu"><div align="left"><span class="paragrafoteste style1"><img src="imagens/ok_16x16.png" width="16" height="16" /> </span><span class="style23">Atende</span>r <span class="style1">|</span> <img src="imagens/delete_16x16.png" width="16" height="16" /> Rejeitar <span class="style1">|</span> <img src="imagens/refresh_16x16.png" width="16" height="16" /> Restaurar <span class="style1">|</span> <img src="imagens/save_16x16.png" width="16" height="16" /> Confirmar alterações</div></td>
      </tr>
  </table>
   <p align="center" class="paragrafoteste style1">
  </fieldset>
  <p class="paragrafoteste">
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