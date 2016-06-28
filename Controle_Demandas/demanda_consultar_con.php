<script>
	$(document).ready(function() {
		$('.edit').on('click',function(){
	
			var demanda = $(this).parent().parent().find("#demanda").val()
			//alert demanda;
			window.open("demanda_manter.php?demanda="+demanda+"");
						
		});
	});
	
</script> 

<?
	abreConexao(); // abrindo a conexao
?>


<?
	$tabela =	'<table name="tabela" >
              		<tr>
			  			<td width="15%" >Tipo de Demanda</td>
						<td width="25%"> Nome do Aplicativo </td>
                		<td width="11%"> Situação </td>
						<td width="25%"> Nome do Solicitante </td>
                		<td width="11%"> Data de Solicitação </td>
                		<td width="11%"> Data de Conclusão </td>
                		<td width="11%"> Ordem de Prioridade </td>
						<td width="11%"> Atender Demanda </td>
						<td width="11%" id="visuOrdenacao" style="display:none;"> Ordenação </td>
              		</tr>';
					
					//<tr>
			  		//	<td width="30%"> Nome do Solicitante </td>	
              		//	<td width="30%" >Tipo de Demanda</td>
                	//	<td width="7%"> Data de Solicitação </td>
                	//	<td width="11%"> Situação </td>
                	//	<td width="25%"> Data de Conclusão </td>
                	//	<td width="11%"> Ordem de Prioridade </td>
              		//</tr>';		  
			  
	$ordenar =	'<table border="0">
        			<tr><td><input type="button" class="myButton" id="btnOrdenar" value="Ordenar"/></td></tr>  
        		</table>';		  
  
	$WHERE = array(3); // vetor de "where"s, condicoes que serao postas na consulta
	$cont;
	$queries;
	$ordem;
	$contadordeWheres;
		
	$situacao = $_REQUEST['situacao'];
	$data_inicio = $_REQUEST['data_inicio'];
	$data_final  = $_REQUEST['data_final'];
	$nomeSolicitante =  $_REQUEST['nomeSolicitante'];
	$click = $_REQUEST['click'];
	
	if(isset($click)){	
		$strQuery = "SELECT DEMANDAS.CO_DEMANDA, DEMANDAS.SOLICITACAO_DATA, USUARIOS.NO_NOME, DEMANDAS_TIPOS.NO_TIPO, APLICATIVOS.NOME, DEMANDAS.ORDEM_PRIORIDADE, DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.CONCLUSAO_DATA_PREVISTA ";
		$strQuery = $strQuery." FROM TB_DEMANDAS AS DEMANDAS INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON DEMANDAS.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO INNER JOIN TB_APLICATIVOS AS APLICATIVOS ON DEMANDAS.CO_APLICATIVO = APLICATIVOS.CO_APLICATIVO ";
	
		$cont=0;
	
		if($situacao <> "" and $situacao <> 0 ){
			$cont++;
			$WHERE[$cont] = "(DEMANDAS.CO_SITUACAO = $situacao)";
			///echo $WHERE[$cont];
		}

		if ($nomeSolicitante <> ""){
			$cont++;
			$WHERE[$cont] = "(USUARIOS.NO_NOME like '%$nomeSolicitante%')";
		}
		
		if($data_inicio <> "" and $data_final <> ""){
			$cont++;
			$WHERE[$cont]= "(DEMANDAS.SOLICITACAO_DATA BETWEEN '$data_inicio' AND '$data_final')";
			//WHERE(cont) = " (DESTACAMENTOS.DT_INICIO >= '"& data_inicio &"' AND DESTACAMENTOS.DT_FIM <='"&data_final&"') "	
		}
	
		$contadordeWheres=0;
		for($i=1;$i<=$cont;$i++){
			if($contadordeWheres < 1){
				$queries = " WHERE ".$WHERE[$i];
				$contadordeWheres = $contadordeWheres+1;

			} else {	
				$queries = $queries." AND ".$WHERE[$i];
			}
	
		} //fecha o for
	
		//echo $queries;
	
		$ordem = " ORDER BY DEMANDAS_SITUACOES.DE_SITUACAO, DEMANDAS.ORDEM_PRIORIDADE ";
		
		$strQuery = $strQuery.$queries.$ordem;
		$consultaDemanda = mssql_query($strQuery);
	
		//echo $strQuery;
		//consulta no banco
	
		echo $tabela; //imprimindo a tabela
		$ota = 1;
		while($linha = mssql_fetch_array($consultaDemanda)) {
			echo "<tr>";
			echo "<td>".$linha['NO_TIPO']."</td>";
			echo "<td>".$linha['NOME']."</td>";		//nome do aplicativo
			echo "<td>".$linha['DE_SITUACAO']. "</td>";
			echo "<td>".$linha['NO_NOME']. "</td>";
			echo "<td>".$linha['SOLICITACAO_DATA']. "</td>";
			echo "<td>".$linha['CONCLUSAO_DATA_PREVISTA']. "</td>";
			//echo "<td>".$linha['ORDEM_PRIORIDADE']. "</td>";
			if ($linha['DE_SITUACAO'] == "Solicitada"){
				echo "<td>".$ota. "</td>";
				$ota = $ota + 1;
			} else{
				echo "<td>  </td>";
			}
			echo "<td width='10%'> <img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer; width:16px; height:16px'> </td>";
		echo "<td width='10%' type='text' style='display:none;'></td>";
			echo "<td> <input type='hidden' id='demanda' value=".$linha["CO_DEMANDA"]." /> </td>";
			echo "</tr>";	
		}
		
		echo  '</table>';	
	
		echo $ordenar;
		//echo $strQuery;
		mssql_close($conexao);
 	}
 ?>