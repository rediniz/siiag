

<h3 class="subtitulosAgenda">F&eacute;rias</h3>
<%
'dataAtual=DAY(DATE())&"/"&MONTH(DATE())&"/"&YEAR(DATE())

'QueryQT_dias ="select DT_INICIO, QT_DIAS from TB_FERIAS;"
'set objConn = server.CreateObject("ADODB.Connection")
'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
'objConn.open dados_sys
'set dias=Server.CreateObject("ADODB.RecordSet")
'dias.Open QueryQT_dias, dados_sys

'	While Not dias.eof
'		
'		dataInicialBanco=dias("DT_INICIO")
'		dataInicio = DAY(dataInicialBanco)& "-"& MONTH(dataInicialBanco)&"-"& YEAR(dataInicialBanco)
'		quantidadeDias=dias("QT_DIAS")
'		
'		dataFinal = DateAdd("d",quantidadeDias,dataInicio)
'		
'		dataFinalBanco = DAY(dataFinal)& "/"& MONTH(dataFinal)&"/"& YEAR(dataFinal)
'		
'		response.Write dataInicialBanco
'		response.Write dataFinalBanco
'
'	QueryFerias ="select CO_MATRICULA,DT_INICIO from TB_FERIAS  WHERE '"&dataAtual&"' BETWEEN DT_INICIO AND '"&dataFinalBanco&"';" 
''	set objConn = server.CreateObject("ADODB.Connection") 
	'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
'	objConn.open dados_sys
'	set Feriasuser=Server.CreateObject("ADODB.RecordSet")
'	Feriasuser.Open QueryFerias, dados_sys 
'	
'	codigodaMatricula=Feriasuser("CO_MATRICULA")
'	response.write codigodaMatricula
'	
'	dias.movenext
'	Wend
'	


%>




 

<h3 class="subtitulosAgenda">Aus&ecirc;ncias</h3> 
<%

dataAtual=DAY(DATE())&"/"&MONTH(DATE())&"/"&YEAR(DATE())

QueryAfastamento ="select DT_INICIO,DT_FIM,CO_MATRICULA,CO_SITUACAO from TB_AFASTAMENTOS WHERE CO_SITUACAO=2;"
set objConn = server.CreateObject("ADODB.Connection")
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set afastamento=Server.CreateObject("ADODB.RecordSet")
afastamento.Open QueryAfastamento, dados_sys

	'response.Write "deu certo"


	DO UNTIL afastamento.eof
	
		dataInicio=afastamento("DT_INICIO")
		dataFim=afastamento("DT_FIM")
		Matricula=afastamento("CO_MATRICULA")
		codigoSituacao=afastamento("CO_SITUACAO")
		
		
		

		
		response.Write "<strong>Empregado: </strong>"
		response.Write "<strong>Motivo: </strong>"
		
		'Empregado: Jurandir Vieira Santiago - 10/12/2013 a 19/12/2013
		'Motivo: Licença Trat. Saúde Sem Desconto 

		afastamento.movenext
		
	LOOP
	
	

objConn.close 
set afastamento = nothing
set objConn = nothing 
%>

      
