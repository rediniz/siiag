<!-- #INCLUDE FILE ="include/Conexao.asp" -->
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

sql = "INSERT INTO TB_FERIAS(CO_MATRICULA, DT_INICIO, QT_PARCELAS, QT_DIAS, CO_SITUACAO, IC_ABONO, DH_CRIACAO, DE_OBS, DIAS_ABONO, CO_CRIADOR, CO_UNIDADE) VALUES ('"&matricula&"', '"&data_inicio_formatada&"', "&parcelas&", "&gozo&", "&situacao&", "&abono&", '"&NOW()&"', '"&observacao&"', "&diasAbono&",'"&user_logado&"', "&co_unidade&")"


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
response.Write sql
Set query = objConn.execute(sql)



	'Fechando conexão
	Set query = Nothing
	'Set query2 = Nothing
	Set objConn = Nothing


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
	Response.Redirect("ferias.asp?sucesso=true")
	
	
%>