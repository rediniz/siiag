<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!--CSS -->
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" language="javascript">
	function Salvar()
	{
		form_lista.f_salvar.value = '1';
		form_lista.submit();
	}
 </script>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<%
	co_perfil = trim(request("co_perfil"))
	'response.write "co_perfil:" & co_perfil
	if co_perfil <> "" then
		'response.End()

		set rs2 = Server.CreateObject("ADODB.RecordSet")
		strQuery = 	"SELECT * FROM TB_TIPOS_PERFIS  WHERE CO_PERFIL = " & co_perfil & "  " 	
		rs2.Open strQuery, dados_sys
		if rs2.eof then
			response.Write("O sistema não localizou o perfil " & co_perfil & ".")
			response.end
		else
			NO_PERFIL = rs2("NO_PERFIL")
			'response.write "salvar:" & request("f_salvar")
			if cStr(request("f_salvar")) = "1" then
				set rs_alt = Server.CreateObject("ADODB.RecordSet")
				Set rs_alt = objConn.execute("SET NOCOUNT ON; DELETE TB_PERFIL_ACESSO where CO_PERFIL='" & co_perfil & "';")
				set rs_alt = nothing
				for each item in request("chk_acesso")
					'response.write "item: " & item & "<br>"
					set rs2 = Server.CreateObject("ADODB.RecordSet")
					if request("chk_admin_" & item) = "on" then
						admin = "1"
					else
						admin = "0"
					end if
					SQL = "SET NOCOUNT ON; INSERT INTO TB_PERFIL_ACESSO (CO_PERFIL, CO_ACESSO, IC_ADMIN) VALUES (" & co_perfil & ",'" & item & "'," & admin & ");"
					'RESPONSE.Write(SQL) & "<BR>"
					Set rs2 = objConn.execute(SQL)
					set rs2 = nothing
				next	
			end if
	
		
			set rs = Server.CreateObject("ADODB.RecordSet")
			strQuery = 	" SELECT A.COD_TIPO_ACESSO, A.DE_ACESSO, B.IC_ADMIN, B.CO_ACESSO AS CADASTRADO "
			strQuery = 	strQuery & " FROM TB_TIPOS_ACESSOS A  "
			strQuery = 	strQuery & " LEFT JOIN ( SELECT * FROM [VW_PERFIS_CADASTRADOS] WHERE CO_PERFIL = " & co_perfil & ") AS B ON A.COD_TIPO_ACESSO = B.CO_ACESSO "
			strQuery = 	strQuery & " ORDER BY A.DE_ACESSO " 	
			rs.Open strQuery, dados_sys
		end if

	end if
%>

<!-- fecha efeito da janela de ajuda -->
		<form action="manutencao_permissao_perfis_tabela.asp" method="post" target="_self" name="form_lista" id="form_lista" >
            <!--<input type="hidden" name="co_perfil" id="co_perfil" value="<%=co_perfil%>"/> -->
            <input type="hidden" name="f_salvar" id="f_salvar" value=""/>
            <input type="hidden" name="usuario"  value="<%=usuario%>"/>

            <select class='form-select' name="co_perfil" id="co_perfil" style="padding-bottom:3px" onchange="form_lista.submit();" style=" width:395px;max-width:395px;min-width:395px;">
                <option value=''>Selecione Perfil</option>  
                <%
                    set rs_2 = Server.CreateObject("ADODB.RecordSet")
                    strQuery = 		"select * from TB_TIPOS_PERFIS ORDER BY NO_PERFIL ; " 	
                    rs_2.Open strQuery, dados_sys
                    do while not rs_2.eof
            %>
                        <option value='<%=rs_2("co_perfil")%>' <%if cstr(co_perfil) = cstr(rs_2("co_perfil")) then %> selected <%end if%>  ><%=rs_2("no_perfil")%></option>  
            <%
                        rs_2.movenext
                    loop
                    set rs_2 =nothing				
                %>
            </select> 
            <br><br>
<% if co_perfil <> "" then  %>        
<div class="tabela"  >
              <table width="653" border="0" cellspacing="0" cellpadding="0" >
                <tr>
                    <td>M&oacute;dulo</td>
                    <td align="center">Acesso</td>
                    <td align="center">Permiss&atilde;o Administrador</td>
                </tr>
    <%			do while not rs.eof
					if rs("ic_admin") then 
						checked=" checked='checked' " 
						disabled = ""
					else
						checked = ""
						if not isnull(rs("CADASTRADO")) then
							disabled = ""
						else
							disabled = "disabled='disabled'"
						end if
					end if
	 %>
                <tr>
                    <td><input type="hidden" name="co_acesso" id="co_acesso" value="<%=rs("COD_TIPO_ACESSO")%>" /><%=rs("de_acesso")%></td>
                    <td align="center"><input type="checkbox" name="chk_acesso" value="<%=rs("COD_TIPO_ACESSO")%>" <% if not isnull(rs("CADASTRADO")) then %> checked="checked" <%end if%> onclick="return(Salvar());" /></td>
                    <td align="center"><input type="checkbox" name="chk_admin_<%=rs("COD_TIPO_ACESSO")%>" <%=checked%> <%=disabled%>  onclick="return(Salvar());"  /></td>
                </tr>
               <%
                    rs.movenext
               loop%>
              </table>
</div>
		</form>          
<%end if%>
          </p>
          <div id="edicao"></div>
