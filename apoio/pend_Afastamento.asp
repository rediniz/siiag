<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<style>
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}

</style>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<div class='tabela'>
            <table>
              <tr>
              
                <td width="8%">Matr&iacute;cula</td>
                <td width="25%">Nome</td>
                <td width="10%" >In&iacute;cio</td>
                <td width="10%">Fim</td>
                <td width="19%" >Coordena&ccedil;&atilde;o</td>
                <td width="10%" >Situa&ccedil;&atilde;o</td>
                <td width="11%" >Solicitado em</td>
                <td>Documento</td>
                <td width="15%"> Editar </td>    
              </tr>
   			
           
<%

strQuery = "SELECT * FROM VW_PENDENCIAS_AFASTAMENTOS AS PEND_AFASTAMENTOS INNER JOIN TB_USUARIOS AS USUARIOS ON PEND_AFASTAMENTOS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE PEND_AFASTAMENTOS.CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY DT_INICIO"

'response.write(strQuery)

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys


	DO UNTIL rs.eof
	
		CO_MATRICULA = rs("CO_MATRICULA")
		NO_NOME = rs("NO_NOME")
		DT_INICIO = formatar_data(rs("DT_INICIO"))
		DT_FIM = formatar_data(rs("DT_FIM"))
		NO_GS = rs("NO_GS")
		DE_SITUACAO = rs("DE_SITUACAO")
		DH_CRIACAO = rs("DH_CRIACAO")
		CO_AFASTAMENTO = rs("CO_AFASTAMENTO")
		Digito_Mat = rs("CO_DIGITO")

		response.write "<tr>"
		response.write "<td id='CO_MATRICULA'>"& CO_MATRICULA &" - "&Digito_Mat&"</td>"
		response.Write "<td id='NO_NOME' style='text-align:left;'>"&NO_NOME&"</td>"
		response.write "<td id='DT_INICIO'>"& DT_INICIO &"</td>"
		response.Write "<td id='QT_DIAS'>"&DT_FIM&"</td>"
		response.write "<td id='NO_GS'>"& NO_GS&"</td>"
		response.write "<td id='DE_SITUACAO'>"& DE_SITUACAO&"</td>"
		response.write "<td id='DH_CRIACAO'>"& formatar_data(DAY(DH_CRIACAO)&"/"&MONTH(DH_CRIACAO)&"/"&YEAR(DH_CRIACAO)) &"</td>"
		response.Write "<input type='hidden' name='co_afastamento' id='co_afastamento' value='"&CO_AFASTAMENTO&"'/>"
		
		set ds=Server.CreateObject("ADODB.RecordSet")											
		sqlDocumento = "SELECT * FROM TB_AFASTAMENTOS_DOCUMENTOS WHERE CO_AFASTAMENTO = " & CO_AFASTAMENTO
		ds.Open sqlDocumento, dados_sys, 3, , 32	
		
		if not ds.eof then
			idDocumento = ds("id")
			caminhoDocumento = ds("caminho")
			visualizaArquivo = false
			perfilVisualizar = false	
			chefiaDireta = false	
			
			queryPerfil = "SELECT CO_PERFIL FROM VW_USUARIOS_PERFIS WHERE CO_MATRICULA = '" & Session("v_Usuario_Matricula") & "' AND CO_PERFIL IN (1, 2, 7)"
			set perfilRs = Server.CreateObject("ADODB.RecordSet")
			perfilRs.Open queryPerfil, dados_sys
			
			if not perfilRs.eof then
				perfilVisualizar = true
			end if
			
			perfilRs.close
			
			queryCoordenador= "SELECT * FROM TB_USUARIOS A, VW_GS B WHERE A.CO_GS = B.CO_GS AND (CO_MATRICULA = '" & CO_MATRICULA & "' AND CO_GERENTE = '" & Session("v_Usuario_Matricula") & "')"
			set coordenadorRs = Server.CreateObject("ADODB.RecordSet")
			coordenadorRs.Open queryCoordenador, dados_sys
			
			if not coordenadorRs.eof then
				chefiaDireta = true
			end if
			
			coordenadorRs.close
			
			if perfilVisualizar or chefiaDireta or Session("v_Usuario_Matricula") = CO_MATRICULA then
				visualizaArquivo = true
			end if
	
			if visualizaArquivo then
				link = Replace(caminhoDocumento, "/", "\")
				response.Write "<td><a href='" & link & "' target='_blank'><img class='documento' id='doc' src='imagens/adobe_16x16.png' width='15' height'15' style='cursor:pointer;width:17px; height:17px;border:none'></a></td>"							
			else
				response.Write "<td><img class='documento' id='doc' src='imagens/adobe_16x16.png' style='width:17px; height:17px;border:none'></td>"
			end if		
	  else
		  response.write "<td></td>"
	  end if
	  
		response.Write "<td width='15%'><img class='editar_afastamento' id='editar_afastamento'  width='15' height'15' src='imagens/edit.png' style='cursor:pointer; width:17px; height:17px;border:none'>"
		
		
		
		response.write "</tr>"
		rs.movenext
			
	LOOP
	response.Write"</table>"
			
		

objConn.close 
set rs = nothing
set objConn = nothing

%>            
   </div>         