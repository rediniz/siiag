<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<%

	' Parâmetros de Conexao ao Banco
	SERVIDOR_DO_BANCO = "ce7180nt005"
	NOME_DO_BANCO = "GIFUG"
	USUARIO_DO_BANCO = "todos"
	SENHA_DO_BANCO = "todosce"
	
	Dim conexao
	
	' Efetua a Conexão
	Set conexao = Server.CreateObject("ADODB.Connection")
	dados = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 	
	conexao.Open dados 
	
	nome = request("nome")
	hora = request("hora")
	data = request("data")
	
	response.write "Hora: " & hora & "<p/>"
	response.write "Data: " & FormatDateTime(data) & "<p/>"

	query = "SELECT co_matricula, no_nome, dt_nascimento from TB_USUARIOS where no_nome like '%" & nome & "%' order by no_nome"
	
	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open query, dados
	
	if not rs.eof then
	
		response.write "<table>"	
		response.write "<tr>"	
		response.write "<td>Matrícula</td> <td>Nome</td> <td>Nascimento</td>"	
		response.write "<tr>"
		
		do while not rs.eof
	
			nome = rs("no_nome")
			nascimento = rs("dt_nascimento")
			matricula = rs("co_matricula")
				
			response.write  "<tr>"
			response.write "<td>"&matricula&"</td><td>"& nome&"</td><td>"&FormatDateTime(nascimento)&"</td>"
			response.write  "</tr>"
			
			rs.movenext
		
		loop
		
		response.write "</table>"
	
	else
	
		response.write "Nenhum resultado a ser exibido"

	end if
	
	'Fechando conexão
	Set query = Nothing
	Set conexao = Nothing

	
%>