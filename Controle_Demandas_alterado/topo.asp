
<meta http-equiv="x-ua-compatible" content="IE=9">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<!-- #INCLUDE FILE ="../include/funcoes.asp" -->

<div class="cabecalhoprincipal">
  <!--cabeçalho -->
  <div class="cabecalhoinside">
    <div class="dadosdousuario">
      <!-- dados do usuario -->
      <%
		usuario = Usuario_Rede
		strQuery = "select * from VW_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys
		'response.write strQuery
		'response.write "gerente:" & rs("IC_GERENTE")
		if not rs.eof then
			'nome = rs("NO_NOME")
			response.Cookies("co_usuario_siiag") = usuario
			response.Cookies("co_usuario_unidade_siiag") = rs("co_unidade")
			'response.Cookies("co_usuario_siiag").expires = dateadd("n",+60,now())
			response.Cookies("no_usuario_siiag") = rs("NO_NOME")
			'response.Cookies("no_usuario_siiag").expires = dateadd("n",+60,now())
			response.Cookies("co_usuario_unidade_siiag") = rs("CO_UNIDADE")
			response.Cookies("co_usuario_sg_unidade_siiag") = rs("SG_UNIDADE")
			response.Cookies("co_usuario_gs_siiag") = rs("CO_GS")
			'response.Cookies("co_usuario_unidade_siiag").expires = dateadd("n",+60,now())
			if rs("IC_GERENTE") then
				response.Cookies("ic_gerente_siiag") = true
				'response.Cookies("ic_gerente_siiag").expires = dateadd("n",+60,now())
			else
				response.Cookies("ic_gerente_siiag") = false
				'response.Cookies("ic_gerente_siiag").expires = dateadd("n",+60,now())
			end if
			
			
			sem_acesso = false
		else
			response.Cookies("no_usuario_siiag") = "Usuário não identificado"
			response.Cookies("co_usuario_siiag") = ""
			response.Cookies("ic_gerente_siiag") = ""
			response.Cookies("co_usuario_unidade_siiag") = ""
			response.Cookies("co_usuario_sg_unidade_siiag") = ""
			co_unidade = ""
			sem_acesso = true
		end if
	
	 
	  '**** Pega o Nome do Perfil do Usuário
	  Perfil_Nome()
	  '*************************************
%>
      <p style="font-size:12px;">
	  <%=request.Cookies("no_usuario_siiag")%>
	  <%
	  	if request.Cookies("co_usuario_siiag")<> "" then
	    	response.write " - " & request.Cookies("co_usuario_siiag")
      	end if
	  %>
       </p>
		
      <p style="font-size:12px;"> 
	  <% 
		if request.Cookies("perfil_acesso_siiag_desc") <> "" then
			response.write "Perfil: " &  request.Cookies("perfil_acesso_siiag_desc")
		end if
		if request.Cookies("co_usuario_unidade_siiag") <> "" then
			response.Write(" | Unidade: " & request.Cookies("co_usuario_unidade_siiag") & " - " & request.Cookies("co_usuario_sg_unidade_siiag") )
		end if
		'response.write request.Cookies("ic_gerente_siiag")
	   %>
      </p>
    </div>
    <!--fim dos dados do usuario -->
    
<a href="principal.asp" ><img src="imagens\topimage5.png" border="0" class="imagetop" /></a>

<!-- o original é o topimage4.jpg, mas esse aqui ficou melhor -->
    <div class="menu">
      <!-- barra laranja e menu -->
    </div>
    <!--fim do barra laranja e do menu-->
    <div class="menuinside" >
      <div class="menucentralizado">
        <!--menu centralizado -->
        <nav id="colorNav" style="margin-left:-23px">
          <ul>
            <li> <a href="principal.asp" class="icon-home">P&aacute;gina Inicial</a> </li>
            <li> <a href="#" class="icon-cogs">Recursos Humanos</a>
              <ul>
                <li><a href="destacamentos.asp">Destacamentos</a></li>
                <li><a href="ferias.asp">F&eacute;rias</a></li>
                <li><a href="afastamento.asp">Afastamento</a></li>
                <li><a href="jornada.asp">Jornada</a></li>
                <li><a href="substituicao.asp">Substitui&ccedil;&atilde;o</a></li>
                <!---  Aqui vai ficar a parte do menu do apoio-->
				<%
				'somente aqueles que fizerem parte da coordenacao apoio
				if tem_acesso("10") then 'MODULO APOIO
					Response.Write "<li><a href='apoio.asp' class='icon-envelope'> Controle </a></li>"
				End If
				%>
              </ul>
            </li>
            <li> <a href="#" class="icon-twitter">Recursos Materiais</a>
              <ul>
                <li><a href="emprestimos.asp">Reserva de Equipamentos</a></li>
                <li><a href="eventos_e_treinamentos.asp">Eventos e Treinamentos</a></li>
                <li><a href="estoque_requisicao.asp">Estoque</a></li>
                <li><a href="controle.asp">Controle de Equipamentos</a></li>
              </ul>
            </li>
            <!--<li > <a href="#" class="icon-beaker">Relat&oacute;rios</a>
              <ul>
                <li><a href="Relatorio.asp?relatorio=destacamento">Destacamentos</a></li>
                <li><a href="Relatorio.asp?relatorio=ferias">F&eacute;rias</a></li>
                <li><a href="Relatorio.asp?relatorio=estoque">Estoque</a></li>
                <li><a href="Relatorio.asp?relatorio=treinamentos">Treinamentos</a></li>
                <li><a href="Relatorio.asp?relatorio=emprestimos">Empr&eacute;stimo de Materiais</a></li>
              </ul>
            </li>-->
            <li> <a href="protocolo.asp" target="_blank">Protocolo</a> </li>
            <!--<li> <a href="Controle_Demandas/demanda_solicitar.php">Demandas T.I</a> </li> -->
            <li> <a href="usuario.asp" class="icon-envelope">Usu&aacute;rios</a> </li>
            <li> <a href="manual.pdf" class="icon-envelope" target="_blank">Manual</a> </li>
            <!--<li> <a href="protocolo.asp" class="icon-envelope">Protocolo</a> </li>-->
            
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

<%
function URLDecode(str)
	dim re
	set re = new RegExp

	str = Replace(str, "+", " ")
	
	re.Pattern = "%([0-9a-fA-F]{2})"
	re.Global = True
	URLDecode = re.Replace(str, GetRef("URLDecodeHex"))
end function

%>