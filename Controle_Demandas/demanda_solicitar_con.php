<?
	include 'funcoes.php'; //incluindo arquivo de funcoes
		
	/*	$conexao = mssql_connect('ce7180sr001','todos', 'todosce');
		mssql_select_db('SIIAG',$conexao);
		$query = "select * from VW_USUARIOS where CO_MATRICULA='$matricula'";
	*/

	//echo "certo";

	$matricula = $_COOKIE['co_usuario_siiag'];
	$aplicativo = $_POST['aplicativo'];
	$tipoDemanda = $_POST['tipoDemanda'];
	$descricao = $_POST['descricao'];
	$AplicativoNovo = $_POST['AplicativoNovo'];
	
	abreConexao();
	
	if ($tipoDemanda = 1) {
		$query2 = "INSERT INTO TB_APLICATIVOS (NOME) VALUES ('$AplicativoNovo')";
		$resultado = mssql_query($query2);
		
//		echo $query2;
		
		$query3 = "SELECT CO_APLICATIVO FROM TB_APLICATIVOS WHERE NOME like '%$AplicativoNovo%'";
		$resultado3 = mssql_query($query3);
		
		$linha3 = mssql_fetch_array($resultado3);
		echo $linha3['CO_APLICATIVO'];
	$aplicativo = $linha3['CO_APLICATIVO'];
	}
 
	$data = pegaData();	

	$queryPrioridade = "SELECT MAX(ORDEM_PRIORIDADE) AS ULTIMO FROM TB_DEMANDAS WHERE CO_SITUACAO = 1";
	$resultadoPrioridade = mssql_query($queryPrioridade);
	
	$PRIORIDADE = mssql_fetch_array($resultadoPrioridade);
	$prioridadeAcrescida = $PRIORIDADE['ULTIMO']+1;
	
	
	$query = "INSERT INTO TB_DEMANDAS (SOLICITACAO_DATA, SOLICITACAO_MATRICULA, TIPO_DEMANDA, CO_APLICATIVO, DESCRICAO, CO_SITUACAO, ORDEM_PRIORIDADE) VALUES ('$data', '$matricula', $tipoDemanda, $aplicativo, '$descricao', 1, $prioridadeAcrescida)";

	//echo $query;
	$resultado = mssql_query($query);
	
	if ($resultado) {
		echo "<script>";
		echo "alert('Demanda inserida com sucesso!');";
		echo "window.location.assign('demanda_solicitar.php');";
		echo "</script>";

	} else {
		echo "<script>";
		echo "alert('Não foi possível inserir a demanda, tente novamente.');";
		echo "window.location.assign('demanda_solicitar.php');";
		echo "</script>";
	}
	

?>