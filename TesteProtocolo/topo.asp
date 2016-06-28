<meta http-equiv="x-ua-compatible" content="IE=9">
<div class="cabecalhoprincipal">
  <!--cabeçalho -->
  <div class="cabecalhoinside">
    <div class="dadosdousuario">
      <!-- dados do usuario -->
      <%


	 if request.Cookies("co_usuario") = "" or request.Cookies("co_usuario_unidade") = "" or request.Cookies("no_usuario") = "" then

		mat = Request.ServerVariables("LOGON_USER")
		i = InStr(mat,"\")
		If i > 0 Then
			dominio = UCase(Left(mat,i-1))
			usuario = UCase(Right(mat,Len(mat)-i))
		End If

		set objConn = 		server.CreateObject("ADODB.Connection")
	'	dados_sys = 		"Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
		dados_sys = 		"Provider=sqloledb;Data Source=RS7655NT005;Initial Catalog=SIIAG;User Id=italo;Password=italo;"
		'strQuery = 			"select NO_NOME from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
		strQuery = 			"select NO_NOME, CO_UNIDADE from TB_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
		objConn.open dados_sys
		set rs =			Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys
		if not rs.eof then
			'nome = rs("NO_NOME")
			response.Cookies("co_usuario") = usuario
			response.Cookies("co_usuario").expires = dateadd("n",+60,now())
			response.Cookies("no_usuario") = rs("NO_NOME")
			response.Cookies("no_usuario").expires = dateadd("n",+60,now())
			response.Cookies("co_usuario_unidade") = rs("CO_UNIDADE")
			response.Cookies("co_usuario_unidade").expires = dateadd("n",+60,now())

			'response.write "criou"
			'co_unidade = rs("CO_UNIDADE")
			sem_acesso = false
		else
			response.Cookies("no_usuario") = "Não identificado"
			response.Cookies("co_usuario") = ""
				
			co_unidade = ""
			sem_acesso = true
		end if
	 end if
%>
      <p>Usu&aacute;rio: <%=request.Cookies("no_usuario")%> </p>
      <p>Matr&iacute;cula: <%=request.Cookies("co_usuario")%> </p>
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
            <li> <a href="principal.asp" class="icon-home">P&aacute;gina Inicial</a> </li>
            <li> <a href="#" class="icon-cogs">Recursos Humanos</a>
              <ul>
                <li><a href="destacamentos.asp">Destacamentos</a></li>
                <li><a href="ferias.asp">F&eacute;rias</a></li>
                <li><a href="afastamento.asp">Afastamento</a></li>
                <li><a href="jornada.asp">Jornada</a></li>
                <li><a href="substituicao.asp">Substitui&ccedil;&atilde;o</a></li>

              </ul>
            </li>
            <li> <a href="#" class="icon-twitter">Recursos Materiais</a>
              <ul>
                <li><a href="emprestimos.asp">Empr&eacute;stimos</a></li>
                <li><a href="eventos_e_treinamentos.asp">Eventos e Treinamentos</a></li>
                <li><a href="estoque.asp">Estoque</a></li>
              </ul>
            </li>
            <li > <a href="#" class="icon-beaker">Relat&oacute;rios</a>
              <ul>
                <li><a href="Relatorio.asp?relatorio=destacamento">Destacamentos</a></li>
                <li><a href="Relatorio.asp?relatorio=ferias">F&eacute;rias</a></li>
                <li><a href="Relatorio.asp?relatorio=estoque">Estoque</a></li>
                <li><a href="Relatorio.asp?relatorio=treinamentos">Treinamentos</a></li>
                <li><a href="Relatorio.asp?relatorio=emprestimos">Empr&eacute;stimo de Materiais</a></li>
              </ul>
            </li>
            <li> <a href="usuario.asp" class="icon-envelope">Usu&aacute;rio</a> </li>
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
