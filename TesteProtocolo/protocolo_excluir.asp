  <%
		  
		 
		  
		 numerOficio = Request("numeroOficio")
		 codigoArea = Request("codigoArea")
		 tipoProtocolo = Request("tipoProtocolo")
		 		  
		 
		  
		  	sql = "DELETE FROM TB_PROTOCOLO WHERE NO_PROTOCOLO='"&numerOficio&"' AND CO_AREA='"&codigoArea&"' AND CO_TIPO='"&tipoProtocolo&"'"
		  
		  
		   set objConn = server.CreateObject("ADODB.Connection") 
           dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
           objConn.open dados_sys
           set PC=Server.CreateObject("ADODB.RecordSet")
           PC.Open sql, dados_sys
		   
		   
		  
		 
		  
		 %>
		  
		  <script>
		  
		  alert("Arquivo Excluido com Sucesso");
          
          window.location.assign("protocolo_consultar.asp");
          </script>
          
		 <%
		  	
			'Response.Write "Deu Certo"
				
		  
		  
		  
		PC.CLOSE
%>
          