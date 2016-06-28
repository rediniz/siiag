<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Controle de Demandas</title>
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
<style>
.ui-datepicker {
	font-size:12px;
}
.datepicker {
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
	font-family: Arial, sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}
.ui-menu .ui-menu-item a {
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
	font-family: Arial, sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}
.ui-menu .ui-menu-item a {
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
		//$('#btnSalvar').on('click',function(){
//		
//			var demandas_situacoes = $("#demandas_situacoes").val();
//			if(demandas_situacoes == 2){
//				estagiario1 = $("#estagiarios1").is(":checked");
//			
//					if(estagiario1 == true){
//						estagiario1Matricula = $("#estagiarios1").val();
//						//alert($estagiario1Matricula);
//					} else {
//						estagiario1Matricula = "";
//					}
//			
//				estagiario2 = $("#estagiarios2").is(":checked");
//			
//					if(estagiario2 == true){
//						estagiario2Matricula = $("#estagiarios2").val();
//						//alert($estagiario2Matricula);
//					}	else {
//						estagiario2Matricula = "";
//					}
//			
//				estagiario3 = $("#estagiarios3").is(":checked");
//			
//					if(estagiario3 == true){
//						estagiario3Matricula = $("#estagiarios3").val();
//					//	alert($estagiario3Matricula);
//					}	else {
//						estagiario3Matricula = "";
//					}
//			
//				estagiario4 = $("#estagiarios4").is(":checked");
//			
//					if(estagiario4 == true){
//						estagiario4Matricula = $("#estagiarios4").val();
//						//alert($estagiario4Matricula);
//					}	else {
//						estagiario4Matricula = "";
//					}
//					
//				responsavel = $("#select1").val();	
//				data_prevista_conclusao = $("#data_prevista_conclusao").val();
//				co_demanda = $("#co_demanda").val();
//		
//				window.open("demanda_manter_con.asp?data_conclusao="+data_prevista_conclusao+"&matResponsavel="+responsavel+"&estagiario1Matricula="+estagiario1Matricula+"&estagiario2Matricula="+estagiario2Matricula+"&estagiario3Matricula="+estagiario3Matricula+"&estagiario4Matricula="+estagiario4Matricula+"&co_demanda="+co_demanda+"&demandas_situacoes="+demandas_situacoes+"");
//
//			}
//			
//			if (demandas_situacoes == 3 || demandas_situacoes == 4){ 
//				co_demanda = $("#co_demanda").val();
//				window.open("demanda_manter_con.asp?&co_demanda="+co_demanda+"&demandas_situacoes="+demandas_situacoes+"");
//				
//			}
//						
//		});

$('#btnSalvar').on('click',function(){


	$(".estagiarios").each(function(){
	
	var matricula = $(this).find("#matriculaEstagiario").html();
	
	//alert(matricula);
		$("#divEstagiarios").append("<input type='hidden' name='v_estagiarios' id='v_estagiarios' value="+matricula+" />");
		
	});
	
	$("#formulario").submit();

});
	});
	
</script>
<script>

	$(document).ready(function() {
	

		$(".info").hide();
		var codigo = $("#demandas_situacoes").val();
		if(codigo == 2){
		
	
			//document.getElementById('label1').style.display = "";
//			document.getElementById('label2').style.display = "";
//			document.getElementById('label3').style.display = "";
//			document.getElementById('select1').style.display = "";
//			document.getElementById('data_conclusao').style.display = "";	
//			document.getElementById('option1').style.display = "";	
//			document.getElementById('option2').style.display = "";	
//			document.getElementById('option3').style.display = "";	
//			document.getElementById('check1').style.display = "";	
//			document.getElementById('check2').style.display = "";	
//			document.getElementById('check3').style.display = "";	
//			document.getElementById('check4').style.display = "";	
//			//document.getElementById('btnSalvar').style.display = "";	
//			document.getElementById('demandas_situacoes').style.hidden="";

			$(".info").show();

		}
	});

</script>
<script>
	$(document).ready(function() {
		$('#demandas_situacoes').on('change',function(){

	
			var codigo = $("#demandas_situacoes").val();
		
				if (codigo==2){
					$(".info").show();
			//		document.getElementById('label1').style.display = "";
//					document.getElementById('label2').style.display = "";
//					document.getElementById('label3').style.display = "";
//					document.getElementById('select1').style.display = "";
//					document.getElementById('data_conclusao').style.display = "";	
//					document.getElementById('option1').style.display = "";	
//					document.getElementById('option2').style.display = "";	
//					document.getElementById('option3').style.display = "";	
//					document.getElementById('check1').style.display = "";	
//					document.getElementById('check2').style.display = "";	
//					document.getElementById('check3').style.display = "";	
//					document.getElementById('check4').style.display = "";	
//					document.getElementById('btnSalvar').style.display = "";	
//					document.getElementById('demandas_situacoes').style.hidden="";
					//alert("andamento");
					
				}
				
				else{
				$(".info").hide();
					$("#btnSalvar").show();
				}
		});
	});
	
</script>
<script>
	$(document).ready(function() {
		$('#data_conclusao').on('change',function(){
	
			var data = $("#data_conclusao").val();
		
			$("#btnSalvar").show();	

		});
		$('#addResponsavel').on('click', function(){
			$(".cabecalhoTabela").show();
			//alert($("#select1 option:selected").text());
			$("#tabelaResponsaveis").append("<tr><td><img src='imagens/delete_16x16.png' class='X' style='cursor:pointer'/></td><td>"+$("#select1 option:selected").val() +"</td><td>"+ $("#select1 option:selected").text()+"</td></tr>");
		
		});
		$('#addEstagiario').on('click', function(){
		
		if($("#selectEstagiarios option:selected").val() == ""){
		
			alert("Escolha um estagiário.");
			return false;
		}
	
			$(".cabecalhoTabela").show();
			//alert($("#select1 option:selected").text());
			$("#tabelaEstagiarios").append("<tr class='estagiarios'><td><img src='imagens/delete_16x16.png' class='X' style='cursor:pointer'/></td><td id='matriculaEstagiario' >"+$("#selectEstagiarios option:selected").val() +"</td><td>"+ $("#selectEstagiarios option:selected").text()+"</td></tr>");
		
		});
		$(document).on('click',".X", function(){
		
			$(this).parent().parent().remove();
					
		});
	
	});
	

</script>
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <%	demanda = request("demanda")
		
		%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <!-- <div class="titulosModulos" ><span >ESTOQUE</span> </div>  -->
        <p>
        <div id='cssmenu' >
          <ul>
            <li ><a href='demanda_solicitar.asp'><span>Solicitar Demanda</span></a></li>
            <li ><a href='demanda_consultar.asp'><span>Consultar Demanda</span></a></li>
            <li class='active'><a href='demanda_manter.asp'><span>Controle de Demandas</span></a></li>
          </ul>
        </div>
        </p>
        <div id='submenu'>
          <ul>
            <!--<li><a href='#'><span>Ajuda</span></a></li>-->
          </ul>
        </div>
        <%		'o conteudo vai aqui   %>
        <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos" >Detalhamento da Demanda</span></legend>
        
        <form action='demanda_manter_con.asp' id='formulario' >
        
        <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos" >Informa&ccedil;&otilde;es</span></legend>
        <table border="0">
          <!-- abre tipos -->
          <%  
   
			query = "SELECT B.NO_TIPO, C.NOME, A.DESCRICAO, A.CONCLUSAO_DATA_PREVISTA, D.CO_SITUACAO, D.DE_SITUACAO, A.SOLICITACAO_MATRICULA, E.NO_NOME, F.NO_GS "
			query = query & " FROM TB_DEMANDAS A "
			query = query & " INNER JOIN TB_DEMANDAS_TIPOS B ON A.TIPO_DEMANDA = B.CO_TIPO "
			query = query & " INNER JOIN VW_DEMANDAS_ULTIMO_ANDAMENTO ULT ON A.CO_DEMANDA = ULT.CO_DEMANDA "
			query = query & " INNER JOIN TB_APLICATIVOS C ON A.CO_APLICATIVO = C.CO_APLICATIVO "
			query = query & " INNER JOIN TB_DEMANDAS_SITUACOES D ON ULT.CO_SITUACAO = D.CO_SITUACAO "
			query = query & " INNER JOIN TB_USUARIOS E ON A.SOLICITACAO_MATRICULA = E.CO_MATRICULA "
			query = query & " INNER JOIN TB_GS F ON E.CO_GS = F.CO_GS "
			query = query & "  WHERE A.CO_DEMANDA = "& demanda &" "
			
			set rs=Server.CreateObject("ADODB.RecordSet")
			rs.Open query, dados_sys
			
			do while not  rs.eof
		 %>
          <tr>
            <td width="150"><label>Tipo de Demanda: </label></td>
            <td width="27" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100"><%= rs("NO_TIPO") %> </td>
          </tr>
          <tr>
            <td width="150"><label>Nome do Aplicativo: </label></td>
            <td width="27" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" ><%= rs("NOME") %> </td>
          </tr>
          <tr>
            <td width="150"><label>Descrição: </label></td>
            <td width="27" colspan="2"><textarea readonly="readonly"  style="margin-top:5px; max-width:350px; min-width:350px; max-height:50px;min-height:50px;" class="form-field" name="nome" id="nomeSolicitante" size="60" rows="5" cols="50"> <%=rs("DESCRICAO") %> </textarea>
            </td>
          </tr>
          <!--                                    <input style="margin-top:5px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" /></td></tr>-->
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td width="400" colspan="3" ><label> <strong> Dados do Solicitante: </strong></label></td>
          </tr>
          <tr>
            <td width="150"><label>Matr&iacute;cula: </label></td>
            <td width="50" style="margin-top:5px;" ><input class="form-field" name="nome" id="nomeSolicitante" type="text" size="8" value="<%=rs("SOLICITACAO_MATRICULA") %>" readonly="readonly" /></td> </td>
            <tr><td width="75" align="left"><label>Nome: </label></td>
            <td width="230" style="margin-top:5px; max-width:350px; min-width:350px;" class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" ><%=rs("NO_NOME") %> </td></tr>
          </tr>
          <tr>
            <td width="150"><label>Coordena&ccedil;&atilde;o: </label></td>
            <td width="150" style="margin-top:5px; max-width:250px; min-width:250px; " class="form-field" name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" ><%= rs("NO_GS") %> </td>
          </tr>
        </table>
        </fieldset>
        <fieldset class="testess"style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
        <legend><span class="titulos" >Acompanhamento</span></legend>
        <table border="0">
          <tr>
            <td width="150"><label>Situa&ccedil;&atilde;o: </label></td>
            <td width="150" style="margin-top:5px; max-width:250px; min-width:250px;"  name="nome" id="nomeSolicitante" type="text" size="43" maxlength="100" ><select class="form-select" style="width:100%;margin-top:5px;height:auto;" id="demandas_situacoes" name='demandas_situacoes'>
                <% 
								   

								querySituacao = "SELECT * FROM TB_DEMANDAS_SITUACOES ORDER BY DE_SITUACAO"
								
								  set ss=Server.CreateObject("ADODB.RecordSet")
												ss.Open querySituacao, dados_sys
								   	
									do while not ss.eof 
										if ss("CO_SITUACAO") = rs("CO_SITUACAO") then 
											response.write "<option value="& ss("CO_SITUACAO")&" selected='selected'> "& ss("DE_SITUACAO")&"</option>"
										else
											response.write "<option value="&ss("CO_SITUACAO")&"> "&ss("DE_SITUACAO")&"</option>"
										end if
									ss.movenext	
								   	loop

									
				%>
              </select></td>
          </tr>
          </tr>
          
          <!-- <input />-->
        </table>
        <%  %>
        <table border="0">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <div >
              <tr class="info">
                <td   id="label1"><label>Data Prevista para Conclus&atilde;o: </label></td>
                <td   size="10" maxlength="10" ><input name="data_conclusao" id="data_conclusao" type="text" class="datepicker" size="10"  value="<%=rs("CONCLUSAO_DATA_PREVISTA")%>" /></td>
              </tr>
              <tr class="info">
                <td   id="label2"><label>Respons&aacute;vel TI:</label></td>
                <td  style="margin-top:5px; max-width:250px; min-width:250px;"><select class="form-select" style="margin-top:5px;" id="select1" name="matResponsavel">
                    <option value=""  id="option1">Selecione o Respons&aacute;vel</option>
                    <!--<option value=""  id="C053498">ÍTALO REGES CAVALCANTE</option>
                    <option value=""  id="C124937">TATIANA BEZERRA ARAUJO</option> -->
                    <%
					  query = "SELECT  mat_responsavel from tb_demandas_responsaveis where co_demanda = " & demanda
					  set ss=Server.CreateObject("ADODB.RecordSet")
					  ss.Open query, dados_sys
					  
					  if not(ss.eof) then
					  	if (ucase(trim(ss("MAT_RESPONSAVEL"))) = "C053498") then
							Response.Write "<option value = 'C053498' selected='selected'>ITALO REGES MARQUES CAVALCANTE</option>"
							Response.Write "<option value = 'C124937' >TATIANA BEZERRA ARAUJO</option>"
						end if
						if (ucase(trim(ss("MAT_RESPONSAVEL"))) = "C124937") then
							Response.Write "<option value = 'C053498' >ITALO REGES MARQUES CAVALCANTE</option>"
							Response.Write "<option value = 'C124937' selected='selected'>TATIANA BEZERRA ARAUJO</option>"
						end if
					  else
					  	Response.Write "<option value = 'C053498' >ITALO REGES MARQUES CAVALCANTE</option>"
						Response.Write "<option value = 'C124937' >TATIANA BEZERRA ARAUJO</option>"
					  end if
					  'if resultado.eof then
					  '	mat = "12345"
					  'else
					  '	mat = resultado("mat_responsavel")
					  'end if
					 ' 
					 ' if ucase(trim(mat)) = "C053498" then
					 ' 
					 ' 	Response.Write "<option value = 'C053498' selected='selected'>ITALO REGES MARQUES CAVALCANTE</option>"
					 ' 
					 ' else
					 ' 
					 ' 	Response.Write "<option value = 'C053498' >ITALO REGES MARQUES CAVALCANTE</option>"
					 ' 
					 ' end if
					 ' 
					 ' if ucase(trim(mat)) = "C124937" then
					 ' 
					 ' 	Response.Write "<option value = 'C124937' selected='selected'>TATIANA BEZERRA ARAUJO</option>"
					 ' 
					 ' else
					 ' 
					 ' 	Response.Write "<option value = 'C124937' >TATIANA BEZERRA ARAUJO</option>"
					 ' 
					 ' end if
					%>

                    </select>
                  </td>
                  <td>
                  <!--<button id='addResponsavel' class="myButton">Adicionar</button>-->
   
                </td>
              </tr>
              <!--
              <tr><td colspan="3">       <div class='tabela' align="center">
                    <table id='tabelaResponsaveis' width="300px" style="margin-top:10px">
                    <tr class="cabecalhoTabela">
                    <td></td><td width="10%" >Matrícula</td><td>Nome</td>
                    </tr>
                    </table>-->
                    
                    </div></td></tr>
          </fieldset>
          
          <tr>
              
              
              
                          <tr class="info">
                <td   id="label2"><label>Estagiários:</label></td>
                <td  style="margin-top:5px;"><select class="form-select" style="margin-top:5px;" id="selectEstagiarios">
                	<option value=""  >Selecione o Estagiário</option>
                    <option value="E689507" >NATALIA ALBUQUERQUE CAVALCANTE</option>
                    <option value="E701082" >JONATHAN GARCIA DE QUEIROZ</option>
                    <option value="E711000" >RENATO DINIZ FERREIRA</option>
                    <option value="E712237" >BELMONDO RODRIGUES ARAGÃO JUNIOR</option>
                    </select>
                  </td>
                  <td>
                  <img src="imagens/add_16x16.png" id="addEstagiario" style="cursor:pointer; margin-left:5px" />
                  <!--<button id='addEstagiario' class="myButton" type="button">Adicionar</button>-->
   
                </td>
              </tr>
              
                        <tr><td colspan="3">       <div class='tabela info' align="center">
                    <table id='tabelaEstagiarios' width="300px" style="margin-top:10px">
                    <tr class="cabecalhoTabela">
                    <td></td><td width="10%" >Matrícula</td><td>Nome</td>
                    </tr>
                    <%
                    queryEstagiarios = "SELECT MAT_ESTAGIARIO FROM TB_DEMANDAS_RESPONSAVEIS WHERE CO_DEMANDA="&demanda
								
								set fs=Server.CreateObject("ADODB.RecordSet")
								fs.Open queryEstagiarios, dados_sys
								   	
								do while not fs.eof 
								
								 matricula =  ucase(trim(fs("MAT_ESTAGIARIO")))
								if(matricula ="E689507") then
									nome = "NATALIA ALBUQUERQUE CAVALCANTE"
									
								end if
								
								if(matricula = "E701082") then
									nome = "JONATHAN GARCIA DE QUEIROZ"
									
								end if
								
								if(matricula = "E711000") then
									nome = "RENATO DINIZ FERREIRA"
									
								end if
								
								if(matricula = "E712237") then
									nome = "BELMONDO RODRIGUES ARAGÃO JUNIOR"
									
								end if
	
									response.write "<tr class='estagiarios'><td><img src='imagens/delete_16x16.png' class='X' style='cursor:pointer'/></td><td id='matriculaEstagiario'>"&fs("MAT_ESTAGIARIO")&"</td><td>"&nome&"</td></tr>"
									fs.movenext	
								loop
					%>
                    </table>
                    
                    </div></td></tr>
          </fieldset>
          
          <tr>
                 
          </div>
          <% 

							
							%>
          <!--<tr class="info">
            <td  id="label3"><label> Estagi&aacute;rios:</label></td>
            <%                      
							
						'			strQuery = "SELECT MAT_RESPONSAVEL, MAT_ESTAGIARIO FROM TB_DEMANDAS_RESPONSAVEIS WHERE (CO_DEMANDA ="&demanda&")"
'									set zs=Server.CreateObject("ADODB.RecordSet")
'									zs.Open strQuery, dados_sys
'
'									do while not zs.eof
'	
'										'response.write "</br>" & zs("MAT_ESTAGIARIO") & "</br>"
'										
'										if UCASE(trim(zs("MAT_ESTAGIARIO"))) = "E712237" then
'										
'											response.write "Belmondo"
'										
'										end if
'										
'										if UCASE(trim(zs("MAT_ESTAGIARIO"))) = "E689507" then
'										
'											response.write "Natália"
'										
'										end if
'										
'										if UCASE(trim(zs("MAT_ESTAGIARIO"))) ="E711000" then
'										
'											response.write "Renato"
'										
'										end if
'										
'										if UCASE(trim(zs("MAT_ESTAGIARIO"))) ="E701082" then
'										
'											response.write "Jonathan"
'									
'										end if
'										
'		
'									zs.movenext
'									loop
'									
									rs.movenext
								loop	
									 %>
          </tr>-->
          
            <td><input type="hidden" value='<%= demanda %>' id="co_demanda" name='co_demanda' />
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td width="239" colspan="4" align="center"><button class='myButton' name="btnSalvar" id="btnSalvar" style="margin-left:20%" type="button">Salvar</button>
            </td>
          </tr>
        </table>
       <div id='divEstagiarios' >
       </div> 
    </form>
        </fieldset>
      </div>
    </div>
    <!--fim do corpo-->
    <%
				sucesso = request("sucesso")
				
				if sucesso <> "" then
					response.write "<script> alert('demanda editada com sucesso');</script>"
					response.write "<script> window.close();</script>"
				end if
				
			%>
    <!-- #INCLUDE FILE ="rodape.asp" -->
  </div>
</div>
<!--teste-->
</body>
</html>
