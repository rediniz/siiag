<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%

  data_pedido = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
  matricula = Session("v_Usuario_Matricula")
  unidade = request.Cookies("co_usuario_unidade_siiag")
  
  query_co_gs = "SELECT CO_GS FROM VW_USUARIOS WHERE CO_MATRICULA = '" & matricula & "' and co_unidade="&unidade
 
  consulta_co_gs = objConn.execute(query_co_gs)
  co_gs = consulta_co_gs("CO_GS")

  For Each codMaterial in request.form("pedido")  
   
  	'#Alterado em 08/12/2015
	D = formatdatetime(data_pedido, 2)
		
	inicio = D
	prazo = dateadd("d", 1, D)
	
  	query_pedido = "INSERT INTO TB_ESTOQUE_PEDIDO (CO_MATRICULA, CO_GS, DT_PEDIDO, CO_UNIDADE, IC_STATUS, DT_INI_ATDMT, DT_PREV_CONC) VALUES ('" & matricula & "', "& co_gs &", '" & data_pedido &"', "& unidade &",1, '"&inicio&"','"&prazo&"')"
	objConn.execute(query_pedido)
	'response.write query_pedido
		
	sql_cod_pedido = "SELECT TOP 1 CO_PEDIDO FROM TB_ESTOQUE_PEDIDO ORDER BY CO_PEDIDO DESC"
	cod = objConn.execute(sql_cod_pedido)

	cod_pedido = cod("CO_PEDIDO")
	
	qtd = mid(codMaterial,  instr(codMaterial, ":")+1, len(codMaterial) )
	cod = left(codMaterial, instr(codMaterial, ":")-1)
	query_item_pedido = "INSERT INTO TB_ESTOQUE_ITEM_PEDIDO (CO_PEDIDO, CO_MATERIAL, QT_SOLICITADA) VALUES ("&cod_pedido&", "&cod&", "&qtd&")"
	objConn.execute(query_item_pedido)
	'response.write query_item_pedido
	
	query_pedido = "UPDATE A SET QT_DISPONIVEL_SOLICITACAO = QT_DISPONIVEL_SOLICITACAO - " & qtd & " FROM TB_ESTOQUE_MATERIAL A WHERE CO_MATERIAL = "& cod &" "
	objConn.execute(query_pedido)
	'response.write query_pedido
   
  next 
  
  
  For Each codMaterial in request.form("reserva")  
  	response.write codMaterial
	qtd = mid(codMaterial,  instr(codMaterial, ":")+1, len(codMaterial) )
	cod = left(codMaterial, instr(codMaterial, ":")-1)
	
	query_pedido = "INSERT INTO TB_ESTOQUE_ITEM_INDISP (CO_MATERIAL, CO_UNIDADE, CO_MATRICULA, DT_SOLICITACAO, CO_GS,QT_QUANTIDADE, IC_STATUS, CO_RESPONSAVEL) "
	query_pedido =  query_pedido &  " VALUES ("& cod &","& unidade &",'" & matricula & "','" & now() & "', "& co_gs &", " & qtd &",1,'" & matricula & "') "
	response.write query_pedido
	objConn.execute(query_pedido)
   
  next 
  
  set query = nothing
  set objConn = nothing

%>