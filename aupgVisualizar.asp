<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>AUPG</title>
<!--CSS -->
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<link href="botao_azul.css" rel="stylesheet" type="text/css" />

<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.mousewheel.js"></script>
<script src="scripts/globalize.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery.ui.button.js"></script>
<script src="scripts/jquery.ui.spinner.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/globalize.culture.de-DE.js"></script>
<script src="scripts/jquery.ui.timepicker.js"></script>
<script src="scripts/jquery.ui.mask.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<!-- efeito da janela de ajuda -->

<script>
    $(function() {
    $("#copiar").click(function(){
	var texto =  $("#texto").text();
	$("input").select();
	window.clipboardData.setData('Text', texto);
	//var range = document.body.createTextRange();
	//range.moveToElementText(txt);
	//range.select();
	alert("O texto foi copiado.");
  });
   });
</script>
</head>

<body>
<%

'*************************
'co_destacamento = request("co_destacamento")
'response.write "Destacamento: " & co_destacamento
'query = "SELECT * FROM TB_DESTACAMENTOS WHERE CO_DESTACAMENTO = " & co_destacamento & ""
'rs 	= objConn.execute(query)
'tipo_diaria = rs("CO_TIPO_DIARIA")
'response.write tipo_diaria
'if tipo_diaria = "2" or tipo_diaria = "3" then
'	texto_hospedagem = "- Hospedagem: " & rs("DE_SUGESTAO_HOSPEDAGEM")
'end if
'set rs = nothing
'********

'	query = "SELECT a.*, b.* FROM TB_TRECHOS A INNER JOIN TB_TIPOS_TRANSPORTE B ON A.CO_TIPO_TRANSPORTE = B.CO_TIPO_TRANSPORTE  WHERE 'CO_DESTACAMENTO = " & co_destacamento & " ORDER BY CO_SUGESTAO, CO_TRECHO"
'	set trechos = Server.CreateObject("ADODB.RecordSet")
'	trechos  = objConn.execute(query)
'	trechos.Open query, dados_sys
'	cabecalho_trecho = ""
'	texto_trecho=""
'	co_sugestao = 0
'	co_trecho = 0
'	do while not trechos.eof
'		if cabecalho_trecho = "" then
'			cabecalho_trecho = "- Sugestões de vôos (sugestões em ordem de preferência):" & vbcrlf
'		end if
'		if co_sugestao <> trechos("co_sugestao") then
'			texto_trecho = texto_trecho & "            " & trechos("co_sugestao") & ") " & "Embarque Data: " & formatar_data(trechos("dh_horario")) & " Hora: " & Formatar_hora(trechos("dh_horario")) &  " " & trechos("no_cia_transporte") & "-" & trechos("nu_voo") & " Cidade: " & capitalize(trechos("no_cidade"))  & vbcrlf
'		else
'			texto_trecho = texto_trecho & "                Embarque Data: " & formatar_data(trechos("dh_horario")) & " Hora: " & Formatar_hora(trechos("dh_horario")) & " " & trechos("no_cia_transporte") & "-" & trechos("nu_voo") & " Cidade: " & capitalize(trechos("no_cidade")) & vbcrlf
'		end if
'		texto_trecho = texto_trecho & trechos("de_tipo_transporte")
'		co_sugestao =trechos("co_sugestao")
'		trechos.movenext
'	loop

	

	query2 = "SELECT DE_UNIDADE, SG_UF, SG_UNIDADE,EMAIL_UNIDADE FROM TB_UNIDADE WHERE CO_UNIDADE ="&request.Cookies("co_usuario_unidade_siiag")
	query2 = "SELECT DE_UNIDADE, SG_UF, SG_UNIDADE, EMAIL_UNIDADE FROM TB_UNIDADE WHERE CO_UNIDADE = 7180"
	resultado2 		= objConn.execute(query2)
	email 			= resultado2("EMAIL_UNIDADE")
	de_unidade		= resultado2("DE_UNIDADE")
	sg_unidade 		= split(resultado2("SG_UNIDADE"), "/")(1)
	palavras = split(de_unidade, " ")
	de_unidade = replace(de_unidade, ", ", "/")
	sg_uf = resultado2("SG_UF")
	de_unidade1 = replace(de_unidade, "FUNDO GARANTIA", "Fundo de Garantia")
	de_unidade2 = replace(de_unidade, ",", "/"&sg_uf)
	
	
	query = "SELECT USUARIO.NO_GS, USUARIO.NO_NOME, CARGO.NO_CARGO FROM VW_USUARIOS AS USUARIO JOIN TB_CARGOS AS CARGO ON USUARIO.CO_CARGO=CARGO.CO_CARGO WHERE CO_MATRICULA = '" & request.Cookies("co_usuario_siiag") & "'"
	resultado 	= objConn.execute(query)
	nome 		= resultado("NO_NOME")
	coordenacao = resultado("NO_GS")
	cargo 		= resultado("NO_CARGO")


%>

<div id="texto">
<textarea id="texto"  readonly="readonly" wrap="hard" style="width:640px; height:400px; font-family: 'Bookman Old Style', Arial;">
<%  
	diaria = request("diaria")
	if diaria = "2" Or diaria = "3" then
	%>
À
GILOG/<%=sg_unidade%> e GILOG/XXXXXXXXXXXXXXXXX
	<%
	else
	%>
À
GILOG/<%=sg_unidade%>
    <%
	end if
%>


1.      Encaminhamos AUPG referente ao evento abaixo descrito:
    
        - Evento: <%=request("evento")%> 
        - Endereço: <%=request("cidade")%>/<%=request("uf")%>
        - Data: <%=request("data_inicio")%> a <%=request("data_fim")%>
        - Horário: dia todo
        <%=texto_hospedagem%>
        <%=cabecalho_trecho%>
        <%=texto_trecho%>
        - e-mail externo do empregado: XXXXXXXXXXXXXXXXXXXXXXXXXXX

2.	Solicitamos que, na impossibilidade de atender os horários de vôos sugeridos, nos contate para analisarmos as opções disponíveis.

3.	Solicitamos confirmação para <%=email%>

Atenciosamente,

<%=nome%>&nbsp;   
<%=cargo%> - <%=coordenacao%> 
GI <%=de_unidade2%>

</textarea>
</div>

<div align="center">
<p>
<input id='copiar' name='copiar' class="myButton" type="button" value="Copiar" />
</p>
</div>
</body>
</html>
