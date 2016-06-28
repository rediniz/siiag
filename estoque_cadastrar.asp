<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
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
<script src="scripts/jquery-1.9.1.js"></script>
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

<script type="text/javascript" language="javascript">

 $(document).on("click", "#adicionar", function (){
 
 if( $("#perfil_estoque").val() == 'False' ){
			alert("Você não tem permissão para cadastrar um material.");
			return false;
		}
 
 var nome = document.getElementById("nome").value;
 
 if(nome == ""){
	alert("Informe o nome.");
	return false;
 }
 
 
 var quantidade = document.getElementById("quantidade").value;
 if(quantidade == ""){
	alert("Informe a quantidade.");
	return false;
 }


 
 var qtd_min = document.getElementById("qtd_min").value;
 
 if(qtd_min == ""){
	alert("Informe a quantidade mínima.");
	return false;
 }
 
 var valor =  document.getElementById("valor").value;
 
 if(valor == ""){
	alert("Informe o valor.");
	return false;
 }
 
 var unidade = document.getElementById("unidade").value;
 
 if(unidade == ""){
	alert("Informe a unidade.");
	return false;
 }
 
 //alert(nome);
 //alert(quantidade);
 //alert(qtd_min);
 //alert(valor);
 //alert(unidade);
 
  var certeza = window.confirm("Tem certeza que deseja cadastrar o material?");
  
  //alert(certeza);
  if (certeza==true){
  
 //  window.location.assign("estoque_cadastrar.asp?nome="+nome+"&quantidade="+quantidade+"&qtd_min="+qtd_min+"&valor="+valor+"&unidade="+unidade+"");
  	form.submit();
  }else{
  
  return false;
  
  }

 });
    
</script>

<script type="text/javascript" language="javascript">
 function Limpar(){
 
 window.location.assign("estoque_cadastrar.asp");
 }
       
</script>		
		
</head>
<%
  Perfil_Acesso("8")
   
  response.write "<input type='hidden' id = 'perfil_estoque' value=" & perfil_acesso_siiag & ">"
%>
<body>
<div class="teste">
<!--fundo azul do meio-->
<!-- #INCLUDE FILE ="topo.asp" -->
<div class="corposite">
  <!--corpo-->
  <div class="container">
    <div class="conteudo2">
      	<div class="titulosModulos" ><span >ESTOQUE</span> </div>
      <p>
      <div id='cssmenu' >
        <ul>
          <li ><a href='estoque_requisicao.asp'><span>Novo Pedido</span></a></li>
          <li ><a href='estoque_pendentes.asp'><span>Pedidos</span></a></li>
          <li class='active'><a href='estoque_manutencao.asp'><span>Manutenção</span></a></li>  
        </ul>
      </div>
      </p>
      <div id='submenu'>
        <ul>
          <li><a href='estoque_manutencao.asp'><span>Editar Material</span></a></li>
          <li class='active'><a href='estoque_cadastrar.asp'><span>Cadastrar Material</span></a></li>
         
        </ul>
      </div>
      <p class="paragrafoteste">
      <div class="testess">
      	<form id="form" name="form" action="estoque_cadastrar.asp" method="post" target="_self" >
            <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
            <legend><span class="style1">Informações sobre o material</span></legend>
            <p>
              <label for="nome" style="float:left; text-align:right;">Nome:</label>
              <input name="nome" type="text" class="form-field" id="nome"  style="display:inline-block;" size="70" maxlength="100" />
            </p>
            <label  for="quantidade" style="float:left; text-align:right;">Quantidade:</label>
            <input name="quantidade" type="text" class="form-field" id="quantidade"  style="display:inline-block;" size="10" maxlength="20" />
            <p>
            <p>
              <label for="qtd_min"  style="float:left; text-align:right;">Quantidade Mínima:</label>
              <input name="qtd_min" type="text" class="form-field" id="qtd_min" style="display:inline-block" size="10" maxlength="20" />
            </p>
            <label for="valor" style="float:left; text-align:right;">Valor em R$:</label>
            <input name="valor" type="text" class="form-field" id="valor" style="display:inline-block" size="10" maxlength="20" />
            </p>
            <p>
              <label style="float:left; text-align:right;">Unidade:</label>
              
              <select  id="unidade" name="unidade" class="form-select" >
              <option value="">Selecione uma unidade</option>
              <%
    
                strQuery ="select CO_UNIDADE, DE_UNIDADE FROM TB_ESTOQUE_UNIDADE WHERE (IC_ATIVO = 1) " 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
                
                set Ls=	Server.CreateObject("ADODB.RecordSet")
                'dados_sys ="Provider=sqloledb;Data Source=rs7655NT005;Initial Catalog=SIIAG;User Id=italo;Password=italo;"
                Ls.Open strQuery, dados_sys
                
                 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
                 'Vamos percorrer o recordset até chegar no final do arquivo
                        
                  DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
                  
                 'atribuindo os valores dos campos as variáveis
                    CO_UNIDADE=Ls("CO_UNIDADE")
                    DE_UNIDADE=Ls("DE_UNIDADE")
                
                                response.write "<option value=" & CO_UNIDADE & ">"& DE_UNIDADE &"</option>" 'imprimindo
                                
                    Ls.movenext 'passando para o proximo elemento da tabela
                  
                    LOOP
                
                set Ls = 		nothing
                set objConn = 	nothing 
                'fechando todas as conexoes
                
                %>
    
              </select>
            </p>
              
              <fieldset style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; background:#F8F8F8">
              <legend><span class="titulos" >SIMAC</span></legend>
              <span>
              <label>Nome:
              <input  class="form-field" name="nome_simac" type="text" id="nome_simac" size="35"  />
              </label>
              <label style="padding-right:5px">Código:
              <input class="form-field" name="cod_simac" type="text" id="cod_simac" size="5" />
              </label>
              <label>Quantidade: </label>
              <input class="form-field" name="qtd_simac" type="text" id="qtd_simac" size="5" />
              </span><span>
              <label> </label>
              </span>
              </fieldset>
                      
            <div  align="center" style="padding-bottom:5px; padding-top:-5px">
              <label></label>
            </div>
                  
            <div align="center" style="padding-top:10px">
              <input  name="limpar" class="myButton" type="button" value="Limpar" onclick="Limpar();" >
              <input  name="adicionar" class="myButton" type="button"  id="adicionar" value="Adicionar"  />
            </div>
            
            </fieldset>
        </form>
        <!--<fieldset style="border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
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
        </div>-->
       	 
        <p>&nbsp;</p>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->     
<%

	nome = Request("nome")
	quantidade = Request("quantidade")
	qtd_min = Request("qtd_min")
	valor =  Request("valor")
	unidade = Request("unidade")
	nome_simac = request("nome_simac")
	cod_simac = request("cod_simac")	
	qtd_simac = request("qtd_simac")
		
	ativo = 1
	
	if nome <> "" Then 
	
		sql = "INSERT INTO TB_ESTOQUE_MATERIAL (NO_MATERIAL, CO_UNIDADE, QT_QUANTIDADE, QT_QTDE_MINIMA, VR_VALOR_UNIT, IC_ATIVO, CO_UNIDADE_FGTS, DE_SIMAC, CO_SIMAC, QT_QTDE_SIMAC, QT_DISPONIVEL_SOLICITACAO) VALUES ('" & nome & "'," & unidade & "," & quantidade & "," & qtd_min & ",cast('" & valor & "' as money)," & ativo & ","& request.Cookies("co_usuario_unidade_siiag")&",'" & nome_simac & "'," & cod_simac & "," & qtd_simac & "," & quantidade & ")"
		Set query = objConn.execute(sql)
		
		'Fechando conexão
		Set query = Nothing
		Set objConn = Nothing
		
		Response.Redirect("estoque_cadastrar.asp?sucesso=true")
			
	End IF
%>        
      
      </div>
    </div>
  </div>
  
  <%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Inserção realizada com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
						
		end if
		
  %>
  
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
