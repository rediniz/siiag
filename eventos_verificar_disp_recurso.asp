 <%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
 
<%	
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	local					= request("local")
	periodo_inicio			= request("periodo_inicio")
	periodo_fim 			= request("periodo_fim")
	horario_inicio 			= request("horario_inicio")
	horario_fim				= request("horario_fim")
	co_recurso				= request("co_recurso")
	co_unidade				= request.Cookies("co_usuario_unidade_siiag")	
	tipo					= request("tipo")
	recursos				= request("recursos")
	
'RECURSO SOLICITADO VIA EVENTOS E TREINAMENTOS
if tipo = 1 then

	if local <> "" and periodo_inicio <> "" and periodo_fim <> "" and horario_inicio <> "" and horario_fim <> "" then				
	  '====================================================================================================
	  'CHECA SE JÁ EXISTE UM EVENTO CADASTRADO NO MESMO HORÁRIO E LOCAL
	  
	  sql_consulta = "SELECT * FROM TB_EVENTOS AS EVENTO JOIN TB_EMPRESTIMO AS EMPRESTIMO ON EVENTO.CO_EVENTO = EMPRESTIMO.CO_EVENTO JOIN TB_EMPRESTIMO_RECURSO AS RECURSO ON EMPRESTIMO.CO_EMPRESTIMO = RECURSO.CO_EMPRESTIMO WHERE EVENTO.CO_SITUACAO IN (1,2) AND ('"&periodo_inicio&"' BETWEEN EVENTO.DH_INICIO AND EVENTO.DH_FIM) AND (EVENTO.DH_HORA_INICIO BETWEEN '"&horario_inicio&"' AND '"&horario_fim&"' OR EVENTO.DH_HORA_FIM BETWEEN '"&horario_inicio&"' AND '"&horario_fim&"') AND RECURSO.CO_RECURSO = " & co_recurso & " AND EVENTO.CO_UNIDADE = " & co_unidade
	  
	  set ds=Server.CreateObject("ADODB.RecordSet")
	  ds.Open sql_consulta, dados_sys 
	  
	  if(ds.eof) then
	  
		response.write "1"
	  
	  else
	  
		response.write "0"
	  
	  end if	
	
	end if

end if

'RECURSO SOLICITADO VIA EMPRÉSTIMO
if tipo = 2 then

		if periodo_inicio <> "" and periodo_fim <> "" and horario_inicio <> "" and horario_fim <> "" and recursos <> "" then
			recursos_lista = split(recursos, ";")
					
			'for each recurso in recursos_lista
			
				'rec	 = split(recurso, ":")
				'id 	 = rec(0)
				'quantidade = rec(1)
				
				id = recursos
				
				sql_consulta = "SELECT NOMES.QT_RECURSO, NOMES.DE_RECURSO FROM TB_EMPRESTIMO AS EMPRESTIMO JOIN TB_EMPRESTIMO_RECURSO AS RECURSO ON EMPRESTIMO.CO_EMPRESTIMO = RECURSO.CO_EMPRESTIMO JOIN TB_TIPOS_RECURSOS AS NOMES ON RECURSO.CO_RECURSO = NOMES.CO_RECURSO WHERE EMPRESTIMO.CO_SITUACAO IN (1,2) AND (EMPRESTIMO.DH_INICIO BETWEEN '"&periodo_inicio&" "&horario_inicio& "' AND '"&periodo_fim&" "&horario_fim&"' OR EMPRESTIMO.DH_FIM BETWEEN '"&periodo_fim&" "&horario_fim&"' AND '"&periodo_fim&" "&horario_fim&"') AND RECURSO.CO_RECURSO = " & id & " AND EMPRESTIMO.CO_UNIDADE = " & co_unidade
				
				set ds=Server.CreateObject("ADODB.RecordSet")
				ds.Open sql_consulta, dados_sys, 1, 1

				
				
				'Se a consulta não retornar nada, então o recurso está disponível
				if(ds.eof) then
				
				   retorno = ""
					
				'Se houver retorno, pega o nome do recurso
				else
					
					if(ds.RecordCount >= ds("QT_RECURSO")) then
				
						retorno = ds("DE_RECURSO") & ","
					else
						retorno = ""
					
					end if
				
				end if
			
			'next	
			
			'Escreve o retorno para ser capturado pelo ajax
			response.write retorno
				
		end if
		
end if
	
%>