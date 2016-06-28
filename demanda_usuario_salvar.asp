<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<%

	co_demanda = request("co_demanda")
	co_matricula = request("co_matricula")
	co_tipo_responsavel = request("co_tipo_responsavel")	 
	sql_pergunta = "INSERT INTO dbo.TB_DEMANDAS_RESPONSAVEL (CO_DEMANDA, CO_TIPO_RESPONSAVEL, CO_MATRICULA) VALUES(" & co_demanda & ","& co_tipo_responsavel &",'" & co_matricula  & "'  ) "
	objConn.execute(sql_pergunta)
	'response.Redirect("cadastrar_perguntas.asp?sucesso=true")
	Envia_Email co_demanda, co_matricula

Sub Envia_Email(co_demanda,co_matricula)

	IF no_aplicativo = "" then
		no_aplicativo = AplicativoNovo
	END IF

	set rs_dem=Server.CreateObject("ADODB.RecordSet")
	SQL = "SELECT * FROM VW_DEMANDAS WHERE co_demanda = " & co_demanda & ""
	rs_dem.Open SQL, dados_sys
	no_tipo_demanda = rs_dem("no_tipo")
	no_aplicativo = rs_dem("no_aplicativo")
	no_responsavel = ""
	rs_dem.close

	SQL = "SELECT * FROM TB_DEMANDAS_TIPOS_RESPONSAVEL WHERE CO_TIPO_RESPONSAVEL = " & co_tipo_responsavel & ""
	rs_dem.Open SQL, dados_sys
	no_tipo_responsavel = rs_dem("no_tipo_responsavel")
	set rs_dem = nothing

	
	 vTexto = "<html><head><head>"
	 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
	 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
	 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"

	 vTexto = vTexto & "<table border=""0"" width=""500px"" style="" border: #000 solid 1px;"" >"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" ><img src=""\\ce7180nt005\Intranet\SIIAG_WEB_HOM\imagens\topo_image_tabela.png"" border=""0""  /></td>"
	 vTexto = vTexto & "</tr>"
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#074aac"" style=""color:#fff;""><font size =""2"" face=""Verdana""><b>CADASTRAMENTO DE USUÁRIO</b></font></td>"
	 vTexto = vTexto & "</tr>"
	 
	 vTexto = vTexto & "<tr>"
	 vTexto = vTexto & "<td align=""center"" ><font size =""2"" face=""Verdana"">"
	 vTexto = vTexto & "Comunicamos o seu cadastramento como <br/><p align=""center""><b>" & UCASE(no_tipo_responsavel) & "</b></p>"

	 vTexto = vTexto & "da Demanda <b>" & co_demanda & " - "& no_tipo_demanda & " - " & no_aplicativo & "</b>"
	 vTexto = vTexto & "<p>Você pode acompanhar esta demanda das seguintes formas:<br/><br/> "
	 vTexto = vTexto & " <li><i>Pelo SIIAG --> Demandas TI --> Consultar Demandas</i></li> ou <br/>"
	 vTexto = vTexto & " <li><a href=""http://ce7180nt005/SIIAG_WEB/demanda_manter.asp?demanda=" & co_demanda & """>Clicando aqui</a></li> <br/>"
	 vTexto = vTexto & "</p>"
	 vTexto = vTexto & "</font></td>"
	 vTexto = vTexto & "</tr>"
	
	 vTexto = vTexto & "</table>"
	 vTexto = vTexto & "<br>**** Encaminhada por SIIAG - Demandas TI *****"
	 vTexto = vTexto & "</body></html>"
 
	 If Err.Number<>0 Then
		Response.Write("Erro: " & Err.Description & "<BR>")
		Response.end	
	 Else
		'SQL3 = "EXECUTE usp_ADM_Inclui_Email_Enviado 1,'" & vDe & "','" & vPara & "','" & vAssunto & "','" & vTexto & "','" & vUsuario & "'"
		'Set rs3 = DB_Administrativo.Execute(SQL3)
		'vCodEmail = rs3("Cod")
		
		If Err.Number<>0 Then
			Response.Write("Erro: " & Err.Description & "<BR>")
			Response.end
		Else
		
			vDe =  "gifugfo@mail.caixa"
			vPara = co_matricula & "@mail.caixa"
			'vCC = matricula & "@mail.caixa;"
			'vCCO = "c077563@mail.caixa;"
			'vPara = "gifugfo01@caixa.gov.br"
			vMensagem = vTexto
			vTitulo = "Demandas TI - Cadastramento de Usuário - " & co_demanda
			vUsuario = request.Cookies("co_usuario_siiag")
		
			'response.write vTexto
			'response.write "DE " & vDE & "<br>"
			'response.write "PARA " & vPara & "<br>"
			'response.write "CC " & vCC & "<br>"
			'response.write "CCO " & vCCO & "<br>"
			'response.write "ASSUNTO " & vAssunto & "<br>"
			'response.write "TEXTO" & vTexto & "<br>"

			'response.write "USUARIO " & vUsuario & "<br>"
			email = f_Envia_Email(vDe,vPara,vTitulo,vMensagem,vRetorno,vUsuario)
			'email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)
			'response.write "RETORNO " & email & "<br>"		
		End If
		
	 End If
End Sub

%>

