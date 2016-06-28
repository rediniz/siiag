<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #Alteraod em 17/03/2016 -------------------------->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<!----------------------------------------------------->
<%


matricula = Request("matricula")
nome  = Request("nome")
data_inicio = Request("data_inicio")
gozo = Request("gozo")
parcelas  = Request("parcelas")
diasAbono = Request("diasAbono")
abono = Request("abono")
observacao = Request("observacao")
co_unidade = request.Cookies("co_usuario_unidade_siiag")
subs = request("subs")
'#Alterado em 17/03/2016----------------
prazoCritico = request("prazoCritico")
'---------------------------------------

if subs <> 1 then
	subs = 0
end if

situacao = 1


'formatando data

dia_inicio = DAY (data_inicio) 
mes_inicio = MONTH(data_inicio) 
ano_inicio = YEAR(data_inicio)

data_inicio_formatada = dia_inicio&"/"&mes_inicio&"/"&ano_inicio



'Pegando Co_Criador

user_logado = request.Cookies("co_usuario_siiag")


'Fim do pega Co_Criador


	    
	
' SQL de atualização na tabela protocolo	

sql = "INSERT INTO TB_FERIAS(CO_MATRICULA, DT_INICIO, QT_PARCELAS, QT_DIAS, CO_SITUACAO, IC_ABONO, DH_CRIACAO, DE_OBS, DIAS_ABONO, CO_CRIADOR, CO_UNIDADE, SOLICITOU_SUB) VALUES ('"&matricula&"', '"&data_inicio_formatada&"', "&parcelas&", "&gozo&", "&situacao&", "&abono&", '"&NOW()&"', '"&observacao&"', "&diasAbono&",'"&user_logado&"', "&co_unidade&", '"&subs&"')"
response.Write(sql)


'INSERT INTO TB_FERIAS                    
'                      (CO_MATRICULA, DT_INICIO, QT_PARCELAS, QT_DIAS, CO_SITUACAO, IC_ABONO, DH_CRIACAO, DE_OBS, DIAS_ABONO, CO_CRIADOR)
'VALUES     ('E712237', '06 / 02 / 2014', 2, 10, 1, 1, '06 / 04 / 2014', ' TESTE ', 10,'E712237')






'matricula
'data_inicio_formatada
'parcelas
'gozo
'1
'abono
'DATE(NOW())
'observacao
'diasAbono




'	
Set query = objConn.execute(sql)



	'Fechando conexão
	Set query = Nothing
	'Set query2 = Nothing
	'#Alterado em 20/03/2016--------------------------------
	'Set objConn = Nothing
	'------------------------------------------------------------


'	
''	'Se foi adicionado AR ao ofício, insere  na tabela ARS
''	if numeroAR <> "" then
''		
''		sql2 = "UPDATE TB_PROTOCOLO_ARS SET CO_TIPO="&tipoProtocolo&", NU_AR="&numeroAR&"" 
''		sql2 = "INSERT INTO TB_PROTOCOLO_ARS(NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NU_AR,CHECKED) VALUES("&numeroProtocolo&","&year(Date())&","&tipoProtocolo&","&numeroAR&",1)"
''	
''		'SQL de inserção na tabela ARS	
''		'Set query2 = conexao.execute(sql2)
''	
''	else
''	
''		sql2 = "INSERT INTO TB_PROTOCOLO_ARS(NO_PROTOCOLO,AA_PROTOCOLO,CO_TIPO,NU_AR,CHECKED) VALUES("&numeroProtocolo&","&year(Date())&","&tipoProtocolo&", null, 0)"
''	
''		'Set query2 = conexao.execute(sql2)
''	
''	end if
'	
'	'Fechando conexão
'	Set query = Nothing
'	'Set query2 = Nothing
'	Set conexao = Nothing
'	
'	'Redireciona para página anterior informando sucesso e o número do protocolo incluído
'	

'	
	'#Alterado em 17/03/2016 ------------------------------
	if prazoCritico = "true" then
		enviaEmailPrazoCritico(matricula)
	end if
	'------------------------------------------------------
	
	'#Alterado em 16/06/2016 ------------------------------
	queryIdade = "select CAST(DATEDIFF(DAY, DT_NASCIMENTO, '"&data_inicio_formatada&"') / 365.25 AS INTEGER) AS idade from tb_usuarios where co_matricula = '"&matricula&"'"
	idade = cint(objConn.execute(queryIdade)("IDADE"))
	if idade >= 50 and cint(gozo) < 30 then
		'enviaEmailMaisDe50()
	end if
	'------------------------------------------------------
	
	
	if subs <> "" then
	
		Response.Redirect("ferias.asp")
	
	else
	
		Response.Redirect("ferias.asp?sucesso=true")
	
	end if
	'response.Write(substituicao)
	
	'#Alterado em 20/03/2016 -------------------------------------------------------
	Sub enviaEmailPrazoCritico(matricula_usuario)

		vTexto = "<body>" &_
				"<font size ='2' face='Verdana'>" &_
				"<p align='center'><b>Atenção, prazo crítico!</b></p>" &_
				"<p>Favor contatar a coordenação Informações e Apoio à Gestão para confirmar a viabilidade do gozo de férias no período solicitado.</p>" &_
				"<p>Atenciosamente,<br /><br />Informações e Apoio à Gestão</p>" &_
				"</font>" &_
				"</body>" &_
				"</html>"
				
		sqlEmailCoordenacao = "SELECT EMAIL_COORDENACAO FROM TB_USUARIOS u, TB_GS c WHERE u.co_gs = c.co_gs and u.co_matricula = '"&matricula_usuario&"'"
		emailCoordenacao = objConn.execute(sqlEmailCoordenacao)("EMAIL_COORDENACAO") 
		
		response.write "<br>"& email

		If Err.Number<>0 Then
			Response.Write("Erro: " & Err.Description & "<BR>")
			Response.end	
		Else
			If Err.Number<>0 Then
				Response.Write("Erro: " & Err.Description & "<BR>")
				Response.end
			Else
				vDe =  "gifugfo@mail.caixa"
				vPara = emailCoordenacao
				vCC ="gifugfo01@mail.caixa;" & matricula_usuario & "@mail.caixa;"
				vCCO = "C124937@mail.caixa;C054423@mail.caixa;C097105@mail.caixa"
				vAssunto = "Solicitação de férias - Aviso de prazo crítico"
				vUsuario = matricula
			
				email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
			End If
		End If
	End Sub	
	'------------------------------------------------------------------------------
	
	'#ALTERADO em 10/05/2016 -------------------------------------------------------
	Sub enviaEmailMaisDe50()
		sqlEmailCoordenacao = "SELECT EMAIL_COORDENACAO, NO_GS, NO_NOME FROM TB_USUARIOS u, TB_GS c WHERE u.co_gs = c.co_gs and u.co_matricula = '"&matricula_usuario&"'"
		resultado = objConn.execute(sqlEmailCoordenacao)
		emailCoordenacao = resultado("EMAIL_COORDENACAO")
		nomeCoordenacao = resultado("NO_GS")
		nomeUsuario = resultado("NO_NOME")
		
		'###########################[MONTA DADOS E-MAIL]############################################
		'CAPTURA DE DADOS
		
		'Substituir 'matricula' pela matrícula do empregado para o qual a atividade está sendo realizada (Férias, etc),
		'geralmente vem no request, tratar caso a caso pois o nome da varíavel muda.
		matriculaEmpregado = matricula
		infoCoordenacao = objConn.execute("SELECT EMAIL_COORDENACAO, CO_GS, u.CO_UNIDADE FROM TB_USUARIOS u, TB_GS c WHERE u.co_gs = c.co_gs and u.co_matricula = '"&matriculaEmpregado&"'")	
		emailCoordenacao = infoCoordenacao("EMAIL_COORDENACAO")
		coCoordenacao = infoCoordenacao("CO_GS")
		coUnidade = infoCoordenacao("CO_UNIDADE")
		emailRH = objConn.execute("SELECT EMAIL_COORDENACAO FROM TB_GS WHERE RH = 1")("EMAIL_COORDENACAO")
		campoCCEmpregado = matriculaEmpregado&"@mail.caixa"
		
		'PREENCHIMENTO DE DADOS
		vDe = "gifugfo@mail.caixa"
		vPara = emailRH&"@mail.caixa"
		vCC = matriculaEmpregado&"@mail.caixa;"&emailCoordenacao&"@mail.caixa;"
		if coUnidade = "7180" then
			vCC = vCC & "C054423@mail.caixa;C097105@mail.caixa"
		end if
			
		'Completar com o assunto
		
		'###########################################################################################
		
		vTexto = "<body>" &_
				"<p> Prezado "&nomeUsuario&"" &_
				"  c/c "&nomeCoordenacao&" </p>" &_
				"<p>1.    Informamos que para lançar férias com abono pecuniário e/ou em dois períodos para empregado com mais de 50 anos é necessário o requerimento formal do empregado, conforme modelo anexo. </p>" &_
				"<p> 1.1.     Solicitamos, portanto, a entrega do referido requerimento, em 2 (duas) vias. </p>" &_
				"<p> Atenciosamente </p>" &_
				"<p> Rubia Santiago Menezes Bento Gonzaga <br />" &_
				"  Assistente Júnior <br />" &_
				"  GI Fundo de Garantia Fortaleza - GIFUG/FO </p>" &_
				"</body>" &_
				"</html>"
		response.write vTexto
		
		If Err.Number<>0 Then
			Response.Write("Erro: " & Err.Description & "<BR>")
			Response.end	
		Else
			If Err.Number<>0 Then
				Response.Write("Erro: " & Err.Description & "<BR>")
				Response.end
			Else
				vDe =  "gifugfo@mail.caixa"
				vPara = emailCoordenacao
				vCC ="gifugfo01@mail.caixa;" & matricula_usuario & "@mail.caixa;"
				vCCO = "C124937@mail.caixa;C054423@mail.caixa;C097105@mail.caixa"
				vAssunto = "REQUERIMENTO PARA PARCELAMENTO E/OU CONVERSÃO EM PECÚNIA DE FÉRIAS"
				vUsuario = matricula
			
				email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
			End If
		End If
	End Sub	
	'------------------------------------------------------------------------------

%>