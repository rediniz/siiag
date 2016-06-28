<%
	dim WHERE(9)
	dim cont
	dim query
	dim ordem
	
	dim tagPAG
	tagPAG = "pag"
	dim Pag 
	dim numPag
	numPag = 2

	tipoTabela = Request("tipoTabela")
	id = request("id")
	co_log = request("coLog")

	dim tabela
	
	if tipoTabela <> "" then
		select case tipoTabela
			case "afastamento": 
				tabela = "TB_AFASTAMENTOS"
				chave = "co_afastamento"
			case "destacamento": 
				tabela = "TB_DESTACAMENTOS"
				chave = "co_destacamento"
			case "ferias": 
				tabela = "TB_FERIAS"
				chave = "co_ferias"
			case "jornada": 
				tabela = "TB_JORNADA"
				chave = "co_jornada"
			case "substituicao": 
				tabela = "TB_SUBSTITUICOES"
				chave = "co_substituicao"
			case "emprestimo": 
				tabela = "TB_EMPRESTIMO"
				chave = "co_emprestimo"
			case "evento": 
				tabela = "TB_EVENTOS"
				chave = "co_evento"
			case "estoque": 
				tabela = "TB_ESTOQUE_PEDIDO"
				chave = "co_pedido"
			case "reparo": 
				tabela = "TB_REPAROS"
				chave = "co_reparo"
			case "demandaTI": 
				tabela = "TB_DEMANDAS"
				chave = "co_demanda"
		end select
	end if

	strQuery = "SELECT * FROM [SIIAG_WEB_LOG].[dbo].["&tabela&"_LOG] where co_log = " & co_log & "  and tipo_log = 'DEPOIS'"

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys
	if rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
	else
		
	
		
			coLog = rs("co_log")
			coLogAntes = rs("co_log_antes")
			dataLog = rs("dt_log")
			matriculaEdicao = rs("co_matricula_edicao")	
			acao = "O usuário " & matriculaEdicao & " modificou a tabela " & tabela & "."	
			valorChave = rs(chave)	
			
			queryNome = "SELECT NO_NOME FROM TB_USUARIOS WHERE CO_MATRICULA = '"&matriculaEdicao&"'"
			nomeEdicao = objConn.execute(queryNome)("NO_NOME")
		
			queryLogAntes = "SELECT * FROM [SIIAG_WEB_LOG].[dbo].["&tabela&"_LOG] where co_log = "&coLogAntes&""
			set rs2=Server.CreateObject("ADODB.RecordSet")
			rs2.Open queryLogAntes, dados_sys
			
			%>    
            
			Alterações feitas pelo usuário <b><%=nomeEdicao%></b> na tabela <b><%=tabela%>, <%=ucase(chave)%> = <%=valorChave%></b> em <b><%=FormatDateTime(dataLog,2)%></b> às <b><%=FormatDateTime(dataLog,3)%></b><br /><br />
            <%
			
			for i=0 to rs.fields.count-1
				nomeColuna = rs.fields(i).name
				
				valorAntes = rs2.fields(i).value
				
				if isnull(valorAntes) then
					valorAntes = "Nulo"
				end if
				
				valorDepois = rs.fields(i).value
				
				if isnull(valorDepois) then
					valorDepois = "Nulo"
				end if
				
				if nomeColuna <> "CO_LOG" and nomeColuna <> "DT_LOG" and  nomeColuna <> "ACAO_LOG" and  nomeColuna <> "TIPO_LOG" and nomeColuna <>  "CO_LOG_ANTES" then
					if (valorDepois <> valorAntes) then
						
						response.write "<label>Coluna:</label>" & nomeColuna & "<br>"
						
						if nomeColuna = "CO_SITUACAO" then
							querySituacaoAntes = "SELECT DE_SITUACAO FROM TB_SITUACOES WHERE CO_SITUACAO = "&valorAntes&""
							nomeSituacaoAntes = objConn.execute(querySituacaoAntes)("DE_SITUACAO")
							
							querySituacaoDepois = "SELECT DE_SITUACAO FROM TB_SITUACOES WHERE CO_SITUACAO = "&valorDepois&""
							nomeSituacaoDepois = objConn.execute(querySituacaoDepois)("DE_SITUACAO")
							
							response.write "<label>Antes:</label> " & nomeSituacaoAntes & "<br>"
							response.write "<label>Depois:</label> " & nomeSituacaoDepois & "<br>"
							
						else
							response.write "<label>Antes:</label> " & valorAntes & "<br>"
							response.write "<label>Depois:</label> " & valorDepois & "<br>"
						end if

						response.write "<br>"
					end if
				end if
			next

	end if
%>