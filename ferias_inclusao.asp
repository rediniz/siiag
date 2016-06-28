  <%
  
 
		  
		 matricula = request("matricula")
		 dataInicio = request("dataInicio")
		 parcelas = request("parcelas")
		 diasAbono = request("diasAbono")
		 situacao = 2
		 observacoes = request("observacoes")
		 dataCricao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
		 matriculaSolicitante = request("mat_usuario")
		 
		 if dias <> "" then
		 	abono = 1
		 else
		 	abono = 0
		 end if
		 
		 sql_coordenacao = "SELECT CO_"
		 
		 
		 'response.Write(codSeq)
		 		  	  
		  	sql = "DELETE FROM TB_PROTOCOLO_ATUAL WHERE CO_SEQUENCIAL="&codSeq&""
			
		  NOME_DO_BANCO = "GIFUG"

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
          