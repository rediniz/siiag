
<meta http-equiv="x-ua-compatible" content="IE=9">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="imagens/favicon.ico" >
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->

<script>
$(document).ready(function() {
	$(document).on("change", "#combo_unidade", function(){ 
		$("#co_unidade_selecionada").val($("#combo_unidade").val());
		$("#frm_unidade").submit();
	});
	
});

</script>

<div class="cabecalhoprincipal">
  <!--cabeçalho -->
  <div class="cabecalhoinside">
    <div class="dadosdousuario">
      <!-- dados do usuario -->
      <%
	'usuario = "C023027"
	usuario = "C124937"
	co_unidade_selecionada = "7180"
	
	if co_unidade_selecionada <> "" then
		response.Cookies("co_usuario_unidade_selecionada") = co_unidade_selecionada
	end if
	
	if UCASE(usuario) = "C053498" or UCASE(usuario) = "C124937"  then 
		'usuario = "C063660"
		'response.Cookies("co_usuario_siiag") = ""
	end if
	'response.write request.Cookies("co_usuario_siiag")
	'if request.Cookies("co_usuario_siiag") = ""  then
		'response.write "entrou"
		strQuery = "select * from VW_USUARIOS where CO_MATRICULA='" & usuario & "'; " 
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open strQuery, dados_sys
		'response.write strQuery
		'response.write "gerente:" & rs("IC_GERENTE")
		if not rs.eof then
			'nome = rs("NO_NOME")
			response.Cookies("co_usuario_siiag") = usuario
			'response.Cookies("co_usuario_siiag").expires =  dateadd("n",+5,now())
			response.Cookies("co_usuario_dv_siiag") = rs("co_digito")
			response.Cookies("co_usuario_unidade_siiag") = rs("co_unidade")
			'response.Cookies("co_usuario_siiag").expires = dateadd("n",+60,now())
			response.Cookies("no_usuario_siiag") = rs("NO_NOME")
			'response.Cookies("no_usuario_siiag").expires = dateadd("n",+60,now())
			if request.Cookies("co_usuario_unidade_selecionada") <> "" then
				response.Cookies("co_usuario_unidade_siiag") = request.Cookies("co_usuario_unidade_selecionada")
			else
				response.Cookies("co_usuario_unidade_siiag") = rs("CO_UNIDADE")
				response.Cookies("co_usuario_sg_unidade_siiag") = rs("SG_UNIDADE")
			end if
			if isnull(rs("CO_GS")) then
				response.Cookies("co_usuario_gs_siiag") = ""
			else
				response.Cookies("co_usuario_gs_siiag") = rs("CO_GS")
			end if
			'response.Cookies("co_usuario_unidade_siiag").expires = dateadd("n",+60,now())
			if rs("IC_GERENTE") then
				response.Cookies("ic_gerente_siiag") = true
				'response.Cookies("ic_gerente_siiag").expires = dateadd("n",+60,now())
			else
				response.Cookies("ic_gerente_siiag") = false
				'response.Cookies("ic_gerente_siiag").expires = dateadd("n",+60,now())
			end if
			sem_acesso = false
			carrega_acessos()
			'response.write request.Cookies("acessos_siiag")
		else
			response.Cookies("no_usuario_siiag") = "Usuário não identificado"
			response.Cookies("co_usuario_siiag") = ""
			response.Cookies("co_usuario_dv_siiag") = ""
			response.Cookies("ic_gerente_siiag") = ""
			response.Cookies("co_usuario_unidade_siiag") = ""
			response.Cookies("co_usuario_sg_unidade_siiag") = ""
			co_unidade = ""
			sem_acesso = true
		end if
	
	 
	  '**** Pega o Nome do Perfil do Usuário
	  Perfil_Nome()
	  if request.Cookies("perfil_acesso_siiag_desc") = "" then
		Admn_Unidade = Localiza_Admn_Unidade()
		if Admn_Unidade <> "" then 
			response.write "<script>"
			response.write "alert('Você não possui perfil cadastrado. Solicite ao(à) " & Admn_Unidade & " o cadastramento de seu Perfil.');"
			response.write "</script>"
		else
			response.write "<script>"
			response.write "alert('Não há Administrador de Unidade cadastrado para " & request.Cookies("co_usuario_sg_unidade_siiag") & ".\n Solicite à GIFUG/FO o cadastramento de sua Unidade ao SIIAG.');"
			response.write "</script>"
		end if
	end if
	  '*************************************
	'end if
%>
	  <table border="0" align="right" style=" margin-right: 10px; margin-top:5px; font-family: 'Futura Bk BT'">
      <tr>
      	<td style="font-size:12px; text-align:right;">
      <!--<p style="font-size:12px;"> -->
	  <%=left(request.Cookies("no_usuario_siiag"),31)%>
	  <%
	  	if request.Cookies("co_usuario_siiag")<> "" then
	    	response.write " (" & request.Cookies("co_usuario_siiag") & ")"
      	end if
	  %>
       <!--</p> -->
		</td>
		<td rowspan="2"  valign="bottom" align="right">
		<% if tem_acesso("10") then 'MODULO APOIO %>
	        <a href="apoio.asp" ><img src="imagens\ferramentas_23_23.png" border="0" title="Gerenciamento" onmouseover="this.src='imagens/ferramentas_23_23_cinza_claro.png'" onmouseout="this.src='imagens/ferramentas_23_23.png'"   /></a>
         <%end if%>
        </td>
       </tr>
       <tr>
       <td style="font-size:12px;" align="left">
      <!--<p style="font-size:12px; vertical-align:middle; margin-top:1px; border:#000000 solid 1px;"> -->
      <form name="frm_unidade" id="frm_unidade"  action="principal.asp" method="post" >
	  <% 
		if request.Cookies("perfil_acesso_siiag_desc") <> "" then
			response.write "Perfil: " &  request.Cookies("perfil_acesso_siiag_desc")
		end if
		if request.Cookies("co_usuario_unidade_siiag") <> "" then
			if Eh_Perfil_Verificado("1") then
				response.Write(" | Unidade: " )
				Combo_Unidades(request.Cookies("co_usuario_unidade_siiag"))
			else
				response.Write(" | Unidade: " & request.Cookies("co_usuario_unidade_siiag") & " - " & request.Cookies("co_usuario_sg_unidade_siiag") )
			end if
		end if
		'response.write request.Cookies("ic_gerente_siiag")
	   %>
		
	        <input  type="hidden" name="co_unidade_selecionada" id="co_unidade_selecionada" value="" />
       <!--</p> -->
       </form>
      </td>
      </tr>
      </table>
    </div>
    <!--fim dos dados do usuario -->
    
<a href="principal.asp" ><img src="imagens\topo_image.png" border="0" class="imagetop" /></a>

<!-- o original é o topimage4.jpg, mas esse aqui ficou melhor 
    <div class="menu">
      <!-- barra laranja e menu 
    </div> -->

    <!--fim do barra laranja e do menu-->
    <div class="menuinside" >
      <div class="menucentralizado" >
        <!--menu centralizado -->
        <nav <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %> id="colorNav" <%else%> id="colorNavOUTROS" <%end if%> class = "cabeçalho colorNavFOR" style="margin-left:-35px; height:30px;" >
          <ul>
            <!--<li> <a href="principal.asp" class="icon-home">P&aacute;gina Inicial</a> </li> -->
            <li> <a href="principal.asp" onmouseover="home.src='imagens/home_23_23.png'" onmouseout="home.src='imagens/home_23_23_cinza_escuro.png'" ><img id="home" src="imagens\home_23_23_cinza_escuro.png" border="0" title="Página Inicial"   /></a></li>
            <li> <a href="#" class="icon-cogs" >Recursos Humanos</a>
              <ul>
                <li><a href="afastamento.asp">Afastamentos</a></li>
                <li><a href="destacamentos.asp">Destacamentos</a></li>
                <li><a href="ferias.asp">F&eacute;rias</a></li>
                <li><a href="jornada.asp">Jornada</a></li>
                <li><a href="substituicao.asp">Substitui&ccedil;&atilde;o</a></li>
                <li><a href="lista_distribuicao.asp">Lista de Distribuição</a></li>
                  <!--#ALTERADO EM 02/05/2016 -->
                <li><a href="colaboracao_conhecimento.asp">GIFUG Colaborativa</a></li>
                <!---  Aqui vai ficar a parte do menu do apoio-->
              </ul>
            </li>
            <li> <a href="#" class="icon-twitter" >Recursos Materiais</a>
              <ul>
                <li><a href="emprestimos.asp">Reserva de Equipamentos</a></li>
                <li><a href="eventos_e_treinamentos.asp">Eventos e Treinamentos</a></li>
                <li><a href="estoque_requisicao.asp">Estoque</a></li>
                <li><a href="controle.asp">Controle de Equipamentos</a></li>
                <li><a href="reparos.asp">Reparos</a></li>
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
            <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
	            <li> <a href="protocolo.asp" target="_self">Protocolo</a> </li>
           	<% end if %>
            <li> <a href="usuario.asp" class="icon-envelope" >Usu&aacute;rios</a> </li>
	        <% if request.Cookies("co_usuario_unidade_siiag") = "7180" then %>
				<%if tem_acesso_admin("12") then %>
                         <li> <a href="demanda_consultar.asp">Demandas T.I.</a> </li>
                <%else %>
                         <li> <a href="demanda_solicitar.asp">Demandas T.I.</a> </li>
                <%end if %>
            <%end if %>
            <li> <a href="manual.pdf" class="icon-envelope" target="_blank" > Manual</a> </li>
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

Sub Combo_Unidades(co_unidade)
	sql = "select * from TB_UNIDADE ORDER BY DE_UNIDADE " 
	set rs = Server.CreateObject("ADODB.RecordSet")
	rs.Open sql, dados_sys

	If Not rs.eof Then
		select_unidade = "<select id='combo_unidade' name='combo_unidade' style='width: 110px; font-size:11px;' class='form-control' required=''><option value=''></option>"
		Do Until rs.eof 
			select_unidade = select_unidade & "<option value='"&rs("co_unidade") & "' "
			if cstr(rs("co_unidade")) = cstr(co_unidade) then
				select_unidade = select_unidade & " selected "
			end if
			select_unidade = select_unidade &  " > " & rs("co_unidade") & "-" & rs("sg_unidade")&"</option>"
		rs.movenext
		Loop
		select_unidade = select_unidade & "</select>"
	End If
	
	response.write select_unidade

End Sub

%>