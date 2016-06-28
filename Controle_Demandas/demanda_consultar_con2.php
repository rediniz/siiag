
<?	abreConexao(); // abrindo a conexao		?>

<?
	$tabela =	'<table name="tabela">
              		<tr>
              			<td width="30%" >Descrição</td>
              		</tr>';
			  
			 /* <td width="7%"> Data de Solicitação </td>
                <td width="11%"> Situação </td>
                <td width="25%"> Data de Conclusão </td>
                <td width="11%"> Ordem de Prioridade </td>*/
			  
			  
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
	//$nomeSolicitante =  $_REQUEST['nomeSolicitante'];
	$click = $_REQUEST['click'];
	
	if(isset($click)){	
		$strQuery = "SELECT ";
		$strQuery = $strQuery."* FROM TB_DEMANDAS";
	
		$cont=0;
	
		if($situacao <> "" and $situacao <> 0 ){
			$cont++;
			$WHERE[$cont] = "(CO_SITUACAO = $situacao)";
		
			///echo $WHERE[$cont];
		}

		/*if ($nomeSolicitante <> ""){
			$cont++;
			WHERE[$cont] = ""
		} */
		
		if($data_inicio <> "" and $data_final <> ""){
			$cont++;
			$WHERE[$cont]= "(SOLICITACAO_DATA BETWEEN '$data_inicio' AND '$data_final')";
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
		
		$ordem = " ORDER BY ORDEM_PRIORIDADE ASC";
		
		$strQuery = $strQuery.$queries.$ordem;
		$consultaDemanda = mssql_query($strQuery,$conexao);
	
		//echo $strQuery;
		//consulta no banco
		
		echo $tabela; //imprimindo a tabela
	
		while($linha = mssql_fetch_array($consultaDemanda)) {
			echo "<tr id='sortable' style='cursor:move'>";
			echo "<td class='ui-state-default'>".$linha['DESCRICAO']. "</td>";
			/*echo "<td>".$linha['SOLICITACAO_DATA']. "</td>";
			echo "<td>".$linha['CO_SITUACAO']. "</td>";
			echo "<td>".$linha['CONCLUSAO_DATA_PREVISTA']. "</td>";
			echo "<td>".$linha['ORDEM_PRIORIDADE']. "</td>";*/
			echo "</tr>";
		}
		
		echo  '</table>';	
	
		//echo $ordenar;
		mssql_close($conexao);
	}
 ?>       
 