<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Controle de Demandas</title>
<!--CSS -->
<link rel="stylesheet" href="../estilo.css" type="text/css"/>
<link rel="stylesheet" href="../abas.css" type="text/css"/>
<link href="../botao_azul.css" rel="stylesheet" type="text/css" />
<link href="../tabela.css" rel="stylesheet" type="text/css" />
<link href="../menu.css" rel="stylesheet" type="text/css" />
<link href="../css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="../imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->

<script src="../scripts/jquery.ui.core.js"></script>
<script src="../scripts/jquery.ui.widget.js"></script>
<script src="../scripts/jquery-1.9.1.js"></script>
<script src="../scripts/jquery.ui.datepicker.js"></script>
<script src="../scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	
<style>
	.ui-datepicker {
		font-size:12px;
	}
	
	.datepicker{
		height:15px;
		border: 1px solid #b5cce2;
		background: #edf4fc;
		-webkit-border-radius: 4px;
		-moz-border-radius: 4px;
		border-radius: 4px;
		color: #666;
		box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
		padding:6px;
		width:auto;	
	}
			
	.datepicker:focus {
		background: #fff;
		color: #000000;
		outline:none;
		padding:6px;
		box-shadow: 0 0 5px #9ecaed;
	}
	
	.ui-widget-header .ui-state-focus {
		border: 1px solid #fbcb09;
		background: #fdf5ce;
		font-weight: bold;
		color: #c77405;
	}
	.ui-widget {
		font-family: Arial,sans-serif;
		font-size: 0.8em;
	}
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	
	.ui-menu .ui-menu-item a{
		height:14px;
		font-size:13px;
	}
	
	.ui-widget-header .ui-state-focus {
		border: 1px solid #fbcb09;
		background: #fdf5ce;
		font-weight: bold;
		color: #c77405;
	}
	.ui-widget {
		font-family: Arial,sans-serif;
		font-size: 0.8em;
	}
	.ui-widget .ui-widget {
		font-size: 0.8em;
	}
	
	.ui-menu .ui-menu-item a{
		height:14px;
		font-size:13px;
	}
	
	.ui-autocomplete {
		height:200px;
		overflow-y:scroll;
		overflow-x:hidden;
	}
</style>    
<!-- efeito da janela de ajuda -->

<script>
    $(function() {
		$( ".datepicker" ).datepicker({
			dateFormat: 'dd/mm/yy',
			dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
			dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
			dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
			monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
			monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
			nextText: 'Próximo',
			prevText: 'Anterior'
		});
	});
</script>

<script>
	$(document).ready(function() {
		$('#btnSalvar').on('click',function(){
		
			var demandas_situacoes = $("#demandas_situacoes").val();
			if(demandas_situacoes == 2){
				estagiario1 = $("#estagiarios1").is(":checked");
			
					if(estagiario1 == true){
						estagiario1Matricula = $("#estagiarios1").val();
						//alert($estagiario1Matricula);
					} else {
						estagiario1Matricula = "";
					}
			
				estagiario2 = $("#estagiarios2").is(":checked");
			
					if(estagiario2 == true){
						estagiario2Matricula = $("#estagiarios2").val();
						//alert($estagiario2Matricula);
					}	else {
						estagiario2Matricula = "";
					}
			
				estagiario3 = $("#estagiarios3").is(":checked");
			
					if(estagiario3 == true){
						estagiario3Matricula = $("#estagiarios3").val();
					//	alert($estagiario3Matricula);
					}	else {
						estagiario3Matricula = "";
					}
			
				estagiario4 = $("#estagiarios4").is(":checked");
			
					if(estagiario4 == true){
						estagiario4Matricula = $("#estagiarios4").val();
						//alert($estagiario4Matricula);
					}	else {
						estagiario4Matricula = "";
					}
					
				responsavel = $("#select1").val();	
				data_prevista_conclusao = $("#data_prevista_conclusao").val();
				co_demanda = $("#co_demanda").val();
		
				window.open("demanda_manter_con.php?data_conclusao="+data_prevista_conclusao+"&matResponsavel="+responsavel+"&estagiario1Matricula="+estagiario1Matricula+"&estagiario2Matricula="+estagiario2Matricula+"&estagiario3Matricula="+estagiario3Matricula+"&estagiario4Matricula="+estagiario4Matricula+"&co_demanda="+co_demanda+"&demandas_situacoes="+demandas_situacoes+"");

			}
			
			if (demandas_situacoes == 3 || demandas_situacoes == 4){ 
				co_demanda = $("#co_demanda").val();
				window.open("demanda_manter_con.php?&co_demanda="+co_demanda+"&demandas_situacoes="+demandas_situacoes+"");
				
			}
						
		});
	});
	
</script>  


<script>

	$(document).ready(function() {
		var codigo = $("#demandas_situacoes").val();
		if(codigo == 2){
			document.getElementById('label1').style.display = "";
			document.getElementById('label2').style.display = "";
			document.getElementById('label3').style.display = "";
			document.getElementById('select1').style.display = "";
			document.getElementById('data_conclusao').style.display = "";	
			document.getElementById('option1').style.display = "";	
			document.getElementById('option2').style.display = "";	
			document.getElementById('option3').style.display = "";	
			document.getElementById('check1').style.display = "";	
			document.getElementById('check2').style.display = "";	
			document.getElementById('check3').style.display = "";	
			document.getElementById('check4').style.display = "";	
			//document.getElementById('btnSalvar').style.display = "";	
			document.getElementById('demandas_situacoes').style.hidden="";
		}
	});

</script>

<script>
	$(document).ready(function() {
		$('#demandas_situacoes').on('change',function(){
	
			var codigo = $("#demandas_situacoes").val();
		
				if (codigo==2){
					document.getElementById('label1').style.display = "";
					document.getElementById('label2').style.display = "";
					document.getElementById('label3').style.display = "";
					document.getElementById('select1').style.display = "";
					document.getElementById('data_conclusao').style.display = "";	
					document.getElementById('option1').style.display = "";	
					document.getElementById('option2').style.display = "";	
					document.getElementById('option3').style.display = "";	
					document.getElementById('check1').style.display = "";	
					document.getElementById('check2').style.display = "";	
					document.getElementById('check3').style.display = "";	
					document.getElementById('check4').style.display = "";	
					document.getElementById('btnSalvar').style.display = "";	
					document.getElementById('demandas_situacoes').style.hidden="";
					//alert("andamento");
				}
				
				else{
					document.getElementById('btnSalvar').style.display = "";
				}
		});
	});
	
</script> 


<script>
	$(document).ready(function() {
		$('#data_conclusao').on('change',function(){
	
			var data = $("#data_conclusao").val();
		
			document.getElementById('btnSalvar').style.display = "";	

		});
	});
	
</script> 


</head>
<body>

	<div class="teste">
  		<!--fundo azul do meio-->
  		<?  include 'topo.php';  ?>
  		
		<?	$demanda = $_REQUEST['demanda'];
		
		?>
        
		<div class="corposite">
  			<!--corpo-->
  			<div class="container">
    			<div class="conteudo2">
     				<!-- <div class="titulosModulos" ><span >ESTOQUE</span> </div>  -->
      				<p>
      					<div id='cssmenu' >
        					<ul>
    							<li ><a href='demanda_solicitar.php'><span>Solicitar Demanda</span></a></li>
								<li ><a href='demanda_consultar.php'><span>Consultar Demanda</span></a></li>
								<li class='active'><a href='demanda_manter.php'><span>Controle de Demandas</span></a></li>
    		 				</ul>
          				</div>
          			</p>
          
          			<div id='submenu'>
            			<ul>
              				<!--<li><a href='#'><span>Ajuda</span></a></li>-->
            			</ul>
          			</div>
     	
       				<? 		//o conteudo vai aqui   ?> 

        			<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          				<legend><span class="titulos" >Controle de Demandas</span></legend>
                        	<fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
                            	<legend><span class="titulos" >Informa&ccedil;&otilde;es</span></legend>
                            	<table border="0">
                                <!-- abre tipos -->
                                		<?  
                                            $conexao = mssql_connect('ce7180sr001','todos', 'todosce');
                                            mssql_select_db('SIIAG',$conexao);
                                            $query = "SELECT B.NO_TIPO, C.NOME, A.DESCRICAO, D.CO_SITUACAO, D.DE_SITUACAO, A.SOLICITACAO_MATRICULA, E.NO_NOME, F.NO_GS  FROM TB_DEMANDAS A INNER JOIN TB_DEMANDAS_TIPOS B ON A.TIPO_DEMANDA = B.CO_TIPO INNER JOIN TB_APLICATIVOS C ON A.CO_APLICATIVO = C.CO_APLICATIVO INNER JOIN TB_DEMANDAS_SITUACOES D ON A.CO_SITUACAO = D.CO_SITUACAO INNER JOIN TB_USUARIOS E ON A.SOLICITACAO_MATRICULA = E.CO_MATRICULA INNER JOIN TB_GS F ON E.CO_GS = F.CO_GS  WHERE A.CO_DEMANDA = ".$demanda." ";
                                            
											$resultado = mssql_query($query, $conexao);
                                   
                                  while($linha = mssql_fetch_array($resultado)) {  ?> 
                                	<tr><td width="150"><label>Tipo de Demanda: </label></td>
                                    <td width="27" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100"> <? echo $linha['NO_TIPO']; ?> </td> </tr>
                                    
                                    <tr><td width="150"><label>Nome do Aplicativo: </label></td>
                                    <td width="27" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" > <? echo $linha['NOME']; ?> </td></tr>
                                    
                                    <tr><td width="150"><label>Descrição: </label></td>
                                    <td width="27" colspan="2"> <textarea readonly="readonly"  style="margin-top:5px; max-width:250px; min-width:250px; max-height:50px;min-height:50px;" class="form-field" name="nome" id="nomeSolicitante" size="43" rows="5" cols="50"> <? echo $linha['DESCRICAO']; ?> </textarea>    </td>   </tr>
<!--                                    <input style="margin-top:5px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" /></td></tr>-->
									
                                    <tr> <td>&nbsp;  </td></tr>
                                    <tr><td width="400" colspan="3" ><label> <strong> Dados do Solicitante: </strong></label></td>  </tr> 
                                    
                                    <tr><td width="150"><label>Matr&iacute;cula: </label></td>
                                    <td width="50" style="margin-top:5px; max-width:90px; min-width:90px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" > <? echo $linha['SOLICITACAO_MATRICULA']; ?> </td>
                                    
                                    <td width="75" align="right"><label>Nome: </label></td>
                                    <td width="230" style="margin-top:5px; max-width:350px; min-width:350px;" class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" > <? echo $linha['NO_NOME']; ?> </td> </tr>
                                    
                                    <tr><td width="150"><label>Coordena&ccedil;&atilde;o: </label></td>
                                    <td width="150" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" > <? echo $linha['NO_GS']; ?> </td></tr>
                                    </table>
                           			</fieldset>
                                    
                            <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
                            	<legend><span class="titulos" >Informa&ccedil;&otilde;es</span></legend>
                                   <table border="0">
                                   <tr> <td width="150"> <label>Situa&ccedil;&atilde;o: </label></td>
              					   <td width="150" style="margin-top:5px; max-width:250px; min-width:250px;"  name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" > <select class="form-select" style="width:100%;margin-top:5px;height:auto;" id="demandas_situacoes"> 
							 <? 
								   
								//$conexao = mssql_connect('ce7180sr001','todos', 'todosce');
								mssql_select_db('SIIAG',$conexao);
								$querySituacao = "SELECT * FROM TB_DEMANDAS_SITUACOES";
                         		
								$resultadoSituacao = mssql_query($querySituacao, $conexao);
								   	
									while($linhaSituacao = mssql_fetch_array($resultadoSituacao)) {   
										if ($linhaSituacao['CO_SITUACAO'] == $linha['CO_SITUACAO']){ 
											echo "<option value=".$linhaSituacao["CO_SITUACAO"]." selected='selected'> ".$linhaSituacao['DE_SITUACAO']."</option>";
										}
										else{
											echo "<option value=".$linhaSituacao["CO_SITUACAO"]."> ".$linhaSituacao['DE_SITUACAO']."</option>";
										}
								   	} 
									
									mssql_select_db('SIIAG',$conexao);
									$queryResponsaveis = "SELECT A.CONCLUSAO_DATA_PREVISTA, B.MAT_RESPONSAVEL, B.MAT_ESTAGIARIO FROM TB_DEMANDAS A LEFT JOIN TB_DEMANDAS_RESPONSAVEIS B ON A.CO_DEMANDA = B.CO_DEMANDA WHERE A.CO_DEMANDA = ".$demanda." ";
                         		
									$resultadoResponsaveis = mssql_query($queryResponsaveis, $conexao);
									//$linhaResponsaveis = mssql_fetch_array($resultadoResponsaveis);							   	
									while($linhaResponsaveis = mssql_fetch_assoc($resultadoResponsaveis))  {
									
									?> </select></td></tr>
          							</tr>
                                   <!-- <input />--> 
                                   	</table>
                                    <?  ?>
                
                                    <table border="0">
                                    <tr> <td>&nbsp;  </td></tr> <tr> <td>&nbsp;  </td></tr>
                                    <tr><td width="27" style="display:none;" id="label1"><label>Data Prevista para Conclus&atilde;o : </label></td>
                                    <td width="64" name="data_conclusao" id="data_conclusao" size="10" maxlength="10" style="max-width:90px; min-width:90px; display:none;"> <input type="text" class="datepicker" size="10" id="data_prevista_conclusao"  style="width:100%;" value="<? echo substr($linhaResponsaveis['CONCLUSAO_DATA_PREVISTA'], 0, 11); ?>" /></td></tr>
                                  
                                    <tr><td width="27" style="display:none;" id="label2"><label>Respons&aacute;vel TI: </label></td> 
                                    <td width="64" style="margin-top:5px; max-width:250px; min-width:250px;"><select class="form-select" style="margin-top:5px; max-width:250px; min-width:250px; display:none;" id="select1">
                                    		
                                            <option value="" style="display:none;" id="option1">Selecione o Respons&aacute;vel</option>
                                            
                                          <?  if (strcasecmp(trim($linhaResponsaveis['MAT_RESPONSAVEL']),"c053498") == 0) { ?> <option value="c053498" style="display:none;" id="option2" selected="selected" >&Iacute;talo Reges Marques Cavalcante</option> <? } else {?>
                    						<option value="c053498" style="display:none;" id="option2" >&Iacute;talo Reges Marques Cavalcante</option> <? } ?>
                                          <? if (strcasecmp(trim($linhaResponsaveis['MAT_RESPONSAVEL']),"c124937")  == 0) { ?>
                                            <option value="c124937" style="display:none;" id="option3" selected="selected" >Tatiana Bezerra Ara&uacute;jo</option> <? } else {?>
                                    <option value="c124937" style="display:none;" id="option3">Tatiana Bezerra Ara&uacute;jo </option>
									<? } ?>
                                     </select> </td></tr>
                                     <? 
									// $a =0;	
									 //$b =0;	
									 //$c =0;	
									 //$d =0;
									  
									 ?>

                                     <?  } ?>
                            <? } ?>
                                 
                                 <tr> 
                                 
                   					<td style="display:none;" id="label3"><label> Estagi&aacute;rios:</label></td>	
                                    
<?                                  $serverName = "ce7180SR001";
									$connection = mssql_connect($serverName, "todos", "todosce");
									mssql_select_db("SIIAG", $connection);
							
									$query = "SELECT MAT_RESPONSAVEL, MAT_ESTAGIARIO FROM TB_DEMANDAS_RESPONSAVEIS WHERE (CO_DEMANDA = $demanda)";
									echo $query;
								
									$resultado = mssql_query($query, $connection);
									
									if (mssql_num_rows($resultado) > 0){
	
									while($linha = mssql_fetch_array($resultado)){
		
										echo "</br>". $linha[1] . "</br>";
										
										if ( strcasecmp(trim($linha[1]), "E712237") ==0){
										
										echo "belmondo";
										
										} else if (strcasecmp(trim($linha[1]),"E689507") ==0){
										
										echo "natalia";
										
										} else if (strcasecmp(trim($linha[1]),"E711000") ==0){
										
										echo "Renato";
										
										} else if(strcasecmp(trim($linha[1]),"E701082") ==0){
										
										echo "Jonathan";
									
										}
										
		
	
									
									}
									}
									 ?>
                                   
                                   
                                   
                                   
                                   			
                                        
                                     
                                    
                                  
                                   
                                   
                                   
                                  </tr>
                                 
                            </fieldset>
                            
	

                            
                            
                            <tr><td> <input type="hidden" value='<? echo $demanda; ?>' id="co_demanda"  /> </td></tr>
                            <tr> <td>&nbsp;  </td></tr>
                            <tr> <td width="239" colspan="4" align="center"><input type="submit" class='myButton' name="btnSalvar" id="btnSalvar" value="Salvar" style="display:none; margin-left:20%"/> </td></tr> 
                                
                            </table>
                                 
        			</fieldset>  
    			</div>
  			</div>
  			<!--fim do corpo-->
            
            <?
				$sucesso = $_REQUEST['sucesso'];
				
				if (isset($sucesso)){
					echo "<script> alert('demanda editada com sucesso');</script>";
					echo "<script> window.close();</script>";
				}
			?>
  			<?  include 'rodape.php'  ?>
		</div>
	</div>
	<!--teste-->
</body>
</html>