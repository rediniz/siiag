<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!--CSS -->
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<script src="scripts/jquery-1.9.1.js"></script>
<script type="text/javascript" language="javascript">
	function Salvar()
	{
		form_lista.f_salvar.value = '1';
		form_lista.submit();
	}
 </script>
<script>
$(function() {
	
		$(document).on("click", ".editar", function(){
			var co_usuario = $(this).parent().find("#co_matricula").val();
			window.open("tre_edicao.asp?co_usuario="+co_usuario,"_blanck","width=500, height=400,top=200, left=500"); 
			//alert("teset");
	
		});
	
	
});
</script>
 
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
	'co_perfil = trim(request("co_perfil"))
	'response.write "co_perfil:" & co_perfil
		'response.End()

		set rs2 = Server.CreateObject("ADODB.RecordSet")
		strQuery = 	"SELECT * FROM VW_TRE WHERE CO_UNIDADE = '" & request.Cookies("co_usuario_unidade_siiag") & "' order by no_nome  " 	
		rs2.Open strQuery, dados_sys
		if rs2.eof then
			response.Write("O sistema não localizou informações de TRE para sua unidade.")
			response.end
		else
			NO_PERFIL = ""
			'response.write "salvar:" & request("f_salvar")
			if cStr(request("f_salvar")) = "1" then
				'set rs_alt = Server.CreateObject("ADODB.RecordSet")
				'Set rs_alt = objConn.execute("SET NOCOUNT ON; DELETE TB_PERFIL_ACESSO where CO_PERFIL='" & co_perfil & "';")
				'set rs_alt = nothing
				'for each item in request("chk_acesso")
				'	'response.write "item: " & item & "<br>"
				'	set rs2 = Server.CreateObject("ADODB.RecordSet")
				'	if request("chk_admin_" & item) = "on" then
				'		admin = "1"
				'	else
				'		admin = "0"
				'	end if
				'	SQL = "SET NOCOUNT ON; INSERT INTO TB_PERFIL_ACESSO (CO_PERFIL, CO_ACESSO, IC_ADMIN) VALUES (" & co_perfil & ",'" & item & "'," & admin & ");"
				'	'RESPONSE.Write(SQL) & "<BR>"
				'	Set rs2 = objConn.execute(SQL)
				'	set rs2 = nothing
				'next	
			end if
	
		
			'set rs = Server.CreateObject("ADODB.RecordSet")
			'strQuery = 	" SELECT A.COD_TIPO_ACESSO, A.DE_ACESSO, B.IC_ADMIN, B.CO_ACESSO AS CADASTRADO "
			'strQuery = 	strQuery & " FROM TB_TIPOS_ACESSOS A  "
			'strQuery = 	strQuery & " LEFT JOIN ( SELECT * FROM [VW_PERFIS_CADASTRADOS] WHERE CO_PERFIL = " & co_perfil & ") AS B ON A.COD_TIPO_ACESSO = B.CO_ACESSO "
			'strQuery = 	strQuery & " ORDER BY A.DE_ACESSO " 	
			'rs.Open strQuery, dados_sys
		end if

%>

<!-- fecha efeito da janela de ajuda -->
		<form action="manutencao_permissao_perfis_tabela.asp" method="post" target="_self" name="form_lista" id="form_lista" >
            <!--<input type="hidden" name="co_perfil" id="co_perfil" value="<%=co_perfil%>"/> -->
            <input type="hidden" name="f_salvar" id="f_salvar" value=""/>
            <input type="hidden" name="usuario"  value="<%=usuario%>"/>

            <br><br>

<div class="tabela"  >
              <table width="653" border="0" cellspacing="0" cellpadding="0" >
                <tr>
                    <td>Nome</td>
                    <td align="center">Qtde Dias</td>
                    <td align="center">Qtde Utilizada</td>
                    <td align="center">Saldo</td>
                    <td align="center" ></td>
                </tr>
				<%do while not rs2.eof%>
                <tr>
                    <td style="text-align:left;"><input type="hidden" name="co_matricula" id="co_matricula" value="<%=rs2("co_matricula")%>" /><%=rs2("co_matricula")%> - <%=ucase(rs2("no_nome"))%></td>
                    <td align="center"><%=rs2("qt_dias")%></td>
                    <td align="center"><%=rs2("qt_dias_utilizado")%></td>
                    <td align="center"><%=rs2("qt_dias") - rs2("qt_dias_utilizado")%></td>
                    <td align="center" id="editar" class="editar" ><img   src='imagens/edit_23_23_2.png' style='cursor:pointer' title='Editar' ></td>
                </tr>
				<%
					rs2.movenext
				loop%>
              </table>
              <br>
</div>
		</form>          

          </p>
          <div id="edicao"></div>

