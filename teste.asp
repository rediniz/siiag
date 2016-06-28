<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<%
data_nascimento = "26/08/1987"
'data_atual = "30/03/2014"
data_atual = Formatar_Dia(day(date())) & "/" & Formatar_Mes(month(date())) & "/" & year(date())
			
			dia_fds = day(data_nascimento)
			mes_fds = month(data_nascimento)
			ano_fds = year(data_atual)
					
			data_fds = Formatar_Dia(dia_fds) & "/" & Formatar_Mes(mes_fds) & "/" & ano_fds	
			
			
			if data_fds <> data_atual then
			
				response.write "fds"
			
			else
			
				response.write "normal"
			
			end if
			
%>
