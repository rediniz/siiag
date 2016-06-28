<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%

	matricula = request("matricula")
	 
	nome = request("nome") 
	situacao = request("situacao") 
	data = request("data")  
	gozo = request("gozo") 
	parcelas = request("parcelas") 
	diasAbono = request("diasAbono") 
	abono = request("abono") 
	co_ferias = request("co_ferias")

	ic_aviso_assinado = request("ic_aviso_assinado")
	ic_requerimento = request("ic_requerimento")
	ic_substituicao = request("ic_substituicao")
	
	if (ic_aviso_assinado) = "" then
		ic_aviso_assinado = 0
	end if
	
	if (ic_requerimento) = "" then
		ic_requerimento = 0
	end if
	
	if (ic_substituicao) = "" then
		ic_substituicao = 0
	end if

	observacaoEdicao = request("observacaoEdicao")
	
	if diasAbono = "" Then
	
	diasAbono = 0
	
	END IF

	dt_ini_atdmt = Request("dt_ini_atdmt")
	dt_prev_conc = Request("dt_prev_conc")
	
	response.write  dt_ini_atdmt & "<br>"
	response.write  dt_prev_conc & "<br>"

	sql = "UPDATE TB_FERIAS SET CO_SITUACAO="&situacao&", DT_INICIO='"& data &"', QT_DIAS="& gozo &",QT_PARCELAS ="& parcelas & ",IC_ABONO="&abono&",DIAS_ABONO="&diasAbono&", DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"', obs_edicao = '"&observacaoEdicao&"', IC_AVISO_ASSINADO = "&ic_aviso_assinado&",IC_REQUERIMENTO= "&ic_requerimento&",IC_SUBSTITUICAO= "&ic_substituicao&" "
	
	
	select case situacao
	
		'Se a demanda estiver sendo finalizada
		case "2", "7"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			sql = sql & ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_FERIAS WHERE CO_FERIAS = " & co_ferias
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				sql = sql & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
			
		case "7"
		
			sql = sql & ", IC_CANCELAMENTO = 0"
	
	end select
	
	sql = sql & ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"' WHERE CO_FERIAS = " & co_ferias
	response.write sql
	objConn.execute(sql)
		
	
%>