	
<!-- essa pagina so mostra as ferias...as ausencias foram transfiridas para a pagina agenda_do_dia -->

<h3 class="subtitulosAgenda">F&eacute;rias</h3>
<%
if data <> "" Then

dataTotal = data

else

dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

END IF 

QueryQT_dias ="select DT_INICIO,CO_MATRICULA, QT_DIAS from TB_FERIAS WHERE CO_SITUACAO=2;"
set objConn = server.CreateObject("ADODB.Connection")
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set dias=Server.CreateObject("ADODB.RecordSet")
dias.Open QueryQT_dias, dados_sys

	DO UNTIL dias.eof
		
		dataInicialBanco=dias("DT_INICIO")
		
		codigoMatricula = dias("CO_MATRICULA")
		quantidadeDias=dias("QT_DIAS")
		
		
		dataFinal = DateAdd("d",quantidadeDias,dataInicialBanco)
		
	
'		
		'response.Write "data Inicial: "&dataInicialBanco&"<br/>"
		'response.Write "data Final: "&dataFinal&"<br/>"
	
	IF (MONTH(dataTotal) = MONTH(dataFinal)) AND (YEAR(dataTotal)= YEAR(dataFinal))Then
	
		
'	
	
	QueryFerias ="select NO_NOME from TB_USUARIOS  WHERE CO_MATRICULA='"&codigoMatricula&"' AND IC_ATIVO=1;" 
	set objConn = server.CreateObject("ADODB.Connection") 
	dados = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
	objConn.open dados
	set Feriasuser=Server.CreateObject("ADODB.RecordSet")
	Feriasuser.Open QueryFerias, dados 
	
	nomeUsuario=Feriasuser("NO_NOME")
	
	response.write "<p style='font-size:13px;font-family:Arial, Verdana;'><strong>"&nomeUsuario&"</strong></p><p style='font-size:12px;font-family:Arial,Verdana'>"& DAY(dataInicialBanco)&"/"&MONTH(dataInicialBanco)&"/"&YEAR(dataInicialBanco)&" &agrave; "& DAY(dataFinal)&"/"&MONTH(dataFinal)&"/"&YEAR(dataFinal)&"</p>"
	
	
	END IF
	
	dias.movenext
	LOOP
	
'	
objConn.close 
set dias = nothing
set objConn = nothing 

%>




 



      
