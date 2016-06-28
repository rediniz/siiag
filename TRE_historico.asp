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
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>    
<script>
$(function() {
	
		$(document).on("click", ".editar", function(){
			var co_usuario = $("#matricula").val();
			window.open("tre_edicao.asp?co_usuario="+co_usuario,"_blanck","width=500, height=400,top=200, left=500"); 
			//alert("teset");
		});
});
</script>

</HEAD>
<BODY>
<!-- #INCLUDE FILE ="include/conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<% 
	Perfil_Acesso("13")

'Chama a subrotina para verificar o perfil
	co_matricula = request("co_matricula")
	nao_exibir_adiciona_folga = request("nao_exibir_adiciona_folga")
	'response.Write(nao_exibir_adiciona_folga)

	set rs=Server.CreateObject("ADODB.RecordSet")
	strQuery = 	"SELECT (QT_DIAS - QT_DIAS_UTILIZADO) AS QT_DISPONIVEL FROM VW_TRE WHERE co_matricula = '" & co_matricula & "'  " 		
	'response.write strQuery
	rs.Open strQuery, dados_sys 
	if not rs.eof then
		qt_saldo = rs("QT_DISPONIVEL")
	else
		qt_saldo = 0
	end if
	rs.close
	
	strQuery = "execute sp_vw_TRE_historico '" & co_matricula & "'"
	'response.write strQuery
	'response.write strQuery
	rs.Open strQuery, dados_sys 
%>
    <div class="tabela" >
		<input type="hidden" id="matricula" name="matricula" value="<%=co_matricula%>" />
        <table border="0" style="width:330px; height:auto; padding:0px;">
       <%if not rs.eof then%>
        <tr>
            <td colspan="5" align="center"><label>Extrato de Folgas TRE - Saldo: <%=qt_saldo%></label></td>
            <td align="center" style="background:#; width:1px;" id="editar" class="editar">
              <%if cStr(nao_exibir_adiciona_folga) <> "1" and perfil_acesso_admin_siiag then %>
              <img src="imagens\add_16x16.png" title="Incluir folgas do TRE"  style="cursor:pointer"  onClick="linha_salvar.style.display='';" />
              <%end if%>
             </td>
        </tr>
        <tr>
            <td ><label>Data</label></td>
            <td ><label>Matrícula</label></td>
            <td>       
                <label>Quantidade</label>
            </td>
            <td>       
                <label>Saldo</label>
            </td>
            <td colspan="2">       
                <label>Declaração<br> TRE</label>
            </td>
        </tr>   
        <%
		else %>
        <tr>
            <td colspan="5" align="center"><label>Saldo de Folgas TRE: <%=qt_saldo%></label></td>
            <td colspan="1" align="center" style="background:#;width:1px;" id="editar" class="editar">
            <%if cStr(nao_exibir_adiciona_folga) <> "1" and perfil_acesso_admin_siiag then %>
	            <img src="imagens\add_16x16.png" title="Incluir folgas do TRE"  style="cursor:pointer"  onClick="linha_salvar.style.display='';" />
			<%end if%>
            </td>
        </tr>
		<%		
		end if
        do while not rs.eof
            
            response.Write "<tr >"	
            response.Write "<td>"
            response.Write	rs("dt_operacao")
            response.Write "</td>"

			if cint(rs("qt_modificada")) < 0 then
				cor = "color:#FF0000"
				qt_modificada = rs("qt_modificada")
			else
				cor = "color:#000000"
				qt_modificada = "+" & rs("qt_modificada")				
			end if
            response.Write "<td>"
            response.Write	rs("co_usuario_operacao")
            response.Write "</td>"
            response.Write "<td style='" & cor & ";'>"		
            response.Write	qt_modificada
            response.Write "</td>"
            response.Write "<td>"
            response.Write	rs("saldo_estoque")
            response.Write "</td>"
            response.Write "<td style='background:#;' colspan='2'>"
			if not isnull(rs("arquivo")) then
				response.write "<a href=""" & Replace(rs("arquivo"), "/", "\") & """  target=""_blank"" />"& Imagem_extensao(rs("arquivo_EXTENSAO"))&  "</a>"
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

</BODY>
</html>

<%
Function Imagem_extensao(ext)
	Select case UCASE(ext)
	case ".PDF"
		Imagem_extensao = "<img src='imagens/25px-Adobe_PDF_icon.jpg' style='background:#;border:#FFFFFF 0px;'  /> "
	case ".XLS"
		Imagem_extensao = "<img src='imagens/xls.png' style='background:#;border:#FFFFFF 0px;'  /> "
	case ".PPT"
		Imagem_extensao = "<img src='imagens/ppt.png' style='background:#;border:#FFFFFF 0px;'  /> "
	case ".ZIP", ".RAR"
		Imagem_extensao = "<img src='imagens/zip.png' style='background:#;border:#FFFFFF 0px;'  /> "
	case ".DOC", ".DOCX"
		Imagem_extensao = "<img src='imagens/doc.png' style='background:#;border:#FFFFFF 0px;'  /> "
	case else
		Imagem_extensao = "<img src='imagens/doc.gif' style='background:#;border:#FFFFFF 0px;'  /> "
	end select

End Function

%>
