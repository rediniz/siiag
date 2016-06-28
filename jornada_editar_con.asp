<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	
	
   ' Pegando os valores informados pelo usuário	
	CO_MATRICULA = request("matricula") 
	NO_NOME = request("nome") 
	CO_SITUACAO = request("situacao") 
	DH_ENTRADA = request("horario_inicio")  
	DH_SAIDA = request("horario_fim") 
	DH_INTERVALO_INICIO = request("intervalo_inicio")
	DH_INTERVALO_FIM = request("intervalo_fim")
	DH_VIGENCIA = request("data") 
	CO_JORNADA = request("co_jornada")
	
	situacao = CO_SITUACAO
	
	'#ALTERADO em 01/12/2015 (adicionado)=====
	dt_ini_atdmt = request("dt_ini_atdmt")
	dt_prev_conc = request("dt_prev_conc")
	'===========================================
	
	'#ALTERADO EM 11/04/2016
	observacaoEdicao = request("observacaoEdicao")
	
	'#ALTERADO em 01/12/2015 (comentado, pois era desnecessário)=======
	'response.write  "matricula: " & CO_MATRICULA & "<br>"
	'response.write  "nome: " & NO_NOME & "<br>"
	'response.write  "situacao: " & CO_SITUACAO & "<br>"
	'response.write  "dh_entrada: " & DH_ENTRADA & "<br>"
	'response.write  "dh_saida: " & DH_SAIDA & "<br>"
	'response.write  "dh_intervalo_inicio: " & DH_INTERVALO_INICIO & "<br>"
	'response.write  "dh_intervalo_saida: " & DH_INTERVALO_FIM  & "<br>"
	'response.write  "dh_vigencia: " & DH_VIGENCIA & "<br>"
	'response.write  "co_jornada: " & CO_JORNADA & "<br>"
	'===================================================================
		' SQL de atualização na tabela 	
	'#ALTERADO EM 11/04/2016
	sql = "UPDATE TB_JORNADA SET DH_ENTRADA='"&DH_ENTRADA&"', DH_SAIDA='"& DH_SAIDA &"', DH_VIGENCIA='"& DH_VIGENCIA &"',CO_SITUACAO ="& CO_SITUACAO &", DH_INTERVALO_INICIO='"&DH_INTERVALO_INICIO&"', DH_INTERVALO_FIM='"&DH_INTERVALO_FIM&"', DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"'"
	
	select case situacao
	
		'Se a demanda estiver sendo finalizada
		case "2","6"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			sql = sql & ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_JORNADA WHERE CO_JORNADA="&CO_JORNADA&""
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				sql = sql & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
			
		case "7"
		
			sql = sql & ", IC_CANCELAMENTO = 0"
			
	end select
	
	sql = sql & ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"'  WHERE CO_JORNADA="&CO_JORNADA&""
	
	Set query = objConn.execute(sql)
	
	
	
	'============================CÓDIGO ANTIDO===========================
	' SQL de atualização na tabela 	
'	sql = "UPDATE TB_JORNADA SET DH_ENTRADA='"&DH_ENTRADA&"', DH_SAIDA='"& DH_SAIDA &"', DH_VIGENCIA='"& DH_VIGENCIA &"',CO_SITUACAO ="& CO_SITUACAO &", DH_INTERVALO_INICIO='"&DH_INTERVALO_INICIO&"', DH_INTERVALO_FIM='"&DH_INTERVALO_FIM&"'  WHERE CO_JORNADA="&CO_JORNADA&""
'	
'	Set query = objConn.execute(sql)
'		
'	'#ALTERADO em 01/12/2015 (adicionado as datas da demandas e checa se foi finalizada)======================
'	'INFORMAÇÕES DE ATENDIMENTO DA DEMANDA
'	sql_atendimento = "UPDATE TB_JORNADA SET DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"' WHERE CO_JORNADA="&CO_JORNADA&""
'	
'	objConn.execute(sql_atendimento)
'	
'	'#Alterado em 08/12/2015 (inclusão da checagem de situação pendente)
'	'Atualiza as datas da demanda de acordo com o código da situação =============================
'		
'	tabela = "tb_jornada"
'	where = "CO_JORNADA="&CO_JORNADA
'	
'	select case situacao
'	
'		'Se a demanda estiver sendo finalizada
'		case "2", "7"
'		
'			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
'			mt_conclusao = request.Cookies("co_usuario_siiag")
'			
'			query_dt_conclusao = "UPDATE "& tabela &" SET DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"' WHERE " & where
'			objConn.execute(query_dt_conclusao)
'	
'		case "3"
'		
'			dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
'			mt_conclusao = request.Cookies("co_usuario_siiag")
'			
'			query_dt_conclusao = "UPDATE "& tabela &" SET DT_PENDENTE = '"&dt_pendencia&"',  MT_CONCLUSAO = '"&mt_conclusao&"' WHERE " & where
'			objConn.execute(query_dt_conclusao)
'	
'	end select
	
	'=============================================================================================
	

	
	'Redireciona para página anterior informando sucesso e o número do protocolo incluído
	Response.Redirect("jornada_edicao.asp?codigo="&CO_JORNADA&"&sucesso=true")
	
%>