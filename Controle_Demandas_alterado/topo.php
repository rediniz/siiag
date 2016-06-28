<?
	include 'funcoes.php';
?>
<meta http-equiv="x-ua-compatible" content="IE=9">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<div class="cabecalhoprincipal">
    <!--cabeçalho -->
    <div class="cabecalhoinside">
        <div class="dadosdousuario">
            <!-- dados do usuario -->

    </p>
		
	<p style="font-size:12px;">  	
        <?
			/* setando uma variavel de conexao*/
			$conexao = mssql_connect('ce7180sr001','todos', 'todosce');
			mssql_select_db('SIIAG',$conexao);
			/*pegando o cookie referente à matricula*/
			$matricula =  $_COOKIE['co_usuario_siiag'];
			
			$unidade = $_COOKIE['co_usuario_unidade_siiag'];
			$query = "select * from VW_USUARIOS where CO_MATRICULA='$matricula'";
			$resultado = mssql_query($query,$conexao);
		
			$linha = mssql_fetch_array($resultado);
		
			/*consulta de perfis */
			$consultaPerfil = "select NO_PERFIL from VW_USUARIOS_PERFIS where CO_MATRICULA='$matricula'";
			$resultadoPerfil = mssql_query($consultaPerfil,$conexao);
		
			$linhaPerfil = mssql_fetch_array($resultadoPerfil);
		
			/* fim da consulta de perfis */
		
			//imprimindo as informações do topo
	    	echo $linha['NO_NOME'].' - '.$matricula.'</br>'.'Perfil: '.$linhaPerfil ['NO_PERFIL']." | "."Unidade: ".$unidade." - ".$linha['SG_UNIDADE'];
		?>
     
    	</p>
    </div>
    <!--fim dos dados do usuario -->
    
	<a href="principal.asp" ><img src="../imagens/topimage5.png" border="0" class="imagetop" /></a>

		<!-- o original é o topimage4.jpg, mas esse aqui ficou melhor -->
    	<div class="menu">
      		<!-- barra laranja e menu -->
    	</div>
        
    	<!--fim do barra laranja e do menu-->
    	<div class="menuinside" >
      		<div class="menucentralizado">
        		<!--menu centralizado -->
        		<nav id="colorNav" style="margin-left:-23px">
          			<ul>
            			<li> <a href="../principal.asp" class="icon-home">P&aacute;gina Inicial</a> </li>
            			<li> <a href="#" class="icon-cogs">Recursos Humanos</a>
              				<ul>
                                <li><a href="../destacamentos.asp">Destacamentos</a></li>
                                <li><a href="../ferias.asp">F&eacute;rias</a></li>
                                <li><a href="../afastamento.asp">Afastamento</a></li>
                                <li><a href="../jornada.asp">Jornada</a></li>
                                <li><a href="../substituicao.asp">Substitui&ccedil;&atilde;o</a></li>
                				<!---  Aqui vai ficar a parte do menu do apoio-->
              				</ul>
           		 		</li>
                        
            			<li> <a href="#" class="icon-twitter">Recursos Materiais</a>
              				<ul>
                                <li><a href="../emprestimos.asp">Empr&eacute;stimos</a></li>
                                <li><a href="../eventos_e_treinamentos.asp">Eventos e Treinamentos</a></li>
                                <li><a href="../estoque_requisicao.asp">Estoque</a></li>
                                <li><a href="../controle.asp">Controle de Equipamentos</a></li>
              				</ul>
            			</li>
                        
            			<!--<li > <a href="#" class="icon-beaker">Relat&oacute;rios</a>
              				<ul>
                                <li><a href="Relatorio.asp?relatorio=destacamento">Destacamentos</a></li>
                                <li><a href="Relatorio.asp?relatorio=ferias">F&eacute;rias</a></li>
                                <li><a href="Relatorio.asp?relatorio=estoque">Estoque</a></li>
                                <li><a href="Relatorio.asp?relatorio=treinamentos">Treinamentos</a></li>
                                <li><a href="Relatorio.asp?relatorio=emprestimos">Empr&eacute;stimo de Materiais</a></li>
              				</ul>
            			</li>-->
                        
            			<li> <a href="consulta_demanda.php">Demandas T.I</a> </li>
            			<li> <a href="../usuario.asp" class="icon-envelope">Usu&aacute;rios</a> </li>
            			<li> <a href="../manual.pdf" class="icon-envelope" target="_blank">Manual</a> </li>
            			<!--<li> <a href="protocolo.asp" class="icon-envelope">Protocolo</a> </li>-->
          			</ul>
        		</nav>
      		</div>
      		<!--fim menu centralizado -->
    	</div>
	</div>
</div>
