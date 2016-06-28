 <%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
 
<%	
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	local					= request("local")
	periodo_inicio			= request("periodo_inicio")
	periodo_fim 			= request("periodo_fim")
	horario_inicio 			= request("horario_inicio")
	horario_fim				= request("horario_fim")
	co_unidade				= request.Cookies("co_usuario_unidade_siiag")	
	
if local <> "" and periodo_inicio <> "" and periodo_fim <> "" and horario_inicio <> "" and horario_fim <> "" then
	
  '====================================================================================================
  'CHECA SE JÁ EXISTE UM EVENTO CADASTRADO NO MESMO HORÁRIO E LOCAL
  
  'sql_consulta = "SELECT * FROM TB_EVENTOS WHERE CO_LOCAL = "&local&" AND '"&periodo_inicio&"' BETWEEN DH_INICIO AND DH_FIM AND (DH_HORA_INICIO BETWEEN '"&horario_inicio&"' AND '"&horario_fim&"' OR DH_HORA_FIM BETWEEN '"&horario_inicio&"' AND '"&horario_fim&"') AND CO_SITUACAO IN(1,2) AND CO_UNIDADE = "&co_unidade
  

  sql_consulta = "SELECT * FROM TB_EVENTOS "
  sql_consulta = sql_consulta &  "  WHERE CO_LOCAL = "&local&" "
  
  'sql_consulta = sql_consulta & "   AND '"&periodo_inicio&"' BETWEEN DH_INICIO AND DH_FIM AND (DH_HORA_INICIO BETWEEN '"&horario_inicio&"' AND '"&horario_fim&"' OR DH_HORA_FIM BETWEEN '"&horario_inicio&"' AND '"&horario_fim&"')"
  sql_consulta = sql_consulta & "   AND ('"&periodo_inicio&"' BETWEEN DH_INICIO  AND DH_FIM) "
  
  sql_consulta = sql_consulta & " AND ('"&horario_inicio&"' between DH_HORA_INICIO and DH_HORA_FIM or  '"&horario_fim&"' between DH_HORA_INICIO and DH_HORA_FIM)"
  
  sql_consulta = sql_consulta & " AND CO_SITUACAO IN(1,2)"
  sql_consulta = sql_consulta & " AND CO_UNIDADE = "&co_unidade  
  
  set ds=Server.CreateObject("ADODB.RecordSet")
  'response.write sql_consulta
  ds.Open sql_consulta, dados_sys 
  
  if(ds.eof) then
  
	response.write "1"
  
  else
  
	response.write "0"
  
  end if	

end if
	
%>