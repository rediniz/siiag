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

<script type="text/javascript" language="javascript">
                     
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
						$("#jornada").val(retorno[7] + " horas");	
						
						if (retorno[8] == "True") {
						$("#ativo").attr("checked", "checked");						
						}
						if (retorno[9] == "True") {
						$("#gerente").attr("checked", "checked");					
						} else{
						$("#gerente").removeAttr("checked");	
						}
						
						if(retorno[10] == ""){
						$("#foto").attr("src", "imagens//X000000.png");
						} else {				
						$("#foto").attr("src", "imagens//usuarios//" + retorno[1] + ".png");
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
</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
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
 
 mat = Request.ServerVariables("LOGON_USER")
		
				i = InStr(mat,"\")
				If i > 0 Then
					dominio = UCase(Left(mat,i-1))
					usuario = UCase(Right(mat,Len(mat)-i))
			
				End If
					
strQuery = 		"select * from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
set objConn = 	server.CreateObject("ADODB.Connection") 
dados_sys = 	"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs =		Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

matricula =		rs("CO_MATRICULA")
nome = 			rs("NO_NOME")

			Select case rs("CO_GS")
			
   						Case 0  coordenacao = "GIFUG/FO"	 					  
						Case 1  coordenacao = "Arrecadação e Repasse"					
					    Case 2  coordenacao = "Recuperação de Crédito"  		  
						Case 3  coordenacao = "Cadastro"
					    Case 4  coordenacao = "Pagamento" 					 
						Case 5  coordenacao = "Aplicação"
						Case 6  coordenacao = "Informações e Apoio à Gestão"	  
						Case 7  coordenacao = "Gerência"
						Case 8  coordenacao = "Ações Judiciais"				  
						Case 9  coordenacao = "Monitoramento e Avaliação da Gestão"
						Case 10 coordenacao = "Manutenção" 					  
						Case 13 coordenacao = "@GS Padrão"	
						Case 16 coordenacao = "Relacionamento com Clientes"   
						Case 17 coordenacao = "CGP"

                        Case else coordenacao = ""
						
			End Select

			Select case rs("CO_CARGO")
			
   						Case 1  cargo = "Gerente de Filial" 		
						Case 2  cargo = "Coordenador"
						Case 3  cargo = "Administrador"	   		
						Case 4  cargo = "Assistente Senior"	
						Case 5  cargo = "Assistente Pleno"  		
						Case 6  cargo = "Assistente Junior"	
						Case 7  cargo = "Auxiliar Operacional"	
						Case 8  cargo = "Técnico Bancário Novo"
						Case 9  cargo = "Escriturário"			
						Case 10 cargo = "Auxiliar de Serviços Gerais"
						Case 11 cargo = "Estagiário"            
						Case 12 cargo = "Secretário Executivo"
						Case 13 cargo = "Adolescente Aprendiz"  
						Case 14 cargo = "Terceirizado(a)"
						Case else cargo = ""
							
			End Select	

nascimento = 	rs("DT_NASCIMENTO")
admissao = 		rs("DT_ADMISSAO")
inicio = 		rs("DT_INICIO_GIFUG")
jornada = 		rs("NU_JORNADA")
ativo = 		rs("IC_ATIVO")
gerente = 		rs("IC_GERENTE")
imagem = 		rs("IM_FOTO")

Set obj = New RegExp

nascimento = Left(Replace(nascimento, "-", "/"), 10)
admissao = Left(Replace(admissao, "-", "/"), 10)
inicio = Left(Replace(inicio, "-", "/"), 10)

%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='usuario.asp'><span>Visualização</span></a></li>
              <li  ><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Informações do Usu&aacute;rio</legend>
          <p class="paragrafoteste style2"> <span class="style4 style2">
            <% response.Write "<div class='img_usuario'><img style='border:#b9d3f0 solid 2px;'id='foto' src='imagens//usuarios//" & matricula & ".png' /></div>" %>
            <label >Matr&iacute;cula: </label>
<%
	
    response.write "<input class='form-field' name='matricula' id='matricula' type='text'  size='10' maxlength='100'  value= '" &  matricula & "' />"
%>
            <br/>
            <br/>
            <label >Nome: </label>
<%
    response.write "<input class='form-field' name='nome' id='nome' type='text'  size='54' maxlength='100' value='" & nome &"'  />"
%>
            <br/>
            <br/>
            <label > Coordena&ccedil;&atilde;o: </label>
<%
    response.write "<input class='form-field' name='coordenacao' id='coordenacao' type='text'  size='50' maxlength='50' value='" &    coordenacao & "' readonly='readonly' />"
%>
            <br/>
            <br/>
            <label >Cargo: </label>
<%
    response.write "<input class='form-field' name='cargo' id='cargo' type='text'  size='30' maxlength='30' value='" & cargo & "' readonly='readonly' /> " %>
            <br/>
            <br/>
            <label >Nascimento: </label>
<%
    response.write "<input class='form-field' name='nascimento' id='nascimento' type='text'  size='8' maxlength='8' value='" & nascimento & "' readonly='readonly' />" %>
            <br/>
            <br/>
            <label >Admissão: </label>
<%
        response.write "<input class='form-field' name='admissao' id='admissao' type='text'  size='10' maxlength='10'  value='" & admissao & "' readonly='readonly' />" %>
            <label>Início: </label>
            <% response.write "<input class='form-field' name='inicio' id='inicio' type='text'  size='10' maxlength='10' value='" & inicio &"' readonly='readonly' />" %>
            <br/>
            <br/>
            <label >Jornada:</label>
            <% response.write  "<input class='form-field' name='jornada' id='jornada' type='text'  size='10' maxlength='10' value='" & jornada & " horas' readonly='readonly' />" %>
            </span>
          <p> <span >
            <label style="float:left; "> Ativo:</label>
<% If ativo = "True" Then
        response.Write "<input  type='checkbox' name='ativo' value='ativo' id='ativo' checked='checked' disabled='disabled'/>"
	  else	  
	 response.Write "<input  type='checkbox' name='ativo' value='ativo' id='ativo' disabled='disabled' />"
	  End if 
%>
            <br/>
            <label for="gerente" style="text-align:right;">Gerente ou Substituto:</label>
<% If gerente = "True" Then
        response.Write "<input type='checkbox' name='gerente' value='gerenteousubstituto' id='gerente' checked ='checked' disabled='disabled'  />"
		else
		response.Write "<input type='checkbox' name='gerente' value='gerenteousubstituto' id='gerente' disabled='disabled' />"

		End if 
		
%>
            </span><span class="style4"><br />
            </span></p>
          <div>
          <fieldset style="border:none;">
          <div id='submenu'>
            <ul>
              <li> <a href='usuario.asp?aba=contatos#bottom'><span>Contatos</span></a></li>
              <li> <a href='usuario.asp?aba=perfis#bottom'><span>Perfis</span></a></li>
            </ul>
            
<% 

	aba=Request("aba")
	SELECT CASE aba
		CASE "contatos"
%>

            <!-- #INCLUDE FILE ="usuario_contatos.asp" -->

<%
		CASE "perfis"

%>
            <!-- #INCLUDE FILE ="usuario_perfis.asp" -->

<%
		
	END SELECT

%>
            <p/>
            <a name="bottom" id="bottom"></a> </div>
          </fieldset>
          </p>
          </fieldset>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
