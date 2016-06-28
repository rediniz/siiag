<meta http-equiv="x-ua-compatible" content="IE=9">
<div class="cabecalhoprincipal">
  <!--cabeçalho -->
  <div class="cabecalhoinside">
    <div class="dadosdousuario">
      <!-- dados do usuario -->
      <%

		mat = Request.ServerVariables("LOGON_USER")
		i = InStr(mat,"\")
		If i > 0 Then
			dominio = UCase(Left(mat,i-1))
			usuario = UCase(Right(mat,Len(mat)-i))
		End If

		set objConn = 		server.CreateObject("ADODB.Connection")
		dados_sys = 		"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
		'dados_sys = 		"Provider=sqloledb;Data Source=RS7655NT005;Initial Catalog=SIIAG;User Id=italo;Password=italo;"
		strQuery = 			"select NO_NOME from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
		'strQuery = 			"select NO_NOME, CO_UNIDADE from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
		objConn.open dados_sys
		set rs =			Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys
		if not rs.eof then
			nome = rs("NO_NOME")	
			'co_unidade = rs("CO_UNIDADE")
			sem_acesso = false
		else
			nome = "Não identificado"	
			co_unidade = ""
			sem_acesso = true
		end if

%>
      <p>Usu&aacute;rio: <%=nome%> </p>
      <p>Matr&iacute;cula: <%=usuario%> </p>
    </div>
    <!--fim dos dados do usuario -->
    <img src="imagens/topimage5.png" class="imagetop"/>
    <!-- o original é o topimage4.jpg, mas esse aqui ficou melhor -->
    <div class="menu">
      <!-- barra laranja e menu -->
    </div>
    <!--fim do barra laranja e do menu-->
    <div class="menuinside">
      <div class="menucentralizado">
        <!--menu centralizado -->
        <nav id="colorNav">
          <ul>
            <li> <a href="protocolo.asp" class="icon-envelope">Protocolo</a> </li>
          </ul>
        </nav>
      </div>
      <!--fim menu centralizado -->
    </div>
  </div>
</div>

<%
if sem_acesso then
%>
		<center>
        	<br><br>
			<table width="100%" border="0" >
            <tr>
             <td align="center">
				<font color=#FFFFF >Você não está cadastrado no SIIAG. Contate o administrador do sistema da sua unidade.</font>
              </td>
			</tr>
            </table>
         </center>
<%		response.End()


end if
%>
<!--fim do cabeçalho-->
<!--</div><!-- se fechar aqui também fica legal -->
