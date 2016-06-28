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
<script type="text/javascript" language="javascript">


function FormatarData(campo,e) 
{
	if (campo.value=="Data")
	{
		campo.value="";
	}
	var cod="";
	if(document.all) {cod=event.keyCode;} else {cod=e.which;} 
	if(cod == 08) return;
	if (cod < 48 || cod > 57)
	{
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
			   
	   
			   
function ValidarData(campo,variavel)
{
	
	//if (variavel=="") { alert("Favor informar a data."); return false; }
	if (variavel=="Data") variavel="";
	if (variavel != "") 
	{ 
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
	 if (Dia > 30 || (Dia > 28 && Mes == 02 )) 
	 {
	  D = Data1.getDate();
	  if (D < Dia)
	  {
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
	   
function Enviar_Arquivo()
{

	if( document.getElementById('matricula').value != '')
	{
		document.getElementById('f_matricula_2').value = document.getElementById('matricula').value
		document.getElementById('f_upload').value = '1';
		document.getElementById('pasta_guardar').value = '/imagens/usuarios/temp/';
		document.getElementById('f_nome_2').value = document.getElementById('nome').value;
		document.getElementById('f_coordenacao_2').value = document.getElementById('coordenacao').value;
		document.getElementById('f_cargo_2').value = document.getElementById('cargo').value;
		document.getElementById('f_nascimento_2').value = document.getElementById('nascimento').value;
		document.getElementById('f_admissao_2').value = document.getElementById('admissao').value;
		document.getElementById('f_inicio_2').value = document.getElementById('inicio').value;		
		document.getElementById('f_jornada_2').value = document.getElementById('jornada').value;
		document.getElementById('f_ativo_2').value = document.getElementById('ativo').checked;		
		document.getElementById('f_gerente_2').value = document.getElementById('gerente').checked;

		document.getElementById('form_upload').submit();
	}

}

		 
$(document).ready(function(){

	//Ao digitar executar essa funcao
	$("#nome").focus().autocomplete("autocompletar_nome.asp",{
		minChars: 1 //Numero minimo de caracteres para aparecer a lista
	  , matchContains: true //Aparecer somente os que tem relação ao valor digitado
	  , scrollHeight: 220 //Altura da lista dos nomes
	  , selectFirst: true  //Vim o primeiro da lista selecionado
	  , mustMatch: false //Caso nao existir na lista, remover o valor
	  , delay: 100 //Tempo para aparecer a lista para 0, por padrao vem 200
	  });
	  
		$("#matricula").focus().autocomplete("autocompletar_matricula.asp",{
		minChars: 1 //Numero minimo de caracteres para aparecer a lista
	  , matchContains: true //Aparecer somente os que tem relação ao valor digitado
	  , scrollHeight: 220 //Altura da lista dos nomes
	  , selectFirst: true //Vim o primeiro da lista selecionado
	  , mustMatch: false //Caso nao existir na lista, remover o valor
	  , delay: 100 //Tempo para aparecer a lista para 0, por padrao vem 200
	  });
				  
	   //Quando selecionar valor pegar retorno. O retorno nesse caso sao: Nome|Codigo
	$("#nome").result(function(event, retorno) {
							
		if ( retorno==undefined )
		
			$("#matricula").val(""),
			$("#coordenacao").val(""),	
			$("#cargo").val(""),
			$("#nascimento").val(""),
			$("#admissao").val(""),
			$("#inicio").val(""),
			$("#jornada").val(""),
			$("#ativo").val(""),
			$("#gerente").val("");
			
			else
			
			var matricula = retorno[1];	
			var imagem = 	"imagens//usuarios//"&matricula&".png";	 
			
			$("#matricula").val(retorno[1]);
			$("#coordenacao").val(retorno[2]);	
			$("#cargo").val(retorno[3]);
			$("#nascimento").val(retorno[4].replace("-", "/").replace("-", "/").split(" ", 1));
			$("#admissao").val(retorno[5].replace("-", "/").replace("-", "/").split(" ", 1));
			$("#inicio").val(retorno[6].replace("-", "/").replace("-", "/").split(" ", 1));
			$("#jornada").val(retorno[7]);	
			
			if (retorno[8] == "True") {
			$("#ativo").attr("checked", "checked");						
			}
			if (retorno[9] == "True") {
			$("#gerente").attr("checked", "checked");					
			} else{
			$("#gerente").removeAttr("checked");	
			}
			
			if(retorno[10] == ""){
			$("#foto").attr("src", "imagens//usuarios//X000000.png");
			} else {				
			$("#foto").attr("src", "imagens//usuarios//" + retorno[10] + "");
			}
	
	});   
		
	 $("#matricula").result(function(event, retorno) {
	 
		if (retorno==undefined)
		
			$("#matricula").val(""),
			$("#coordenacao").val(""),	
			$("#cargo").val(""),
			$("#nascimento").val(""),
			$("#admissao").val(""),
			$("#inicio").val(""),
			$("#jornada").val(""),
			$("#ativo").val(""),
			$("#gerente").val("");
			
		else
			
			$("#nome").val(retorno[1]);
			$("#coordenacao").val(retorno[2]);				
			$("#cargo").val(retorno[3]);
			$("#nascimento").val(retorno[4].replace("-", "/").replace("-", "/").split(" ", 1));
			$("#admissao").val(retorno[5].replace("-", "/").replace("-", "/").split(" ", 1));
			$("#inicio").val(retorno[6].replace("-", "/").replace("-", "/").split(" ", 1));
			$("#jornada").val(retorno[7]);
								
			if (retorno[8] == "True") {
			$("#ativo").attr("checked", "checked");				
			}
			if (retorno[9] == "True") {
			$("#gerente").attr("checked", "checked");					
			}
			if(retorno[10] == ""){
			$("#foto").attr("src", "imagens//usuarios//X000000.png");
			} else {
			$("#foto").attr("src", "imagens//usuarios//" + retorno[10] + "");
			}	
									
			});
			
			
			$('a[name=modal]').click(function(e) {
			e.preventDefault();
			
			if (($('#f_matricula').val() != ''))
			{
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
			}
			else
			{
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

function editar()
{     
	//document.getElementById('f_coordenacao').disabled = false;
	document.getElementById('matricula').setAttribute('disabled');
	document.getElementById('matricula').value = document.getElementById('matricula_aux').value
	document.getElementById('nome').value = document.getElementById('nome_aux').value
	document.getElementById('nome').focus();
	

	document.getElementById('coordenacao').removeAttribute('disabled');
	document.getElementById('coordenacao').className = 'form_bloqueado';
	document.getElementById('coordenacao').style.background = '#FFFFFF';

	document.getElementById('cargo').removeAttribute('disabled');
	document.getElementById('cargo').className = 'form_bloqueado';
	document.getElementById('cargo').style.background = '#FFFFFF';
	
	document.getElementById('nascimento').removeAttribute('disabled');
	document.getElementById('nascimento').className = 'form-field';
	document.getElementById('nascimento').style.background = '#FFFFFF';
	
	document.getElementById('inicio').removeAttribute('disabled');
	document.getElementById('inicio').className = 'form-field';
	document.getElementById('inicio').style.background = '#FFFFFF';

	document.getElementById('admissao').removeAttribute('disabled');
	document.getElementById('admissao').className = 'form-field';
	document.getElementById('admissao').style.background = '#FFFFFF';
	document.getElementById('jornada').removeAttribute('disabled');
	document.getElementById('jornada').className = 'form-field';
	document.getElementById('jornada').style.background = '#FFFFFF';
	document.getElementById('ativo').removeAttribute('disabled');
	document.getElementById('gerente').removeAttribute('disabled');

	document.getElementById('bt_salvar').style.display = '';
	document.getElementById('bt_editar').style.display = 'none';

	document.getElementById('bt_editar_foto').style.display = '';
}

function editar_2()
{     
	//document.getElementById('f_coordenacao').disabled = false;
	document.getElementById('matricula').setAttribute('disabled');
	document.getElementById('matricula').value = document.getElementById('matricula_aux').value
	document.getElementById('nome').value = document.getElementById('nome_aux').value
	document.getElementById('nome').focus();
	
	document.getElementById('nascimento').removeAttribute('disabled');
	document.getElementById('nascimento').className = 'form-field';
	document.getElementById('nascimento').style.background = '#FFFFFF';
	
	document.getElementById('bt_salvar').style.display = '';
	document.getElementById('bt_editar_2').style.display = 'none';

	document.getElementById('bt_editar_foto').style.display = '';
}


function salvar()						//novo
{     

	if (form_editar.matricula.value == '') {alert('Digite a matrícula do usuário.'); form_editar.matricula.focus(); return false;}
	if (form_editar.nome.value == '') {alert('Digite o nome do usuário.'); form_editar.nome.focus(); return false;}
	if (form_editar.coordenacao.value == '') {alert('Selecione a coordenação.'); form_editar.coordenacao.focus(); return false;}
	if (form_editar.cargo.value == '') {alert('Selecione o cargo.'); form_editar.cargo.focus(); return false;}	
	if (form_editar.admissao.value == '') {alert('Digite a data de admissão do usuário.'); form_editar.admissao.focus(); return false;}	
	if (form_editar.inicio.value == '') {alert('Digite a data de início do usuário na unidade.'); form_editar.inicio.focus(); return false;}	
	if (form_editar.jornada.value == '') {alert('Digite a jornada de trabalho diária do usuário.'); form_editar.jornada.focus(); return false;}		

	document.getElementById('flg_salvar').value = '1';
	document.getElementById('matricula').removeAttribute('disabled');
	document.getElementById('coordenacao').removeAttribute('disabled');
    document.getElementById('cargo').removeAttribute('disabled');
	document.getElementById('nascimento').removeAttribute('disabled');
	document.getElementById('inicio').removeAttribute('disabled');
	document.getElementById('admissao').removeAttribute('disabled');
	document.getElementById('jornada').removeAttribute('disabled');
	document.getElementById('ativo').removeAttribute('disabled');
	document.getElementById('gerente').removeAttribute('disabled');
	
	form_editar.submit();
}

</script>

</head>

<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <%

	 Dim matricula
	 Dim nome
	 Dim coordenacao
	 Dim cargo
	 Dim nascimento
	 Dim admissao
	 Dim jornada
	 Dim ativo
	 Dim gerente
	 Dim usuario
	 Dim imagem
 
	'usuario = request("f_matricula")
	'if usuario = "" then
	'	mat = Request.ServerVariables("LOGON_USER")
	'	
	'	i = InStr(mat,"\")
	'	If i > 0 Then
	'		dominio = UCase(Left(mat,i-1))
	'		usuario = UCase(Right(mat,Len(mat)-i))
	'	
	'	End If
	'end if				


	'set objConn = 	server.CreateObject("ADODB.Connection") 
	'dados_sys = 	"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
	'objConn.open dados_sys
%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->

<%
	'Chama a subrotina para verificar o perfil
	Perfil_Acesso("9")
%>
<!-- #INCLUDE FILE ="topo.asp" -->
<%

if not request.Cookies("perfil_acesso_siiag") then
	'response.Write("O seu perfil não permite o acesso a este módulo")
else

	arquivo = trim(request("arquivo"))
	arquivo_pasta = trim(request("arquivo_pasta"))
	if arquivo = "" then arquivo = request("f_arquivo_3") end if
	
	matricula = ucase(request("matricula"))
	if matricula = "" then
	matricula = trim(request("f_matricula"))
	end if
	if matricula = "" then
	matricula = request.Cookies("co_usuario_siiag")
	end if
	nome = request("nome")
	coordenacao = request("coordenacao")
	cargo = request("cargo")
	nascimento = request("nascimento")
	admissao = request("admissao")
	inicio = request("inicio")
	jornada = request("jornada")
	gerente = request("gerente")
	ativo  = request("ativo")
	'response.Write(gerente)
	co_unidade = request("co_unidade")
	'response.write ativo
	
	'RESPONSE.WRITE "CO_USUARIO:" & request.Cookies("co_usuario_siiag")
	'RESPONSE.WRITE "MATRICULA:" & matricula
	'RESPONSE.WRITE "ADMIN" & request.Cookies("usuario_admin_siiag")
	'RESPONSE.WRITE "IC_GERENTE:" & request.Cookies("ic_gerente_siiag")
	
	if  not (request.Cookies("perfil_acesso_admin_siiag") or request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = matricula ) then
		matricula = request.Cookies("co_usuario_siiag")
	end if
	
	if cStr(request("flg_salvar")) = "1" then
	
		dim ScriptObject
		Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
		pasta=Server.MapPath("./imagens/usuarios/temp/")
		pasta_destino = Server.MapPath("./imagens/usuarios/")
		'response.Write(pasta & "\" & imagem)
		'response.Write(pasta & "\" & matricula & right(imagem,4))
		
		if arquivo <> "" then
			imagem_gravar = matricula & right(arquivo,4)
			ScriptObject.CopyFile pasta & "\" & arquivo, pasta_destino & "\" & imagem_gravar , "true"
			ScriptObject.DeleteFile pasta & "\" & arquivo
		end if
		
		'response.Write(pasta & "\" & imagem)
		'response.Write(pasta & "\" & matricula & right(imagem,4))
		
		'FileSystemObjectName.CopyFile(source,destination[, overwrite])
		
		'response.Write("ativo" & ativo)
		if ativo = "on" then ativo_aux = 1 else ativo_aux = 0 end if
		if gerente = "on" then gerente_aux = 1 else gerente_aux = 0 end if
		
		
		strQuery = "select * from TB_USUARIOS where CO_MATRICULA='" & left(matricula,7) & "'; " 
		'response.write(strquery)
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys
		'response.Write(strQuery)
		if not rs.eof then
				if arquivo <> "" then
					sql= "UPDATE TB_USUARIOS "
					sql = sql & " SET NO_NOME = '" & nome & "', CO_CARGO = '" & cargo & "', DT_NASCIMENTO = '" & nascimento & "', NU_JORNADA = '" & left(jornada,1) & "', CO_GS = '" & coordenacao & "', IC_GERENTE = " & gerente_aux & ", IC_ATIVO = " & ativo_aux & ", DT_ADMISSAO = '" & admissao & "', DT_INICIO_GIFUG = '" & inicio & "', IM_FOTO = '" & imagem_gravar & "'  WHERE CO_MATRICULA='" & left(matricula,7) & "'"
				else
					sql= "UPDATE TB_USUARIOS "
					sql = sql & " SET NO_NOME = '" & nome & "', CO_CARGO = '" & cargo & "', DT_NASCIMENTO = '" & nascimento & "', NU_JORNADA = '" & left(jornada,1) & "', CO_GS = '" & coordenacao & "', IC_GERENTE = " & gerente_aux & ", IC_ATIVO = " & ativo_aux & ", DT_ADMISSAO = '" & admissao & "', DT_INICIO_GIFUG = '" & inicio & "' WHERE CO_MATRICULA='" & left(matricula,7) & "'"
				end if
				arquivo = ""
				'response.write sql
		end if
		Set rs2 = objConn.execute(sql)
		
		%>
		 <script type="text/javascript" language="javascript">
			alert("Alteração realizada com sucesso!");
		 </script>
		<%
		'response.Redirect "usuario.asp?f_matricula=" & matricula
	end if
	
	set rs =		Server.CreateObject("ADODB.RecordSet")
	if  not ( request.Cookies("perfil_acesso_admin_siiag") or request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = matricula ) then
		matricula = request.Cookies("co_usuario_siiag")
		strQuery = 		"select * from TB_USUARIOS where CO_MATRICULA='" & matricula & "' AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "'; " 
	elseif request.Cookies("ic_gerente_siiag") and not request.Cookies("perfil_acesso_admin_siiag") then
		strQuery = 		"select * from TB_USUARIOS where CO_MATRICULA='" & matricula & "' AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' AND CO_GS = '" & request.Cookies("co_usuario_gs_siiag") & "'; " 	
	else
		strQuery = 		"select * from TB_USUARIOS where CO_MATRICULA='" & matricula & "' AND CO_UNIDADE = '" & REQUEST.Cookies("co_usuario_unidade_siiag") & "' ; " 	
	end if
	'response.write "strQuery: " & strQuery
	rs.Open strQuery, dados_sys
	
	if not rs.eof then
		matricula =		rs("CO_MATRICULA")
		nome = 			rs("NO_NOME")
		coordenacao = rs("CO_GS")
		cargo = rs("CO_CARGO")
		nascimento = 	rs("DT_NASCIMENTO")
		admissao = 		rs("DT_ADMISSAO")
		inicio = 		rs("DT_INICIO_GIFUG")
		jornada = 		rs("NU_JORNADA")
		ativo = 		rs("IC_ATIVO")
		gerente = 		rs("IC_GERENTE")
		if arquivo <> "" then
			imagem = arquivo_pasta & arquivo
		else
			if not isnull(rs("IM_FOTO")) then
				imagem =  "imagens//usuarios//" & rs("IM_FOTO")
			end if
		end if
	else
		matricula = ""
		nome = 			""
		coordenacao = ""
		cargo = ""
		nascimento = 	""
		admissao = 		""
		inicio = 		""
		jornada = 		""
		ativo = 		""
		gerente = 		""
		imagem =  ""
	end if
	Set obj = New RegExp
	
	'response.write imagem
	nascimento = Left(Replace(nascimento, "-", "/"), 10)
	admissao = Left(Replace(admissao, "-", "/"), 10)
	inicio = Left(Replace(inicio, "-", "/"), 10)
end if
if request.Cookies("perfil_acesso_siiag") then
%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='usuario.asp'><span>Consultar</span></a></li>
			<%	if  request.Cookies("perfil_acesso_admin_siiag") or request.Cookies("ic_gerente_siiag") then %>
                          <li  ><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
            <% end if%>
			<%	if  request.Cookies("co_usuario_gs_siiag") = "7" then %>
                          <li  ><a href='usuario_lista_frequencia.asp'><span>Lista de Frequência</span></a></li>
            <% end if%>

            </ul>
          </div>
          </p>
			<div id="submenu" >
            <ul>
                <li> <a href=''><span>Ajuda</span></a></li>
            </ul>          
           </div>

          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Informações do Usu&aacute;rio</legend>
          <p class="paragrafoteste style2"> <span class="style4 style2">
			<form action="usuario.asp" method="post" name="form_editar" target="_self">
            <table border="0" width="100%">
            <tr>
                <td width="9%">
	            <label >Matr&iacute;cula: </label>
                </td>
             <td colspan="5">
				 <input class='form-field' name='matricula' id='matricula' type='text'  size='8' maxlength='7'  value= '<%=matricula %>' />
				 <input name='matricula_aux' id='matricula_aux' type='hidden'  size='8' maxlength='7' value= '<%=matricula %>' />
                </td>
                <td width="18%" rowspan="5"  align="center" valign="middle" >
				 <!-- <img style='border:#b9d3f0 solid 3px;'id='foto' src='imagens//usuarios//<% =matricula%>.png' /> -->
    			  <%IF imagem = "" then%>
	                  <img style='border:#b9d3f0 solid 3px;'id='foto' src='imagens//usuarios//X000000.png' />
				  <%else%>
    	              <img style='border:#b9d3f0 solid 3px;'id='foto' src='<% =imagem%>'  />
                  <%end if%>
                  <a href="#dialog" name="modal"><INPUT style="display:none" type="button" name="bt_editar_foto" id="bt_editar_foto" value="Editar foto"  class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" ></a>

              </td>
                
            </tr>
            <tr>
                <td>
	            <label >Nome: </label>
                </td>
				<td colspan="5">
	                <input class='form-field' name='nome' id='nome' type='text'  size='50' maxlength='100' value='<%= nome%>'  />
	                <input name='nome_aux' id='nome_aux' type='hidden'  size='50' maxlength='100' value='<%= nome%>'  />                    
				</td>
                
            </tr>
            <tr>
                <td>
	            <label >Coordena&ccedil;&atilde;o: </label>
                </td>
				<td colspan="5">
	              <!--  <input class='form-field' name='coordenacao' id='coordenacao' type='text'  size='50' maxlength='50' value='<%=coordenacao%>' readonly='readonly' /> -->
				<%ComboCoordenacao%>
				</td>
                
            </tr>

            <tr>
                <td>
	            <label >Cargo: </label>
                </td>
				<td colspan="5">
	            <!--   <input class='form-field' name='cargo' id='cargo' type='text'  size='30' maxlength='30' value='<% = cargo %>' readonly='readonly' />  -->
				   <%ComboCargo%>
				</td>
                
            </tr>
		  <%if request.Cookies("perfil_acesso_admin_siiag") or (request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = matricula ) then%>
            <tr>
                <td>
	            <label >Nascimento: </label>
                </td>
				<td width="10%" >
                  <input class='campo_bloqueado' name='nascimento' id='nascimento' type='text'  size='10' maxlength='10' value='<%=nascimento %>' disabled="disabled" OnKeyPress="return(FormatarData(this,event))"  onblur="return(ValidarData(this,this.value))"
                  />
			  </td>

                <td width="7%">
	            <label >Admissão: </label>
              </td>
				<td width="21%" >
                  <input class='campo_bloqueado' name='admissao' id='admissao' type='text'  size='10' maxlength='10'  value='<%= admissao %>' disabled="disabled" OnKeyPress="return(FormatarData(this,event))"  onblur="return(ValidarData(this,this.value))" />
			  </td>                
                <td width="12%">
	            <label >Início: </label>
              </td>
				<td width="23%" >
                  <input class='campo_bloqueado' name='inicio' id='inicio' type='text'  size='10' maxlength='10' value='<%= inicio %>' disabled="disabled" OnKeyPress="return(FormatarData(this,event))"  onblur="return(ValidarData(this,this.value))"/>
			  </td>
            </tr>
            <tr>
                <td>
	            <label >Jornada: </label>
                </td>
				<td width="10%"  colspan="6" >
                  <input class='campo_bloqueado' name='jornada' id='jornada' type='text'  size='1' maxlength='1' value='<% = jornada %>' disabled="disabled" />     <label >horas</label>
			  </td>

            </tr>
            <tr>
                <td>
	            <label >Ativo: </label>
                </td>
				<td width="10%"  colspan="1" >
				<% If ativo = "True" Then
                        response.Write "<input  type='checkbox' name='ativo'  id='ativo' checked='checked' disabled='disabled'/>"
                   else	  
                     response.Write "<input  type='checkbox' name='ativo'  id='ativo' disabled='disabled' />"
                   End if 
                %>
			  </td>
  
                <td align="left" colspan="2">
	            <label>Gerente ou Substituto:</label>
                </td>
				<td width="10%"  colspan="6" >
				<% If gerente = "True" Then
                        response.Write "<input type='checkbox' name='gerente'  id='gerente' checked ='checked' disabled='disabled'  />"
                        else
                        response.Write "<input type='checkbox' name='gerente'  id='gerente' disabled='disabled' />"
                
                        End if 
                %>
			  </td>
            </tr>
            <tr>
                <td colspan="7" align="center">
				<br>
                </td>
            </tr>
			<%end if%>
            <tr>
                <td colspan="7" align="center">
                <%if request.Cookies("perfil_acesso_admin_siiag") or (request.Cookies("ic_gerente_siiag") ) then%>
					<input type="button" name="bt_editar" id="bt_editar" value="Editar" class="myButton" onclick="return(editar())" />
					<input type="button" name="bt_salvar" id="bt_salvar" value="Salvar" class="myButton" style="display:none;" onclick="return(salvar())" />
				<%elseif request.Cookies("co_usuario_siiag") = matricula then %>
					<input type="button" name="bt_editar_2" id="bt_editar_2" value="Editar" class="myButton" onclick="return(editar_2())" />
					<input type="button" name="bt_salvar" id="bt_salvar" value="Salvar" class="myButton" style="display:none;" onclick="return(salvar())" />
				<%end if%>
                    <input type="hidden" name="flg_salvar" id="flg_salvar"  />
	                <input type="hidden" name = "f_arquivo_3" id="f_arquivo_3" value="<%=arquivo%>">
                </td>
                
            </tr>
			</form>
            </table>
            </span><span class="style4"><br />
            </span></p>
          <div>
          
          <DIV style="margin-left:0px;">
              <fieldset style="border:none;">
              <legend class="style3 style2" >Contatos</legend>

                <iframe name="frame_contaots" id="frame_contatos"  src="usuario_contatos.asp?usuario=<%=matricula%>"  frameborder="0"  width="450" height="135">
                </iframe>
    	      </fieldset>
           </DIV>


          <DIV style="margin-left:0px;">
              <fieldset style="border:none;">
              <legend class="style3 style2" >Perfis</legend>

                <iframe name="frame_contaots" id="frame_perfis"  src="usuario_perfis.asp?usuario=<%=matricula%>"  frameborder="0"  width="450" height="100">
                </iframe>
    	      </fieldset>
           </DIV>

          </fieldset>
        </div>
      </div>
    </div>
  </div>
  
  
    <div id="boxes">
        <div id="dialog" class="window" style="display:">
            <a href="#" class="close">fechar [X]</a><br />
            Selecione o arquivo com a imagem<br /> 
             <form name="form_upload"  id="form_upload"  action="usuario_upload_arquivo_editar.asp" method="POST" target="_self" onsubmit=""  ENCtype="multipart/form-data" >
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

      <!-- Máscara para cobrir a tela -->
      <div id="mask"></div>
        
   </div>
 <%
   else
 		response.write "<p align='center'><span style='color:#FFFFFF'>O seu perfil <b>" & request.Cookies("perfil_acesso_siiag_desc") & "</b> não permite o acesso a este módulo</span></p>"
   end if
 %>
  
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
<%
if arquivo <> "" then
%>
<script language="javascript" >
   editar();
</script>
<%
end if
%>

</body>
</html>
<%
Sub ComboCoordenacao()
%>
    <select name="coordenacao" id="coordenacao"  class="form-select" style=" width:340px;max-width:340px;min-width:340px;" tabindex="3" disabled="disabled" >

        <option value="">Selecione a Coordenação</option>
            <%
            Query3 ="select CO_GS, NO_GS from TB_GS WHERE IC_ATIVO = 1 ORDER BY NO_GS" 
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
    <select name="cargo" id="cargo"  class="form-select" style=" width:340px;max-width:340px;min-width:340px;" tabindex="3"  disabled="disabled">

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