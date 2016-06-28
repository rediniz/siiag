<?php
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
?>