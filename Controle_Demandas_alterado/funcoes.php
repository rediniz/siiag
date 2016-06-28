<?


function abreConexao(){
	$conexao = mssql_connect('ce7180sr001','todos', 'todosce'); //variavel conexao setada com as configuracoes do servidor - nome do servidor, login e senha do servidor
	
	mssql_select_db('SIIAG',$conexao); // comando para abrir o banco(SIIAG)associado a variavel de conexao
	
}


function pegaData(){

	$data = date('d/m/Y'); // pega a data formatando para ficar no formato dd/mm/aa
	
 	return $data; //retornando a variavel data
}



/*function retornaConsulta($variaveisaConsultar,$quantidadeCondicionais,$consulta){
/*definindo a funcao */

//

/* a funcao, ao menos em teoria precisaria saber apenas a quantidade de wheres na consulta, 
 as variaveis que serão recebidas por get ou post, onde essas variaveis precisariam ter o mesmo nome da coluna que sera pesquisada posteriormente, por fim mas não menos importante, é necessário escrever a consulta atraves de uma variavel */

//	$WHERE = array($quantidadeCondicionais); // vetor de "where"s, condicoes que serao postas na consulta
	//$cont;
	//$queries;
	//$ordem;
	//$contadordeWheres;
	
	//$variaveis = array();
	
	// usar split para pegar variaveis em um array
	
	//strQuery = $consulta;

//}


/*
 * $consulta - > a consulta SQL, sem as cláusulas WHERE e ORDER BY. Ex: "SELECT * FROM TB_USUARIO AS USUARIO JOIN TB_COORDENACAO AS COORD ON USUARIO.CO_GS = COORD.CO_GS"
 * $parametros - > cada cláusula WHERE da consulta. Devem ser passados como um array indexado no seguinte formato: array("nome_da_coluna1"=>"$valor1", "nome_da_coluna2"=>"$valor2");,
 * lembrando que se o valor da coluna do banco for do tipo texto ou data, deve ser passado entre aspas simples. Ex: array("nome_da_coluna"=>"'$valor'");
 * $ordem - > opcional. Coluna que será usada no ORDER BY. Ex: "NO_NOME"
 *
 * Exemplo de chamada do método:

 $data 		  = $_REQUEST["data"];
 $cpfgts 	  = $_REQUEST["cpfgts"];
 $codigoSaque = $_REQUEST["codigoSaque"];
 $situacao 	  = (int)$_REQUEST["situacao"];

 $consulta 	  = "SELECT CO_SEQUENCIAL, NU_CPFGTS,INCLUSAO_DATA, INCLUSAO_MATRICULA, CO_SAQUE, CO_SITUACAO, NU_LOTE FROM TB_CPFGTS ";
 $parametros  = array("INCLUSAO_DATA" => "'$data'", "NU_CPFGTS" => "'$cpfgts'", "CO_SAQUE"=>"'$codigoSaque'", "CO_SITUACAO"=>$situacao);

 $consulta 	  = where($consulta, $parametros, "INCLUSAO_DATA");

 */
function where($consulta, $parametros, $ordem) {

	$i = 0;
	$where = "";

	foreach ($parametros as $chave => $valor) {

		if ($valor != "" && $valor != "''") {
			if ($i == 0) {
				$where .= " where " . " ( {$chave} = {$valor} ) ";
				$i = 1;
			} else {
				$where .= " and " . " ( {$chave} = {$valor} ) ";
			}
		}
	}
	$consulta .= $where;
	if (isset($ordem)) {
		$consulta .= " order by " . $ordem;
	}
	return $consulta;
}

/*
 * Caso especial do WHERE com o uso de BETWEEN
*/
function whereBetween($consulta, $coluna, $valor1, $valor2){

	$i = 0;
	$where = "";

	foreach ($parametros as $chave => $valor) {
		if ($valor != "" && $valor != "''") {
			if ($i == 0) {
				$where .= " where " . " ( {$chave} = {$valor} ) ";
				$i = 1;
			} else {
				$where .= " and " . " ( {$chave} = {$valor} ) ";
			}
		}
	}
	
	$consulta .= $where;
	if (isset($ordem)) {
		$consulta .= " order by " . $ordem;
	}
	return $consulta;
}

?>