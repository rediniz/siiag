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
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
<script src="scripts/jquery.autocomplete.js" language="javascript"></script>
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--<script src="scripts/jquery-1.9.1.js"></script> -->
<!--favicon -->
<!--CSS-->

<style type="text/css">
<!--
	.style2 {
		font-size: 14
	}

	.style3 {
		color: #5683C4
	}
-->
</style>

<!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js"></script> -->
<script type="text/javascript">
	function FormatarData(campo,e) {
		if (campo.value=="Data"){
			campo.value="";
		}
		var cod="";
		if(document.all) {cod=event.keyCode;} else {cod=e.which;} 
		if(cod == 08) return;
		if (cod < 48 || cod > 57){
			if (cod < 45 || cod > 57) alert("Digite somente Caracteres Numéricos!");
			cod=0;
			campo.focus(); return false;
		}
		tam=campo.value.length; 
		if(tam > 9) return false;
		var caract = String.fromCharCode(cod);
		if(tam == 2 || tam == 5) {campo.value+="/"+caract; return false;};  
		campo.value+=caract; return false; 
	}

	function ValidarData(campo,variavel){
		//if (variavel=="") { alert("Favor informar a data."); return false; }
		if (variavel=="Data") variavel="";
		if (variavel != "") {
	 		var Parte=variavel.split("/"); 
	 		Ano=Parte[2];
	 		Mes=Parte[1];
	 		Dia=Parte[0];
	 		if (Parte.join("").length != 8 && variavel != "" ) { alert("Digite a Data corretamente."); campo.focus(); campo.value = ''; return false; }
	 		if (isNaN(Parte.join(""))) {alert("Data deve ser numérica.");  campo.focus(); campo.value = ''; return false;}
	 		if (Ano < 1500) {alert("Verifique o ano."); campo.focus(); campo.value = ''; return false;}
	 		Data1 = new Date(Ano,Mes-1,Dia);
	 		if (Mes < 1 || Mes > 12) {alert("Mes incorreto, favor retificar."); campo.focus(); campo.value = ''; return false;}
	 		if (Dia < 1 || Dia > 31) {alert("Dia incorreto, favor retificar."); campo.focus(); campo.value = ''; return false;}
	 		if (Dia > 30 || (Dia > 28 && Mes == 02 )) {
	  			D = Data1.getDate();
	  			if (D < Dia){
	  				alert("Data inexistente! Digite novamente.");
	  				campo.focus(); campo.value = '';
	  				return false; 
	  			}
	 		}
			Hoje = new Date();
	 		Ano2 = Hoje.getFullYear();
	 		Mes2 = Hoje.getMonth(); 
	 		Dia2 = Hoje.getDate(); 
	 		if (Mes2 < 10) { Mes2= "0" + Mes2 }
	 		if (Dia2 < 10) { Dia2= "0" + Dia2 }
	
	 		var Hoje="";
	 		var Data = "";
	 		Hoje =  Ano2 + "" + Mes2 + "" + Dia2;
	 		Data = Ano + "" + Mes + "" + Dia;
		}
	 	return true;
	}
	  
	function Enviar_Arquivo(){
		if( document.getElementById('f_matricula').value != ''){
			document.getElementById('f_matricula_2').value = document.getElementById('f_matricula').value
			document.getElementById('f_upload').value = '1';
			document.getElementById('pasta_guardar').value = '/imagens/usuarios/temp/';
			document.getElementById('f_nome_2').value = document.getElementById('f_nome').value;
			document.getElementById('f_coordenacao_2').value = document.getElementById('f_coordenacao').value;
			document.getElementById('f_cargo_2').value = document.getElementById('f_cargo').value;
			document.getElementById('f_nascimento_2').value = document.getElementById('f_nascimento').value;
			document.getElementById('f_admissao_2').value = document.getElementById('f_admissao').value;
			document.getElementById('f_inicio_2').value = document.getElementById('f_inicio').value;		
			document.getElementById('f_jornada_2').value = document.getElementById('f_jornada').value;
			document.getElementById('f_ativo_2').value = document.getElementById('f_ativo').checked;		
			document.getElementById('f_gerente_2').value = document.getElementById('f_gerente').checked;

			document.getElementById('form_upload').submit();
		} else{
			alert('Digite a matricula do usuário a ser cadastrado.');
			document.getElementById('f_matricula').focus();
		}
	}

	function Salvar(){
		if (form_salvar.f_nome.value == '') {alert('Digite o nome do usuário.'); form_salvar.f_nome.focus(); return false;}
		if (form_salvar.f_coordenacao.value == '') {alert('Selecione a coordenação.'); form_salvar.f_coordenacao.focus(); return false;}
		if (form_salvar.f_cargo.value == '') {alert('Selecione o cargo.'); form_salvar.f_cargo.focus(); return false;}	
		if (form_salvar.f_admissao.value == '') {alert('Digite a data de admissão do usuário.'); form_salvar.f_admissao.focus(); return false;}	
		if (form_salvar.f_inicio.value == '') {alert('Digite a data de início do usuário na unidade.'); form_salvar.f_inicio.focus(); return false;}	
		if (form_salvar.f_jornada.value == '') {alert('Digite a jornada de trabalho diária do usuário.'); form_salvar.f_jornada.focus(); return false;}		

		form_salvar.f_salvar.value = '1'; 
		form_salvar.submit();
	}

	$(document).ready(function() {	
		$('#EnviarArquivo').click(function(){
			$('#arquivo1').trigger('click');

		 	if ($('#arquivo1').val() != ''){
				if ($('#matricula').val() != ''){
					$('#f_matricula').val($('#matricula').val());
					$('#f_upload').val('1');				
					$('#form_upload').submit;
				} else{
					alert('Digite a matricula do usuário a ser cadastrado.');
					$('#matricula').focus();	
				}
		 	}
		});

		$('a[name=modal]').click(function(e) {
			e.preventDefault();
		
			if (($('#f_matricula').val() != '')){
				var id = $(this).attr('href');
		
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
		
				$('#mask').css({'width':maskWidth,'height':maskHeight});
	
				$('#mask').fadeIn(500);	
				$('#mask').fadeTo("slow",0.8);	
		
				//Get the window height and width
				var winH = $(window).height();
				var winW = $(window).width();
				  
				$(id).css('top',  winH/2-$(id).height()/2);
				$(id).css('left', winW/2-$(id).width()/2);
		
				$(id).fadeIn(500); 
			} else{
				alert('Digite a matricula.');
				$('#f_matricula').focus();
			}
		});
	
		$('.window .close').click(function (e) {
			e.preventDefault();
		
			$('#mask').hide();
			$('.window').hide();
		});		
	
		$('#mask').click(function () {
			$(this).hide();
			$('.window').hide();
		});
	});
</script>

<script type="text/javascript" language="javascript">
	$(document).ready(function(){
		function isNumber(n) {
	  		return !isNaN(parseFloat(n)) && isFinite(n);
		}

		function Left(str, n){
			if (n <= 0)
				return "";
			else if (n > String(str).length)
				return str;
			else
				return String(str).substring(0,n);
		}
		
		function Right(str, n){
			if (n <= 0)
		   		return "";
			else if (n > String(str).length)
		   		return str;
			else {
		   		var iLen = String(str).length;
		   		return String(str).substring(iLen, iLen - n);
			}
		}

		//Ao digitar executar essa funcao
		$('#f_verificar').click(function(){
			//document.getElementById('label1').style.display = "";
			//document.getElementById('digito').style.display = "";
			var matricula = $("#f_matricula").val();
			if (matricula != "" && !isNumber(Left(matricula,1)) && isNumber(Right(matricula,6))  ){
				window.location.assign("usuario_cadastrar_consulta_matricula.asp?matricula=" + matricula);
			} else{
				alert('Digite uma matrícula para verificação no formato X999999.');
				$("#f_matricula").focus();
			}
			//alert('teste');
	  	});
	
	 	$("#f_matricula").result(function(event, retorno) {
			if (retorno==undefined)
				$("#f_matricula").val(""),
				$("#f_coordenacao").val(""),	
				$("#f_cargo").val(""),
				$("#f_nascimento").val(""),
				$("#f_admissao").val(""),
				$("#f_inicio").val(""),
				$("#f_jornada").val(""),
				$("#f_ativo").val(""),
				$("#f_gerente").val("");
				
			else
				$("#nome").val(retorno[1]);
				$("#coordenacao").val(retorno[2]);				
				$("#cargo").val(retorno[3]);
				$("#nascimento").val(retorno[4].replace("-", "/").replace("-", "/").split(" ", 1));
				$("#admissao").val(retorno[5].replace("-", "/").replace("-", "/").split(" ", 1));
				$("#inicio").val(retorno[6].replace("-", "/").replace("-", "/").split(" ", 1));
				$("#jornada").val(retorno[7] + " horas");
								
				if (retorno[8] == "True") {
					$("#ativo").attr("checked", "checked");				
				}
				if (retorno[9] == "True") {
					$("#gerente").attr("checked", "checked");					
				}
				if(retorno[10] == ""){
					$("#foto").attr("src", "imagens//X000000.png");
				} else {		
					$("#foto").attr("src", "imagens//usuarios//" + retorno[0] + ".png");
				}						
		});
	});
</script>

<style type="text/css">
	body {
		font-family:verdana;
		font-size:15px;
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
				Perfil_Acesso("9")

				imagem = request("arquivo")
				if imagem = "" then imagem = request("f_arquivo_3") end if
	
				matricula = ucase(request("f_matricula"))
				nome = request("f_nome")
				coordenacao = request("f_coordenacao")
				cargo = request("f_cargo")
				nascimento = request("f_nascimento")
				admissao = request("f_admissao")
				inicio = request("f_inicio")
				jornada = request("f_jornada")
				gerente = request("f_gerente")
				ativo  = request("f_ativo")
				digito = request("digito")
				'response.Write(gerente)
				co_unidade = request("f_co_unidade")
	
				if cStr(request("f_salvar")) = "1"  and (perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag")) then
					dim ScriptObject
					Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
					pasta=Server.MapPath("./imagens/usuarios/temp/")
					pasta_destino = Server.MapPath("./imagens/usuarios/")
					'response.Write(pasta & "\" & imagem)
					'response.Write(pasta & "\" & matricula & right(imagem,4))
		
					if imagem <> "" then
						imagem_gravar = matricula & right(imagem,4)
						ScriptObject.CopyFile pasta & "\" & imagem, pasta_destino & "\" & imagem_gravar , "true"
						ScriptObject.DeleteFile pasta & "\" & imagem
					end if
	
					'FileSystemObjectName.CopyFile(source,destination[, overwrite])
	
					response.Write(ativo)
					if ativo = "on" then ativo_aux = 1 else ativo_aux = 0 end if
					if gerente = "on" then gerente_aux = 1 else gerente_aux = 0 end if
		
					strQuery = 		"select * from TB_USUARIOS where CO_MATRICULA='" & left(matricula,7) & "'; " 
					set rs =		Server.CreateObject("ADODB.RecordSet")
					rs.Open strQuery, dados_sys
					'response.Write(strQuery)
					
					if rs.eof then
						set rs2 =		Server.CreateObject("ADODB.RecordSet")
						if imagem_gravar <> "" then
							sql= "INSERT INTO TB_USUARIOS (CO_MATRICULA, CO_DIGITO, NO_NOME, CO_CARGO, DT_NASCIMENTO, NU_JORNADA, IC_GERENTE, IC_ATIVO,IM_FOTO, CO_GS, CO_UNIDADE, DT_ADMISSAO, DT_INICIO_GIFUG)"
							
							sql = sql & " VALUES ('" & matricula & "','" & digito & "', '" & nome & "','" & cargo & "','" & nascimento & "','" & jornada & "'," & gerente_aux & "," & ativo_aux & ",'" & imagem_gravar & "','" & coordenacao & "','" & co_unidade & "','" & admissao & "','" & inicio & "') "
							'response.Write(sql)
						
						else
							sql= "INSERT INTO TB_USUARIOS (CO_MATRICULA, CO_DIGITO, NO_NOME, CO_CARGO, DT_NASCIMENTO, NU_JORNADA, IC_GERENTE, IC_ATIVO, CO_GS, CO_UNIDADE, DT_ADMISSAO, DT_INICIO_GIFUG)"
							sql = sql & " VALUES ('" & matricula & "','" & digito & "', '" & nome & "','" & cargo & "','" & nascimento & "','" & jornada & "'," & gerente_aux & "," & ativo_aux & ",'" & coordenacao & "','" & co_unidade & "','" & admissao & "','" & inicio & "') "
						end if
						
						Set rs2 = objConn.execute(sql)
						gravado = true
					end if
				end if
			%>
  			<div class="corposite">
    			<!--corpo-->
    			<div class="container">
    	  			<div class="conteudo2">
      					<div class="titulosModulos" ><span >USUÁRIO</span> </div>
        					<div class="usuariodiv">
          						<div id='cssmenu'>
            						<ul>
									<%aba_ativa = 2%>
                                    <!-- #INCLUDE FILE ="abas_usuarios.asp" -->
            						</ul>
          						</div>
          					</p>
          					<div id="submenu" >
            					<ul>
                					<!--<li> <a href=''><span>Ajuda</span></a></li>-->
            					</ul>          
           					</div>
							
							<%
								if not (perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag")) then
									response.write "<label>     Acesso negado.</label>"
									response.End()
								end if
							%>
         	 				<fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; height:450px;">
          						<legend class="style2 style3">Informações do Usu&aacute;rio</legend>
          						<p/>
          						<form name="form_salvar" id="form_salvar" action="usuario_cadastrar.asp" method="post" >
          							<table border="0" width="100%">
            							<tr>
                							<td width="9%">
	            								<label >Matr&iacute;cula: </label>
                							</td>
	             							<td colspan="5">
					 							<input class='form-field' name='f_matricula' id='f_matricula' type='text'  size='8' maxlength='7'  value= '<%=matricula%>' tabindex="1" />
                                                <label style="display:none" id="label1">-</label>
                                                <input class='form-field' name='digito' id='digito' type='text'  size='1' maxlength='1'  value= '<%=digito%>' style="display:none" />
                     							<input type="button" value="Verificar"  name="f_verificar" class="myButton" id="f_verificar"/>
                 							</td>
											
											<%
            									existe = request("existe")
            									if existe = "1" then
                									ativo_verificado = request("ativo")
                									if ativo_verificado then
            								%>
               	 							<script language="javascript">
												if (confirm('A matrícula já está cadastrada. Deseja consultar as informações deste usuario?'))
													{window.location.assign('usuario.asp?f_matricula=' + form_salvar.f_matricula.value);}
                    						</script>
            								
											<%	
                								else
            								%>
											<script language="javascript">
												if (confirm('O usuário em questão está marcado como inativo. Deseja editar as informações?')){
													window.location.assign('usuario.asp?f_matricula=' + form_salvar.f_matricula.value);
												}
                    						</script>
            								
											<%	
                								end if
            								end if
			
											if existe <> "" or nome <> "" then %>
                								<td width="18%" rowspan="5"  align="center" valign="middle" >
                								<%if imagem = "" then%>
						  							<img style='border:#b9d3f0 solid 3px;'id='foto' src='imagens//usuarios//X000000.png' />
                      								<br>
                								<%else%>
					  								<img style='border:#b9d3f0 solid 3px;'id='foto' width="103" height="128" src='imagens//usuarios//temp//<%=imagem%>' />
                      								<br>
                								<%end if%>
												
                                                <script>
												document.getElementById('label1').style.display = "";
												document.getElementById('digito').style.display = "";
												</script>
                                                <!--<INPUT type="button" value="Adicionar foto" name="EnviarArquivo"  id="EnviarArquivo" class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" > -->

												<a href="#dialog" name="modal"><INPUT type="button"  value="Adicionar foto"  class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" ></a>
	            							</td>
            							</tr>

            							<tr>
                							<td>
	            								<label >Nome: </label>
                							</td>
											<td colspan="5">
	                							<input class='form-field' name='f_nome' id='f_nome' type='text'  size='50' maxlength='100' value='<%=nome%>' tabindex="2"  />
											</td>
            							</tr>
            							
                                        <tr>
                							<td>
	            								<label >Coordena&ccedil;&atilde;o: </label>
                							</td>
											<td colspan="5">
                    							<%ComboCoordenacao()%>
											</td>
            							</tr>

            							<tr>
                							<td>
	            								<label >Cargo: </label>
                							</td>
											<td colspan="5">
                    							<%ComboCargo()%>
											</td>
            							</tr>
                                        
            							<tr>
                							<td>
	            								<label >Nascimento: </label>
                							</td>
											<td width="10%" >
                		  						<input class='form-field' name='f_nascimento' id='f_nascimento' type='text'  size='10' maxlength='10' value='<%=nascimento%>'  tabindex="5" OnKeyPress="return(FormatarData(this,event))"  onblur="return(ValidarData(this,this.value))" />
			  								</td>

                							<td width="7%">
	            								<label >Admissão: </label>
              								</td>
											<td width="21%" >
                	  							<input class='form-field' name='f_admissao' id='f_admissao' type='text'  size='10' maxlength='10'  value='<%=admissao%>'  tabindex="6" OnKeyPress="return(FormatarData(this,event))"  onblur="return(ValidarData(this,this.value))" />
			  								</td> 
                							<td width="12%">
	            								<label >Início: </label>
              								</td>
											<td width="23%" >
                  								<input class='form-field' name='f_inicio' id='f_inicio' type='text'  size='10' maxlength='10' value='<%=inicio%>'  tabindex="7" OnKeyPress="return(FormatarData(this,event))"  onblur="return(ValidarData(this,this.value))" />
			  								</td>
            							</tr>
                                        
            							<tr>
                							<td>
	            								<label >Jornada: </label>
                							</td>
											<td width="10%"  colspan="6" >
                  								<input class='form-field' name='f_jornada' id='f_jornada' type='text'  size='1' maxlength='1' value='<%=jornada%>'  tabindex="8" /><label> horas</label>
			  								</td>
            							</tr>
            							
                                        <tr>
                							<td>
	            								<label >Ativo: </label>
                							</td>
											<td width="10%"  colspan="1" >
                								<input  type='checkbox' name='f_ativo' id='f_ativo' <%if ativo = "true" or ativo = "" then%> checked="checked" <%end if%>  tabindex='9'/>
			  								</td>
              
              								<td align="left" colspan="2">
	            								<label>Gerente ou Substituto:</label>
                							</td>
											<td width="10%"  colspan="6" >
												<input type='checkbox' name='f_gerente' id='f_gerente' <%if gerente = "true" then%> checked="checked" <%end if%>  tabindex='10' />
			  								</td>
            							</tr>
            							
                                        <tr>
                							<td>&nbsp;  </td>
            							</tr>
                                        
            							<tr>
                							<td align="center" colspan="7">
	            								<INPUT type="button" value="Salvar" class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" onclick="return(Salvar())">
                								<input type="hidden" name = "f_salvar" id="f_salvar">
                								<input type="hidden" name = "f_arquivo_3" id="f_arquivo_3" value="<%=imagem%>">
                								<input type="hidden" name = "f_co_unidade" id="f_co_unidade" value="<%=request.Cookies("co_usuario_unidade_siiag")%>" >
                							</td>
            							</tr>
									<%end if%>

            					</table>
            				</form>
          				</fieldset>
        			</div>
      			</div>
    		</div>
  		</div>

<!--
    <div id="div_arquivo" class="window" style="display:''">
        <a href="#" class="close">Fechar [X]</a><br />
        Selecione o arquivo com a imagem<br /> 
         <form name="form_upload"  id="form_upload"  action="usuario_upload_arquivo.asp" method="POST" target="_blank" ENCtype="multipart/form-data" >
          <input type="file" class = "arquivo" id="arquivo1" name="arquivo1" style="display:'';"/> 
          <input type="text" value="" name="f_arquivo" id="f_arquivo"/>
          <input type="text" value="" name="f_matricula" id="f_matricula"/>
          <input type="text" value="" name="f_upload" id="f_upload"/>
          <input type="submit" onclick="" value="Enviar" />      
         </form>
    </div>
-->

    	<div id="boxes">

    		<div id="dialog" class="window" style="display:">
        		<a href="#" class="close">fechar [X]</a><br />
        		Selecione o arquivo com a imagem<br /> 
         		<form name="form_upload"  id="form_upload"  action="usuario_upload_arquivo.asp" method="POST" target="_self" onsubmit=""  ENCtype="multipart/form-data" >
          			<input type="file" class = "arquivo" id="arquivo1" name="arquivo1" style="display:'';"/> 
          			<input type="hidden" value="" name="f_arquivo" id="f_arquivo"/>
          			<input type="hidden" value="" name="f_matricula_2" id="f_matricula_2"/>
          			<input type="hidden" value="" name="f_upload" id="f_upload"/>
          			<input type="hidden" value="" name="pasta_guardar" id="pasta_guardar"/>
          			<input type="hidden" value="" name="f_nome_2" id="f_nome_2"/>
          			<input type="hidden" value="" name="f_coordenacao_2" id="f_coordenacao_2"/>
          			<input type="hidden" value="" name="f_cargo_2" id="f_cargo_2"/>
          			<input type="hidden" value="" name="f_nascimento_2" id="f_nascimento_2"/>
          			<input type="hidden" value="" name="f_admissao_2" id="f_admissao_2"/>
          			<input type="hidden" value="" name="f_inicio_2" id="f_inicio_2"/>
          			<input type="hidden" value="" name="f_jornada_2" id="f_jornada_2"/>
          			<input type="hidden" value="" name="f_ativo_2" id="f_ativo_2"/>
          			<input type="hidden" value="" name="f_gerente_2" id="f_gerente_2"/>          
          			<input type="button" onclick="return(Enviar_Arquivo());" value="Enviar"/>      
         		</form>
    		</div>

    		<!-- Janela Modal com caixa de diálogo -->  
    		<div id="dialog1" class="window">
      			<div class="d-header">
        			<input type="text" value="usuario" onclick="this.value=''"/><br/>
        			<input type="password" value="Password" onclick="this.value=''"/>    
      			</div>
      			<div class="d-blank"></div>
      			<div class="d-login"><input type="image" alt="Login" title="Login" src="login-button.png"/></div>
    		</div>
    		<!-- Fim Janela Modal com caixa de diálogo -->  
    
    		<!-- Janela Modal com Bloco de Nota -->
    		<div id="dialog2" class="window">
    			Então?<br />
    			Construir uma <b>Janela Modal Simples</b> com o formato que você quiser é fácil!<br />
    			Simples e totalmente personalizável : ) <br /><br />
    			<input type="button" value="Fechar" class="close"/>
    		</div>
    		<!-- Fim Janela Modal com Bloco de Nota -->
    
    		<!-- Máscara para cobrir a tela -->
      		<div id="mask"></div>
    
    		</div>

  			<!--fim do corpo-->
  			<!-- #INCLUDE FILE ="rodape.asp" -->
		</div>

		<%
			if gravado then
		%>
		<script language="javascript">
			alert('Inclusão realizada com sucesso!');
			window.location.assign('usuario.asp?f_matricula=' + form_salvar.f_matricula.value);
		</script>
        <%
			end if
		%>
		<!--teste-->
		
		<%
			Sub ComboCoordenacao()
		%>
    		<select name="f_coordenacao" id="f_coordenacao"  class="form-select" style=" width:340px;max-width:340px;min-width:340px;" tabindex="3" >
				<%
					if request.Cookies("co_usuario_co_visao") = "2" and perfil_acesso_admin_siiag then
	            		Query3 ="select CO_GS, NO_GS from TB_GS WHERE IC_ATIVO = 1 AND CO_GS = '" & request.Cookies("co_usuario_gs_siiag")  & "' AND CO_UNIDADE='"&request.Cookies("co_usuario_unidade_siiag")&"' ORDER BY NO_GS" 
					elseif request.Cookies("co_usuario_co_visao") = "3" and perfil_acesso_admin_siiag then
	            		Query3 ="select CO_GS, NO_GS from TB_GS WHERE IC_ATIVO = 1 AND CO_UNIDADE='"&request.Cookies("co_usuario_unidade_siiag")&"' ORDER BY NO_GS"
				%>
	                <option value="">Selecione a Coordenação</option>
                <%
					end if
            		set ds=Server.CreateObject("ADODB.RecordSet")
            		ds.Open Query3, dados_sys 
            		DO UNTIL ds.eof
                		response.write "<option value='"& DS("co_gs")  & "'"
                		if cstr(coordenacao)	= cstr(ds("co_gs")) then
                    		response.Write(" selected ")
                		end if 						
                		response.Write ">" & ds("no_gs") & "</option>"							 
                		ds.movenext
            		LOOP
            	%>
    		</select>
		<%
			End Sub
		%>

		<%
			Sub ComboCargo()
		%>
        <select name="f_cargo" id="f_cargo"  class="form-select" style=" width:340px;max-width:340px;min-width:340px;" tabindex="3" >
            <option value="">Selecione o Cargo</option>
            <%
                Query3 ="select CO_CARGO, NO_CARGO from TB_CARGOS WHERE IC_ATIVO = 1 AND CO_CARGO <> 3 ORDER BY NO_CARGO" 
                set ds=Server.CreateObject("ADODB.RecordSet")
                ds.Open Query3, dados_sys 
                DO UNTIL ds.eof
                    response.write "<option value='"& DS("co_CARGO")  & "'"
                    if cstr(cargo)	= cstr(ds("co_CARGO")) then
                        response.Write(" selected ")
                    end if 						
                    response.Write ">" & ds("no_CARGO") & "</option>"							 
                    ds.movenext
                LOOP
            %>
        </select>
        <%
            End Sub
        %>

</body>
</html>
