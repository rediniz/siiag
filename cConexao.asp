<%
class cConexao
	
'------------------------------------------------------------ Vari�veis

	Private objConexao			'Objeto Conex�o
	Private objRS				'Objeto RecordSet
	
	Public stringConexao		'String de conexao ao servidor
	Private id					'id de conexao
	Private senha				'Senha de conexao
	Private bancoDados			'Catalogo (Banco de Dados) de conexao
	Private servidor			'N�mero do servidor. No nosso caso: 001, 005 ou 006. Futuramente sera incluido o servidor externo.
	
	Private camposTabela		'Dictionary com os nomes das colunas da tabela
	Private camposChaveValor	'Dictionary com as chaves e os valores a serem inseridos
	Private condicaoChaveValor	'Dictionary com as chaves e os valores dos condicionais.
	
	Private itensChave			'Dictionary com as chaves a serem consultados
	Private ordenacaoChave		'Dictionary com as chaves a serem utilizados como criterio de ordenacao
	
	Private transacaoIniciada	'Variavel booleana que verifica se tem alguma transa��o aberta.
	
'------------------------------------------------------------ Construtor e Destrutor.
	'Construtor
	Private Sub Class_Initialize()
		Set objConexao = Server.CreateObject("ADODB.Connection")
		Set objRS = Server.CreateObject("ADODB.Recordset")
		stringConexao = ""
		id = ""
		senha = ""
		catalogo = ""
		servidor = ""
		transacaoIniciada = false
	End Sub
	
	'Destrutor
	Private Sub Class_Terminate()
		On Error Resume Next
		objConexao.Close
		objRS.Close
		Set Objeto = Nothing
		Set objRS = Nothing
		On error Goto 0
	End Sub
	
'------------------------------------------------------------ Propriedades

	'Descri��o:		Manusear o timeOut da conex�o (objConexao.ConnectionTimeout).
	'				Para que a conex�o fique ativa por tempo indeterminado, tempo deve ser igual a 0(Zero).
	'Par�metros:	tempo	- inteiro em segundos. Tempo que a conex�o vai ficar ativa.
	'Retorno:		inteiro	- tempo limite para a conex�o.
	Public Property Let tempo ( segundos )
		If conectado Then
			If tempoValor < 0 Then
				objConexao.ConnectionTimeout = 0
			Else
				objConexao.ConnectionTimeout = segundos
			End If
		End If
	End Property
	
	Public Property Get tempo ()
		If conectado Then
			tempo = objConexao.ConnectionTimeout
		Else
			tempo = 0
		End If
	End Property

	'Descri��o:		Propriedades que identificao se o RecorSet esta no In�cio(EOF) ou no Final(BOF).
	'				Se o RecordSet estiver fechado, o ponteiro estar� no Final, logo EOF = True.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Property Get inicio ()
		If consultado Then
			if objRS.BOF then
				inicio = True
			else
				inicio = False
			end if
		Else
			inicio = False
		End If
	End Property
	
	Public Property Get fim ()
		If consultado Then
			if objRS.EOF then
				fim = True
			else
				fim = False
			end if
		Else
			fim = False
		End If
	End Property
	
'------------------------------------------------------------ Funcoes
	
	'Descri��o:		Verifica se a conex�o est� aberta.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Function conectado ()
		If objConexao.State > 0 Then
			conectado = True
		Else
			conectado = False
		End If
	End Function
	
	'Descri��o:		Verifica se o RecordSet est� aberto.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Function consultado ()
		If objRS.State > 0 Then
			consultado = True
		Else
			consultado = False
		End If
	End Function
	
	'Descri��o:		Gera a string de conex�o com o servidor. Realiza a conex�o com o servirdor.
	'Par�metros:	servidor	- Nome/numera��o do servidor � se conectar.
	'				bancoDados	- Nome (cat�logo) do banco de dados.
	'Retorno:		True ou False.
	Public Function abrir ( servidor, bancoDados )
		fechar
		'Conecta-se apenas com os servidores 001, 005 ou 006.
		'Depois de especificado deve ser alterada esta funcao para permitir conexao com o servidor externo.
		If servidor  = "001" or servidor = "005" or servidor = "006" Then
			
			id			= "todos"		'id de conexao
			senha		= "todosce"		'Senha de conexao
			bancoDados	= bancoDados	'Banco de Dados. oO
			servidor	= servidor		'Servidor. oO
			
			stringConexao = ""
			stringConexao = " Provider				= SQLOLEDB; " & _
							" Persist Security Info	= True; " & _
							" user id				= "& id &"; " & _
							" password				= "& senha &"; " & _
							" Initial Catalog		= "& bancoDados &"; " & _
							" Data Source			= CE7180NT"& servidor &";"
			If servidor = "001" Then stringConexao = Replace(stringConexao, "NT001", "SR001")
			
			objConexao.ConnectionString = stringConexao
			objConexao.Open
			objConexao.CursorLocation = 3
			abrir = True			
		Else			
			abrir = False			
		End If
	End Function
	
	'Descri��o:		Fecha a conex�o com o servidor. Verificando antes se a conex�o est� aberta.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Function fechar ()
		on error resume next
		'Fecha algum RecordSet que esteja aberto.
		If consultado Then
			objRS.Close
		End If
		
		'Fecha a conexao.
		If conectado Then
			objConexao.Close
			fechar = True
		Else
			fechar = False
		End If
		
	End Function
	
	'Descri��o:		Manipula o deslocamento dentro de RecordSet.
	'				Nesta fun��o move para a pr�xima tupla.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Function proximo ()
		If consultado Then
			If Not objRS.EOF Then
				objRS.MoveNext
				proximo = not objRS.eof 'True pra nao fim do arquivo
			Else
				proximo = False
			End If
		End If
	End Function
	
	'Descri��o:		Manipula o deslocamento dentro de RecordSet.
	'				Nesta fun��o move para a tupla anterior.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Function anterior ()
		If consultado Then
			If Not objRS.BOF Then
				objRS.MovePrevious
				anterior = not objRS.bof 'true pra nao inicio do arquivo
			Else
				anterior = False
			End If
		End If
	End Function
	
	'Descri��o:		Manipula o deslocamento dentro de RecordSet.
	'				Nesta fun��o move para a primeira tupla.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Function primeiro ()
		If Not (objRS.BOF And objRS.EOF) Then
			objRS.MoveFirst
			primeiro = True
		Else
			primeiro = False
		End If
	End Function
	
	'Descri��o:		Manipula o deslocamento dentro de RecordSet.
	'				Nesta fun��o move para a ultima tupla.
	'Par�metros:	-
	'Retorno:		True ou False.
	Public Function ultimo ()
		if consultado then
			If Not (objRS.BOF And objRS.EOF) Then
				objRS.MoveLast
				ultimo = True
			end if
		Else
			ultimo = False
		End If
	End Function
	
	'Descri��o:		Captura o valor de um campo (coluna) dan tabela em pesquisada.
	'Par�metros:	nomeCampo	- string. O nome do campo (coluna) da tabela.
	'Retorno:		Valor do campo pesquisado.
	Public Function campo (nomeCampo)
		If consultado then
			if Not (objRS.BOF And objRS.EOF)  then
				campo = objRS(nomeCampo)
			end if
		end if
	End Function
	
	'Descri��o:		Inicia uma Transa��o.
	'Par�metros:	-
	'Retorno:		True ou False
	Public Function iniciarTransacao()
		If conectado and not transacaoIniciada Then
			objConexao.BeginTrans
			transacaoIniciada = true
			iniciarTransacao = true
		Else
			iniciarTransacao = false
		End If
	End Function
	
	'Descri��o:		Realiza Commit na Transa��o caso opera��es, inser��es e edi��es, realizadas sem erro.
	'				Caso tenha ocorrido algum erro realiza um RollBack no BD.
	'Par�metros:	-
	'Retorno:		True ou False
	Public Function salvarTransacao()
		If conectado and transacaoIniciada Then
			If objConexao.Errors.Count > 0 Then
				objConexao.RollbackTrans
				salvarTransacao = False
			Else
				objConexao.CommitTrans
				salvarTransacao = True
			End If
			transacaoIniciada = False
		Else
			salvarTransacao = False
		End If
	End Function
	
	'Descri��o:		Executa o comando SQL v�lido contido em 'comando'.
	'				Captura o valor de um campo (coluna) dan tabela em pesquisada.
	'Par�metros:	comando	- string. String com instru��es SQL.
	'Retorno:		RecordSet contendo a execu��o do comando SQL.
	Public Function executar ( comando )
		'Verifica se existe um RecordSet aberto para fech�-lo.
		If consultado Then
			on error resume next
			objRS.movefirst			'para resolver bug que n�o fechava o objRS.
			objRS.Close
			set objRS = nothing
			set objRS = server.createObject("ADODB.RecordSet")
			on error goto 0
		End If
		
		'Abre um novo RecordSet com o comando em SQL.
		
		objRS.Open comando, objConexao, 3, 3
		
		Set executar = objRS
		
	End Function
	
	'Descri��o:		Executa uma consulta SQL v�lida e abre um recordSet com a referida tabela.
	'Par�metros:	tabela		- string. Nome da tabela no BD.
	'				condicao	- string. Com as condi��es da cl�usula WHERE, mas sem o WHERE.
	'				ordenacao	- string. Com as condi��es de ordena��o da cl�usula ORDER BY, mas sem o ORDER BY.
	'Retorno:		RecordSet contendo os dados da consulta SQL.
	Public Function consultar ( tabela, condicao, ordenacao )
		'Adiciona a condi��o � consulta.
		If Trim(condicao) <> "" Then
			condicao = " WHERE " & condicao
		End If
		
		'Adiciona a ordenacao � consulta.
		If Trim(ordenacao) <> "" Then
			ordenacao = " ORDER BY " & ordenacao
		End If
		
		'Executa a consulta.
		'response.write "SELECT * FROM " & tabela & condicao & ordenacao
		executar "SELECT * FROM " & tabela & condicao & ordenacao

		Set consultar = objRS
	End Function
	
	'Descri��o:		Seta dois Dictionary que serao utilizados nas funcoes de inserir e atualizar.
	'				Esta fun��o � utilizada no in�cio do processo de insert.
	'Par�metros:	-
	'Retorno:		True
	Public Function novo ()
		'Dictionary que recebera os campos das colunas.
		Set camposChaveValor = nothing
		Set camposChaveValor = CreateObject("Scripting.Dictionary")
		
		'Dictionary que recebera as chaves e os valores a serem atribuidos na cl�usula WHERE do SQL.
		Set condicaoChaveValor = nothing
		Set condicaoChaveValor = CreateObject("Scripting.Dictionary")
		
		'Dictionary que recebera as chaves a serem atribuidos na cl�usula SELECT do SQL.
		Set itensChave = nothing
		Set itensChave = CreateObject("Scripting.Dictionary")
		
		'Dictionary que recebera as chaves e os valores a serem atribuidos na cl�usula ORDER BY do SQL.
		Set ordenacaoChave = nothing
		Set ordenacaoChave = CreateObject("Scripting.Dictionary")
		
		novo = true
	End Function
	
	'Descri��o:		Seta dois Dictionary que serao utilizados nas funcoes de inserir e atualizar.
	'				Esta fun��o � usada no in�cio do processo de update.
	'Par�metros:	-
	'Retorno:		True
	Public Function editar ()
		editar = novo		'Fun��o id�ntica � fun��o novo.
	End Function
	
	'Descri��o:		Adiciona os valores ao Dictionary camposChaveValor para posterior inser��o na tabela.
	'				Esta fun��o � usada no processo de insert, update e select(buscar).
	'Par�metros:	chave	- string. String com o campo da tabela.
	'				valor	- string. String com o valor do referido campo.
	'Retorno:		True
	Public Function add ( chave, valor )
		camposChaveValor.add Ucase(chave), valor
		add = True
	End Function
	
	'Descri��o:		Adiciona os valores ao Dictionary condicaoChaveValor para montagem da cl�usula WHERE.
	'				Esta fun��o � usada no processo de update e select (buscar).
	'Par�metros:	chave	- string. String com o campo da tabela.
	'				valor	- string. String com o valor do referido campo.
	'Retorno:		True
	Public Function where ( chave, valor )
		condicaoChaveValor.add Ucase(chave), valor
		condicao = True
	End Function
	
	'Descri��o:		Adiciona os valores ao Dictionary itensChave para montagem da cl�usula SELECT.
	'				Esta fun��o � usada no processo de select (buscar).
	'Par�metros:	chave	- string. String com o campo da tabela.
	'Retorno:		True
	Public Function itens ( chave )
		itensChave.add Ucase(chave), " "
		itens = True
	End Function
	
	'Descri��o:		Adiciona os valores ao Dictionary ordenacaoChave para montagem da cl�usula ORDER BY.
	'				Esta fun��o � usada no processo de update.
	'				Caso seja necessario de DESC no ORDER BY, esse deve ser inserido no Dictionary.
	'Par�metros:	chave	- string. String com o campo da tabela a ser integrado no order by.
	'Retorno:		True
	Public Function ordena ( chave )
		ordenacaoChave.add Ucase(chave), " "
		ordena = True
	End Function
	
	'Descri��o:		Executa uma consulta SQL v�lida e abre um recordSet com a referida tabela.
	'				A condicao sera montada a partir das funcoes add (ou where) (uso de colecoes).
	'Par�metros:	tabela		- string. Nome da tabela no BD.
	'Retorno:		RecordSet contendo os dados da consulta SQL.
	Public Function buscar ( tabela )
		on error resume next
		
		'Dictionary com os campos da tabela.
		Dim chaves 
		Set chaves = server.createObject("Scripting.Dictionary")
		
		'Alimenta o Dictionary com todos os campos n�o auto-incrementaveis da tabela.
		consultar tabela, "1=2", ""
		For Each campos In objRS.Fields
			'If Not campos.Properties("isAutoIncrement") Then
				chaves.add Ucase(campos.Name), ""
			'End If
		Next		
		
		dim flagOrder
		condicional = ""
		flagConsultaErro = 0 'flag para indicar que houve erro no processo de sele��o.
		contador = 0
		flagAsterisco = 1 'flag para indicar o uso do '*' no SELECT.
		flagOrder = 0 'flag para indicar o uso do ORDER BY na consulta.

		'Percorre todos as chaves do Dictionary itensChave (funcao itens)
		For Each atual In itensChave
			'verificando se as chaves do dicionario de condicionais batem com as colunas das tabelas
			If chaves.Exists(atual) Then
				contador = contador + 1
				flagAsterisco = 0 'indica que nao sera utilizado '*' no select.
				'seleciona monta a cl�usula SELECT sem o SELECT.
				if contador = 1 then 'apenas uma condicao ou primeira condicao de um conj. de condicoes.
					seleciona = " "& atual 
				else
					seleciona = seleciona &" , "& atual
				end if
			Else
				'nao existe na tabela a coluna especificada.
				flagConsultaErro = 1
				exit for
			End If
		Next
		'response.write "a: "&seleciona
		'response.End()
		contador = 0 'o contador agora determinara a montagem do WHERE
		'Percorre todos as cahves do Dictionary camposChaveValor (funcao add)
		For Each atual In camposChaveValor
			If IsNull(camposChaveValor.Item(atual)) Then
				camposChaveValor.Item(atual) = " IS NULL"
			Else
				camposChaveValor.Item(atual) = " = '" & camposChaveValor.Item(atual) & "' "
			End If
			'verificando se as chaves do dicionario de condicionais batem com as colunas das tabelas
			If chaves.Exists(atual) Then
				contador = contador + 1
				'condicional monta a cl�usula WHERE sem o WHERE.
				if contador = 1 then 'apenas uma condicao ou primeira condicao de um conj. de condicoes.
					condicional = " " & atual & camposChaveValor.Item(atual)
				else
					condicional = condicional & " AND " & atual & camposChaveValor.Item(atual)
				end if
			Else
				'nao existe na tabela a coluna especificada.
				flagConsultaErro = 1
				exit for
			End If
		Next
		
		'Percorre todos as cahves do Dictionary condicaoChaveValor (funcao where)
		For Each atual In condicaoChaveValor
			If IsNull(condicaoChaveValor.Item(atual)) Then
				condicaoChaveValor.Item(atual) = " IS NULL"
			Else
				condicaoChaveValor.Item(atual) = " = '" & condicaoChaveValor.Item(atual) & "' "
			End If
			'verificando se as chaves do dicionario de condicionais batem com as colunas das tabelas
			If chaves.Exists(atual) Then
				contador = contador + 1
				'condicional monta a cl�usula WHERE sem o WHERE.
				if contador = 1 then 'apenas uma condicao ou primeira condicao de um conj. de condicoes.
					condicional = " " & atual & condicaoChaveValor.Item(atual)
				else
					condicional = condicional & " AND " & atual & condicaoChaveValor.Item(atual)
				end if
			Else
				'nao existe na tabela a coluna especificada.
				flagConsultaErro = 1
				exit for
			End If
		Next
		
		contador = 0
		'Percorre todos as cahves do Dictionary ordenacaoChave (funcao ordenacao)
		For Each atual In ordenacaoChave
			if inStr(1, atual, " DESC") > 0 then
				campoVerificado = replace(atual, " DESC", "")
			else
				campoVerificado = atual
			end if
				
			'verificando se as chaves do dicionario de condicionais batem com as colunas das tabelas
			If chaves.Exists(campoVerificado) Then
				flagOrder = 1 'flag para indicar o uso do ORDER BY na consulta.
				contador = contador + 1
				'ordena monta a cl�usula ORDER BY sem o ORDER BY.
				if contador = 1 then 'apenas uma condicao ou primeira condicao de um conj. de condicoes.
					ordenaPor = " "& atual 
				else
					ordenaPor = ordenaPor &" , "& atual
				end if
			Else
				'nao existe na tabela a coluna especificada.
				flagConsultaErro = 1
				exit for
			End If

		Next
		
		'O select � executado dentro desta estrutura de controle.
		if flagConsultaErro = 0 or true then
			
			if flagAsterisco = 1 then 'usa asterisco no select
				seleciona = "*"
			else 'usa campos definidos no select
				seleciona = seleciona
			end if
			
			if ""&condicional = "" and flag then 'sem condicional -> sem where
				onde = ""
			else 'com condicional -> com where
				onde = " WHERE " & condicional
			end if
			
			if flagOrder = 1 then 'com ordena -> com order by
				ordenado = " ORDER BY " & ordenaPor
			else 'com ordena -> com order by
				ordenado = ""
			end if
			
			'Montagem da string de atualizacao e execucao do comando SQL.
			consultaSql = "SELECT "& seleciona &" FROM "& tabela &" "& onde &" "& ordenado
			consultaSql = replace(consultaSql,"'FALSE'","'0'")
			consultaSql = replace(consultaSql,"'TRUE'","'1'")
			consultaSql = replace(consultaSql,"'False'","'0'")
			consultaSql = replace(consultaSql,"'True'","'1'")
			'response.write "<br>"&consultaSql&"<br>"
			
			executar consultaSql
			'Set consultar = objRS
			if Err.Number = 0 then
				'buscar = True
			else
				'buscar = False
			End If
			
		else
			
			'response.write "conjunto de chaves nao existente."
			'buscar = False
			
		end if
		
		Set chaves = Nothing
		Set buscar = objRS 'retorno da funcao
		
	End Function
	
	'Descri��o:		Salva, na referida tabela, os valores determinados no processo de insert ou update.
	'Par�metros:	tabela	- string. String com o nome da tabela.
	'Retorno:		True ou False
	Public Function salvar (tabela)
		on error resume next
		Dim condicao
		Dim novosValores
		Dim atualizacao
		Dim ultimoId 
		ultimoId = 0
		'Dictionary com os campos da tabela.
		Dim chaves 
		Set chaves = server.createObject("Scripting.Dictionary")
		
		'Alimenta o Dictionary com todos os campos n�o auto-incrementaveis da tabela.
		consultar tabela, "1=2", ""
		For Each campos In objRS.Fields
			'If Not campos.Properties("isAutoIncrement") Then
				chaves.add Ucase(campos.Name), ""
			'End If
		Next
		
		'Verifica se � um processo de update ou insert.
		if condicaoChaveValor.Count <> 0 then
			'condicaoChaveValor tem campos apenas no processo de update.
			condicao = ""
			novosValores = ""
			flagEdicaoErro = ""
			
			'Percorre todos as cahves do Dictionary condicaoChaveValor
			For Each atual In condicaoChaveValor
				If IsNull(condicaoChaveValor.Item(atual)) Then
					condicaoChaveValor.Item(atual) = " IS NULL"
				Else
					condicaoChaveValor.Item(atual) = " = '" & condicaoChaveValor.Item(atual) & "' "
				End If
				'verificando se as chaves do dicionario de condicionais batem com as colunas das tabelas
				If chaves.Exists(atual) Then
					
					flagEdicaoErro = 0 'flag para indicar que houve erro no processo de edi��o.
					contador = contador + 1
					
					'condicional � usado como par�metro da funcao consultar, que altera a string adicionando um WHERE.
					'condicao � usado no restante desta fun��o.
					if contador = 1 then 'apenas uma condicao ou primeira condicao de um conj. de condicoes.
					
						condicional = " "& atual & condicaoChaveValor.Item(atual)
						condicao 	= " "& atual & condicaoChaveValor.Item(atual)
						
					else
					
						condicional = condicional & " AND " & atual & condicaoChaveValor.Item(atual)
						condicao 	= condicao 	  & " AND " & atual & condicaoChaveValor.Item(atual)
						
					end if
				Else
					flagEdicaoErro = 1
					'exit for
					
				End If
			Next
			
			if flagEdicaoErro = 0 then
				
				contador = 0
				'Percorre todos as chaves do Dictionary camposChaveValor
				
				For Each atual In camposChaveValor
					'verificando se as chaves do dicionario de novos valores batem com as colunas das tabelas
					If chaves.Exists(atual) Then
						contador = contador + 1
						
						if contador = 1 then 'apenas um campo ou primeiro campo de um conj. de condicoes.
							campos = " "& atual &" = '"& camposChaveValor.Item(atual) &"' "
						else
							if isNull(camposChaveValor.Item(atual)) then
								campos = campos &" , "& atual &" = null "
							else
								campos = campos &" , "& atual &" = '"& camposChaveValor.Item(atual) &"' "
							end if
						end if
						
					End If
				Next
				
				'Montagem da string de atualizacao e execucao do comando SQL.
				atualizacao = "UPDATE " & tabela & " SET " & campos & " WHERE " & condicao
				atualizacao = replace(atualizacao,"'FALSE'","'0'")
				atualizacao = replace(atualizacao,"'TRUE'","'1'")
				atualizacao = replace(atualizacao,"'False'","'0'")
				atualizacao = replace(atualizacao,"'True'","'1'")
				objConexao.Execute (atualizacao)
				'response.write atualizacao
				if Err.Number = 0 then
					salvar = True
				else
					salvar = False
				End If
				
				Set chaves = Nothing
				
			else
				'response.write "conjunto de chaves nao existente."
				salvar = False
			end if
			
		else
		
			objRS.AddNew
			'verificando se as chaves do dicionario de novos valores batem com as colunas das tabelas
			For Each atual In camposChaveValor
				If chaves.Exists(atual) Then
					objRS(atual) = camposChaveValor.Item(atual)
					'response.write atual & " " & camposChaveValor.Item(atual) & "<br>"
				End If
			Next
			objRS.Update
			ultimoId = 0
			temp = objConexao.execute ("Select @@IDENTITY as ultId")
			ultimoId = temp("ultId")
			if isNumeric("" & ultimoId) then salvar = true
		end if
		
		
		if Err.Number = 0 and salvar then
			salvar = True
			if ultimoId <> 0 then salvar = ultimoId
		else
			salvar = False
			'response.write "erro ao salvar."
		End If
		
		Set chaves = Nothing
		
	End Function
	
	'Descri��o:		Insere tuplas na tabela em quest�o.
	'				Usando um Dictionary determindado no programa, fora do escopo destas fun��es.
	'Par�metros:	tabela	- string. String com o nome da tabela que ter� tuplas inseridas.
	'				dic		- dictionary. Dictionary com as chaves e os valores dos campos a serem inseridos.
	'Retorno:		True ou False
	Public Function inserir ( tabela, dic )
		'Abre um novo RecordSet vazio (where 1 = 2).
		consultar tabela, "1=2", ""
		
		'Dictionary que recebera os campos das volunas.
		Set camposTabela = CreateObject("Scripting.Dictionary")
		
		'Constroi o Dictionary com os nomes das colunas (campos da tabela) n�o incrementadas automaticamente.
		total = 0
		For a = 0 to objRS.Fields.Count - 1
			If Not objRS.Fields(a).Properties("isAutoIncrement") Then
				'total = n�mero de campos n�o increment�veis automaticamente.
				total = total + 1
				
				'Dictionary com os campos da tabela.
				camposTabela.Add a, UCase(objRS.Fields(a).Name)
			end if
		Next
		
		'Verifica se temos campos na tabela aptos a receber valores. Que n�o sejam increment�veis automaticamente.
		if camposTabela.Item(0) <> "" then
			
			objRS.AddNew
			
			'percorre todo o Dictionary com os campos, aptos a receberem valores, da tabela.
			for each elemento in camposTabela
				
				'percorre todo o Dictionary com os campos e os valores a serem inseridos.
				for each elemento2 in dic
					
					'Caso as chaves realmente existam � inserido na estrutura de insert.
					if Ucase( camposTabela.Item(elemento) ) = Ucase ( elemento2 ) then
						objRS( Ucase( trim( elemento2 ) ) ) = trim( dic.Item(elemento2) )
					end if
					
				next
				
			next
			
			on error resume next
			objRS.Update
			if Err.Number = 0 then
				inserir = True
			else
				inserir = False
			end if
			
		else
			inserir = False
			'response.write "nao temos campos nesta tabela habilitados para inser��o de dados."
		end if
		
		'Limpa o Dictionary.
		camposTabela.RemoveAll
		
	End Function
	
	'Descri��o:		Exclui as tuplas que estejam satisfazendo a cl�usula WHERE, na tabela em quest�o.
	'Par�metros:	tabela		- string. String com o nome da tabela que ter� tuplas exclu�das.
	'				condicional	- string. String com o a forma��o da cl�usula WHERE, sem o WHERE. oO
	'Retorno:		True ou False
	Public Function excluir ( tabela, condicional )
		'Abre um novo RecordSet.
		consultar tabela, "1=2", ""
		excluir = False
		
		'Adiciona � string SQL a cl�usula WHERE com as condi��es desejadas para exclus�o.
		If Trim(condicional) <> "" Then
			condicional = " WHERE " & condicional
		End If
		
		on error resume next
		if err.number = 0 then
			
			excluir = executar ("DELETE FROM " & tabela & condicional)
			
		elseif err.number <> 0 then
			
			msgErro = "Error: N�o foi possivel excluir os dados da tabela."
			excluir = False
			
		end if

	End Function

end class


'------------------------------------------------------------ Modos de Usar (exemplos)

'--- Iniciando conexao com o servidor
'	dim obj
'	set obj = new cConexao
'	obj.abrir "005", "pubs"

'--- Fechando conexao com o servidor
'	obj.fechar()
'	response.write obj.conectado() 'apenas para verificar se esta fechda a conexao

'--- Verificando conexao
'	conexao.conectado()

'--- Consultando valores
'	obj.consultar "Tb_Usuarios", "condicao","ordenacao"

'--- Capturando e imprimindo valores de RecordSet

'	obj.consultar "TB_USUARIOS", "nome = 'pessoa1'", ""
'	response.write obj.campo("matricula")

'	obj.consultar "TB_USUARIOS", "", ""
'	do
'		response.write obj.campo("matricula") &"-"& obj.campo("nome") & "<br>"
'	loop while obj.proximo

'	obj.consultar "TB_USUARIOS", "", ""
'	obj.primeiro
'	while not obj.fim
'		response.write obj.campo("matricula") & " - " & obj.campo("nome") & "<br>"
'		obj.proximo
'	wend


'	obj.consultar "TB_USUARIOS", "", ""
'	obj.primeiro
'	do
'		response.write obj.campo("nome") &" existe proximo: "
'		retorno = obj.proximo()
'		response.write retorno & "<br>"
'	loop while retorno


'--- inserindo novos valores
'	obj.novo ()
'	obj.add "Nome", "Nome3"
'	obj.add "Matricula", "000004"
'	obj.add "cargo", 2
'	obj.salvar("TB_USUARIOS")

'--- editando valores anteriores
'	obj.editar ()
'	obj.add "Nome", "UHU"
'	obj.add "sexo", "1"
'	obj.add "NU_float", "123.123"
'	obj.where "Nome", "NomeTeste"
'	obj.salvar ("TB_USUARIOS")

'--- inserindo valores atrav�s de um Dictionary

'	Dim dic
'	Set dic = CreateObject("Scripting.Dictionary")
'	dic.Add "matricula", "00000X"
'	dic.Add "nome", "pessoaX"
'	dic.Add "cargo", "1"
'	dic.Add "sexo", "0"
'	dic.Add "ativo", "1"
'	obj.inserir ("TB_USUARIOS", dic)

'--- Excluindo valores
'	obj.excluir "TB_USUARIOS", "matricula = '222222'"
'	obj.excluir "TB_USUARIOS", "nome = 'teste'"

'--- Executando um comando SQL
'	obj.executar "DELETE FROM TB_USUARIOS WHERE nome = 'pessoa4'"

'--- EM VERIFICACAO E VALIDACAO Busca (Select) usando colecoes das funcoes add e where.
'	obj.novo ()								'inicia processo
'	obj.itens "matricula"					'seleciona os itens para a consulta
'	obj.itens "nome"
'	obj.add "Nome", "Pessoa1"				'adiciona condicoes no where
'	obj.add "Matricula", "000001"
'	obj.where "cargo", 1
'	obj.ordena "nome DESC"					'adiciona condicoes no where
'	obj.ordena "matricula"
'	obj.buscar("TB_USUARIOS")				'inicia a busca
'	response.write obj.campo("Matricula")	'imprime o valor do campo especificado.
%>