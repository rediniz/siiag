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
  
  query_pedido = "INSERT INTO TB_ESTOQUE_PEDIDO (CO_MATRICULA, CO_GS, DT_PEDIDO, CO_UNIDADE) VALUES ('" & matricula & "', "& co_gs &", '" & data_pedido &"', "& unidade &")"
  
  objConn.execute(query_pedido)
  
    sql_cod_pedido = "SELECT TOP 1 CO_PEDIDO FROM TB_ESTOQUE_PEDIDO ORDER BY CO_PEDIDO DESC"
	cod = objConn.execute(sql_cod_pedido)
	cod_pedido = cod("CO_PEDIDO")
  
  For Each codMaterial in request.form("pedido")
 
	  qtd = mid(codMaterial,  instr(codMaterial, ":")+1, len(codMaterial) )
	  cod = left(codMaterial, instr(codMaterial, ":")-1)
	  query_item_pedido = "INSERT INTO TB_ESTOQUE_ITEM_PEDIDO (CO_PEDIDO, CO_MATERIAL, QT_SOLICITADA) VALUES ("&cod_pedido&", "&cod&", "&qtd&")"
	  objConn.execute(query_item_pedido)
   
  next 
  
  set query = nothing
  set objConn = nothing

%>