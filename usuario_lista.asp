<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Usu&aacute;rio</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
<script src="scripts/jquery.autocomplete.js" language="javascript"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--<script src="scripts/jquery-1.9.1.js"></script> -->
<!--favicon -->
<!--CSS-->
<style type="text/css">
	<!--

	.background_coord{
		/* Permalink - use to edit and share this gradient: http://colorzilla.com/gradient-editor/#587fb5+0,e8f8ff+100 */
		background: #587fb5; /* Old browsers */
		background: -moz-linear-gradient(left,  #587fb5 0%, #e8f8ff 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, right top, color-stop(0%,#587fb5), color-stop(100%,#e8f8ff)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(left,  #587fb5 0%,#e8f8ff 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(left,  #587fb5 0%,#e8f8ff 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(left,  #587fb5 0%,#e8f8ff 100%); /* IE10+ */
		background: linear-gradient(to right,  #587fb5 0%,#e8f8ff 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#587fb5', endColorstr='#e8f8ff',GradientType=1 ); /* IE6-9 */
		
		border-bottom-left-radius: 5px;
		border-bottom-right-radius: 5px;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		
		font-family:arial;
		font-size:12px;
		text-shadow: 1px 1px #999;
		
		color:#222;
	}

	.lista {
		text-shadow: 1px 1px #999;
		
		color:#222;
		
	}

	.style2 {
		font-size: 14
	}
	.style3 {
		color: #5683C4
	}
	
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
	
	.ui-autocomplete {
		height:120px;
		overflow-y:scroll;
		overflow-x:hidden;
		font-size:12px;
	}
	-->
</style>

<script language="javascript">
<!--
$(document).ready(function() {


	$(".coordenacao").on("change", function(){
//		alert($(this).val());
		co_matricula = $(this).parent().parent().find("#co_matricula").val()
		co_coord  = $(this).val();
		//alert($(this).parent().parent().find("#co_matricula").val());

			$.ajax({
				cache:false,
				url: 'coordenacao_editar_usuario.asp?co_matricula=' + co_matricula + '&co_coord=' +  co_coord,
				dataType:"html",
				success: function (data) {
						//alert('sucesso!');
						window.navigate('usuario_lista.asp');
					},
				error: function() {
					alert(erro);
					},
			});
			//window.location.assign('coordenacao_editar_usuario.asp?co_matricula=' + co_matricula + '&co_coord=' +  co_coord);
			
	});

	$(".edit_usuario_coord").click(function(){
//		alert($(this).val());
		co_matricula = $(this).parent().parent().find("#co_matricula").val();
		$("#co_matricula_alterar").val(co_matricula);

		$("#dialog-coordenacao_usuario").prop("title", "Editar Coordenação");
		//============================================[DIÁLOGO]===========================
		// A div com o conteúdo da janela está lá embaixo
		$( "#dialog-coordenacao_usuario" ).dialog({
			modal: true, // Escurecer o fundo ou não
			dialogClass: "dialogo", //classe para formatar via CSS
			closeText: "Fechar",
			close: function( event, ui ) { 
				},
			height:130,
			width:500,
		});			
		//================================================================================	

			
	});

	$("#bt_salvar_coordenacao").click(function(){	
	
			co_matricula_alterar = $("#co_matricula_alterar").val();
			co_coord = $(this).parent().find("#coordenacao_usuario").val();
			$.ajax({
				cache:false,
				url: 'coordenacao_editar_usuario.asp?co_matricula=' + co_matricula_alterar + '&co_coord=' +  co_coord,
				dataType:"html",
				success: function (data) {
						alert('Coordenação alterada!');
						window.navigate('usuario_lista.asp');
					},
				error: function() {
					alert(erro);
					},
			});
		//window.location.assign('coordenacao_editar_usuario.asp?co_matricula=' + co_matricula_alterar + '&co_coord=' +  co_coord);
	});

});

	carregar_pagina();
		function carregar_pagina() {
			$("#div_coordenacoes").html('');
			$.ajax({
				cache:false,
				url: 'coordenacao_editar_usuario.asp',
				dataType:"html",
				success: function (data) {
						$("#div_coordenacoes").html(data);
					},
				error: function() {
					alert(erro);
					},
			});
			//window.location.assign('coordenacao_manter.asp');
	
	}

-->
</script>

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

<style type="text/css">
	.check {
		font-family:verdana;
		font-size:13px;
		color:#666666;
	}
	
	body {
		font-family:verdana;
		font-size:14px;
		color:#000;
	}
	
	a {color:#333; text-decoration:none}
	a:hover {color:#ccc; text-decoration:none}
	
	#mask {
		position:absolute;
		left:0;
		top:0;
		z-index:9000;
		background-color:#000;
		display:none;
	}
	
	#boxes .window {
		position:absolute;
		left:0;
		top:0;
		width:440px;
		height:200px;
		display:none;
		z-index:9999;
		padding:20px;
	}
	
	#boxes #dialog {
		width:375px; 
		height:203px;
		padding:10px;
		background-color:#ffffff;
	}
	
	#boxes #dialog1 {
		width:375px; 
		height:203px;
	}
	
	#dialog1 .d-header {
		background:url(login-header.png) no-repeat 0 0 transparent; 
		width:375px; 
		height:150px;
	}
	
	#dialog1 .d-header input {
		position:relative;
		top:60px;
		left:100px;
		border:3px solid #cccccc;
		height:22px;
		width:200px;
		font-size:15px;
		padding:5px;
		margin-top:4px;
	}
	
	#dialog1 .d-blank {
		float:left;
		background:url(login-blank.png) no-repeat 0 0 transparent; 
		width:267px; 
		height:53px;
	}
	
	#dialog1 .d-login {
		float:left;
		width:108px; 
		height:53px;
	}
	
	#boxes #dialog2 {
		background:url(notice.png) no-repeat 0 0 transparent; 
		width:326px; 
		height:229px;
		padding:50px 0 20px 25px;
	}
	.close{display:block; text-align:right;}

</style>
</head>

<!-- #INCLUDE FILE ="include/conexao.asp" -->
<body>
	<div class="teste2">
		<!--fundo azul do meio-->
  		<!-- #INCLUDE FILE ="topo.asp" -->
		<%	
  			'Chama a subrotina para verificar o perfil
			Perfil_Acesso("10")
			'Response.write request.Cookies("perfil_acesso_siiag_desc")
		%>
        <div class="corposite">
        	<!--corpo-->
	        <div class="container">
    		    <div class="conteudo2">
			        <div class="titulosModulos" ><span >USUÁRIO</span> </div>
				        <div class="usuariodiv">
					        <div id='cssmenu'>
						        <ul>
							        <li><a href='usuario.asp'><span>Consultar</span></a></li>
        
        							<%if (perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag")) then %>
								        <li ><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
							        <%end if %>
							        <% if tem_acesso("10") then  %>
	                                    <li class='' ><a href='coordenacao.asp'><span>Coordenações</span></a></li>
	                                    <li class='active' ><a href='usuario_lista.asp'><span>Relação de Usuários</span></a></li>
							        <% end if %>                                    
							        <li  ><a href='usuario_lista_frequencia.asp'><span>Lista de Usu&aacute;rios</span></a></li>
							        <% if tem_acesso("31") then  %>
	                                    <li><a href='usuario_lista_estagiario.asp'><span>Frequência de Estagiários</span></a></li>
							        <% end if %>
						        </ul>
					        </div>
					        </p>
                            
					        <%
						        if not perfil_acesso_siiag then
							        response.write "<label>     Acesso negado.</label>"
							        response.End()
						        end if

								strQuery = "select * from VW_USUARIOS where co_unidade=" & request.Cookies("co_usuario_unidade_siiag") & " and (co_gs is null OR CO_GS = 0 or co_gs not in (select co_gs from vw_gs where co_unidade = " & request.Cookies("co_usuario_unidade_siiag") & ")) order by no_nome ; " 

								set rs = Server.CreateObject("ADODB.RecordSet")
								rs.Open strQuery, dados_sys
								if not rs.eof then
									%>
									<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
										<legend class="style2 style3">Usu&aacute;rios sem coordenação vinculada</legend>
										<center>
										<table class="background_coord" width="90%">
										<tr><td style="color:#FFF; font-weight: bold" align="left"> NOME</td>
											<td style="color:#FFF;font-weight: bold" align="left">CARGO</td>
											<td></td>
										</tr>
										<%
										strCoord  = ComboCoordenacao
										do while not rs.eof
										%>
											<tr>
											<input type="hidden" value="<%=rs("co_matricula")%>" name="co_matricula" id ="co_matricula" />
											<td align="left"><%=rs("co_matricula")%> - <%=rs("no_nome")%></td>
											<td align="left"><%=rs("no_cargo")%></td>
											<td>
												<%=strCoord%>
											</td>
											</tr>
										<%
		
											rs.movenext
										loop
										
										%>
										</table>
										</center>
									</fieldset>
									<%
								end if
							        %>
		
        			        <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
						        <legend class="style2 style3" style="text-align:left;">Usu&aacute;rios por Coordenação</legend>
								<center>
			
            					<%
								strQuery = "select * from VW_GS where co_unidade='" & request.Cookies("co_usuario_unidade_siiag") & "' order by no_gs ; " 

								set rs_coord = Server.CreateObject("ADODB.RecordSet")
								'response.write strQuery
								rs_coord.Open strQuery, dados_sys
								do while not rs_coord.eof
            					
									strQuery = "select * from VW_USUARIOS where co_unidade='" & request.Cookies("co_usuario_unidade_siiag") & "' and co_gs = " & rs_coord("co_gs") & " order by eh_coordenador desc,eh_substituto desc, no_nome ; " 
									
									set rs = Server.CreateObject("ADODB.RecordSet")
									rs.Open strQuery, dados_sys
									if rs.eof then
										qt_emp_coord = 0
									else
										qt_emp_coord = x
									end if
									
									%>

									<% if not rs.eof then
										cont = 0
										lista = ""
										do while not rs.eof
											cont = cont + 1
										
										
										lista = lista & " <tr> "
										lista = lista & " <td align='left'><input type='hidden' value='" & ("co_matricula") & "' name='co_matricula' id ='co_matricula' /> " & rs("co_matricula") & " - " & rs("no_nome") & "</td> "
										lista = lista & "		<td align='left'>" &  ucase(rs("no_cargo")) & "</td> "
										lista = lista & "		<td> "
										lista = lista & "			<label class='select_coord' style='display:none;'></label> "
										lista = lista & "			<img src='imagens/edit_23_23_2.png' style='cursor:pointer;' class='edit_usuario_coord' title='alterar coordenação do usuário' /> "
										lista = lista & "  </td> "
										lista = lista & "</tr> "

                                    	
									 		rs.movenext
									 	loop	
									 else
										cont = 0
										lista = ""
									 end if %>
									<table width="90%"  border="0" class="background_coord">
									<tr height="40px">
										 <td style="color:#FFF;text-align:left; font-weight:bold;"><%=UCASE(rs_coord("no_gs"))%> ( <%=cont%> colaboradore(s) )</td>
									</tr>
									<tr><td align="center" valign="top">
                                        <table width='80%' border='0' class='lista'>
    
                                        <%= lista%>
                                                      
                                        </table>
                                        <br/>
									</td>
								   </tr>
								   </table>
	                               <br/>
                               <%
							   	rs_coord.movenext
								loop
							   %>
                               
                                 </center>
    	    			    </fieldset>
                           
		            </div>
            	</div>
            </div>
		</div>
		<!--fim do corpo-->
		<!-- #INCLUDE FILE ="rodape.asp" -->
	</div>
</body>
</html>



<%
Function ComboCoordenacao()

	ComboCoordenacao = ""
	ComboCoordenacao = ComboCoordenacao & " <select name='coordenacao' id='coordenacao'  class='form-select coordenacao' style='max-width:300px; min-width:300px;' tabindex='3' > "
	
	ComboCoordenacao = ComboCoordenacao  & "        <option value=''>Selecione a Coordenação</option> "
		Query3 ="select CO_GS, NO_GS from TB_GS WHERE IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY NO_GS" 
		set ds=Server.CreateObject("ADODB.RecordSet")
		ds.Open Query3, dados_sys 
		DO UNTIL ds.eof
			 ComboCoordenacao = ComboCoordenacao & " <option value='"& DS("co_gs")  & "'"
			 ComboCoordenacao = ComboCoordenacao & ">" & UCASE(ds("no_gs")) & "</option>"							 
			ds.movenext
		LOOP
	
	ComboCoordenacao = ComboCoordenacao  & "     </select> "

End Function


Sub ComboCoordenacaoUsuario(co_coord)
%>
    <select name="coordenacao_usuario" id="coordenacao_usuario"  class="form-select" style="max-width:450px; min-width:450px;" tabindex="3"  >
	<option value="">--Selecione a Coordenação--</option>
            <%
            Query3 ="select CO_GS, NO_GS from TB_GS WHERE IC_ATIVO = 1 AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ORDER BY NO_GS" 
            set ds=Server.CreateObject("ADODB.RecordSet")
            ds.Open Query3, dados_sys 
            DO UNTIL ds.eof
                response.write "<option value='"& DS("co_gs")  & "'"
                if cstr(co_coord)	= cstr(ds("co_gs")) then
                    response.Write(" selected ")
                end if 						
                response.Write ">" & UCASE(ds("no_gs")) & "</option>"							 
                ds.movenext
            LOOP
            %>
    </select>
<%
End Sub

%>
  <!-- DIV QUE VIRA DIALOG -->
<div  align="center" id="dialog-coordenacao_usuario" title="Coordenação" class="msg-dialog" style="display:none;">
    <div id="coordenacao_usuario"  style="text-align:left;" >
		<% ComboCoordenacaoUsuario 0 %>
        <input type="hidden" id="co_matricula_alterar" />
        <br/><br/>
        <input type="button" value="Salvar" id="bt_salvar_coordenacao" style="width:450px;" />
    </div>
</div>
<!-- FIM DIV QUE VIRA DIALOG -->