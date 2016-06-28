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
	
		if (form_perfil.f_tipo_perfil.value == '')
		{
			alert('Selecione um Perfil!');
			form_contato.f_tipo_perfil.focus();
			return false;
		}
		
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
	tipo_perfil = request("f_tipo_perfil")
	if tipo_perfil = "" then tipo_perfil = request("f_codigo_perfil_deletar")

	if  ( perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") ) then

		'****** SALVAR
		if cStr(request("f_salvar")) = "1" then
			set rs = Server.CreateObject("ADODB.RecordSet")
			set rs2 = Server.CreateObject("ADODB.RecordSet")
			'set rs = objConn.execute("select * from VW_PERFIS where CO_MATRICULA='" & usuario & "' AND CO_PERFIL = " & tipo_perfil & "")
			set rs = objConn.execute("select * from VW_PERFIS where CO_MATRICULA='" & usuario & "'")
			
			if rs.eof then
				Set rs2 = objConn.execute("SET NOCOUNT ON; INSERT INTO TB_USUARIOS_PERFIS (CO_MATRICULA, CO_PERFIL) VALUES ('" & usuario & "'," & tipo_perfil & ");")
				
				set rs2 = nothing
			end if
		end if
	
		'****** DELETAR
		if cStr(request("f_salvar")) = "2" then
			codigo_contato = REQUEST("f_codigo_contato")
			set rs = Server.CreateObject("ADODB.RecordSet")
			
			Set rs = objConn.execute("DELETE FROM TB_USUARIOS_PERFIS WHERE CO_MATRICULA = '" & usuario & "' AND CO_PERFIL = " & tipo_perfil & "")
			
			set rs = nothing
		end if

	end if

		strQuery = "select * from VW_PERFIS where CO_MATRICULA='" & usuario & "'; " 
		set rs=Server.CreateObject("ADODB.RecordSet")
		'response.write strQuery
		rs.Open strQuery, dados_sys 
%>
        <form name="form_perfil" action="usuario_perfis.asp" method="post" target="_self">
            <input type="hidden" name="f_salvar" id="f_salvar" value=""/>
            <input type="hidden" name="usuario"  value="<%=usuario%>"/>
            <input type="hidden" name="f_codigo_perfil_deletar"  value=""/>    
            <div class="tabela" >
                <table border="0" style="width:400px; height:auto;">
                <tr >
                <td width="350" colspan="1">perfil</td>
                <td width="50">
					<%if perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") then %>
	                    <img src="imagens\add_16x16.png" title="Adiciona um contato" onClick="linha_salvar.style.display='';"/>
                    <%end if%>
                </td>
                </tr>
                <tr style="display:none;"  id="linha_salvar">
                <td width="350"><%ComboTipoPerfil()%></td>
                <td width="50">
                <%if perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") then %>
	                <img src="imagens\save_16x16.png" title="Adiciona um contato" onClick="return(Salvar());" />
                <%end if%>
                </td>
                </tr>    
                <%
                do while not rs.eof
                    
                    response.Write "<tr >"	
                    response.Write "<td>"
                    response.Write	trim(rs("NO_PERFIL"))
                    response.Write "</td>"
                    response.Write "<td>"
		            if perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") then
                %>
                    <img src="imagens\delete_16x16.png" title="Exclui o perfil" onClick=" return(Deletar(<%=rs("CO_PERFIL")%>))"  />
                <%
					end if
                    response.Write "</td>"
                    response.Write "</tr>"	
                
                    rs.movenext
                loop
                
                objConn.close 
                set rs = nothing
                set objConn = nothing
                
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