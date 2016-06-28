<%@LANGUAGE=VBSCRIPT CODEPAGE="65001"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#INCLUDE FILE="include/Conexao.asp"-->
<%
	co_File = Request("file")

	on error resume next

    Set RS = Server.CreateObject("ADODB.RecordSet")
	rs.Open "SELECT * FROM TB_DEMANDAS_ARQUIVOS WHERE CO_SEQUENCIAL = " &co_File& "", dados_sys
	if not rs.eof then

		dim fs
		Set fs=Server.CreateObject("Scripting.FileSystemObject")
		if fs.FileExists(rs("endereco_arquivo")) then
			fs.DeleteFile(rs("endereco_arquivo"))
		end if
		set fs=nothing


		sql = "DELETE FROM TB_DEMANDAS_ARQUIVOS WHERE co_sequencial = "&co_File&" "
		objConn.execute(sql)
		set query = nothing
	end if
  	set objConn = nothing

    if err.number <> 0 or erro <> 0  then
%>
		<script language="javascript">
			alert('Erro na exclusão. <% = "Erro:" & err.description %>' );
			//window.navigate('cadastro.asp');
		</script>
<%		
	else
%>
		<script language="javascript">
			alert('Exclusão realizada com sucesso.');
			//window.navigate('cadastro.asp');
		</script>
<%		
	end if
%>
