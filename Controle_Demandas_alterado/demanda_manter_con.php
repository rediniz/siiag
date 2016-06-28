<?

 $data_conclusao = $_REQUEST['data_conclusao'];
 $responsavel = $_REQUEST['matResponsavel'];
 $estagiario1 = $_REQUEST['estagiario1Matricula'];
 $estagiario2 = $_REQUEST['estagiario2Matricula'];
 $estagiario3 = $_REQUEST['estagiario3Matricula'];
 $estagiario4 = $_REQUEST['estagiario4Matricula'];
 $co_demanda = $_REQUEST['co_demanda'];
 $demandas_situacoes = $_REQUEST['demandas_situacoes'];

		$conexao = mssql_connect('ce7180sr001','todos', 'todosce');
		mssql_select_db('SIIAG',$conexao);
		
//$queryData = "SELECT CONCLUSAO_DATA_PREVISTA FROM TB_DEMANDAS WHERE CO_DEMANDA= $co_demanda ";
//$resultadoData = mssql_query($queryData, $conexao);

//if (mssql_num_rows($resultadoData) = 0) {

if($demandas_situacoes == 2){

		$query = "UPDATE TB_DEMANDAS SET CONCLUSAO_DATA_PREVISTA = '$data_conclusao', CO_SITUACAO = 2 WHERE CO_DEMANDA= $co_demanda ";
		$resultado = mssql_query($query);
		
		if ($estagiario1 != ""){
			$queryINSERT = "INSERT INTO TB_DEMANDAS_RESPONSAVEIS (CO_DEMANDA, MAT_RESPONSAVEL, MAT_ESTAGIARIO) VALUES ('$co_demanda', '$responsavel', '$estagiario1')";
			$resultadoINSERT = mssql_query($queryINSERT, $conexao);
		}
		
		if ($estagiario2 != "") {
			$queryINSERT = "INSERT INTO TB_DEMANDAS_RESPONSAVEIS (CO_DEMANDA, MAT_RESPONSAVEL, MAT_ESTAGIARIO) VALUES ('$co_demanda', '$responsavel', '$estagiario2')";
			$resultadoINSERT = mssql_query($queryINSERT, $conexao);
		}
		
		if($estagiario3 != "") {
			$queryINSERT = "INSERT INTO TB_DEMANDAS_RESPONSAVEIS (CO_DEMANDA, MAT_RESPONSAVEL, MAT_ESTAGIARIO) VALUES ('$co_demanda', '$responsavel', '$estagiario3')";
			$resultadoINSERT = mssql_query($queryINSERT, $conexao);
		}
				
		if ($estagiario4 != "") {
			$queryINSERT = "INSERT INTO TB_DEMANDAS_RESPONSAVEIS (CO_DEMANDA, MAT_RESPONSAVEL, MAT_ESTAGIARIO) VALUES ('$co_demanda', '$responsavel', '$estagiario4')";
			$resultadoINSERT = mssql_query($queryINSERT, $conexao);
		}
		
}

if ($demandas_situacoes == 3){
		$query = "UPDATE TB_DEMANDAS SET CO_SITUACAO = 3 WHERE CO_DEMANDA= $co_demanda ";
		$resultado = mssql_query($query);
}

if ($demandas_situacoes == 4){
		$query = "UPDATE TB_DEMANDAS SET CO_SITUACAO = 4 WHERE CO_DEMANDA= $co_demanda ";
		$resultado = mssql_query($query);
}

//}else{
//	$query = "UPDATE TB_DEMANDAS SET CONCLUSAO_DATA_PREVISTA = '$data_conclusao' WHERE CO_DEMANDA= $co_demanda ";
//	$resultado = mssql_query($query);
//}
		echo "<script>";
		echo "alert('Demanda editada com sucesso!');";
		echo "window.location.assign('demanda_consultar.php?situacao=0&nomeSolicitante=&data_inicio=&data_final=&click=1');";
		echo "</script>";

?>
