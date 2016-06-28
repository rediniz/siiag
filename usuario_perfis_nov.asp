<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--CSS -->


<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />

	<style type="text/css">
    body {
    font-family:verdana;
    font-size:15px;
    }
    
    a {color:#333; text-decoration:none}
    a:hover {color:#ccc; text-decoration:none}
    
    #mask {
      position:absolute;
      left:0;
      top:0;
      z-index:9000;
      background-color:#000;
      display:none;
    }
      
    #boxes .window {
      position:absolute;
      left:0;
      top:0;
      width:440px;
      height:200px;
      display:none;
      z-index:9999;
      padding:20px;
    }
    
    #boxes #dialog {
      width:375px; 
      height:203px;
      padding:10px;
      background-color:#ffffff;
    }
    
    #boxes #dialog1 {
      width:375px; 
      height:203px;
    }
    
    #dialog1 .d-header {
      background:url(login-header.png) no-repeat 0 0 transparent; 
      width:375px; 
      height:150px;
    }
    
    #dialog1 .d-header input {
      position:relative;
      top:60px;
      left:100px;
      border:3px solid #cccccc;
      height:22px;
      width:200px;
      font-size:15px;
      padding:5px;
      margin-top:4px;
    }
    
    #dialog1 .d-blank {
      float:left;
      background:url(login-blank.png) no-repeat 0 0 transparent; 
      width:267px; 
      height:53px;
    }
    
    #dialog1 .d-login {
      float:left;
      width:108px; 
      height:53px;
    }
    
    #boxes #dialog2 {
      background:url(notice.png) no-repeat 0 0 transparent; 
      width:326px; 
      height:229px;
      padding:50px 0 20px 25px;
    }
    .close{display:block; text-align:right;}
    
    </style>
    
<script language="javascript">
	function Salvar_jona(){
	
		form_perfil.f_salvar.value = '1';
		form_perfil.submit();
	
	}
	
	
	function Salvar()
	{
	
		form_perfil.f_salvar.value = '1';
		form_perfil.submit();
		
	}
	
	
	function Deletar(codigo)
	{
	
		if (confirm('Você confirma a exclusão deste perfil?'))
		{
			form_perfil.f_codigo_perfil_deletar.value = codigo;
			form_perfil.f_salvar.value = '2';
			form_perfil.submit();
		}
	}
	
</script>

</HEAD>
<BODY>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<% 
'Chama a subrotina para verificar o perfil
Perfil_Acesso("9")
Verifica_Perfil "1"  ' Verifica se o usuário tem o perfil 1 - Admin Sistema e grava o resultado na variavel eh_perfil

if not perfil_acesso_siiag then
	response.Write("O seu perfil não permite o acesso a este módulo")
else

	usuario =  request("usuario")
	'tipo_perfil = request("f_tipo_perfil")
	tipo_perfil = request("rd_perfil")
	if tipo_perfil = "" then tipo_perfil = request("f_codigo_perfil_deletar")

	if  ( perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") ) then

		'****** SALVAR
		'if cStr(request("f_salvar")) = "1" then
		'	set rs = Server.CreateObject("ADODB.RecordSet")
		'	set rs2 = Server.CreateObject("ADODB.RecordSet")
		'	'set rs = objConn.execute("select * from VW_PERFIS where CO_MATRICULA='" & usuario & "' AND CO_PERFIL = " & tipo_perfil & "")
		'	set rs = objConn.execute("select * from VW_PERFIS where CO_MATRICULA='" & usuario & "'")
		'	
		'	if rs.eof then
		'		Set rs2 = objConn.execute("SET NOCOUNT ON; INSERT INTO TB_USUARIOS_PERFIS (CO_MATRICULA, CO_PERFIL) VALUES ('" & usuario & "'," & tipo_perfil & ");")
		'		set rs2 = nothing
		'	else
		'		Set rs2 = objConn.execute("SET NOCOUNT ON; UPDATE TB_USUARIOS_PERFIS SET CO_PERFIL = " & tipo_perfil & " FROM TB_USUARIOS_PERFIS WHERE CO_MATRICULA = '" & usuario & "';")
		'		set rs2 = nothing
		'	end if

		'end if

		if cStr(request("f_salvar")) = "1" then
			set rs = Server.CreateObject("ADODB.RecordSet")
			Set rs = objConn.execute("SET NOCOUNT ON; DELETE TB_USUARIOS_PERFIS where CO_MATRICULA='" & usuario & "';")
			set rs = nothing
			for each item in request("rd_perfil")
				'response.write "item: " & item & "<br>"
				set rs2 = Server.CreateObject("ADODB.RecordSet")
				SQL = "SET NOCOUNT ON; INSERT INTO TB_USUARIOS_PERFIS (CO_MATRICULA, CO_PERFIL) VALUES ('" & usuario & "'," & item & ");"
				'RESPONSE.Write(SQL)
				Set rs2 = objConn.execute(SQL)
				set rs2 = nothing
			next	

		end if
	
		'****** DELETAR
		'if cStr(request("f_salvar")) = "2" then
		'	codigo_contato = REQUEST("f_codigo_contato")
		'	set rs = Server.CreateObject("ADODB.RecordSet")
		'	
		'	Set rs = objConn.execute("DELETE FROM TB_USUARIOS_PERFIS WHERE CO_MATRICULA = '" & usuario & "' AND CO_PERFIL = " & tipo_perfil & "")
		'	
		'	set rs = nothing
		'end if

	end if


%>
        <form name="form_perfil" action="usuario_perfis_nov.asp" method="post" target="_self">
            <input type="hidden" name="f_salvar" id="f_salvar" value=""/>
            <input type="hidden" name="usuario"  value="<%=usuario%>"/>
            <input type="hidden" name="f_codigo_perfil_deletar"  value=""/>    
            <div class="tabela" >
                <table border="0" style="width:250px; height:auto;">
                <tr  >
                <td width="350" style="height:5px;" colspan="2">Perfil</td>
                </td>
                </tr>
<%				                  
				strQuery = "select * from VW_PERFIS where CO_MATRICULA='" & usuario & "' ; " 
				set rs=Server.CreateObject("ADODB.RecordSet")
				rs.Open strQuery, dados_sys 

				co_perfil_usu = ""
				if not rs.eof then
					do while not rs.eof 
						if co_perfil_usu = "" then
							co_perfil_usu = rs("co_perfil")
						else
							co_perfil_usu = co_perfil_usu & "," & rs("co_perfil")
						end if
						response.Write "<tr style='height:15px;' >"	
						response.Write "<td>"
						response.Write	trim(rs("NO_PERFIL"))
						response.Write "</td>"
						response.Write "<td>"
						'response.write Eh_Perfil_Verificado("4")
			            if not(Eh_Perfil_Verificado("1") or Eh_Perfil_Verificado("4") )  then
							'radio_desabilitado = "disabled='disabled'"
							response.write "<font face='wingdings' size='3' color='green'>ü</font>"
						else
		%>
							<input  type="checkbox" id="rd_perfil" name="rd_perfil" checked="checked" value="<%=rs("co_perfil")%>"  onClick="return(Salvar());" style="padding:0px;" />
		<%
						end if
						response.Write "</td>"
						response.Write "</tr>"	
						rs.movenext
					loop
				else
					co_perfil_usu = "0"
				end if
				
				if Eh_Perfil_Verificado("1") or Eh_Perfil_Verificado("4")  then
					strQuery = "SELECT A.*, ISNULL(B.CO_PERFIL,0) AS PERFIL_USUARIO FROM TB_TIPOS_PERFIS A LEFT JOIN (select * from VW_PERFIS where CO_MATRICULA='" & usuario & "') AS B ON A.CO_PERFIL = B.CO_PERFIL WHERE A.CO_PERFIL NOT IN (1," & co_perfil_usu & ") ; " 
				'response.write strQuery
				'else
					'strQuery = "SELECT A.*, ISNULL(B.CO_PERFIL,0) AS PERFIL_USUARIO FROM TB_TIPOS_PERFIS A LEFT JOIN (select * from VW_PERFIS where CO_MATRICULA='" & usuario & "') AS B ON A.CO_PERFIL = B.CO_PERFIL WHERE IC_USUARIO = 1 AND A.CO_PERFIL NOT IN (" & co_perfil_usu & ") ; " 

					set rs=Server.CreateObject("ADODB.RecordSet")
					'response.write strQuery
					rs.Open strQuery, dados_sys 
	
					do while not rs.eof
						
						response.Write "<tr >"	
						response.Write "<td>"
						response.Write	trim(rs("NO_PERFIL"))
						response.Write "</td>"
						response.Write "<td>"
						if not(Eh_Perfil_Verificado("1") or Eh_Perfil_Verificado("4") )  then
							'response.write "desabilitado"
							radio_desabilitado = "disabled='disabled'"
						end if
						if  rs("co_perfil") = rs("perfil_usuario") then
							perfil_marcado = "checked='checked'"
						else
							perfil_marcado = ""
						end if
					%>
						<input  type="checkbox" id="rd_perfil" name="rd_perfil"  <%=perfil_marcado%> value="<%=rs("co_perfil")%>"  onClick="return(Salvar());" />
					  <!--  <input  type="radio" id="rd_perfil" name="rd_perfil" <%=radio_desabilitado%> value="<%=rs("co_perfil")%>" onClick="return(Salvar());" /> -->
					<%
						response.Write "</td>"
						response.Write "</tr>"	
					
						rs.movenext
					loop
					
					objConn.close 
					set rs = nothing
					set objConn = nothing
                
				end if
				
                %>
                </table>
            </div>
        </form>
<%

 end if
 
 %>
</BODY>
</html>

<%
Sub ComboTipoPerfil()
%>
    <select name="f_tipo_perfil" id="f_tipo_perfil"  class="form-select" style=" width:220px;max-width:220px;min-width:220px;" tabindex="3">

        <option value="">Selecione o Perfil</option>
            <%
			if eh_perfil  then
	            Query3 ="select * from TB_TIPOS_PERFIS ORDER BY NO_PERFIL" 
			else
	            Query3 ="select * from TB_TIPOS_PERFIS WHERE IC_USUARIO = 1 ORDER BY NO_PERFIL" 
			end if
			
			
            set ds=Server.CreateObject("ADODB.RecordSet")
            ds.Open Query3, dados_sys 
            DO UNTIL ds.eof
                response.write "<option value='"& DS("co_PERFIL")  & "'"
                response.Write ">" & ds("no_PERFIL") & "</option>"							 
                ds.movenext
            LOOP
			set ds = nothing
            %>
    </select>
<%
End Sub
%>