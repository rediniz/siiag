<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- #INCLUDE FILE ="include/Conexao.asp" -->

<!--#INCLUDE FILE="FPDF/fpdf.asp"-->
<%

	dim WHERE(3)
	dim cont
	dim query
	dim ordem
	dim i
	dim j
	

	
	'CAPTURA DE VARIAVEIS
	

	situacao = Request("situacao")
	gerencia =  Request("gerencia")
	data_inicio= Request("data_inicio")
	data_final=Request("data_final")
	
	
	
Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.SetPath("FPDF/fpdf/")
pdf.SetFont "Arial","",12
pdf.Open()
pdf.AddPage()
pdf.SetTitle "Relatorio de Ferias"
pdf.SetSubject "Assunto"
pdf.Image "imagens/logo-caixa-vetorial.jpg", 5	, 5, 40, 10 ,"JPG" 'primeiro parametro é a imagem, o segundo é a distancia da margem esquerda, o terceiro é a distancia do topo, o quarto é a largura da imagem, o quinto é o tamanho da imagem, e o ultimo é o formato da imagem

pdf.Text 83,25, "Relatorio de Ferias"
pdf.Text 180, 25, DAY(DATE()) & "/" & MONTH(DATE()) & "/" & YEAR(DATE()) 'primeiro parametro é a distancia da lateral esquerda, o segundo é a distancia com relacao ao topo, e o ultimo é o conteudo

	strQuery = "SELECT  " 
	strQuery = strQuery &  " FERIAS.CO_MATRICULA, USUARIOS.NO_NOME, FERIAS.QT_DIAS, FERIAS.DT_INICIO "
	strQuery = strQuery &  "  FROM TB_FERIAS AS FERIAS "
	strQuery = strQuery &  "  INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = FERIAS.CO_MATRICULA"
	
	
	if situacao <> "" and situacao <> 0 then
		cont = cont + 1
		WHERE(cont) = " (FERIAS.CO_SITUACAO = "&situacao&") "
	else
		
	end if
	
	if gerencia <> ""  then
		cont = cont + 1
		WHERE(cont) = " (FERIAS.CO_GS = "&gerencia&") " 
 	end if
	
	if data_inicio <> "" and data_final <> "" then
		cont = cont + 1
		WHERE(cont) = " (FERIAS.DT_INICIO BETWEEN '"&data_inicio&"' AND '"&data_final&"') "
	end if
	
	j=0
	For i=1 to cont
		If j=0 then
			Query = Query & " where " &  WHERE(i)
			j=1
	   Else
			Query = Query & " and " & WHERE(i)
	   End If
	Next
	
	ordem = " ORDER BY FERIAS.DT_INICIO DESC "

	strQuery = strQuery & query & ordem	


'Query4 = "SELECT FERIAS.CO_MATRICULA, USUARIOS.NO_NOME, FERIAS.QT_DIAS, FERIAS.DT_INICIO FROM TB_FERIAS AS FERIAS INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = FERIAS.CO_MATRICULA WHERE (FERIAS.CO_SITUACAO = "&situacao&") AND (FERIAS.DT_INICIO >= '"&data_inicio&"') AND (FERIAS.CO_GS = "&gerencia&")  ORDER BY FERIAS.DT_INICIO DESC"
'
''WHERE AND  

set ds=Server.CreateObject("ADODB.RecordSet")
ds.Open strQuery, dados_sys 

contador = 0

 DO UNTIL ds.eof
	

'	
'	IF rs.eof Then  'mensagem caso nao haja resultados
'		Response.Write "<br/><p align='center'>Não foram encontrados resultados com esses parâmetros.</p>"
'	Else
	
		CO_MATRICULA =		ds("CO_MATRICULA")
		NO_NOME =		ds("NO_NOME")
		QT_DIAS =		ds("QT_DIAS")
		DT_INICIO =      ds("DT_INICIO")
		
		

	if contador >200 Then

		pdf.AddPage()
		contador=0
	End If



pdf.Text 10, 40, "Matricula      |               Nome                |                          Data de Inicio      |         Quantidade de Dias      "
pdf.Text 10, 43, "____________________________________________________________________________"
 
'IF Len(NO_NOME) = 17 Then 
pdf.Text 10,50+contador, CO_MATRICULA &"   "&Left(NO_NOME,20)&"                 "& DAY(DT_INICIO)&"/"&MONTH(DT_INICIO)&"/"&YEAR(DT_INICIO)& "        "&QT_DIAS



'Else 

'pdf.Text 10,50+contador, CO_MATRICULA &"          "&Left(NO_NOME,17)&"                       "& DAY(DT_INICIO)&"/"&MONTH(DT_INICIO)&"/"&YEAR(DT_INICIO)& "                                     "&QT_DIAS

'End If



  
 contador=contador+6
 	
 ds.movenext
  
  LOOP

  
  
pdf.Close()
pdf.Output()


%>
	
		