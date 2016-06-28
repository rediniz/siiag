<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- USADO PARA CORRIGIR PALAVRAS COM ACENTOS-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- #INCLUDE FILE = "include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/f_email.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<%
	response.Expires = 0		
	
	co_situacao     = request("co_situacao")
	dt_conclusao    = request("dt_conclusao")
	tipo            = request("tipo")
	co_reparo	    = request("co_reparo")

	co_responsavel = request.Cookies("co_usuario_siiag")
    no_responsavel = request.Cookies("no_usuario_siiag")
	'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	'#Alterado em 04/12/2015 (adicionado)
	dt_ini_atdmt = request("dt_ini_atdmt")
	dt_prev_conc = request("dt_prev_conc")
	
	'1 #ALTERADO EM 19/04/2016
	observacaoEdicao = request("observacaoEdicao")
	
	
	'#Alterado em 04/12/2015 (usando agora a TB_SITUACOES original)
	consultasDeSITUACAO ="SELECT DE_SITUACAO FROM TB_SITUACOES WHERE CO_SITUACAO = "&co_situacao 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set tv=Server.CreateObject("ADODB.RecordSet")
                                                tv.Open consultasDeSITUACAO, dados_sys
												
												
                                                if not tv.eof then
                                                    de_si=tv("DE_SITUACAO")						

                                                end if
                                                set tv= nothing
												
   consultaDescricao ="SELECT DE_DESCRICAO FROM TB_REPAROS WHERE CO_REPARO = " & co_reparo 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set tt=Server.CreateObject("ADODB.RecordSet")
                                                tt.Open consultaDescricao, dados_sys
												
												
                                                if not tt.eof then
                                                    de_de=tt("DE_DESCRICAO")						

                                                end if
                                                set tt= nothing											
												
												
	'response.write CO_REPARO
	
	'2 #ALTERADO EM 19/04/2016
	SQL = "UPDATE TB_REPAROS SET CO_SITUACAO="&co_situacao&", DT_INI_ATDMT = '"&dt_ini_atdmt&"', dt_prev_conc = '"&dt_prev_conc&"',obs_edicao = '"&observacaoEdicao&"'"
   ' response.write SQL

	
	select case co_situacao
	
		'Se a demanda estiver sendo finalizada
		case "2", "6"
		
			dt_conclusao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
			mt_conclusao = request.Cookies("co_usuario_siiag")
			
			SQL = SQL & ", DT_CONCLUSAO = '"&dt_conclusao&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
	
		case "3", "9"
		
			set rsPendencia = Server.CreateObject("ADODB.RecordSet")
			sqlPendenciaExistente = "SELECT DT_PENDENTE FROM TB_REPAROS WHERE CO_REPARO = "&co_reparo
			rsPendencia.open(sqlPendenciaExistente), dados_sys

			if isnull(rsPendencia("DT_PENDENTE")) then
				dt_pendencia = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
				mt_conclusao = request.Cookies("co_usuario_siiag")	
				SQL = SQL & ", DT_PENDENTE = '"&dt_pendencia&"', MT_CONCLUSAO = '"&mt_conclusao&"'"
			end if
			
		case "7"
		
			SQL = SQL & ", IC_CANCELAMENTO = 0"
	
	end select
	
	SQL = SQL & ", CO_MATRICULA_EDICAO = '"&request.Cookies("co_usuario_siiag")&"' WHERE CO_REPARO = "&co_reparo
	objConn.execute(SQL)
	
	'=============================================================================================
	


objConn.Close

sucesso = true

If Err.Number = 0  Then 'And objConn.Errors.Count = 0
	
	'Envia_Email_GIFUG()
	
	' Redireciona para a página inicial informando sucesso ou falha
	If sucesso = true then
		Response.Redirect("reparos_consultar.asp?sucesso=true")
	Else
		Response.Redirect("reparos_consultar.asp?sucesso=false")
	End If
	
Else

	response.write "Erro"

End If
	
%>
<%

Sub Envia_Email_GIFUG

 vTexto = "<html><head><head>"
 vTexto = vTexto & "<body bgcolor=""FFFFFF"">"
 vTexto = vTexto & "<p><font size =""2"" face=""Verdana""><b>"
 vTexto = vTexto & "**** MENSAGEM AUTOMÁTICA - NÃO RESPONDER *****" & "<br><br>"
 vTexto = vTexto & "Registro de alteração no status do Reparo <br><br>"
 vTexto = vTexto & "<table border=""1"" width=""600px"" >"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td colspan=2 align=""center"" bgcolor=""#75aad0""><font size =""2"" face=""Verdana""><b>INFORMAÇÕES DA SOLICITAÇÃO</b></font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Solicitante:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & co_responsavel & " - " &  no_responsavel & "</font></td>"
 vTexto = vTexto & "</tr>"
' vTexto = vTexto & "<tr>"
' vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Tipo do reparo:</b></font></td>"
' vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & de_tp  & "</font></td>"
' vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Descrição</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & de_de  & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Situação:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & de_si  & "</font></td>"
 vTexto = vTexto & "</tr>"
  vTexto = vTexto & "<tr>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana""><b>Data de Conclusão:</b></font></td>"
 vTexto = vTexto & "<td><font size =""2"" face=""Verdana"">" & dt_conclusao & "</font></td>"
 vTexto = vTexto & "</tr>"
 vTexto = vTexto & "</table>"

 vTexto = vTexto & "<br>**** Encaminhada pelo SIIAG - Solicitação de Reparos *****"
 vTexto = vTexto & "</body></html>"
 
 If Err.Number<>0 Then
  Response.Write("Erro: " & Err.Description & "<BR>")
  Response.end	
 Else
 
  If Err.Number<>0 Then
   Response.Write("Erro: " & Err.Description & "<BR>")
   Response.end
  Else
   vDe = "gifugfo@mail.caixa"
   vPara = "gifugfo01@mail.caixa;"
   vCC = co_responsavel & "@mail.caixa;"
   vCCO = "C124937@mail.caixa;"
   vAssunto = "SIIAG WEB - Solicitação de Reparo "
   vUsuario = co_responsavel
   
		email = f_Envia_Email_CC(vDe,vPara,vCc,vCco,vAssunto,vTexto,vRetorno,vUsuario)

  End If
 End If
End Sub	

%>