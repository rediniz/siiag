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
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<script src="scripts/jquery-1.9.1.js"></script>
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

function Enviar_Arquivo()
{
	if( document.getElementById('matricula').value != '')
	{
		document.getElementById('f_matricula').value = document.getElementById('matricula').value
		document.getElementById('f_upload').value = '1';
		document.getElementById('form_upload').submit();
	}
	else
	{
		alert('Digite a matricula do usuário a ser cadastrado.');
		document.getElementById('matricula').focus();
	}


}


$(document).ready(function() {	

	$('#EnviarArquivo').click(function(){
		
		 $('#arquivo1').trigger('click');

		 if ($('#arquivo1').val() != '')
		 {
			if ($('#matricula').val() != '')
			{
				$('#f_matricula').val($('#matricula').val());
				$('#f_upload').val('1');				
				$('#form_upload').submit;
			}
			else
			{ alert('Digite a matricula do usuário a ser cadastrado.');
				$('#matricula').focus();	
			}

		 }
		 
	});

	$('a[name=modal]').click(function(e) {
		e.preventDefault();
		
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
<!-- #INCLUDE FILE ="conexao.asp" -->
<%
imagem = request("arquivo")
response.Write("imagem" & imagem)


if cStr(request("f_salvar")) = "1" then
	matricula = request("f_matricula")
	nome = request("f_nome")
	coordenacao = request("f_coordenacao")
	cargo = request("f_cargo")
	nascimento = request("f_nascimento")
	admissao = request("f_admissao")
	inicio = request("f_inicio")
	jornada = request("f_jornada")
	
	strQuery = 		"select * from TB_USUARIOS where CO_MATRICULA='" & left(matricula,7) & "'; " 
	set rs =		Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys
	response.Write(strQuery)
	if rs.eof then
		response.Write("Vai incluir")
		sql= "INSERT INTO TB_USUARIOS (CO_MATRICULA, CO_DIGITO, NO_NOME, CO_CARGO, NU_JORNADA, IC_GERENTE, IC_ATIVO, CO_GS, DT_ADMISSAO, DT_INICIO_GIFUG)"
		sql = sql & " VALUES ('" & matricula & "','0', '" & nome & "') "
	else

	end if
	
end if




%>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='usuario.asp'><span>Consultar</span></a></li>
              <li class='active'><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Informações do Usu&aacute;rio</legend>
          <p/>
          <form name="form_salvar" action="usuario_cadastrar.asp" method="post">
          <table border="0" width="100%">
            <tr>
                <td width="9%">
	            <label >Matr&iacute;cula: </label>
                </td>
	             <td colspan="5">
					 <input class='form-field' name='f_matricula' id='f_matricula' type='text'  size='8' maxlength='100'  value= '<%=matricula%>' tabindex="1" />
                 </td>
                <td width="18%" rowspan="5"  align="center" valign="middle" >
                <%if imagem = "" then%>
					  <img style='border:#b9d3f0 solid 3px;'id='foto' src='imagens//usuarios//X000000.png' />
                      <br>
                <%else%>
					  <img style='border:#b9d3f0 solid 3px;'id='foto' width="103" height="128" src='imagens//usuarios//temp//<%=imagem%>' />
                      <br>
                <%end if%>
<!--<INPUT type="button" value="Adicionar foto" name="EnviarArquivo"  id="EnviarArquivo" class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" > -->
<a href="#dialog" name="modal"><INPUT type="button"   value="Adicionar foto"  class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" ></a>
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
	                <input class='form-field' name='f_coordenacao' id='f_coordenacao' type='text'  size='50' maxlength='50' value='<%=coordenacao%>'  tabindex="3" />
				</td>
                
            </tr>

            <tr>
                <td>
	            <label >Cargo: </label>
                </td>
				<td colspan="5">
	               <input class='form-field' name='f_cargo' id='f_cargo' type='text'  size='30' maxlength='30' value='<%=cargo%>'  tabindex="4" /> 
				</td>
                
            </tr>
            <tr>
                <td>
	            <label >Nascimento: </label>
                </td>
				<td width="10%" >
                  <input class='form-field' name='f_nascimento' id='f_nascimento' type='text'  size='8' maxlength='10' value='<%=nascimento%>'  tabindex="5" />
			  </td>

                <td width="7%">
	            <label >Admissão: </label>
              </td>
				<td width="21%" >
                  <input class='form-field' name='f_admissao' id='f_admissao' type='text'  size='8' maxlength='10'  value='<%=admissao%>'  tabindex="6" />
			  </td>                
                <td width="12%">
	            <label >Início: </label>
              </td>
				<td width="23%" >
                  <input class='form-field' name='f_inicio' id='f_inicio' type='text'  size='8' maxlength='10' value='<%=inicio%>'  tabindex="7" />
			  </td>
            </tr>
            <tr>
                <td>
	            <label >Jornada: </label>
                </td>
				<td width="10%"  colspan="6" >
                  <input class='form-field' name='f_jornada' id='f_jornada' type='text'  size='8' maxlength='10' value='<%=jornada%>'  tabindex="8" />
			  </td>

            </tr>
            <tr>
                <td>
	            <label >Ativo: </label>
                </td>
				<td width="10%"  colspan="6" >
				<% If request("ativo")= "True" or ativo = "True" Then
                        response.Write "<input  type='checkbox' name='ativo' value='ativo' id='ativo' checked='checked' disabled='disabled' tabindex='9'/>"
                   else	  
						response.Write "<input  type='checkbox' name='ativo' value='ativo' id='ativo' disabled='disabled'  tabindex='9' />"
                   End if 
                %>
			  </td>
            </tr>
            <tr>
                <td align="left" colspan="2">
	            <label>Gerente ou Substituto:</label>
                </td>
				<td width="10%"  colspan="6" >
				<% If request("gerente") = "True" or gerente = "True" Then
                        response.Write "<input type='checkbox' name='gerente' value='gerenteousubstituto' id='gerente' checked ='checked' disabled='disabled' tabindex='10' />"
                        else
                        response.Write "<input type='checkbox' name='gerente' value='gerenteousubstituto' id='gerente' disabled='disabled' tabindex='11' />"
                
                        End if 
                %>
			  </td>
            </tr>
            <tr>
                <td align="center" colspan="7">
	            <INPUT type="button" value="Salvar" class="myButton" style="padding:3px; font-size:13px; height:25px; width:108px;" tabindex="12" onclick="f_salvar.value = '1'; form_salvar.submit();">
                <input type="text" name = "f_salvar" id="f_salvar">
                </td>
            </tr>
            </table>
            </form>
          </fieldset>
        </div>
      </div>
      <!-- #INCLUDE FILE ="calendario.asp" -->
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
         <form name="form_upload"  id="form_upload"  action="usuario_upload_arquivo.asp" method="POST" target="_self" ENCtype="multipart/form-data" >
          <input type="file" class = "arquivo" id="arquivo1" name="arquivo1" style="display:'';"/> 
          <input type="text" value="" name="f_arquivo" id="f_arquivo"/>
          <input type="text" value="" name="f_matricula" id="f_matricula"/>
          <input type="text" value="" name="f_upload" id="f_upload"/>
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
<!--teste-->


</body>
</html>
