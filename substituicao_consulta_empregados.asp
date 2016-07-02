<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
  	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	empregado = request("empregado")
	gerente = request("gerente")
	edicao = request("edicao")
	substituto = request("substituto")

   queryCargo = "select co_cargo from tb_usuarios where co_matricula = '"&empregado&"'"
   cargo = objConn.execute(queryCargo)("CO_CARGO")
   
  if cargo = 1 then
	  query = "SELECT CO_MATRICULA, NO_NOME FROM VW_USUARIOS WHERE (letra = 'C') AND (IC_ATIVO = 1) AND (CO_MATRICULA <> '"&gerente&"') AND (CO_UNIDADE =  "& request.Cookies("co_usuario_unidade_siiag") &") ORDER BY NO_NOME"
	
	  set ds=Server.CreateObject("ADODB.RecordSet")
	  ds.Open query, dados_sys

	  DO UNTIL ds.eof
		MATRICULA_SUBSTITUTO=ds("CO_MATRICULA")
		NOME_SUBSTITUTO=ds("NO_NOME")
		if edicao = "true" and substituto = MATRICULA_SUBSTITUTO then
			response.write "<option value="&ds("CO_MATRICULA")&" selected = 'selected'>"&NOME_SUBSTITUTO&"</option>"
		else
			response.write "<option value="&ds("CO_MATRICULA")&">"&NOME_SUBSTITUTO&"</option>"
		end if
		ds.movenext
	  LOOP
  else
  
	matriculaUsuario = Session("v_Usuario_Matricula")
	'#ALTERADO em 14/04/2016 (adicionado ORDER BY NO_NOME na query)
	if edicao = "true" then
		queryColaboradores = "SELECT * FROM VW_USUARIOS WHERE CO_GS = (SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '"&empregado&"') AND IC_ATIVO=1 AND LETRA = 'C' AND (CO_UNIDADE =  "& request.Cookies("co_usuario_unidade_siiag") &") ORDER BY NO_NOME"	
	else
		queryColaboradores = "SELECT * FROM VW_USUARIOS WHERE CO_GS = (SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '"&matriculaUsuario&"') AND CO_MATRICULA <> '"&empregado&"' AND IC_ATIVO=1 AND LETRA = 'C' AND (CO_UNIDADE =  '" & request.Cookies("co_usuario_unidade_siiag") & "') ORDER BY NO_NOME"
	end if
	
	set ds=Server.CreateObject("ADODB.RecordSet")
	ds.Open queryColaboradores, dados_sys 

	DO UNTIL ds.eof	
		if edicao = "true" and substituto = ds("CO_MATRICULA") then
			%>
			<option value=<%=ds("CO_MATRICULA")%> selected="selected"><%=ds("NO_NOME")%></option>
			<%
		else
			%>
			<option value=<%=ds("CO_MATRICULA")%>><%=ds("NO_NOME")%></option>
			<%
		end if
	ds.movenext
	LOOP

  end if
%>