<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
Session.lcid = 1046

co_coord = request("co_coord")
co_matricula = request("co_matricula")

	sql = "UPDATE TB_USUARIOS SET CO_GS = '" & co_coord & "' FROM TB_USUARIOS WHERE CO_MATRICULA = '" & co_matricula & "'"
	response.write sql
	objConn.execute(sql)
	
    if err.number <> 0 then
%>
		<script language="javascript">
			alert('Erro na atualização. <% = "Erro:" & err.description  %>' );
		</script>
<%		
	else
%>
		<script language="javascript">
			alert('Dados atualizados com sucesso.');
		</script>
<%		
	end if
%>
