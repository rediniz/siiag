<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>Relatório de Pendências do Estoque</title>
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!-- Favicon -->
<!--CSS -->
<script src="scripts/jquery-1.9.1.js"></script>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />

<script language="javascript">

	function imprimir(){
		$("#bt_imprimir").hide();
		window.print();
		$("#bt_imprimir").show();
	}
	
</script>

</head>
<body>


<%
dim WHERE(3)
	dim cont
	dim query
	dim ordem
	
	
	


  strQuery = "SELECT usuario.NO_NOME, GS.NO_GS,item.CO_PEDIDO, item.CO_MATERIAL, material.CO_MATERIAL, material.NO_MATERIAL,item.QT_SOLICITADA, item.QT_LIBERADA, material.QT_QUANTIDADE, unidade.DE_UNIDADE, pedido.CO_PEDIDO, pedido.CO_MATRICULA, pedido.CO_GS, pedido.DT_PEDIDO FROM TB_ESTOQUE_ITEM_PEDIDO as item, TB_ESTOQUE_PEDIDO as pedido, TB_ESTOQUE_MATERIAL as material, TB_ESTOQUE_UNIDADE as unidade, VW_USUARIOS as usuario, TB_GS AS GS  WHERE item.CO_PEDIDO = pedido.CO_PEDIDO AND material.CO_UNIDADE = unidade.CO_UNIDADE AND item.CO_MATERIAL = material.CO_MATERIAL and usuario.CO_MATRICULA = pedido.CO_MATRICULA AND PEDIDO.CO_GS = GS.CO_GS and item.QT_LIBERADA IS NULL and pedido.co_unidade = "&request.Cookies("co_usuario_unidade_siiag")
  
  coordenacao = request("coordenacao")
  
  if coordenacao <> "" then
  
  strQuery = strQuery & " and PEDIDO.CO_GS = " & coordenacao & " "
  
  end if
  
  strQuery = strQuery & " ORDER BY pedido.CO_GS, pedido.CO_PEDIDO "
  
  objConn.execute(strQuery)
   
  Pag = cint(request("pag"))
	if Pag = 0 then Pag = 1

	set rs=Server.CreateObject("ADODB.RecordSet")
	rs.Open strQuery, dados_sys, 3, , 32
	IF rs.eof Then  'mensagem caso nao haja resultados
		Response.Write "<br><p align='center'>Não há requisições pendentes.</p>"
	Else
	%>
    <br />
    
             <table border="1" align="center" style="text-align:center;" class="tabela" title="Relatório de Estoque">
              <tr>
              	
         
        
              	<td> Material </td>
              	<td> Qtd. Solicitada </td>
              	<!--<td> Qtd. a Liberar </td>-->
              	<!--<td> Qtd. Disponível </td> -->
              	<!--<td> Unidade </td>-->
              	<td> Solicitante </td>
              	<td> Coordenação </td>
              	<td> Solicitado em </td>
              </tr>
	<%
	
'		rs.AbsolutePage = pag
	
		'DO UNTIL rs.eof
		do while (not rs.eof) ' and Abs(rs.AbsolutePage - pag) < numPag 
			'atribuindo os valores dos campos as vari�veis
			
			co_pedido = rs("CO_PEDIDO")
			co_material = rs("CO_MATERIAL")
			material=rs("NO_MATERIAL")
			qtd_solicitada=rs("QT_SOLICITADA")
			qtd_liberar=rs("QT_LIBERADA")
			qtd_disponivel=rs("QT_QUANTIDADE")
			unidade=rs("DE_UNIDADE")
			solicitante=rs("NO_NOME")
			coordenacao=rs("NO_GS")
			solicitado=formatdatetime(rs("DT_PEDIDO"),2)

			response.write "<tr>"
			response.write "<input type='hidden' id='co_pedido' name='co_pedido' value=" & co_pedido & ">"
			response.write "<input type='hidden' id='co_material' name='co_material' value=" & co_material & ">"
			
			response.write "<td id='material' >"& material &"</td>"
			response.write "<td id='qtd_solicitada' >"& qtd_solicitada &"</td>"
			
			response.write "<td id='solicitante' >"& solicitante &"</td>"
			response.write "<td id='coordenacao' >"& coordenacao &"</td>"
			response.write "<td id='solicitado' >"& solicitado &"</td>"
			response.write "</tr>"
			rs.movenext
		LOOP
	
	


	END IF ' fim do if da mensagem caso nao haja resultados
%>

	
    <br />
<%

	objConn.close 
	set rs = nothing
	set objConn = nothing 


	Sub Writeln(texto)
		response.write(texto)
	End Sub
	
	
%>





<tr>
<td colspan="5"><input type="button" value="Imprimir" class="myButton" id="bt_imprimir" onclick=" return(imprimir())" /> </td>
</tr>
</table>

</body>
</html>
