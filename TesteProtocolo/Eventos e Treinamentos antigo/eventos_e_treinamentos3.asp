<%@LANGUAGE="VBScript" CODEPAGE="65001"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge"> 

<title>Eventos e Treinamentos</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon"><!--favicon -->

<script>
  $(function() {
    $( "#tabs" ).tabs();
  });
  </script>

<style type="text/css">
<!--
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}
-->
</style>
</head>
<body>

<div class="teste"> <!--fundo azul do meio-->

<!-- #INCLUDE FILE ="topo.asp" -->

<div class="corposite"> <!--corpo-->

<div class="container">

<div class="conteudo">

<div class="usuariodiv">

 <div id='cssmenu'>
<ul>
   <li class='active'><a href='eventos_e_treinamentos.asp'><span>Solicitar</span></a></li>
   <li ><a href='consultar_eventos_e_treinamentos.asp'><span>Consultar</span></a></li>
   
</ul>
</div></p>
<div id='submenu'>
<ul>

   <li><a href='#'><span>Ajuda</span></a></li>
</ul>
</div>


  
     <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-bottom:10px">
     <legend><span class="titulos">Eventos e Treinamentos</span></legend>
  	 <p class="paragrafoteste">
     <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; padding-bottom:0"> 
     <!-- dados da inclusão -->
  	 <legend><span class="titulos">Dados da Inclus&atilde;o</span></legend>
     
     <p class="paragrafoteste">
     
    <%
 mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i))
				End If
				
				
strQuery = "select NO_NOME,CO_GS from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

nome = rs("NO_NOME")
codigoGerencia = rs("CO_GS")


consultaUnidade = "select CO_UNIDADE,CO_GS from TB_GS where CO_GS='" & codigoGerencia & "'; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set consultar=Server.CreateObject("ADODB.RecordSet")
consultar.Open consultaUnidade, dados_sys

Unidade=consultar("CO_UNIDADE")



objConn.close 
set rs = nothing
set consultar = nothing
set objConn = nothing

%> 
     
     <img src="imagens/X000000.png"  height="19" width="19"/>&nbsp;
     <label>Matr&iacute;cula: <%=usuario%></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <label>Unidade: <% response.Write Unidade %> </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      
     <label>Data: </label>
     <label name="data"><% response.Write DAY(DATE()) &"/"& MONTH(DATE()) &"/"& YEAR(DATE()) %></label>
     
     </p>
     </fieldset> <!-- fim do dados da inclusão -->
     
     
     
     <p><img src="imagens/info_16x16.png" />  <span class="style1">Entre com os dados abaixo para Eventos. Para Treinamento, basta substituir o Tipo para "Treinamento".</span></p>
     
     
     <label for="descricao">Descri&ccedil;&atilde;o:</label>  <input name="descricao" class="form-field" type="text" size="99" maxlength="1024" /><br/><br/>
     <label for="iniciativa" >Iniciativa:</label>  
     		<select name="iniciativa">
                    <option value="Aplicacao" selected="selected">Aplica&ccedil;&atilde;o</option>
                    <option value="ArecadacaoeRepasse">Arrecada&ccedil;&atildeo e Repasse</option>
                    <option value="Cadastro">Cadastro</option>
                    <option value="gerencia">Ger&ecirc;ncia</option>
                    <option value="InformacaoeGestao">Informa&ccedil;&otilde;es e Apoio &agrave; Gest&atilde;o</option>
                    <option value="MonitoramentoeAvaliacao">Monitoramento e Avalia&ccedil;&atildeo da Gest&atilde;o</option>
                    <option value="Pagamento">Pagamento</option>
                    <option value="Recuperacao">Recupera&ccedil;&atildeo de Cr&eacute;dito</option>
                    <option value="Relacionamento">Relacionamento com Cliente</option>  
            </select>&nbsp;&nbsp;
             
	<label>Tipo do Evento:</label> 
			<select name="tipo_evento">
					
                    <option value="Audioconferencia">Audiconfer&ecirc;ncia</option>
                    <option value="Confraternizacao">Confraterniza&ccedil;&atilde;o</option>
                    <option value="EventoExterno">Evento Externo</option>
                    <option value="Palestra">Palestra</option>
                    <option value="Reunicao">Reuni&atilde;o</option>
                    <option value="Treinamento">Treinamento</option>
                    <option value="VisitaExterna">Visita Externa</option>
                    <option value="VisitaInterna">Visita Interna</option>
                    
			</select>
            
   	<br/><br/>        
    <label>Per&iacute;odo:</label>          
        <select name="periodo_de">   <option><% Response.Write(Date)%></option>
        </select>
         <select name="periodo_a">   <option><% Response.Write(Date)%></option>
        </select>
         
         <label for="horario_de" style="margin-left:10px">Horário do evento:</label>
         <input type="text" class="form-field" name="horario_de" id="horario_de" size="4px" maxlength="5"/> 
         <input type="text" class="form-field" name="horario_ate" id="horario_ate" size="4px" maxlength="5"/>     
         <p></p>
               
         <label for="local">Local:</label>          
         <select name="local"><option>09ª Vara - Justiça Federal</option></select>  
         <label for="qtd_participantes" style="margin-left:10px">Quantidade de Participantes:</label>
         <input type="text" class="form-field" name="qtd_participantes" id="qtd_participantes" size="4px" maxlength="5"/> 
          <p></p>
         <label for="desc_participantes">Descrição dos participantes para a agenda:</label>
         <input type="text" class="form-field" name="desc_participantes" id="desc_participantes" size="60px" maxlength="50px"/> 
              
    <br/><br/>        
    
	<label>Situa&ccedil;&atilde;o:</label>  
    
            <select name="Situacao">
                    <option value="todos" selected="selected">Todos</option>
                    <option value="solicitado">Socilitado</option>
                    <option value="confirmado">Confirmado</option>
                    <option value="pendente">Pendente</option>
                    <option value="gozado">Gozado</option>
                    <option value="natendido">Não Atendido</option>
                    <option value="cancelado">Cancelado</option>
                    <option value="emandamento">Em Andamento</option>
            </select>&nbsp;&nbsp;          
            
 			<br />
            <p></p>
       
       
        <p align="center" class="style1"> <img src="imagens/info_16x16.png" /> Inclua os dados em cada aba clicando em Incluir. Por fim, clique em Salvar.</p>
      <fieldset style="border:none;">
      
      <div id='submenu'>
     
      
        <ul>
        
           <li> <a href='eventos_e_treinamentos.asp?aba=responsaveis#bottom'><span>Respons&aacute;veis/Facilitadores</span></a></li>
           <li> <a href='eventos_e_treinamentos.asp?aba=publico#bottom'><span>P&uacute;blico-alvo</span></a></li>
           <li> <a href='eventos_e_treinamentos.asp?aba=servico#bottom'><span>Servi&ccedil;os</span></a></li>
           <li class="classe4"> <a href='eventos_e_treinamentos.asp?aba=recursos#bottom'><span>Recursos</span></a></li>
           <li class="classe5"> <a href='eventos_e_treinamentos.asp?aba=material#bottom'><span>Material</span></a></li>
           <li class="classe6"> <a href='eventos_e_treinamentos.asp?aba=arquivos#bottom'><span>Arquivos</span></a></li>
           <li class="classe7"> <a href='eventos_e_treinamentos.asp?aba=observacoes#bottom'><span>Observa&ccedil;&otilde;es</span></a></li>
           
        </ul>
        
<% 

	aba=Request("aba")
	SELECT CASE aba
		CASE "responsaveis"
	%>
    <!-- #INCLUDE FILE ="eventos_e_treinamentos_responsaveis.asp" -->
    <%
		CASE "publico"
	%>
    <!-- #INCLUDE FILE ="eventos_e_treinamentos_publico_alvo.asp" -->
  
    <%
		CASE "servico"		
	%>
    <!-- #INCLUDE FILE ="eventos_e_treinamentos_servicos.asp" -->	
    
     <%
		CASE "material"
	%>
    <!-- #INCLUDE FILE ="eventos_e_treinamentos_material.asp" -->	
	
	<%
		CASE "arquivos"
	%>
    <!-- #INCLUDE FILE ="eventos_e_treinamentos_arquivos.asp" -->	
	
	<%
		CASE "observacoes"
	%>
    <!-- #INCLUDE FILE ="eventos_e_treinamentos_observacoes.asp" -->	
	
	<%
		CASE "recursos"
	%>
    <!-- #INCLUDE FILE ="eventos_e_treinamentos_recursos.asp" -->	
	
	<%
	
	END SELECT

%>        
<p/><a name="bottom" id="bottom"></a>        </div>
<div align="center">
 <input name="incluir" class="myButton" type="button" value="Salvar" onclick="javascript:window.open('popup_teste.asp','vb','toolbar=0, status=1, menubar=0,scrollbars=0,resizable=0,height=450,width=450');" />
 </div>
      </fieldset>                 
  
  </p>
  <p class="paragrafoteste">&nbsp;</p>
  
  
  </fieldset>
  
<script language="javascript">

</script>

</div>


</div> 


<!-- #INCLUDE FILE ="calendario.asp" -->

</div>


</div> <!--fim do corpo-->

<!-- #INCLUDE FILE ="rodape.asp" -->
</div> <!--teste-->



</body>
</html>