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
	
	iframe { margin:0; padding:0; height:100%; }
	iframe { display:block; width:100%; border:none; }
	
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
<script language="javascript" >

function Salvar()
{

	if (form_contato.f_contato.value == '')
	{
		alert('Preencha um contato!');
		form_contato.f_contato.focus();
		return false;
	}

	if (form_contato.f_tipo_contato.value == '')
	{
		alert('Selecione um tipo de contato!');
		form_contato.f_tipo_contato.focus();
		return false;
	}


	form_contato.f_salvar.value = '1';
	form_contato.submit();


}


function Deletar(codigo)
{

	form_contato.f_codigo_contato.value = codigo;
	form_contato.f_salvar.value = '2';
	form_contato.submit();
}
</script> 
</HEAD>
<BODY>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<% 

'Chama a subrotina para verificar o perfil
Perfil_Acesso("9")

if not perfil_acesso_siiag then
	'response.Write("O seu perfil não permite o acesso a este módulo")
else
	
	usuario =  request("usuario")
	contato = request("f_contato")
	tipo_contato = request("f_tipo_contato")
	'response.Write(contato)
	'response.Write(tipo_contato)
	
	if  (perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") or request.Cookies("co_usuario_siiag") = usuario ) then
	
		'response.Write("com acesso") & "<br>"
	
		if cStr(request("f_salvar")) = "1" then
			
			set rs = Server.CreateObject("ADODB.RecordSet")
			set rs2 = Server.CreateObject("ADODB.RecordSet")
			Set rs2 = objConn.execute("SET NOCOUNT ON; INSERT INTO TB_CONTATOS (CO_TIPO, DE_CONTATO) VALUES (" & tipo_contato & ",'" & contato & "'); SELECT SCOPE_IDENTITY() ID;")
			'response.Write("INSERT INTO TB_USUARIOS_CONTATOS (CO_MATRICULA, CO_CONTATO) VALUES ('" & usuario & "','" & rs2("ID") & "')")
			set rs = objConn.execute("INSERT INTO TB_USUARIOS_CONTATOS (CO_MATRICULA, CO_CONTATO) VALUES ('" & usuario & "','" & rs2("ID") & "')")			
	
		end if
	
	
		if cStr(request("f_salvar")) = "2" then
			
			codigo_contato = REQUEST("f_codigo_contato")
			
			'set rs = Server.CreateObject("ADODB.RecordSet")
			set rs2 = Server.CreateObject("ADODB.RecordSet")
			Set rs2 = objConn.execute("DELETE FROM TB_USUARIOS_CONTATOS WHERE CO_CONTATO = " & codigo_contato & "")
			Set rs2 = objConn.execute("DELETE FROM TB_CONTATOS WHERE CO_CONTATO = " & codigo_contato & "")
	
			'set rs = objConn.execute("INSERT INTO TB_USUARIOS_CONTATOS (CO_MATRICULA, CO_CONTATO) VALUES ('" & usuario & "','" & rs2("ID") & "')")			
	
		end if

		strQuery = "select * from VW_CONTATOS where CO_MATRICULA='" & usuario & "' ORDER BY CO_CONTATO DESC; " 
		set rs=Server.CreateObject("ADODB.RecordSet")
		'response.write strQuery
		rs.Open strQuery, dados_sys 
	%>
         <div class="tabela" >
         <form name="form_contato" action="usuario_contatos.asp" method="post" target="_self">
            <input type="hidden" name="f_salvar" id="f_salvar" value=""/>
            <input type="hidden" name="usuario"  value="<%=usuario%>"/>
            <input type="hidden" name="f_codigo_contato"  value=""/>
            <table border="0" style="width:400px;" >
            <tr >
            <td width="70">contato</td>
            <td width="230">tipo contato</td>
            <td width="50"><img src="imagens\add_16x16.png" title="Adiciona um contato" onClick="linha_salvar.style.display='';"/></td>
            </tr>
            <tr style="display:none;"  id="linha_salvar">
            <td width="70"><input name="f_contato" id="f_contato" class="form-field" style="font-size:12px;" type="text" size="8"></td>
            <td width="230"><%ComboTipoContato()%></td>
            <td width="50"><img src="imagens\save_16x16.png" title="Adiciona um contato" onClick="return(Salvar());" /></td>
            </tr>
        <%
            do while not rs.eof
                
                response.Write "<tr >"	
                response.Write "<td>"
                response.Write	trim(rs("DE_CONTATO"))
                response.Write "</td>"
                response.Write "<td>"
                response.Write	rs("NO_TIPO")
                response.Write "</td>"
                response.Write "<td>"
        %>
                <img src="imagens\delete_16x16.png" title="Apaga o contato" onClick=" return(Deletar(<%=rs("CO_CONTATO")%>))"  />
        <%
                response.Write "</td>"
                response.Write "</tr>"	
            
                rs.movenext
            loop
        
            objConn.close 
            set rs = nothing
            set objConn = nothing
        %>
            </table>
            </form>
        </div>
<%
	else
		'response.Write("sem acesso")
	end if



%>


</BODY>
</html>
<%

end if
Sub ComboTipoContato()
%>
    <select name="f_tipo_contato" id="f_tipo_contato"  class="form-select" style=" width:220px;max-width:220px;min-width:220px;" tabindex="3">

        <option value="">Selecione o Tipo de Contato</option>
            <%
            Query3 ="select * from TB_TIPOS_CONTATOS ORDER BY NO_TIPO" 
            set ds=Server.CreateObject("ADODB.RecordSet")
            ds.Open Query3, dados_sys 
            DO UNTIL ds.eof
                response.write "<option value='"& DS("co_TIPO")  & "'"
                if cstr(cargo)	= cstr(ds("co_TIPO")) then
                    response.Write(" selected ")
                end if 						
                response.Write ">" & ds("no_TIPO") & "</option>"							 
                ds.movenext
            LOOP
			set ds = nothing
            %>
    </select>
<%
End Sub


%>