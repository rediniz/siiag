<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
 				
data_inicio = Request("data_inicio")
data_final = Request("data_final")
motivo = Request("motivo")
substituto = Request("substitutos")

'#ALTERADO EM 12/04/2016
empregado = Request("empregados")

co_substituicao = Request("co_substituicao")
situacao = Request("situacao")

'#ALTERADO em 01/12/2015 (adicionado)===
dt_ini_atdmt = request("dt_ini_atdmt")
dt_prev_conc = request("dt_prev_conc")
'=======================================

'#ALTERADO EM 11/04/2016
observacaoEdicao = request("observacaoEdicao")

'#ALTERADO em 01/12/2015 (comentado, pois era desnecessário)===
'response.write "co_substituicao: " & co_substituicao
'response.write "gerencia_gerente: " & gerencia_gerente
'response.write "substituto: " & substituto
'response.write "motivo: " & motivo
'response.write "data_inicio: " & data_inicio
'response.write "data_final: " & data_final
'===============================================================

	'#ALTERADO EM 11/04/2016
	query = "UPDATE TB_SUBSTITUICOES SET CO_SUBSTITUTO='"&substituto&"', DT_INICIO='"&data_inicio&"', DT_FIM='"&data_final&"', CO_SITUACAO="&situacao&", CO_TIPO_AFASTAMENTO="&motivo&", DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"'"
	
	select case situacao
	
		'Se a demanda estiver sendo finalizada
		case "2", "6"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			query = query &  ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_SUBSTITUICOES WHERE CO_SUBSTITUICAO="&co_substituicao&""
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				query = query & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
			
		case "7"
		
			query = query & ", IC_CANCELAMENTO = 0"
	
	end select
	
	query = query & ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"' WHERE CO_SUBSTITUICAO="&co_substituicao&""
	objConn.execute(query)
	
	'=============================================================================================

set query = nothing
objConn.close

%>