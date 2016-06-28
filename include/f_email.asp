<%
Function f_Envia_Email(vDe,vPara,vTitulo,vMensagem,vRetorno,vUsuario)
 
Dim vDestinatario
Dim vRemetente
Dim vTexto
Dim vPagRetorno
Dim vAssunto
Dim strSQL
Dim rs
Dim DB_Email 
Dim vOrigem 
Dim CaixaPostal
Dim vEmailExistente
 
'AO ACRESCENTAR UMA CAIXA POSTAL, INCLUIR NO ARRAY lINHA 31 (FOR I = 0 TO ...)
CaixaPostal=Array("gifugfo")
 
Set DB_Email= Server.CreateObject("ADODB.Connection")
vDe = LCase(vDe)
 
 If len(vDe) < 1 Or vDe = null OR vDe = "" Then
  f_Envia_Email =  vRetorno & "?Msg=Remetente não informado. Email não enviado."
  Exit Function
 Else
  vOrigem = Replace(vDe,"@mail.caixa","")
  vOrigem = Replace(vOrigem,"@caixa.gov.br","")
  
  '************************
  vEmailExistente = False
  For I = 0 to 26
   If CaixaPostal(I) = vOrigem then
     vEmailExistente = True
    Exit For
   End if
  Next
  '***************************
   If vEmailExistente = True Then
   With DB_Email
    .Provider = "SQLOLEDB"
    .Properties("user id").Value = "gifugfo"
    .Properties("Password").Value = "}Q-6sJj_PyWc-s2+fO"
          .Properties("Data Source").Value = "RS0000NT115"
          .Properties("Initial Catalog").Value = "emails" 
          .Properties("Network Library").Value = "DBMSSOCN"
            .Open
   End With
  Else
   Response.Write("O REMETENTE do e-mail inexiste na base de envio da GITEC/PO.")
   Response.end 
  End If
 End If

'****************************************************
' VERIFICAÇÕES
'****************************************************
 If len(vPara) < 1 Or vPara = null OR vPara = "" Then
  f_Envia_Email = vRetorno &  "?Msg=Destinatário não informado. Email não enviado."
  Exit Function
 Else
  vDestinatario = vPara
 End If
 
 If len(vTitulo ) < 1 Or vTitulo = null OR vTitulo = "" Then
  f_Envia_Email = vRetorno &  "?Msg=O assunto da mensagem não foi informado. Email não enviado."
  Exit Function
 Else
  vAssunto = vTitulo
 End If
 
 If len(vMensagem) < 1 Or vMensagem = null OR vMensagem = "" Then
  f_Envia_Email = vRetorno &  "?Msg=Texto da mensagem inexistente. Email não enviado."
  Exit Function
 Else
  vTexto = vMensagem
 End If
 
 'If len(vRetorno) < 1 Or vRetorno= null OR vRetorno= "" Then
 ' f_Envia_Email = vRetorno &  "?Msg=Página de retorno inexistente. Email não enviado."
 ' Exit Function
 'Else
 ' vPagRetorno= vRetorno
 'End If
 
 If len(vUsuario) < 1 Or vUsuario = null OR vUsuario = "" Then
  f_Envia_Email = vRetorno &  "?Msg=Usuário Caixa inexistente. Email não enviado."
  Exit Function
 Else
  vRemetente = vUsuario
 End If
 
 vPagRetorno = vRetorno & "?Msg=E-Mail enviado com sucesso." & vAddRetorno
'************************************************************************************ 
strSQL = "SET NOCOUNT ON;" 
strSQL = strSQL & "INSERT conMensagens (destinatario, remetente, assunto, texto, pagina_retorno) "
strSQL = strSQL & "VALUES ('" & vDestinatario & "','" & vRemetente & "','" &  vAssunto & "','" & vTexto & "','" & vPagRetorno & "'); "
strSQL = strSQL & "SELECT @@IDENTITY AS ultimo"

set rs = DB_Email.Execute(strSQL)
id = rs("ultimo")
DB_Email.Close

If Err.Number <> 0 Then
 Response.write("Erro: " & err.description & "<br>")
 Response.write("Nº: " & err.number)
Else
 f_Envia_Email = "http://enviamail.rs.caixa/envia_email.asp?id=" & id
End If
 
End Function
'====================================================================================
'====================================================================================
'====================================================================================
'====================================================================================
 
Function f_Envia_Email_CC(vDe,vPara,vCc,vCco,vTitulo,vMensagem,vRetorno,vUsuario)
 
Dim vDestinatario
Dim vRemetente
Dim vTexto
Dim vPagRetorno
Dim vAssunto
Dim strSQL
Dim rs
Dim DB_Email 
Dim vOrigem 
Dim CaixaPostal
Dim vEmailExistente
 
CaixaPostal=Array("gifugfo")
 
Set DB_Email= Server.CreateObject("ADODB.Connection")
vDe = LCase(vDe)
 
'response.write(vDe)
'response.end
 
 If len(vDe) < 1 Or vDe = null OR vDe = "" Then
  f_Envia_Email_CC =  vRetorno & "?Msg=Remetente não informado. Email não enviado."
  Exit Function
 Else
  vOrigem = Replace(vDe,"@mail.caixa","")
  vOrigem = Replace(vOrigem,"@caixa.gov.br","")
  
  '************************
  vEmailExistente = False
  For I = 0 to 24
   If CaixaPostal(I) = vOrigem then
     vEmailExistente = True
    Exit For
   End if
  Next
  '***************************
   If vEmailExistente = True Then
   With DB_Email
    .Provider = "SQLOLEDB"
    .Properties("user id").Value = "gifugfo"
    .Properties("Password").Value = "}Q-6sJj_PyWc-s2+fO"
         .Properties("Data Source").Value = "RS0000NT115"
         .Properties("Initial Catalog").Value = "emails" 
         .Properties("Network Library").Value = "DBMSSOCN"
           .Open
   End With
  Else
   Response.Write("O REMETENTE do e-mail inexiste na base de envio da GITEC/PO.")
   Response.end 
  End If
 End If
 
'****************************************************
' VERIFICAÇÕES
'****************************************************
 If len(vPara) < 1 Or vPara = null OR vPara = "" Then
  f_Envia_Email_CC = vRetorno &  "?Msg=Destinatário não informado. Email não enviado."
  Exit Function
 Else
  vDestinatario = vPara
 End If
 
 If len(vTitulo ) < 1 Or vTitulo = null OR vTitulo = "" Then
  f_Envia_Email_CC = vRetorno &  "?Msg=O assunto da mensagem não foi informado. Email não enviado."
  Exit Function
 Else
  vAssunto = vTitulo
 End If
 
 If len(vMensagem) < 1 Or vMensagem = null OR vMensagem = "" Then
  f_Envia_Email_CC = vRetorno &  "?Msg=Texto da mensagem inexistente. Email não enviado."
  Exit Function
 Else
  vTexto = vMensagem
 End If
 
 'If len(vRetorno) < 1 Or vRetorno= null OR vRetorno= "" Then
 ' f_Envia_Email_CC = vRetorno &  "?Msg=Página de retorno inexistente. Email não enviado."
 ' Exit Function
 'Else
 ' vPagRetorno= vRetorno
 'End If
 
 If len(vUsuario) < 1 Or vUsuario = null OR vUsuario = "" Then
  f_Envia_Email_CC = vRetorno &  "?Msg=Usuário Caixa inexistente. Email não enviado."
  Exit Function
 Else
  vRemetente = vUsuario
 End If
 
 vPagRetorno = vRetorno & "?Msg=E-Mail enviado com sucesso."
'************************************************************************************ 
strSQL = "SET NOCOUNT ON;" 
strSQL = strSQL & "INSERT conInserirMensagens (destinatario, remetente, assunto, texto, cc, cco) "
strSQL = strSQL & "VALUES ('" & vDestinatario & "','" & vRemetente & "','" &  vAssunto & "','" & vTexto & "','" & vCc & "','" & vCco  & "'); "
 
set rs = DB_Email.Execute(strSQL)
 
f_Envia_Email_CC = vPagRetorno
 
End Function
 
'****************************************************
'****************************************************
'***********  tblMensagens = Tabela de dados na GITEC/PO ***************
'(id - int(4), 
'data - datetime(8), 
'usuario - varchar(50)
'remetente - varchar(50), 
'destinatario - varchar(8000), 
'assunto - varchar(100), 
'texto - text(16), 
'enviado - int(4), 
'pagina_retorno - varchar(500), 
'anexo - varchar(500))
 
'conMensagens = View do sistema (id, remetente, destinatario, assunto, texto, pagina_retorno)
'******************************************************************************
%>