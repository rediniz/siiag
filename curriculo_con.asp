<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE = "include/upload/clsUpload.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	acao = request("acao")

	select case acao
	
		case "solicitarCadastroEscolaridade"
			solicitarCadastroEscolaridade()
		case "solicitarModalidadeComplementar"
			solicitarModalidadeComplementar()
		case "enviarDocumento"
			id = request("id")
			enviarDocumento(id)
		case "carregarAreasConhecimento"
			modalidade = request("modalidade")
			carregarAreasConhecimento(modalidade)
		case "carregarAreasConcentracao"
			areaConhecimento = request("areaConhecimento")
			carregarAreasConcentracao(areaConhecimento)
		case "carregarModalidades"
			carregarModalidades()
		case "carregarMetodologias"
			carregarMetodologias()
		case "carregarTiposMediadores"
			carregarTiposMediadores()
		case "carregarSituacoes"
			carregarSituacoes()
			
		case "teste"
			response.write Len(vbNullString)
		case else

	end select

	sub solicitarCadastroEscolaridade()
	
		matriculaEmpregado = request("matriculaEmpregado")
		nomeEmpregado 	   = request("nomeEmpregado")
		modalidade		   = request("modalidade")
		areaConhecimento   = request("areaConhecimento")
		areaConcentracao   = request("areaConcentracao")
		nomeCurso 		   = request("nomeCurso")
		metodologia 	   = request("metodologia")
		situacao 		   = request("situacao")
		dataInicio 		   = request("dataInicio")
		dataConclusao 	   = request("dataConclusao")
		cargaHoraria 	   = request("cargaHoraria")
		dataSolicitacao	   = date()&" "&time()
		matriculaInclusao  = session("v_usuario_matricula")
		
		sqlCadastroEscolaridade = "INSERT INTO TB_CURRICULO_ESCOLARIDADE (matricula_empregado, nome_empregado, modalidade, area_conhecimento, area_concentracao, nome_curso, metodologia, situacao, data_inicio, data_conclusao, carga_horaria, data_solicitacao, matricula_inclusao) VALUES ('"&matriculaEmpregado&"', '"&nomeEmpregado&"', "&modalidade&", "&areaConhecimento&", "&areaConcentracao&", '"&nomeCurso&"', "&metodologia&", "&situacao&", '"&dataInicio&"', '"&dataConclusao&"', '"&cargaHoraria&"', '"&dataSolicitacao&"', '"&matriculaInclusao&"')"
		
		objConn.execute(sqlCadastroEscolaridade)
		
		resultado = objConn.execute("SELECT TOP 1 ""ID"" AS ID_RETORNO FROM TB_CURRICULO_ESCOLARIDADE ORDER BY ""ID"" DESC")
				
		idInserido = resultado("ID_RETORNO")
		
		response.write "{""id"":"""&idInserido&"""}"
	
	end sub
	
	sub enviarDocumento(id, tipo)
		if(tipo = 1) then
			tabela = "TB_CURRICULO_COMPLEMENTAR_DOCUMENTO"
			coluna = "modalidade_complementar"
		else
			tabela = "TB_CURRICULO_ESCOLARIDADE_DOCUMENTO"
			coluna = "escolaridade"
		end if
		
		Set upload = new clsUpload
		cont = 0
		For Each item In Request.Form("documento")
			nomeDocumento 	= upload.fields(cont).filename
			diretorio 		= Server.MapPath("upload") & "\"
			objConn.execute("INSERT INTO "&tabela&" ("&coluna&", documento) VALUES ("&id&", '"&diretorio&nomeDocumento&"')")	
			upload(cont).saveas diretorio & nomeDocumento
			cont = cont + 1
		Next

	end sub
	
	sub solicitarModalidadeComplementar()
	
		iniciativa 		       = checarNulo(request("iniciativa"))
		empregados		       = checarNulo(request("empregados"))
		areaConhecimento       = checarNulo(request("areaConhecimento"))
		areaConcentracao       = checarNulo(request("areaConcentracao"))
		modalidade		       = checarNulo(request("modalidade"))
		metodologia 	       = checarNulo(request("metodologia"))
		nomeCurso 		       = checarNulo(request("nomeCurso"))
		codigoCurso		       = checarNulo(request("codigoCurso"))
		instituicaoMinistrante = checarNulo(request("instituicaoMinistrante"))
		dataInicio 		       = checarNulo(request("dataInicio"))
		dataConclusao 	       = checarNulo(request("dataConclusao"))
		cargaHoraria 	       = checarNulo(request("cargaHoraria"))
		investimentoCaixa      = checarNulo(request("investimentoCaixa"))
		numeroCompromisso	   = checarNulo(request("numeroCompromisso"))
		documentoMinistrante   = checarNulo(request("documentoMinistrante"))
		nota  				   = checarNulo(request("nota"))
		conceito			   = checarNulo(request("conceito"))
		frequencia			   = checarNulo(request("frequencia"))
		mediador			   = checarNulo(request("mediador"))
		tipoMediador		   = checarNulo(request("tipoMediador"))
		resultadoFinal		   = checarNulo(request("resultadoFinal"))
		dataSolicitacao	       = date()&" "&time()
		matriculaInclusao      = session("v_usuario_matricula")
				
		Set chModComp = Server.CreateObject("ADODB.Command")
		chModComp.ActiveConnection=objConn
		chModComp.Prepared = true

		chModComp.commandtext = "INSERT INTO TB_CURRICULO_COMPLEMENTAR (iniciativa, area_conhecimento,area_concentracao, modalidade,metodologia,nome_curso, codigo_curso,instituicao_ministrante,data_inicio, data_conclusao, carga_horaria,investimento_caixa,numero_compromisso,documento_ministrante,nota,conceito,frequencia,mediador,tipo_mediador,resultado_final,data_solicitacao, matricula_inclusao) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
		
		chModComp.Parameters.Append chModComp.CreateParameter("@iniciativa",3,1, ,iniciativa)
		chModComp.Parameters.Append chModComp.CreateParameter("@area_conhecimento", 3,1, ,areaConhecimento)
		chModComp.Parameters.Append chModComp.CreateParameter("@area_concentracao",3,1, ,areaConcentracao)
		chModComp.Parameters.Append chModComp.CreateParameter("@modalidade", 3,1, ,modalidade)
		chModComp.Parameters.Append chModComp.CreateParameter("@metodologia", 3,1, ,metodologia)
		chModComp.Parameters.Append chModComp.CreateParameter("@nome_curso", 200,1,tamanho(nomeCurso),nomeCurso)
		chModComp.Parameters.Append chModComp.CreateParameter("@codigo_curso", 200,1,tamanho(codigo_curso),codigo_curso)
		chModComp.Parameters.Append chModComp.CreateParameter("@instituicao_ministrante", 200,1,tamanho(instituicaoMinistrante),instituicaoMinistrante)
		chModComp.Parameters.Append chModComp.CreateParameter("@data_inicio", 200,1,tamanho(dataInicio),dataInicio)
		chModComp.Parameters.Append chModComp.CreateParameter("@data_conclusao", 200,1,tamanho(dataConclusao),dataConclusao)
		chModComp.Parameters.Append chModComp.CreateParameter("@carga_horaria", 200,1,tamanho(cargaHoraria),cargaHoraria)
		chModComp.Parameters.Append chModComp.CreateParameter("@investimento_caixa", 200,1,tamanho(investimentoCaixa),investimentoCaixa)
		chModComp.Parameters.Append chModComp.CreateParameter("@numero_compromisso", 200,1,tamanho(numeroCompromisso),numeroCompromisso)
		chModComp.Parameters.Append chModComp.CreateParameter("@documento_ministrante", 200,1,tamanho(documentoMinistrante),documentoMinistrante)
		chModComp.Parameters.Append chModComp.CreateParameter("@nota", 200,1,tamanho(nota),nota)
		chModComp.Parameters.Append chModComp.CreateParameter("@conceito", 200,1,tamanho(conceito),conceito)
		chModComp.Parameters.Append chModComp.CreateParameter("@frequencia", 200,1,tamanho(frequencia),frequencia)
		chModComp.Parameters.Append chModComp.CreateParameter("@mediador", 3,1,,mediador)
		chModComp.Parameters.Append chModComp.CreateParameter("@tipo_mediador", 3,1,,tipoMediador)	
		chModComp.Parameters.Append chModComp.CreateParameter("@resultado_final",3,1, ,resultadoFinal)
		chModComp.Parameters.Append chModComp.CreateParameter("@data_solicitacao", 200,1,tamanho(dataSolicitacao),dataSolicitacao)
		chModComp.Parameters.Append chModComp.CreateParameter("@matricula_inclusao", 200,1,tamanho(matriculaInclusao),matriculaInclusao)

	response.write chModComp.commandtext
		set rschModComp = chModComp.execute
		
		resultado = objConn.execute("SELECT TOP 1 ""ID"" AS ID_RETORNO FROM TB_CURRICULO_ESCOLARIDADE ORDER BY ""ID"" DESC")
				
		idInserido = resultado("ID_RETORNO")
		
		vetorEmpregados = split(empregados, ",")
		
		for each empregado in vetorEmpregados
		
			valorDividido = split(empregado, ":")
			matriculaEmpregado = valorDividido(0)
			nomeEmpregado 	   = valorDividido(1)
			
			sqlEmpregadoModalidadeComplementar = "INSERT INTO TB_CURRICULO_COMPLEMENTAR_EMPREGADO (MODALIDADE_COMPLEMENTAR, MATRICULA_EMPREGADO, NOME_EMPREGADO) VALUES ("&idInserido&",'"&matriculaEmpregado&"','"&nomeEmpregado&"')"
			
			objConn.execute(sqlEmpregadoModalidadeComplementar)
					
		next
		
		response.write "{""id"":"""&idInserido&"""}"
	
	end sub
	
	sub carregarAreasConhecimento(modalidade)
		queryAreasConhecimento = "SELECT * FROM TB_UCC_AREA_CONHECIMENTO"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryAreasConhecimento, dados_sys				
		if not rs.eof then	
			%>
            <option value="">Selecione uma área de conhecimento...</option>
            <%
			do while not rs.eof
				%>
                <option value="<%=rs("codigo")%>"><%=rs("descricao")%></option>
                <%
				rs.movenext
			loop	
			rs.close
			set rs = nothing		
		end if	
	end sub
	
	sub carregarAreasConcentracao(areaConhecimento)
		queryAreasConcentracao = "SELECT * FROM TB_UCC_AREA_CONCENTRACAO WHERE area_conhecimento = " & areaConhecimento
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryAreasConcentracao, dados_sys				
		if not rs.eof then	
			%>
            <option value="">Selecione uma área de concentração...</option>
            <%
			do while not rs.eof
				%>
                <option value="<%=rs("codigo")%>"><%=rs("descricao")%></option>
                <%
				rs.movenext
			loop	
			rs.close
			set rs = nothing		
		end if	
	end sub
	
	sub carregarModalidades()
		queryModalidades = "SELECT * FROM TB_UCC_MODALIDADE"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryModalidades, dados_sys				
		if not rs.eof then	
			%>
            <option value="">Selecione uma modalidade...</option>
            <%
			do while not rs.eof
				%>
                <option value="<%=rs("codigo")%>"><%=rs("descricao")%></option>
                <%
				rs.movenext
			loop	
			rs.close
			set rs = nothing		
		end if	
	end sub
	
	sub carregarMetodologias()
		queryMetodologias = "SELECT * FROM TB_UCC_METODOLOGIA"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryMetodologias, dados_sys				
		if not rs.eof then	
			%>
            <option value="">Selecione uma metodologia...</option>
            <%
			do while not rs.eof
				%>
                <option value="<%=rs("codigo")%>"><%=rs("descricao")%></option>
                <%
				rs.movenext
			loop	
			rs.close
			set rs = nothing		
		end if	
	end sub
	
	sub carregarTiposMediadores()
		queryMetodologias = "SELECT * FROM TB_UCC_TIPO_MEDIADOR"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryMetodologias, dados_sys				
		if not rs.eof then	
			%>
            <option value="">Selecione um tipo de mediador...</option>
            <%
			do while not rs.eof
				%>
                <option value="<%=rs("codigo")%>"><%=rs("descricao")%></option>
                <%
				rs.movenext
			loop	
			rs.close
			set rs = nothing		
		end if	
	end sub
	
	sub carregarSituacoes()
		queryMetodologias = "SELECT * FROM TB_SITUACOES"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryMetodologias, dados_sys				
		if not rs.eof then	
			%>
            <option value="">Selecione uma situação...</option>
            <%
			do while not rs.eof
				%>
                <option value="<%=rs("co_situacao")%>"><%=rs("de_situacao")%></option>
                <%
				rs.movenext
			loop	
			rs.close
			set rs = nothing		
		end if	
	end sub
	
	function checarNulo(valor) 
		if valor = "" then
			valor = vbNullString
		end if
		checarNulo = valor
	end function
	
	function tamanho(valor)
		tamanho = Len(valor)
		if tamanho = 0 then
			tamanho = 1
		end if
	end function
%>
