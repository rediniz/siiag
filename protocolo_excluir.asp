<!-- #INCLUDE FILE ="include/conexao_protocolo.asp" -->
  <%
  
  ' Parâmetros de Conexao ao Banco
	'SERVIDOR_DO_BANCO = "ce7180nt005"
	'NOME_DO_BANCO = "SIIAG"
	'USUARIO_DO_BANCO = "todos"
	'SENHA_DO_BANCO = "todosce"
	
	'Dim conexao
	
	' Efetua a Conexão
	'Set conexao = Server.CreateObject("ADODB.Connection")
	'conexao.Open = "Provider=MSDASQL;Driver={SQL Server};Server="&SERVIDOR_DO_BANCO&";Database="&NOME_DO_BANCO&";UID="&USUARIO_DO_BANCO&";PWD="&SENHA_DO_BANCO&";" 
		  
		 
		  
		 codSeq = Request("codSeq")
		 
		 'response.Write(codSeq)	  
 
		  
		  	sql = "DELETE FROM TB_PROTOCOLO_ATUAL WHERE CO_SEQUENCIAL="&codSeq&""

		  Set query = objConn.execute(sql)
		  
		  'Fechando conexão
	Set query = Nothing
	Set conexao = Nothing
		  
		 %>
		  
		  <script>
		  
		  alert("Protocolo excluído com sucesso.");
          
         window.location.assign("protocolo_consultar.asp?sucesso=true");
         </script>
          
		 <%
		  	
			'Response.Write "Deu Certo"
				
		  
		  
		  
		'PC.CLOSE
%>
          