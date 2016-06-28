<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta charset="utf-8">
<title>Alterar Prioridade</title>
<link rel="stylesheet" href="../estilo.css" type="text/css"/>
<link rel="stylesheet" href="../abas.css" type="text/css"/>
<link href="../botao_azul.css" rel="stylesheet" type="text/css" />
<link href="../tabela.css" rel="stylesheet" type="text/css" />
<link href="../menu.css" rel="stylesheet" type="text/css" />
<link href="../css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="../imagens/siiag-logo.ico" type="image/x-icon">
<script src="../scripts/jquery-1.9.1.js"></script>
<script src="../scripts/jquery.ui.core.js"></script>
<script src="../scripts/jquery.ui.widget.js"></script>

</head>

<body>
    <div class="container">
        <div class="conteudo"> 

			<div class="tabela" >
   
<?php   

$tabela =	'<table name="tabela" >
              		<tr>
			  			<td width="15%"> Nome : </td>
						<td width="25%"> Prioridade : </td>
              		</tr>';  
					   
                $conexao = mssql_connect('ce7180sr001','todos', 'todosce');
                mssql_select_db('SIIAG',$conexao);

                $situacao = $_REQUEST['situacao'];
                $data_inicio = $_REQUEST['data_inicio'];
                $data_final  = $_REQUEST['data_final'];  

                $strQuery = "SELECT ";
                $strQuery = $strQuery."* FROM TB_DEMANDAS AS DEMANDAS INNER JOIN TB_USUARIOS AS USUARIOS ON DEMANDAS.SOLICITACAO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_DEMANDAS_TIPOS AS DEMANDAS_TIPOS ON DEMANDAS.TIPO_DEMANDA = DEMANDAS_TIPOS.CO_TIPO INNER JOIN TB_DEMANDAS_SITUACOES AS DEMANDAS_SITUACOES ON DEMANDAS.CO_SITUACAO = DEMANDAS_SITUACOES.CO_SITUACAO WHERE DEMANDAS.CO_SITUACAO=2";

                $cont=0;

                if($situacao <> "" and $situacao <> 0 ){
                    $cont++;
                    $WHERE[$cont] = "(CO_SITUACAO = $situacao)";
    
                    //echo $WHERE[$cont];
                }

                /*if ($nomeSolicitante <> ""){
                    $cont++;
                    WHERE[$cont] = ""
                } */
    
                if($data_inicio <> "" and $data_final <> ""){
                    $cont++;
                    $WHERE[$cont]= "(SOLICITACAO_DATA BETWEEN '$data_inicio' AND '$data_final')";
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

                //consulta no banco
                while($linha = mssql_fetch_array($consultaDemanda)) {  
					echo "<tr>"; 
                    echo "<td>".$linha['NO_NOME']."</td>";	
					echo "<td>".$linha['ORDEM_PRIORIDADE']."</td>";			
					echo "</tr>";
                }
        
                mssql_close($conexao);
				echo "</table>";
?>			
      		
        
      		<input value="Salvar Prioridade" type="button" class="myButton" style="margin-left:20%;margin-top:5%;margin-bottom:5%;" />
            </div>
		</div>
	</div>
</body>
</html>
