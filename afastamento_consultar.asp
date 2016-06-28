<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Afastamentos</title>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">

<!--favicon -->
<style>
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}

</style>
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

.ui-autocomplete {

	height:120px;
	overflow-y:scroll;
	overflow-x:hidden;
	font-size:12px;
}
.ui-widget {
	font-family: Arial, sans-serif;
	font-size: 0.8em;
}

</style>

<script>
$(document).ready(function() {
	
$('.cancelar').on("click", function(){
	$("#divCancelamento" ).dialog({
		modal: true,
		dialogClass: "dialogo",
		closeText: "Fechar",
		width:'auto'
	});
	$("#codigoCancelamento").val($(this).parent().parent().find("#codigo").html());
	$("#divCancelamento").dialog("open");
});

$('#botaoCancelar').on("click", function(){
	if(window.confirm("Confirmar pedido de cancelamento?")){
		var codigo = $("#codigoCancelamento").val(),
			motivo = $("#motivoCancelamento").val();
		
		if(motivo == ""){
			alert("Informe o motivo do cancelamento.");
			return false;
		}
		
		$.ajax({
			url: "cancelar_demanda.asp",
			data:{
				tipo:"afastamento",
				codigo:codigo,
				motivo:motivo
			},
			success: function(data) {
				alert("Solicitação de cancelamento concluída com sucesso.");
			},
			error: function(data) {
				console.log(data.responseText);
				alert("Erro ao solicitar cancelamento.");
			}
		});
	}
});

$('.edit').on('click',function(){

								
			var co_afastamento = $(this).parent().parent().find("#codigo").html()
			var co_situacao = $(this).parent().parent().find("#co_situacao").val();
			//alert(co_situacao);
			/*alert(matricula + nome + data+descricao+dtcriacao+empregadosolicitante+dias);*/
			//perfil_coordenador
			
			if (($("#perfil_coordenador").val()=="False" || co_situacao != "1"    ) && ($("#perfil_afastamento_admin").val() == "False")   ){
				alert("Você não tem permissão para editar.");
				return false;
			}

			var top = (window.innerHeight / 2)-100
			var left = (window.innerWidth / 2)-280
			
			//#ALTERADO EM 11/04/2014(height passou de 450 para 500)
			window.open("afastamento_edicao.asp?co_afastamento="+co_afastamento, "Editar Afastamento", "height=500, width=460, scrollbars=yes, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
						
	});
	});
	
	
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

</head>
<% 
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2

	sit = Request("situacao")
	matricula = Request("nome")
	data_de = Request("data_inicio")
	data_a = Request("data_final")
	'#EDITADO em 16/06/2016
	'if(sit = "" and matricula = "" and data_de = "" and data_a = "")  then sit = "1" end if

	'Response.Write data_de
	'Response.Write data_a

	Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

%>

<body>
<%
	Perfil_Acesso("14") 
	
	if perfil_acesso_admin_siiag  then
		consultaTodos = true
	elseif Tem_Acesso_cookie("3")  then  'tem acesso a afastamento solicitar ( quem pode solicitar pode consultar todos de sua coordenacao)
		consultaGS = true
		consultaTodos = false
	else
		consultaGS = false
		consultaTodos = false
	end if
	
	response.write "<input type='hidden' id = 'perfil_afastamento_consultar' value=" & perfil_acesso_siiag & ">"
	response.write "<input type='hidden' id = 'perfil_coordenador' value=" & consultaGS  & ">"
	response.write "<input type='hidden' id = 'perfil_afastamento_admin' value=" & perfil_acesso_admin_siiag  & ">"
	response.write "<input type='hidden' id = 'co_gs_usuario' value=" & request.Cookies("co_usuario_gs_siiag")  & ">"	
  
%>
<div class="teste2">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <!-- #INCLUDE FILE ="include/Conexao.asp" -->
 <%

	Dim campos(7)
	
	SQL = "SELECT * FROM [TB_AFASTAMENTOS] AS afast"
	SQL = SQL + " INNER JOIN [VW_USUARIOS] AS usuarios "
	SQL = SQL + " ON usuarios.CO_MATRICULA = afast.CO_MATRICULA AND IC_ATIVO = '1'"
	SQL = SQL + " INNER JOIN [TB_SITUACOES] AS sit ON afast.CO_SITUACAO = sit.CO_SITUACAO"
	SQL = SQL + " INNER JOIN [TB_TIPOS_AFASTAMENTO] AS t_afast "
	SQL = SQL + " ON afast.CO_TIPO_AFASTAMENTO = t_afast.CO_TIPO_AFASTAMENTO "
	
	cont = 0
	
	if(sit <> "" and sit <> "0") then
		cont = cont + 1
		campos(cont) = " (afast.CO_SITUACAO = '" & sit & "')"
	end if

	if(matricula <> "") then
		cont = cont + 1
		campos(cont) = " (afast.CO_MATRICULA = '" & matricula & "')"
	end if

	if(data_de <> "" and data_a <> "") then
		cont = cont + 1
		campos(cont) = " (DT_INICIO >= '" & data_de & "' AND DT_FIM <= '"& data_a &"')"
	end if
	
	if consultaGS then
		cont = cont + 1
		campos(cont) = " (USUARIOS.CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') "	
	elseif consultaTodos = "False" then
		cont = cont + 1
		campos(cont) = " USUARIOS.CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' "
	end if
	
	cont = cont + 1
	campos(cont) = " (afast.CO_UNIDADE = " & request.Cookies("co_usuario_unidade_siiag") & ")"
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  campos(i)
			j=1
	   Else
			Query = Query & " and " & campos(i)
	   End If
	Next
	SQL = SQL & Query
	SQL = SQL & " ORDER BY CO_AFASTAMENTO DESC"
	
	set rs_princ=Server.CreateObject("ADODB.RecordSet")
	rs_princ.Open SQL, dados_sys, 3, , 32
	
	'Response.Write SQL
 
 %>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
      <div class="titulosModulos" ><span >AFASTAMENTOS</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
             <%			
			if not perfil_acesso_siiag then
				response.write "Você não possui acesso a este módulo"
				response.End()
			end if	
			
			
			if tem_acesso("3") then
				response.write "<li ><a href='afastamento.asp'><span>Solicitar</span></a></li>"
			end if
			response.write "<li class='active'><a href='afastamento_consultar.asp'><span>Consultar</span></a></li>"			  

			 %>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <!--<li><a href='#'><span>Ajuda</span></a></li>-->
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; min-height:430px;" >
          <legend ><span class="titulos" >Consultar Afastamento</span></legend>
          
		  <form action="afastamento_consultar.asp" method="get" target="_self">
          <table border="0" width="100%">
          <tr>
           <!--#ALTERADO EM 16/06/2016-->
          <td  width="5%"><label for="situacao" >Situação: </label>
          
          <select name="situacao" id='situacao' class='form-select'  >
          <option value="0">Todas</option>
<%
			strQuery = "select CO_SITUACAO, DE_SITUACAO from TB_SITUACOES ORDER BY CO_SITUACAO" 'Selecionando o campo descricao do recurso da tabela tipos_recursos 
			set Ls=Server.CreateObject("ADODB.RecordSet")
			Ls.Open strQuery, dados_sys
				
			DO UNTIL Ls.eof 'ate o final do campo, ou seja, passando por todos os valor existentes
				response.write "<option value="& Ls("CO_SITUACAO") &" "
				if cstr(sit) = cstr(Ls("CO_SITUACAO")) then response.write " selected='selected' " end if
				response.write " >"& Ls("DE_SITUACAO") &"</option>" 'imprimindo
				Ls.movenext 'passando para o proximo elemento da tabela
			LOOP
%>

            </select></td>
           <!--#ALTERADO EM 16/06/2016-->
          <td  width="5%"><label>Nome:</label>
          <select name="nome" class="form-select" >
          	<option value="">Todos</option>
            
            
          <%	
			SQL = "SELECT NO_NOME, CO_MATRICULA FROM [VW_USUARIOS] WHERE IC_ATIVO = '1' "
			SQL = SQL + " AND CO_MATRICULA <> '' AND LETRA ='C' "
			if consultaGS then
				SQL = SQL + " and (CO_GS='" & request.Cookies("co_usuario_gs_siiag") & "') "	
			elseif consultaTodos = "False" then
				SQL = SQL + " and CO_MATRICULA='" & request.Cookies("co_usuario_siiag") & "' "
			end if
			SQL = SQL + " and co_unidade = "& request.Cookies("co_usuario_unidade_siiag")&" ORDER BY NO_NOME"

			
			set rs=Server.CreateObject("ADODB.RecordSet")
			rs.Open SQL, dados_sys, 3, , 32
			
			do while(rs.eof = false)
				
				nome = rs("NO_NOME")
				response.Write "<option " 
				if matricula = rs("CO_MATRICULA")  Then response.Write "selected='selected'" END IF
				response.Write " value='"& rs("CO_MATRICULA") &"'>" & ucase(nome) & "</option>"
				rs.MoveNext
				
			loop
		  %>
          </select></td>
          <!--#ALTERADO EM 16/06/2016-->
          <td style="vertical-align:bottom"><label >De: </label>
         <input <% if data_de <> "" Then Response.Write "value= '"&data_de&"' " End If %>name="data_inicio" type="text" size="8" maxlength="10"  id="data_inicio" class="datepicker"/>
          <label> até </label>
          <input <% if data_a <> "" Then Response.Write "value= '"&data_a&"' " End If %>name="data_final" type="text" size="8" maxlength="10"  id="data_final" class="datepicker" /></td>     
          <!--#ALTERADO EM 16/06/2016-->
          <td style="vertical-align:bottom"><input type="submit" class='myButton' name="btnPesquisar" id="btnPesquisar" value="Pesquisar" style="margin-left:6px"/></td>
          </tr>
          </table>
</form>
          </legend>
          <p></p>
          <div class="tabela" >
             <table>
              <tr>
                <td width="10%"> Código </td>
                <td width="35%"> Empregado </td>
                <td width="21%"> Tipo </td>
                <td width="12%"> Data Início </td>
                <td width="11%"> Data Fim </td>
                <td width="11%"> Situação </td>
                <td width="20%"> Observação </td>
                <td width="11%"> Documento </td>
                <td width="11%"> Editar </td>
				<td></td>

              </tr>
              <% 
				  	if(rs_princ.eof) then
						Response.Write "<br><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
				  	else
						rs_princ.AbsolutePage = pag
						'do while(rs_princ.eof = false)
						do while (not rs_princ.eof and Abs(rs_princ.AbsolutePage - pag) < numPag )
							afastamento = rs_princ("CO_AFASTAMENTO")
							matricula = rs_princ("CO_MATRICULA")
							usuario =  rs_princ("NO_NOME")
							digito = rs_princ("CO_DIGITO") 
							tipo = rs_princ("DE_TIPO_AFASTAMENTO")
							cod_afast = rs_princ("CO_CAIXA")
							data_inicio = rs_princ("DT_INICIO")
							data_fim = rs_princ("DT_FIM")
							situacao = rs_princ("DE_SITUACAO")
							co_situacao = rs_princ("co_SITUACAO")
							co_gs = rs_princ("co_gs")	
							obs = rs_princ("OBS_EDICAO")	
							ic_cancelamento = rs_princ("ic_cancelamento")	
							
							if(matricula = request.Cookies("co_usuario_siiag")) then
								podeCancelar = true
							else
								podeCancelar = false
							end if
							
							
							set ds=Server.CreateObject("ADODB.RecordSet")
												
							sqlDocumento = "SELECT * FROM TB_AFASTAMENTOS_DOCUMENTOS WHERE CO_AFASTAMENTO = " & afastamento
							
							ds.Open sqlDocumento, dados_sys, 3, , 32	
													
							response.Write "<tr>"
							response.Write "<td id='codigo' name='codigo'>" & afastamento & "</td>"
							response.Write "<td style='text-align:left;'>" & matricula & "-" & digito  & " - " & usuario & "</td>"
							response.Write "<td>" & tipo &  " - "&cod_afast &"</td>"
							response.Write "<td>" & data_inicio &  "</td>"
							response.Write "<td><input type='hidden' id='co_gs' name='co_gs' value='" & co_gs & "'>" & data_fim &  "</td>"
							response.Write "<td><input type='hidden' id='co_situacao' name='co_situacao' value='" & co_situacao & "'> " & situacao &  "</td>"
							response.Write "<td  id='obs'>" & obs &  "</td>"
							
							if not ds.eof then
								idDocumento = ds("id")
								caminhoDocumento = ds("caminho")
								
								visualizaArquivo = false
								perfilVisualizar = false	
								chefiaDireta = false	
								
								queryPerfil = "SELECT CO_PERFIL FROM VW_USUARIOS_PERFIS WHERE CO_MATRICULA = '" & Session("v_Usuario_Matricula") & "' AND CO_PERFIL IN (1, 2, 7)"
								set perfilRs = Server.CreateObject("ADODB.RecordSet")
								perfilRs.Open queryPerfil, dados_sys
								
								if not perfilRs.eof then
									perfilVisualizar = true
								end if
								
								perfilRs.close
								
								queryCoordenador= "SELECT * FROM TB_USUARIOS A, VW_GS B WHERE A.CO_GS = B.CO_GS AND (CO_MATRICULA = '" & matricula & "' AND CO_GERENTE = '" & Session("v_Usuario_Matricula") & "')"
								set coordenadorRs = Server.CreateObject("ADODB.RecordSet")
								coordenadorRs.Open queryCoordenador, dados_sys
								
								if not coordenadorRs.eof then
									chefiaDireta = true
								end if
								
								coordenadorRs.close
								
								if perfilVisualizar or chefiaDireta or Session("v_Usuario_Matricula") = matricula then
									visualizaArquivo = true
								end if

								if visualizaArquivo then
									link = Replace(caminhoDocumento, "/", "\")
									response.Write "<td><a href='" & link & "'  target='_blank'><img class='documento' id='doc' src='imagens/adobe_16x16.png' style='cursor:pointer;'></a></td>"							
								else
									response.Write "<td><img class='documento' id='doc' src='imagens/adobe_16x16.png'></td>"
								end if
								
								
							else
								response.write "<td></td>"
							end if
							
							response.write "<td width='10%'><img class='edit' id='edit'  src='imagens/edit.png' style='cursor:pointer; width:16px; height:16px'></td>"	
				
							if podeCancelar = true and rs_princ("co_situacao") = 2 then
								%><td width='10%'><img class='cancelar' id='cancelar'  src='imagens/delete_16x16.png' style='cursor:pointer; width:16px; height:16px'></td><%						else
								%><td></td><%
							end if
							response.Write "</tr>"
							rs_princ.MoveNext	
						loop
						Controla_Pagina()
					end if
			  %>
            </table>
            
          </div>
          </fieldset>
        </div>
      </div>
    </div>
  </div>
  <%
  objConn.Close
  %>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
<div id="divCancelamento" class="msg-dialog" style="display:none;" title="Cancelar">
	<input type="hidden" id="codigoCancelamento"/>
    <label>Motivo do cancelamento:</label><br />
    <textarea  class="form-field" name="motivoCancelamento" id="motivoCancelamento" cols="50" rows="5" style="max-width:405px;min-width:405px;max-height:70px;min-height:70px; margin-left:5px"></textarea><br />
    <input  style="margin-top:7px;margin-left:5px;" name="botaoCancelar" id="botaoCancelar" class="myButton" type="button" value="Cancelar"/>
</div>
</body>
</html>

<%
		Sub Writeln(texto)
		response.write(texto)
	End Sub
	
	Sub Controla_Pagina()
	
		 '****CONTROLE DE PÁGINA
		  'response.Write(" Pag: " & Pag)
		  Dim Ult
		  rs_princ.MoveLast
		  rs_princ.MoveFirst
		  Ult = rs_princ.PageCount
		  'response.Write(" Pag: " & Pag)
		  'response.Write(" ultima pagina:" & Ult)
		  If (Pag < 1)   Then Pag = 1
		  If (Pag > Ult) Then Pag = Ult
	
		  WriteLn "	<table style='' >"
		  WriteLn "		<tr valign=middle>"
		  WriteLn "		<td>"
		  Response.Write "<input type='button' class='myButton'"
		  If (Pag <= numPag) Then Response.Write " disabled "
		  Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(1), "") & """);' value='&lt;&lt;'>"
	
				
		  Response.Write "<input type='button' class='myButton'"
		  If (Pag <= numPag) Then Response.Write " disabled "
		  Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(Pag - numPag), "") & """);' value='&lt;'>"
				
		  WriteLn "		</td>"
		  WriteLn "		<td>"
		  Response.Write "p&aacute;gina"
		  WriteLn "		</td>"
		  WriteLn "		<td>"
		  Response.Write "<input size=3 type='text' value='" & CStr(Round(Pag / numPag + 0.5, 0)) & "' onKeyPress='JavaScript:if(window.event.keyCode==13)window.navigate(""?" &  rsSubst(tagPag, """ + (1 + (this.value - 1) * " & numPag & ") + """, "") & """);'>"
		  WriteLn "		</td>"
		  WriteLn "		<td>"
		  if Ult = numPag then
			 Response.Write "de&nbsp;" & Ult/numPag & Chr(13)
		  else
			  Response.Write "de&nbsp;" & CStr(Round(Ult / numPag + 0.5, 0)) & Chr(13)
		  end if
		  WriteLn "		</td>"
		  WriteLn "		<td>"
	
		  'response.write Cpf
		  Response.Write "<input type='button' class='myButton'"
		  If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
		  Response.Write "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, CStr(Pag + numPag), "") & """);' value='&gt;' >"
	
	
		  
		  Response.Write "<input type='button' class='myButton'"
		  If ((Pag + numPag - 1) >= Ult) Then Response.Write " disabled "
		  WriteLn "onClick='JavaScript:window.navigate(""?" & rsSubst(tagPag, 1 + (CStr(Round(Ult / numPag + 0.5, 0))-1)*numPag, "") & """);' value='&gt;&gt;'>"
	
		  WriteLn "		</td>"
		  WriteLn "		</tr>"
		  WriteLn "	</table>"
		  '***** FIM CONTROLA PAGINA
	
	End Sub

'******************************************************************************
  '** FUNÇÃO QUE PERMITE REDIRECIONAR A PÁGINA COM NOVOS PARÂMETROS            **
  '------------------------------------------------------------------------------
  Function rsSubst(tag, valor, rqs)
  	  Dim j
	  Dim k
	  Dim rs
	  
	  If rqs = "" Then rqs = Request.QueryString
	  rs = rqs
	  j = instr(1, rs, tag & "=", 1)
	  If j > 0 Then
	    k = instr(j, rs & "&", "&", 1)
	    rs = left(rs, j - 1) & tag & "=" & valor & mid(rs, k)
	  Else
	    If rs <> "" Then rs = rs & "&"
	    rs = rs & tag & "=" & valor
	  End If
	  rsSubst = rs
  End Function
  '******************************************************************************
%>
