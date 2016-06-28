<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Demanda</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--CSS-->

<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="scripts/jquery.ui.draggable.js"></script>
	<script src="scripts/jquery.ui.sortable.js"></script>
	
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
		$('.pesquisar').on('click',function(){
			//alert("deu certo");
			//var situacao = document.getElementById("situacoes").value;
			// var nome =  document.getElementById("nome").value;
			//var data_inicio = document.getElementById("data_inicio").value;
			//var data_final = document.getElementById("data_final").value;
 
			var situacao = $("#situacoes").val();
			//var nomeSolicitante = $("#nomeSolicitante").val();
			var coSolicitante = $("#coSolicitante").val();
			var data_inicio = $("#data_inicio").val();
			var data_final = $("#data_final").val();
			var codigoDemanda = $("#codigoDemanda").val();

				
			window.location.assign("demanda_listar.asp?situacao="+situacao+"&coSolicitante="+coSolicitante+"&data_inicio="+data_inicio+"&data_final="+data_final+"&codigo="+codigoDemanda+"&click=1");
		});
	});
</script>

<script>
	$(document).ready(function() {
		$('#btnOrdenar').on('click',function(){
		
			//var situacao = $("#situacao").val();
			//var nomeSolicitante = $("#nomeSolicitante").val();
			//var data_inicio = $("#data_inicio").val();
			//var data_final =$("#data_final").val();
			
			//window.location.assign("demanda_ordenacao.php?situacao="+situacao+"&data_inicio="+data_inicio+"&data_final="+data_final+"&click=1");
			//var top = (window.innerHeight / 4) +80;
			//var left = (window.innerWidth / 4) -60;
			//window.open("demanda_ordenacao.php?situacao="+situacao+"&data_inicio="+data_inicio+"&data_final="+data_final+"", "Ordenação de Demanda", "height=280, width=400, scrollbars=yes, toolbar=no, resizable=yes, location=no, modal=yes, top="+top+", 	left="+left+"");
			
			//alert("Ordenar");
			
			document.getElementById('visuOrdenacao').style.display = "";
			document.getElementById('inputPrioridade').style.display = "";
			
 
		});
	});
</script>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
		//Ao digitar executar essa função
		$("#nomeSolicitante").focus().autocomplete({
			source: "autocompletar_nome2.asp",
			minlength: 2,
			select: function( event, ui ) {
				$( "#nomeSolicitante" ).val( ui.item.nome);				
				return false;
			}
		});
		
		
		
		
		
	});
</script>

<script type="text/javascript" language="javascript">

	
</script>
<%
	situacao = Request("situacao")
	data_inicio= Request("data_inicio")
	data_final=Request("data_final")
	'nomeSolicitante = Request("nomeSolicitante")
	coSolicitante = Request("coSolicitante")
	codigo = Request("codigo")
response.write codigo
%>
</head>
<body>
	<div class="teste2">
		<!--fundo azul do meio-->
        
		<!-- #INCLUDE FILE="topo.asp" -->
		<%
        'Chama a subrotina para verificar o perfil
        Perfil_Acesso_Cookie("15")
        %>  

		<div class="corposite">
			<!--corpo-->
  			<div class="container">
    			<div class="conteudo2">
					<%
                    if not perfil_acesso_siiag then
                        response.Write("O seu perfil não permite o acesso a este módulo")
                    else
                    %>                
      				<div class="titulosModulos" ><span >DEMANDAS T.I.</span> </div>
      				<p>
      					<div id='cssmenu' >
        					<ul>
                            <%if tem_acesso("12") then %>
    							<li ><a href='demanda_solicitar.asp'><span>Solicitar Demanda</span></a></li>
								<li class='inactive'><a href='demanda_consultar.asp'><span>Painel de Demandas</span></a></li>
							<%end if%>
								<li class='active'><a href='demanda_listar.asp?situacao=&coSolicitante=&data_inicio=&data_final=&click=1'><span>Consultar Demandas</span></a></li>
								<!--<li ><a href='demanda_manter.php'><span>Manter Demandas</span></a></li>-->
     						</ul>
          				</div>
          			</p>
          
          			<div id='submenu'>
            			<ul>
              				<!--<li><a href='#'><span>Ajuda</span></a></li>-->
            			</ul>
          			</div>
     	
       				
       
        			<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:450px;">
          				<legend><span class="titulos" >Listar Demanda</span></legend>
          
          				<table border="0" width="100%">
                        <tr>
                            <td width=""><label>C&oacute;digo:</label></td> 
                            <td width="" colspan="9"><input name="codigoDemanda" id="codigoDemanda" type="text" class="form-field" size="5" maxlength="5" value="<%=codigo%>"/><input type="submit" class='myButton pesquisar' style="padding-left:3px;padding-right:3px;margin-left:10px" name="btnPesquisar" id="btnPesquisar"  value="Pesquisar" /></td>

                        </tr>
       					<tr> <!-- abre tipos -->
          					<td width=""> <label>Situa&ccedil;&atilde;o: </label></td>
          
          					<td width=""><select class="form-select" style="max-width:150px; min-width:150px;" id="situacoes">
          
          		   <option <% 'if situacao="0" Then Response.Write "selected='selected'" END IF%> value="">Todos</option>
                   <!--<option <%' if situacao="1" Then Response.Write "selected='selected'" END IF%> value="1">Solicitado</option>
                   <option <% 'if situacao="2" Then Response.Write "selected='selected'" END IF%> value="2">Em Andamento</option>
          		   <option <% 'if situacao="3" Then Response.Write "selected='selected'" END IF%> value="3">Conclu&iacute;do</option>
                   <option <% 'if situacao="4" Then Response.Write "selected='selected'" END IF%> value="4">Rejeitado</option> -->
									<%  
										Query4 ="SELECT * FROM TB_DEMANDAS_SITUACOES" 
										set objConn = server.CreateObject("ADODB.Connection") 
										dados_sys = "Provider=sqloledb;Data Source=CE7180sr001;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
										objConn.open dados_sys
										set ds=Server.CreateObject("ADODB.RecordSet")
										ds.Open Query4, dados_sys
										DO UNTIL ds.eof
											co_sit=ds("CO_SITUACAO")
											de_sit=ds("DE_SITUACAO")

											'response.write "<option value="& codigoArea &">"&nomeArea&"</option>"							
											response.write "<option value='" & co_sit  & "'   "
											if cstr(situacao) = cstr(co_sit)  Then response.Write "selected='selected'" END IF											
											response.write " > " & de_sit & "</option>"							
											ds.movenext
										LOOP
										set ds = nothing
        							'	$conexao = mssql_connect('ce7180sr001','todos', 'todosce');
'										mssql_select_db('SIIAG',$conexao);
'										$query = "SELECT * FROM TB_DEMANDAS_SITUACOES";
'										$resultado = mssql_query($query,$conexao);
'								
'										while($linha = mssql_fetch_array($resultado)) {
'											echo "<option value=".$linha['CO_SITUACAO'].">".$linha['DE_SITUACAO']."</option>";
'										}
'									
'										mssql_close($conexao);
          							%> 
          
          						</select> </td>
          
          						<td width=""><label>Nome do Solicitante: </label></td>
          
								<td width="">
                                <!--<input style="margin-top:5px; max-width:170px; min-width:170px;" class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" /> -->
                                    <select name="nome" id='coSolicitante' class="form-select" style="width:200px;">
                                            <option value="">Todos</option>
                                          <%	
                                            SQL = "SELECT NO_NOME, CO_MATRICULA FROM [SIIAG].[dbo].[VW_USUARIOS] WHERE IC_ATIVO = '1' "
                                            SQL = SQL + " AND CO_MATRICULA <> '' AND LETRA ='C' "
                                            if not perfil_acesso_admin_siiag then
                                                SQL = SQL + " and (CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') "	
                                            end if
                                            SQL = SQL + " and co_unidade = "& request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_NOME"
                                
                                            
                                            set rs=Server.CreateObject("ADODB.RecordSet")
                                            rs.Open SQL, dados_sys, 3, , 32
                                            
                                            do while(rs.eof = false)
                                                
                                                nome = rs("NO_NOME")
                                                response.Write "<option " 
                                                if coSolicitante = rs("CO_MATRICULA")  Then response.Write "selected='selected'" END IF
                                                response.Write " value='"& rs("CO_MATRICULA") &"'>" & ucase(nome) & "</option>"
                                                rs.MoveNext
                                                
                                            loop
                                          %>
                                          </select>                               
                                </td>
      
       							<td width=""><label>De </label></td> 
       							<td width=""><input name="data_inicio" id="data_inicio" class="datepicker" type="text" size="10" maxlength="10" style="max-width:70px; min-width:70px;"/> </td>
          						<td width=""><label>até </label></td> 
          						<td width=""><input name="data_final" id="data_final" class="datepicker" type="text" size="10" maxlength="10" style="max-width:70px; min-width:70px;" /> </td>
          
          						<td width="" ><input type="submit" class='myButton pesquisar' style="padding-left:3px;padding-right:3px;margin-left:10px" name="btnPesquisar" id="btnPesquisar"  value="Pesquisar" /> </td>
          					</tr>
          				</table>
          
          				<br/>
          				<br/>
          				<div class="tabela" >
          					<!-- #INCLUDE FILE="demanda_listar_con.asp" -->
          				</div>
        			</fieldset>  
				<%end if%>
    			</div>
  			</div>
  			<!--fim do corpo-->
  			<!-- #INCLUDE FILE="rodape.asp" -->
		</div>
	</div>
	<!--teste-->
</body>
</html>
