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
 
	usuario = request("f_matricula")
	if usuario = "" then
		mat = Request.ServerVariables("LOGON_USER")
		
		i = InStr(mat,"\")
		If i > 0 Then
			dominio = UCase(Left(mat,i-1))
			usuario = UCase(Right(mat,Len(mat)-i))
		
		End If
	end if				


	'set objConn = 	server.CreateObject("ADODB.Connection") 
	'dados_sys = 	"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
	'objConn.open dados_sys
%>
<!-- #INCLUDE FILE ="conexao.asp" -->
<%	set rs =		Server.CreateObject("ADODB.RecordSet")
	strQuery = 		"select * from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
	rs.Open strQuery, dados_sys
	
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
              <li class='active'><a href='usuario.asp'><span>Consultar</span></a></li>
              <li  ><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Informações do Usu&aacute;rio</legend>
          <p class="paragrafoteste style2"> <span class="style4 style2">
            <table border="0" width="100%">
            <tr>
                <td width="9%">
	            <label >Matr&iacute;cula: </label>
                </td>
             <td colspan="5">
				 <input class='form-field' name='matricula' id='matricula' type='text'  size='8' maxlength='7'  value= '<%=matricula %>' />
                </td>
                <td width="18%" rowspan="5"  align="center" valign="middle" >
				 <!-- <img style='border:#b9d3f0 solid 3px;'id='foto' src='imagens//usuarios//<% =matricula%>.png' /> -->
    			  <img style='border:#b9d3f0 solid 3px;'id='foto' src='imagens//usuarios//<% =rs("IM_FOTO")%>' />
              </td>
                
            </tr>
            <tr>
                <td>
	            <label >Nome: </label>
                </td>
				<td colspan="5">
	                <input class='form-field' name='nome' id='nome' type='text'  size='50' maxlength='100' value='<%= nome%>'  />
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
            <tr>
                <td>
	            <label >Nascimento: </label>
                </td>
				<td width="10%" >
                  <input class='form-field' name='nascimento' id='nascimento' type='text'  size='8' maxlength='10' value='<%=nascimento %>' readonly='readonly' />
			  </td>

                <td width="7%">
	            <label >Admissão: </label>
              </td>
				<td width="21%" >
                  <input class='form-field' name='admissao' id='admissao' type='text'  size='8' maxlength='10'  value='<%= admissao %>' readonly='readonly' />
			  </td>                
                <td width="12%">
	            <label >Início: </label>
              </td>
				<td width="23%" >
                  <input class='form-field' name='inicio' id='inicio' type='text'  size='8' maxlength='10' value='<%= inicio %>' readonly='readonly' />
			  </td>
            </tr>
            <tr>
                <td>
	            <label >Jornada: </label>
                </td>
				<td width="10%"  colspan="6" >
                  <input class='form-field' name='jornada' id='jornada' type='text'  size='8' maxlength='10' value='<% = jornada %>" horas' readonly='readonly' />
			  </td>

            </tr>
            <tr>
                <td>
	            <label >Ativo: </label>
                </td>
				<td width="10%"  colspan="1" >
				<% If ativo = "True" Then
                        response.Write "<input  type='checkbox' name='ativo' value='ativo' id='ativo' checked='checked' disabled='disabled'/>"
                      else	  
                     response.Write "<input  type='checkbox' name='ativo' value='ativo' id='ativo' disabled='disabled' />"
                      End if 
                %>
			  </td>
                <td align="left" colspan="2">
	            <label>Gerente ou Substituto:</label>
                </td>
				<td width="10%"  colspan="6" >
				<% If gerente = "True" Then
                        response.Write "<input type='checkbox' name='gerente' value='gerenteousubstituto' id='gerente' checked ='checked' disabled='disabled'  />"
                        else
                        response.Write "<input type='checkbox' name='gerente' value='gerenteousubstituto' id='gerente' disabled='disabled' />"
                
                        End if 
                %>
			  </td>
            </tr>
            </table>
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