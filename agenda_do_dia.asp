<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<h3 class="subtitulosAgenda">Eventos</h3>
<% 

if data <> "" Then

dataTotal = data

else

dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

END IF 

strQuery = "SELECT EVENTOS.DE_EVENTO, EVENTOS.DE_PARTICIPANTES, EVENTOS.DH_HORA_INICIO,EVENTOS.DH_HORA_FIM, GS.NO_GS, TIPOS.DE_TIPO_EVENTO, LOCAL.DE_LOCAL FROM TB_EVENTOS AS EVENTOS INNER JOIN VW_GS AS GS ON GS.CO_GS = EVENTOS.CO_GS_INICIATIVA INNER JOIN TB_TIPOS_EVENTO AS TIPOS ON TIPOS.CO_TIPO_EVENTO = EVENTOS.CO_TIPO_EVENTO INNER JOIN TB_LOCAL AS LOCAL ON LOCAL.CO_LOCAL = EVENTOS.CO_LOCAL WHERE(EVENTOS.DH_INICIO = '"&dataTotal&"' AND EVENTOS.CO_UNIDADE_FGTS="&request.Cookies("co_usuario_unidade_siiag")&") AND EVENTOS.CO_SITUACAO = 2"
 
'set objConn = server.CreateObject("ADODB.Connection") 
'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
'objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
 	
  if rs.eof Then
  response.Write "<p style='font-family:Arial,Verdana;font-size:15px;'>N&atildeo h&aacute; Eventos.<p>"
  else	
  DO UNTIL rs.eof
  
 'atribuindo os valores dos campos as variáveis
  descricaoEventos =		rs("DE_EVENTO")
  participantesdoEvento =	rs("DE_PARTICIPANTES")
  nomeGerencia      =       rs("NO_GS")
  descricaoLocal    =       rs("DE_LOCAL")
  tipodoEvento        =       rs("DE_TIPO_EVENTO")

  horaInicio = 				FormatDateTime(rs("DH_HORA_INICIO"),4)
  
  horaFim = 				FormatDateTime(rs("DH_HORA_FIM"),4)

  response.write "<li class='textosAgenda'> <strong>Ger&ecirc;ncia: </strong>"& nomeGerencia  &" <br/><strong>Tipo: </strong>" & tipodoEvento &"<br/><strong>Evento/Motivo: </strong> " & descricaoEventos & "<br/><strong>Participantes: </strong>" & participantesdoEvento & "<br/>"	

	
  response.write "<strong>Local/Per&iacute;odo: </strong>" & descricaoLocal & " - " &  " " & horaInicio &"h" & " &agrave;s " & horaFim &"h" & "  </li>"
  response.write "<hr class='linhaSeparadora'/>"	
  
  rs.movenext
 
  LOOP
 End If 
objConn.close 
set rs = nothing
set objConn = nothing 
  
  %>
<h3 class="subtitulosAgenda">Destacamentos</h3>
<%

Query4 = "SELECT DESTACAMENTOS.DT_INICIO, DESTACAMENTOS.DT_FIM, DESTACAMENTOS.DE_PROJETO, DESTACAMENTOS.NO_CIDADE, DESTACAMENTOS.CO_MATRICULA, USUARIOS.NO_NOME FROM TB_DESTACAMENTOS AS DESTACAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON USUARIOS.CO_MATRICULA = DESTACAMENTOS.CO_MATRICULA WHERE DESTACAMENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&" AND ((DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND ('"& dataTotal &"' BETWEEN DESTACAMENTOS.DT_INICIO AND DESTACAMENTOS.DT_FIM) OR(DESTACAMENTOS.CO_SITUACAO IN (2, 3, 5)) AND (CONVERT(DATETIME,CAST(DAY(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(MONTH(DESTACAMENTOS.DT_INICIO) AS varchar) + '/' + CAST(YEAR(DESTACAMENTOS.DT_INICIO) AS varchar), 103) = '"& dataTotal &"'))"
					  
'set objConn = server.CreateObject("ADODB.Connection") 
'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
'objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
ds.Open Query4, dados_sys 
	
 if ds.eof Then
  response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Destacamentos.<p>"
  else	
 DO UNTIL ds.eof

nomeCidade =			ds("NO_CIDADE")
descricaoEvento =		ds("DE_PROJETO")
codigoMatricula =		ds("CO_MATRICULA")
dataInicio = 			ds("DT_INICIO")
dataFim = 				ds("DT_FIM")
dataInicioTotal = 		(DAY(dataInicio) &"/" & MONTH(dataInicio) &"/"& YEAR(dataInicio))
dataFimTotal = 			(DAY(dataFim) &"/" & MONTH(dataFim) &"/"& YEAR(dataFim))
nomeFuncionario = 		ds("NO_NOME")


response.Write "<li class='textosAgenda'> <strong>Empregado: </strong>"& nomeFuncionario &"<br/><strong>Evento/Motivo: </strong>"& descricaoEvento &"<br/><strong>Local/Per&iacute;odo: </strong>"& nomeCidade & " - " & formatar_data(dataInicioTotal) & " a " & formatar_data(dataFimTotal) &"  </li>"
response.write "<hr class='linhaSeparadora'/>"

 ds.movenext
  
  LOOP
  End If 

set ds = 		nothing

%>
<h3 class="subtitulosAgenda">Aus&ecirc;ncias</h3>
<%




	QueryAfastamento =	"SELECT AFASTAMENTOS.CO_MATRICULA, TIPOS.CO_TIPO_AFASTAMENTO, AFASTAMENTOS.DT_INICIO, AFASTAMENTOS.DT_FIM, AFASTAMENTOS.CO_SITUACAO, USUARIOS.NO_NOME,TIPOS.DE_TIPO_AFASTAMENTO FROM TB_AFASTAMENTOS AS AFASTAMENTOS INNER JOIN VW_USUARIOS AS USUARIOS ON AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_TIPOS_AFASTAMENTO AS TIPOS ON AFASTAMENTOS.CO_TIPO_AFASTAMENTO = TIPOS.CO_TIPO_AFASTAMENTO WHERE (AFASTAMENTOS.CO_SITUACAO = 2 OR AFASTAMENTOS.CO_SITUACAO = 3) AND ('"&dataTotal&"' BETWEEN AFASTAMENTOS.DT_INICIO AND AFASTAMENTOS.DT_FIM) AND ( AFASTAMENTOS.CO_UNIDADE="&request.Cookies("co_usuario_unidade_siiag")&") ORDER BY USUARIOS.NO_NOME"

	'set objConn =server.CreateObject("ADODB.Connection")
	'dados_sys ="Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce"
	'objConn.open dados_sys
	set afastamento =	Server.CreateObject("ADODB.RecordSet")
	afastamento.Open QueryAfastamento, dados_sys

	

	if afastamento.eof Then
  	response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Afastamentos ou Aus&ecirc;ncias.<p>"
  	else	
	DO UNTIL afastamento.eof
	
	
		nomeFuncionario = afastamento("NO_NOME")
		descricaoAfastamento = afastamento("DE_TIPO_AFASTAMENTO")
		dataInicio=afastamento("DT_INICIO")
		dataFim=afastamento("DT_FIM")
		
		
		
			
			response.Write "<li class='textosAgenda'> <strong>Empregado: </strong>"&nomeFuncionario&"<br/><strong>Motivo: </strong>"&descricaoAfastamento&"<br/><strong>de:</strong> "&DAY(dataInicio)&"/"&MONTH(dataInicio)&"/"&YEAR(dataInicio)&" &agrave; "&DAY(dataFim)&"/"&MONTH(dataFim)&"/"&YEAR(dataFim)&" </li><hr class='linhaSeparadora'/>"
		
		

		afastamento.movenext
		
	LOOP
	END IF
	
'objConn.close 
set afastamento = 	nothing
set objConn = 		nothing 
%>
<br/>
<br/>
<!--dando espaco entre essas divs e a div do aniversario -->
