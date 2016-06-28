<h3 class="subtitulosAgenda">Eventos</h3>
<% 

if data <> "" Then

dataTotal = data

else

dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

END IF 

strQuery = "select DE_EVENTO, CO_TIPO_EVENTO, DE_PARTICIPANTES, CO_LOCAL, DH_HORA_INICIO, DH_HORA_FIM, CO_GS_INICIATIVA  from TB_EVENTOS WHERE DH_INICIO='"& dataTotal &"';" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
 	
  if rs.eof Then
  response.Write "<p style='font-family:Arial,Verdana;font-size:13px;'>N&atildeo h&aacute; Eventos Hoje<p>"
  else	
  DO UNTIL rs.eof
  
 'atribuindo os valores dos campos as variáveis
  descricaoEventos =		rs("DE_EVENTO")
  participantesdoEvento =	rs("DE_PARTICIPANTES")
  codigoEvento = 			rs("CO_TIPO_EVENTO")
  local =  					rs("CO_LOCAL")
  horaInicio = 				HOUR(rs("DH_HORA_INICIO"))
  horaFim = 				HOUR(rs("DH_HORA_FIM"))
  codigoGerencia = 			rs("CO_GS_INICIATIVA")
 
  'teste de  descricao do evento    
  	IF codigoEvento=1 THEN
		tipodoEvento = "Visita Externa"
	END IF	
	IF codigoEvento=2 THEN
		tipodoEvento = "Treinamento"
	END IF	
	IF codigoEvento=3 THEN
		tipodoEvento = "Reuni&atilde;o"
	END IF	
	IF codigoEvento=4 THEN
		vdoEvento = "Palestra"
	END IF
	IF codigoEvento=5 THEN
		tipodoEvento = "Audioconfer&ecirc;ncia"
	END IF	
	IF codigoEvento=6 THEN
		descricaodoEvento = "Visita Interna"
	END IF	
	IF codigoEvento=13 THEN
		tipodoEvento = "Confraterniza&ccedil;&atilde;o"
	END IF	
	IF codigoEvento=14 THEN
		tipodoEvento = "Evento Externo"
	END IF	


Query3 ="select NO_GS from TB_GS WHERE CO_GS ='"& codigoGerencia &"';" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
ds.Open Query3, dados_sys 

	nomeGerencia=ds("NO_GS")

  response.write "<li class='textosAgenda'> <strong>Ger&ecirc;ncia: </strong>"& nomeGerencia  &" <br/><strong>Tipo: </strong>" & tipodoEvento &"<br/><strong>Evento/Motivo: </strong> " & descricaoEventos & "<br/><strong>Participantes: </strong>" & participantesdoEvento & "<br/>"	
  
    
'fim do teste de  descricao do evento  	
  
	Query2 ="select DE_LOCAL from TB_LOCAL WHERE CO_LOCAL ='"& local &"';" 
	set objConn = server.CreateObject("ADODB.Connection") 
	dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
	objConn.open dados_sys
	set cs=Server.CreateObject("ADODB.RecordSet")
	cs.Open Query2, dados_sys 

	descricaoLocal=cs("DE_LOCAL")
	
  response.write "<strong>Local/Per&iacute;odo: </strong>" & descricaoLocal & " - " &  " " & horaInicio &"h" & " &agrave;s" & horaFim &"h" & "  </li>"
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

Query4 ="select DT_INICIO, DT_FIM,DE_PROJETO,NO_CIDADE, CO_MATRICULA from TB_DESTACAMENTOS WHERE CO_SITUACAO IN (2,3,5) AND (('"& dataTotal &"' BETWEEN DT_INICIO AND DT_FIM) OR CONVERT(DATETIME, cast(day(DT_INICIO) as varchar) + '/' +cast( month(DT_INICIO) as varchar) + '/' + cast(year(DT_INICIO) as varchar), 103)='"&dataTotal&"')" 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
ds.Open Query4, dados_sys 
	
 if ds.eof Then
  response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Destacamentos<p>"
  else	
 DO UNTIL ds.eof

nomeCidade =			ds("NO_CIDADE")
descricaoEvento =		ds("DE_PROJETO")
codigoMatricula =		ds("CO_MATRICULA")
dataInicio = 			ds("DT_INICIO")
dataFim = 				ds("DT_FIM")
dataInicioTotal = 		(DAY(dataInicio) &"/" & MONTH(dataInicio) &"/"& YEAR(dataInicio))
dataFimTotal = 			(DAY(dataFim) &"/" & MONTH(dataFim) &"/"& YEAR(dataFim))

Query5 =				"select NO_NOME from TB_USUARIOS  WHERE CO_MATRICULA ='"& codigoMatricula &"';" 
set objConn = 			server.CreateObject("ADODB.Connection") 
dados_sys = 			"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set tuser =				Server.CreateObject("ADODB.RecordSet")
tuser.Open Query5, dados_sys 

nomeFuncionario = 		tuser("NO_NOME")

response.Write "<li class='textosAgenda'> <strong>Empregado: </strong>"& nomeFuncionario &"<br/><strong>Evento/Motivo: </strong>"& descricaoEvento &"<br/><strong>Local/Per&iacute;odo: </strong>"& nomeCidade & " - " & dataInicioTotal & " &agrave; " & dataFimTotal &"  </li>"

response.write "<hr class='linhaSeparadora'/>"

 ds.movenext
  
  LOOP
  End If 

set tuser = 	nothing
set ds = 		nothing

%>
<h3 class="subtitulosAgenda">Aus&ecirc;ncias</h3>
<%



QueryAfastamento =	"select DT_INICIO,DT_FIM,CO_MATRICULA,CO_TIPO_AFASTAMENTO,CO_SITUACAO from TB_AFASTAMENTOS WHERE CO_SITUACAO=2 AND '"&dataAtual&"' BETWEEN DT_INICIO AND DT_FIM;"
set objConn = 		server.CreateObject("ADODB.Connection")
dados_sys = 		"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set afastamento =	Server.CreateObject("ADODB.RecordSet")
afastamento.Open QueryAfastamento, dados_sys

	'response.Write "deu certo"

	if afastamento.eof Then
  	response.Write "<p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Afastamentos ou Aus&ecirc;ncias<p>"
  	else	
	DO UNTIL afastamento.eof
	
		dataInicio=afastamento("DT_INICIO")
		dataFim=afastamento("DT_FIM")
		Matricula=afastamento("CO_MATRICULA")
		codigoSituacao=afastamento("CO_SITUACAO")
		codigoAfastamento=afastamento("CO_TIPO_AFASTAMENTO")
				
		QueryNomeUser ="select NO_NOME from TB_USUARIOS  WHERE CO_MATRICULA ='"& Matricula &"';" 
		set objConn = server.CreateObject("ADODB.Connection") 
		dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
		objConn.open dados_sys
		set tuser=Server.CreateObject("ADODB.RecordSet")
		tuser.Open QueryNomeUser, dados_sys 
	
		nomeFuncionario=tuser("NO_NOME")
				
		QueryMotivo ="select DE_TIPO_AFASTAMENTO from TB_TIPOS_AFASTAMENTO  WHERE CO_TIPO_AFASTAMENTO ='"& codigoAfastamento &"';" 
		set objConn = server.CreateObject("ADODB.Connection") 
		dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
		objConn.open dados_sys
		set motivo=Server.CreateObject("ADODB.RecordSet")
		motivo.Open QueryMotivo, dados_sys
		
		descricaoAfastamento=motivo("DE_TIPO_AFASTAMENTO") 
			
			response.Write "<li class='textosAgenda'> <strong>Empregado: </strong>"&nomeFuncionario&"<br/><strong>Motivo: </strong>"&descricaoAfastamento&"<br/><strong>de:</strong> "&DAY(dataInicio)&"/"&MONTH(dataInicio)&"/"&YEAR(dataInicio)&" &agrave; "&DAY(dataFim)&"/"&MONTH(dataFim)&"/"&YEAR(dataFim)&" </li><hr class='linhaSeparadora'/>"
		
		'Empregado: Jurandir Vieira Santiago - 10/12/2013 a 19/12/2013
		'Motivo: Licença Trat. Saúde Sem Desconto 

		afastamento.movenext
		
	LOOP
	END IF
	
objConn.close 
set afastamento = 	nothing
set objConn = 		nothing 
%>
<br/>
<br/>
<!--dando espaco entre essas divs e a div do aniversario -->
