<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<script>
$(document).ready(function() {

	$('.editar_ferias').on('click',function(){
								
			
			var co_ferias = $(this).parent().parent().find("#co_ferias").val();
	
			var top = (window.innerHeight / 2) - 120
			var left = (window.innerWidth / 2) - 250
			
			window.open("ferias_edicao.asp?co_ferias=" + co_ferias + "", "_blank", "height=420, width=400, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
			//carregarPagina(co_ferias);
	});


});
</script>  
<script language="javascript" type="text/javascript">
	function carregarPagina(co_ferias) {
		var d = new Date()

			$('#Tabela').html("<center><img src='imagens/carregando.gif' style='width:auto; height:auto;' /><span style='position:relative;top:-8px;'> Carregando...</span></center>");
			var campos = {}
			campos['co_ferias'] = co_ferias;
							
			$.ajax({
				type: 'POST', //Post (request.form) ou GET (request.querystring ou request)
				url: "ferias_edicao.asp?t=" + d.getTime(),
				data: campos,
				async: true, // se false, para a execução do java script até a finalização do processamento do ajax
				error: function (dados) {
					document.write('<b>Erros</b><br />' + dados.responseText)
					alert(var_dump(dados));
					alert('Ocorreram erros .');
					
				},
				success: function (dados) {
						$('#Tabela').html(dados);
						//alert($("#f_pagina_rodape").val());
					//alert('Ocorreram erros gravando dados.')
						//alert('Dados com sucesso!')
				}
			})
	}

	function realizarMonitoria(idMonitoria) {
		$("#f_Monitoria").val(idMonitoria);
		$("form").attr("action", "monitoria_contato.asp").submit();
	}

	$(function () {
		$("#f_ddDataReferencia,#f_ddEmpresa,#f_ddOperadores,#f_ddCodAcao,#f_ddCodResultado,#f_ddMonitoriaRealizada").change(function () {
			$.cookie(this.id, $(this).val());
			carregarTabela();
		})
		
	
		$( "#f_cpf_cnpj" ).on( "keydown", function(event) {
			if(event.which == 13) 
			{
				$("#f_pagina_rodape").val('1');
				carregarTabela();
			}
		});
		
		var campo = "f_ddDataReferencia"
		$("#" + campo).val($.cookie(campo));
		var campo = "f_ddEmpresa"
		$("#" + campo).val($.cookie(campo));
		var campo = "f_ddOperadores"
		$("#" + campo).val($.cookie(campo));
		var campo = "f_ddCodAcao"
		$("#" + campo).val($.cookie(campo));
		var campo = "f_ddCodResultado"
		$("#" + campo).val($.cookie(campo));

		carregarTabela()
	})
</script>


<style>
.edit{
	width:10px;
	height:10px;
	size:auto;
	
}

</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<div class='tabela'>
            <!--#ALTERADO EM 18/05/2016-->
            <p style="font-size:12px"><b>Legenda:</b><br />
 			<b> A</b> = Aviso de férias | <b>S</b> = Substituição | <b>R</b> = Requerimento de parcelamento/pecúnia</p>
            <table >
              <tr>
              
                <td width="8%">Matr&iacute;cula</td>
                <td width="25%">Nome</td>
                <td width="10%" >In&iacute;cio</td>
                <td width="5%">Qt. Dias</td>
                <td width="8%" >Abono</td>
                <td width="22%" >Coordena&ccedil;&atilde;o</td>
                <td width="10%" >Situa&ccedil;&atilde;o</td>
                <td width="15%" >Solicitado em</td>
                <td width=1%>A</td>
                <td width=1%>S</td>
                <td width=1%>R</td>
                <td width="15%" >Editar</td>	
                
              </tr>
              <!-------------------------->
   			
         
<%

strQuery = "SELECT * FROM VW_PENDENCIAS_FERIAS AS PEND_FERIAS INNER JOIN TB_USUARIOS AS USUARIOS ON PEND_FERIAS.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE PEND_FERIAS.CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "' ORDER BY DT_INICIO"

'response.write(strQuery)

set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys

	DO UNTIL rs.eof

		co_ferias = rs("CO_FERIAS")
		CO_MATRICULA = rs("CO_MATRICULA")
		NO_NOME = ucase(rs("NO_NOME"))
		DT_INICIO = rs("DT_INICIO")
		QT_DIAS = rs("QT_DIAS")
		IC_ABONO = rs("IC_ABONO")
		NO_GS = rs("NO_GS")
		DE_SITUACAO = rs("DE_SITUACAO")
		DH_CRIACAO = formatar_data(rs("DH_CRIACAO"))
		Digito_Mat = rs("CO_DIGITO")
	%>
		<tr>
		<td id='CO_MATRICULA'><%= CO_MATRICULA&" - "&Digito_Mat%></td>
		<td id='NO_NOME' style="text-align:left;"><%= NO_NOME %></td>
		<td id='DT_INICIO'><%= DT_INICIO %></td>
		<td id='QT_DIAS'><%= QT_DIAS %></td>
		<%	
        if IC_ABONO then
			response.write "<td id='IC_ABONO'>Sim</td>"
		else 
			response.write "<td id='IC_ABONO'>Não</td>"
		end if
		%>
		<td id='NO_GS'><%= NO_GS %></td>
		<td id='DE_SITUACAO'><%= DE_SITUACAO%></td>
		<td id='DH_CRIACAO'><%= DH_CRIACAO %></td>
        <!--#ALTERADO 21/05/2016-------------------->
        <td id='aviso' ><input type='checkbox' disabled="disabled" <%if rs("ic_aviso_assinado") = "True" then response.write "checked" end if%>/></td>
        <%
       	queryCoordenadorGerente = "SELECT CO_CARGO FROM VW_USUARIOS WHERE CO_MATRICULA =  '"&rs("co_matricula")&"'"
		coCargo = objConn.execute(queryCoordenadorGerente)("CO_CARGO")
		if coCargo = 1 or coCargo = 2 then %>
            <td id='substituicao' ><input type='checkbox' disabled="disabled" <%if rs("ic_substituicao") = "True" then response.write "checked" end if%>/></td>
        <%
        else
            response.write "<td></td>"
        end if
        '#ALTERADO EM 22/05/2016
        queryIdade = "select CAST(DATEDIFF(YEAR, DT_NASCIMENTO,'"&DT_INICIO&"') AS INT) AS IDADE from tb_usuarios where co_matricula = '"&rs("co_matricula")&"'"
				idade = cint(objConn.execute(queryIdade)("idade"))
        if idade >= 50 and cint(QT_DIAS) < 30 then
        %>
            <td id='parcelamento' ><input type='checkbox' disabled="disabled" <%if rs("ic_requerimento") = "True" then response.write "checked" end if%>/></td>
        <%
        else
            response.write "<td></td>"
        end if
        %>
		<!-------------------------------------------------->
		<td width="15%"><img class="editar_ferias" id="bt_editar_ferias"  width="15" height="15" src="imagens/edit.png" style="cursor:pointer; width:17px; height:17px;border:none">
        <input type="hidden" name="co_ferias" id="co_ferias" value="<%=co_ferias%>" />
        </td>
		</tr>

<%
		rs.movenext
				
	LOOP
	response.Write"</table>"
			


objConn.close 
set rs = nothing
set objConn = nothing

%>          
</div>  
            
<div id="Tabela" style="position:absolute; border:#000000 solid 0px; background-color:#FFFFFF; top:50%; margin-top: -100px; left: 50%; margin-left: -250px; width:500px;">
</div>