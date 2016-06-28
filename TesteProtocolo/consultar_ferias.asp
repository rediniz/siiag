<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar F&eacute;rias</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->



</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo.asp" -->
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='ferias.asp'><span>Solicitar</span></a></li>
              <li  class='active'><a href='consultar_ferias.asp'><span>Consultar</span></a></li>
            </ul>
          </div>
          </p>
          <div id='submenu'>
            <ul>
              <li><a href='#'><span>Ajuda</span></a></li>
            </ul>
          </div>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend><span class="titulos" > Consultar F&eacute;rias</span></legend>
          <p class="paragrafoteste">
            <label>Situa&ccedil;&atilde;o :</label>
            <select name"situacao">
              <option value="solicitado" selected="selected">Socilitado</option>
              <option value="confirmado">Confirmado</option>
              <option value="pendente">Pendente</option>
              <option value="gozado">Gozado</option>
              <option value="natendido">Não Atendido</option>
              <option value="cancelado">Cancelado</option>
              <option value="emandamento">Em Andamento</option>
            </select>
            &nbsp;&nbsp;
            <label>Por Data: </label>
            <input name="por_data" type="text" size="20" maxlength="27" />
          <div class="tabela" style="margin-left:0.8%; margin-bottom:3%;" >
            <table>
              <tr>
                <td width="8%">Matr&iacute;cula</td>
                <td width="17%" >Nome</td>
                <td width="8%">In&iacute;cio</td>
                <td width="10%" >Situa&ccedil;&atilde;o</td>
                <td width="15%">Data de Solicita&ccedil;&atilde;o</td>
                <td width="17%" >Empregado Solicitante</td>
                <td width="25%" >Quantidade de Dias de Abono</td>
              </tr>
        
<%
			  
strQuery = "select CO_MATRICULA, DIAS_ABONO, DT_INICIO, CO_CRIADOR, CO_SITUACAO, DH_CRIACAO from TB_FERIAS WHERE CO_SITUACAO = "& 1 &" " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys


	DO UNTIL rs.eof
'atribuindo os valores dos campos as variáveis
  Matricula=rs("CO_MATRICULA")
  Dias_de_abono=rs("DIAS_ABONO")
  Data_de_inicio=rs("DT_INICIO")
  Empregado_Solicitante=rs("CO_CRIADOR")
  Situacao=rs("CO_SITUACAO")
  dataCriacao = rs("DH_CRIACAO")
  
  diaInicio = DAY(Data_de_inicio)
  mesInicio = MONTH(Data_de_inicio)
  anoInicio = YEAR(Data_de_inicio)
  
  
  
  diaCriacao =  DAY(dataCriacao)
  mesCriacao =  MONTH(dataCriacao)
  anoCriacao =  YEAR(dataCriacao)
  horaCriacao = HOUR(dataCriacao)
  minutoCriacao = MINUTE(dataCriacao)
  segundoCriacao = SECOND(dataCriacao)
  
  'dataTotalCriacao = diaCriacao &"/"& mesCriacao &"/"& anoCriacao &" &agrave;s "& horaCriacao &":"& minutoCriacao &":" &segundoCriacao
  
  dataTotal = diaInicio &"/"& mesInicio& "/"& anoInicio
  
  	querySituacao = "select DE_SITUACAO from TB_SITUACOES WHERE CO_SITUACAO ="& Situacao &" " 
	set objConn = server.CreateObject("ADODB.Connection") 
	dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
	objConn.open dados_sys
	set qs=Server.CreateObject("ADODB.RecordSet")
	qs.Open querySituacao, dados_sys
		
		descricao_Situacao = qs("DE_SITUACAO")
		
		
		
	QueryNomeUser ="select NO_NOME from TB_USUARIOS  WHERE CO_MATRICULA ='"& Matricula &"';" 
	set objConn = server.CreateObject("ADODB.Connection") 
	dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
	objConn.open dados_sys
	set tuser=Server.CreateObject("ADODB.RecordSet")
	tuser.Open QueryNomeUser, dados_sys 
		
		nomeFuncionario=tuser("NO_NOME")	
		
	
		
	
	
 
                    	response.write "<tr>"
                        response.write "<td>"& Matricula & "</td>"
                        response.write "<td>"& nomeFuncionario &"</td>"
                        response.write "<td>"& dataTotal &"</td>"
                        response.write "<td>"& descricao_Situacao &"</td>"
                        response.write "<td>"& dataCriacao &"</td>"
                        response.write "<td>"& Empregado_Solicitante &"</td>"
                        response.write "<td>"& Dias_de_abono &"</td>"
                   		response.write "</tr>"
					  	rs.movenext
					LOOP
objConn.close 
set rs = nothing
set objConn = nothing 
%>
            </table>
          </div>
          </fieldset>
        </div>
      </div>
    </div>
  </div>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>





