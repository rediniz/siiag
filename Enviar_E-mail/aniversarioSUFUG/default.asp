<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
dim data, conn, rs, sqlstr

de = "" & request("caixa")
if de = "" then de = "SUFUG - SN de Fundo de Garantia"
testes = "" & request("testes")
usuario = "" & request("usuario")
enviar = "" & request("enviar")
data = trim("" & request("data"))
if data = "" or not isDate(data) or len(data) < 8 then data = day(now) & "/" & month(now) & "/" & year(now)

if enviar = "sim" then
	for each atual in request.form
		if instr(1,atual,"send") > 0 and request(atual) <> "nao" then
			apelidoAtual = request("Apelido" & replace(atual,"send","")  )
			if testes = "true" and usuario <> "" then
				emails = emails & ";" & usuario & "#" & apelidoAtual 'request(atual)   
			else
				emails = emails & ";" & replace(atual,"send","") & "#" & apelidoAtual 'request(atual)   
			end if
		end if
	next
	enviarCartao emails, de
	'response.write emails
end if


response.flush
set conn = server.createObject("adodb.connection")
set rs = server.createObject("adodb.recordset")



if DatePart("w", cdate(data)) >= 6 then 'SEXTAS E SABADOS
	dataFim = dateAdd("d",cdate(data), 8 - DatePart("w", cdate(data)))
else	'DEMAIS DATAS
	dataFim = data
end if
%>

<%
				'ABRINDO CONEXAO
				conn.Open "Provider=SQLOLEDB.1;Password=todosce;Persist Security Info=True;User ID=todos;Initial Catalog=UsuariosGIFUG;Data Source=ce7180nt005"	
				
				sqlstr = "    SELECT * FROM VW_EMPREGADOS_SUFUG " & _
							" WHERE CONVERT(DATETIME, [Dia_e_Mês_Aniversário] + '/" & year(data) & "',103) BETWEEN "  & _
							" CONVERT(DATETIME, '" & data & "', 103) AND CONVERT(DATETIME, '" & dataFim & "', 103) order by  nome"
				'response.write sqlstr
				rs.Open sqlstr, conn, 3, 3

	
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Envio de cartões de aniversário</title>
<link href="estilo.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
body,td,th {
	font-family: MS Sans Serif, Arial, sans-serif;
	font-size: 11px;
	color: #000000;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {color: #FFFFFF; font-weight: bold; }

.caixa {
	font-family: MS Sans Serif, Arial, sans-serif;
	font-size: 11px;
	border:solid 1px #6699CC;
}

.botao {
	font-family: MS Sans Serif, Arial, sans-serif;
	font-size: 11px;
	border:solid 2px #6699CC;
	background:#0066CC;
	color:#FFFFFF;
}

-->
</style>

<%

function enviarCartao(para, de)
	if left(para, 1) = ";" then
		para = right(para, len(para)-1)
	end if
	matriz = split(para,";")
	if de = "" then de = "SUFUG - SN de Fundo de Garantia"
	for a = 0 to ubound(matriz)
		matrizUsu = split (matriz(a),"#")
		matricula = matrizUsu(0)
		nome = matrizUsu(1)
		
	next
	
	%>
	<script language="VBScript" type="text/vbscript">
		on error resume next
		titulo =  "Feliz Aniversário"
		texto = "<table>" & _
		"	<tr>" & _
		"		<td style=""position:relative"">" & _
		"			<div style=""position:absolute; width:228px; text-align:left; " & _
		"			font-family:'Trebuchet MS', Verdana, Arial; font-size:16px; font-weight:bold; top:35px; left:60px;""> " & _
		"			@@@" & _
		"			</div>" & _
		"			<img src=""***"" />" & _
		"		</td>" & _
		"	</tr>" & _
		"</table>"
		
		
		Set OutApl = CreateObject("Outlook.Application")
		Set OutSes = OutApl.GetNameSpace("MAPI")
		OutSes.Logon "<%= de %>" ,"" , False, False
		
		<%
		randomize
		set fso = server.CreateObject("Scripting.FileSystemObject")


		'set pasta = fso.getfolder("\\ce7180nt005\cartoesSUFUG$")
		set pasta = fso.getfolder("\\ce7180nt005\Intranet\aniversarioSUFUG\cartoesSUFUG")
	
		set arquivos = pasta.files
		for each f in arquivos
			if instr(1,f.name,"jpg") then total = total + 1
		next	
		
		for a = 0 to ubound(matriz)
			matrizUsu = split (matriz(a),"#")
			matricula = matrizUsu(0)
			nome = matrizUsu(1)
			
			'Exibir apenas os dois primeiros nomes. Caso segundo nome < 3 caracteres, exibir 3 nomes
			'matrizNome = split(nome, " ")
			'nome = matrizNome(0)
			
			'if ubound(matrizNome) > 1 then
			'	nome = nome &" "& matrizNome(1)
			'	if len(matrizNome(1)) < 4  then
			'		if ubound (matrizNome) > 2 then
			'			nome = nome &" "& matrizNome(2)
			'		end if
			'	end if
			'end if
			
			indice = cint(rnd*total)
			z = 0			
			for each f in arquivos
				'if instr(1,f.name,"jpg") then
				if instr(1,f.name,"png") then
					tema = f.name
					if indice = z then 
						exit for
					end if
					z = z+ 1
				end if
			next	
			
		%>
			err.clear
			Set OutMsg = OutApl.CreateItem(olMailItem)
			//OutMsg.Attachments.Add "\\ce7180nt005\cartoesSUFUG$\<%=tema%>"
			OutMsg.Attachments.Add "\\ce7180nt005\Intranet\aniversarioSUFUG\cartoesSUFUG\<%=tema%>"
	
			OutMsg.Subject = titulo
			OutMsg.HtmlBody = replace(replace(texto, "@@@", "<%= nome %>"), "***", "<%=tema%>")
			OutMsg.Recipients.Add  "<%=matricula%>"
			
			OutMsg.Send
			
			if err.number <> 0 then 
				msgbox "Erro no envio do cartão: " & vbnewline & "DE: <%= de %>" & vbnewline & "<%= data %>  Nome: <%= nome %> Matrícula: <%=matricula%> " & vbnewline & err.description & vbnewline & vbnewline & "Continuando envio de cartões."
				erro = erro + 1
			else
				sucesso = sucesso + 1
			End if
			
			Set OutMsg = Nothing
			
		<%
		next
		%>
			
		Set OutApl = Nothing
		

		msgbox "Cartões enviados: " & sucesso & " sucesso(s) / " & erro & " erro(s)"
		


		window.location = "default.asp?data=<%= request("data") %>"
	</script>
<%


end function
%>

</head>

<body>
<center>

	<form action="default.asp" method="POST">
		<p><img src="logoCartoes.jpg" alt="Envio de cart&otilde;es" width="446" height="56" align="middle" />Dia 
		  <input name="data" type="text" class="caixa" id="data" value="<%= data %>" size="15" maxlength="10">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  <INPUT TYPE="SUBMIT" class="botao" value="Exibir">
        </p>
  </form>
	<form action="default.asp" method="POST">
		
		<hr>
		Linhas em azul são de colaboradores sem o apelido cadastrado na base de dados.<br><br>
		<table width="90%" cellspacing="0" cellpadding="2">
	  <tr>
		<td align="center" bgcolor="#1F4B7F"><span class="style3">Excluir</span></td>
	    <td align="left" bgcolor="#1F4B7F"><span class="style3">Nome</span></td>
		<td align="left" bgcolor="#1F4B7F"><span class="style3">Apelido</span></td>
	    <td bgcolor="#1F4B7F"><span class="style3">Matrícula</span></td>
	    <td bgcolor="#1F4B7F"><span class="style3">Unidade</span></td> 
	    <td bgcolor="#1F4B7F"><span class="style3">Data</span></td>
		  </tr>
		<%
		while not rs.eof
			i = i + 1
			apelido = "" & rs("apelido")
			if apelido = "" then
				matriz = split(rs("nome"), " ")
				apelido = matriz(0)
				if len(matriz(1)) > 3 then
					apelido = apelido & " " & matriz(1)
				else  'o segundo nome é algo como DAS ou DE
					if ubound(matriz) >= 2 then
						apelido = apelido & " " & matriz(1) & " " & matriz(2)
					end if
				end if
				autoNome = true
			else
				autoNome = false
			end if
			if i mod 2 = 0 then 
				cor = "#F4F4F4"
			else
				cor = "#FFFFFF"
			end if
			
			if autoNome then
				cor = "#a6c9f8"
			end if
			
			apelido = ucase(apelido)
			%>
			<tr id="tr<%= i %>">
				<td align="center" bgcolor="<%= cor %>">
		<img src="delete.gif" style="cursor:pointer" onclick="document.getElementById('tr<%= i %>').style.display = 'none';document.getElementById('sendC<%= rs("matricula") %>').value = 'nao';"></td>
				<td align="left" bgcolor="<%= cor %>"><%= rs("nome") %></td>
				<td align="left" bgcolor="<%= cor %>">
					<input name="apelidoC<%= rs("matricula") %>" type="text" class="caixa" id="apelido<%= rs("matricula") %>" value="<%=  apelido %>" size="30" />
				</td>
				<td bgcolor="<%= cor %>">C<%= rs("matricula") %></td>
				<td bgcolor="<%= cor %>"><%= rs("Unidade_Lotação") %></td>
				<td bgcolor="<%= cor %>"><%= rs("Dia_e_Mês_Aniversário") %>
				<input type="hidden" id="sendC<%= rs("matricula") %>" name="sendC<%= rs("matricula") %>" value="<%= rs("nome") %>">				</td>
			</tr>	
			
			<%
			rs.movenext
		wend
		%>
			<tr>
				<td align="center"></td>
				<td align="left" colspan="4"><br>
					<input type="hidden" name="enviar" value="sim" />
					<input type="hidden" name="data" id="data" value="<%= data %>"> 
					Caixa postal de envio
                    <input name="caixa" type="text" class="caixa" id="caixa" value="<%= de %>" size="30" maxlength="40" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;					
					<input type="submit" class="botao" value="Enviar cartões" />
					&nbsp;&nbsp;&nbsp;&nbsp; 
					<input type="checkbox" name="testes" id="testes" value="true">
					<label for="testes">Enviar apenas e-mails de teste para o usuário </label>
					<input name="usuario" type="text" class="caixa" id="usuario" value="" size="10" maxlength="40" />
				</td>
				
			</tr>
		</table>
		<hr>
		<!--<img src="alerta.gif" align="absmiddle"> <B>ATENÇÃO:</B> Antes de enviar os cartões, você deve definir nosso servidor como "Site Confiável", <a href="\\ce7874sr102\1005 www.gifugfo.ce.caixa\Sites_gifugfo.reg">clicando aqui,</a> confirmando as mensagens e reiniciando o seu navegador. -->

		<img src="alerta.gif" align="absmiddle"> <B>ATENÇÃO:</B> Antes de enviar os cartões, você deve definir nosso servidor como "Site Confiável", <a href="\\ce7874NT101\1005 www.gifugfo.ce.caixa\Sites_gifugfo.reg">clicando aqui,</a> confirmando as mensagens e reiniciando o seu navegador.
  </form>
</center>
</body>
</html>

<%
rs.close
set rs = nothing
conn.close
set conn = nothing
%>