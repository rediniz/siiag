<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%
	response.expires  = 0
  gerente = request("gerente")
  substituto = request("substituto")
  edicao = request("edicao")
  
  	query = "SELECT CO_MATRICULA, NO_NOME FROM VW_USUARIOS WHERE letra = 'C' and (CO_GERENTE = '"&gerente&"') AND (IC_ATIVO = 1) AND (CO_MATRICULA <> '"&gerente&"') AND (CO_CARGO <> 11) ORDER BY NO_NOME"
	query_coordenadores = "SELECT USUARIO.CO_MATRICULA, USUARIO.NO_NOME FROM VW_GS AS GS JOIN TB_USUARIOS AS USUARIO ON GS.CO_GERENTE=USUARIO.CO_MATRICULA WHERE GS.IC_ATIVO = 1 AND GS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&"  and CO_MATRICULA <> 'C022903' ORDER BY USUARIO.NO_NOME"
	
	if gerente = "C022903" then
		set ds=Server.CreateObject("ADODB.RecordSet")
				ds.Open query_coordenadores, dados_sys
				DO UNTIL ds.eof
					MATRICULA_SUBSTITUTO=ds("CO_MATRICULA")
					NOME_SUBSTITUTO=ds("NO_NOME")
					response.write "<option value="&ds("CO_MATRICULA")&">"&NOME_SUBSTITUTO&"</option>"
					ds.movenext
				LOOP
				set ds = nothing
	    set query_coordenadores = nothing
	else		
		set ds=Server.CreateObject("ADODB.RecordSet")
				ds.Open query, dados_sys
				DO UNTIL ds.eof
					MATRICULA_SUBSTITUTO=ds("CO_MATRICULA")
					'if MATRICULA_SUBSTITUTO <> gerente then
					NOME_SUBSTITUTO=ds("NO_NOME")
						
							response.write "<option value="&ds("CO_MATRICULA")&">"&NOME_SUBSTITUTO&"</option>"
				
					ds.movenext
				LOOP
				set ds = nothing
	  
	  set query = nothing
	end if 
%>