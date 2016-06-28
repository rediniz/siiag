<script language="javascript">
function Checa_Campos() 
{
	with (document.inclusao)
	{
		// Preenchimento ----------------------------------- //
		if ($F('tipo') > 0 && $F('inicio') == "")
		{
			alert("O campo Início é obrigatório");
			document.inclusao.inicio.focus();
			return false;		
		}

		if ($F('tipo') > 0 && $F('fim') == "")
		{
			alert("O campo Fim é obrigatório");
			document.inclusao.fim.focus();
			return false;		
		}			
		
		if (document.inclusao.reuniao.value == "")
		{
			alert("O campo Data Reunião é obrigatório");
			document.inclusao.reuniao.focus();
			return false;		
		}
		
		if (document.inclusao.acao.value == "")
		{
			alert("O campo Ação é obrigatório");
			document.inclusao.acao.focus();
			return false;		
		}
		
		if (document.inclusao.acao.value.length > 750)
		{
			alert("O campo Ação não pode ter mais que 750 caracteres");
			document.inclusao.acao.focus();
			return false;					
		}
		
		if (document.inclusao.resp1.value == "-1")
		{
			alert("O campo Responsável 1 é obrigatório");
			document.inclusao.resp1.focus();
			return false;		
		}						
		
		if ( $F('tipo') == "0" && document.inclusao.prazo.value == "")
		{
			alert("O campo prazo é obrigatório");
			document.inclusao.prazo.focus();
			return false;		
		}			
		// ------------------------------------------------- //								
	}
}	

function Checa_Campos_Upload_Ata() 
{
	with (document.upload)
	{
		// Preenchimento ----------------------------------- //
		if ( !document.upload.tipo[0].checked && !document.upload.tipo[1].checked ) {
			alert ("Selecione o tipo do arquivo!");
			return false;
		}
		if ( document.upload.tipo[0].checked && !document.upload.tipo[1].checked ) {
			if ( document.upload.numero.value == "" ) {
				alert("O campo Número Sequencial é obrigatório para Informativos!");
				return false;
			}
			if ( document.upload.titulo.value == "" ) {
				alert("O campo Título é obrigatório para Informativos!");
				return false;
			}
		}
		
		if (document.upload.data.value == "") {
			alert("Selecione a Data!");
			document.upload.data.focus();
			return false;		
		}
		if (document.upload.arquivo.value == "") {
			alert("O campo Arquivo é obrigatório!");
			document.upload.arquivo.focus();
			return false;		
		}
										
		// ------------------------------------------------- //								
	}
}
	
function num(fld) {
	var i = len =  0;
	var aux = aux2 = '';
	aux = fld.value;
	var strCheck = '0123456789';
	fld.value = '';
	len = aux.length;      
	for ( i = 0; i < len; i++ ) {
		if ( strCheck.indexOf ( aux.charAt(i) )!= -1 ) {
		fld.value += aux.charAt(i).toUpperCase();
		}
		else {
			fld.value += '';
		}
	}
}
function texto(fld) {
	var i = len =  0;
	var aux = aux2 = '';
	aux = fld.value;
	var strCheck = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMáéíóúÁÉÍÓÚâêîôûÂÊÎÔÛãõÃÕàèìòùÀÈÌÒÙÇç (){}[]\/-.,1234567890 ';
	fld.value = '';
	len = aux.length;      
	for ( i = 0; i < len; i++ ) {
		if ( strCheck.indexOf ( aux.charAt(i) )!= -1 ) {
		fld.value += aux.charAt(i).toUpperCase();
		}
		else {
			fld.value += '';
		}
	}
}

function showHide(objeto) {
	var nomeSpan=document.getElementById(objeto);
	if(nomeSpan.style.display=="none"){
		nomeSpan.style.display="";
	}
}

function nShowHide(objeto) {
	var nomeSpan=document.getElementById(objeto);
	if(nomeSpan.style.display==""){
		nomeSpan.style.display="none";
	}
}

	
</script>
<script src="Ouvidoria/calendario.js"></script>
<link href="../estilo.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.observacao {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 8px;
	font-weight: bold;
	color:#FF0000
}	
.asterisco {
	font-family: Arial, Helvetica, sans-serif;
	color: #FF0000
}	
.botaoBranco {
	background:url(imagem/botao_branco.gif);
	font-family:Arial, Helvetica, sans-serif;
	font-size:12px;
	color: #555555;
	border:none;
	font-weight:bold;
	border: solid 1px #bbbbbb;
	height:22px;
	padding:0 10px;
}
-->
</style>

<%
	set conNT001 = server.CreateObject("adodb.connection")
	conNT001.open "Provider=SQLOLEDB.1;Password=todosce;Persist Security Info=True;User ID=todos;Initial Catalog=inf_Gerencia;Data Source=CE7180SR001"
	set conNT005 = server.CreateObject("adodb.connection")
	conNT005.open "Provider=SQLOLEDB.1;Password=todosce;Persist Security Info=True;User ID=todos;Initial Catalog=UsuariosGIFUG;Data Source=CE7180NT005"
%>

<div align="center">
<form name="inclusao" method="post" action="Estrategias/salva_deliberacao.asp" onSubmit="JavaScript:return Checa_Campos()">
  <table width="816" class="pretoMedio" align="center">
	<tr>
	  <td width="44">&nbsp;</td>
      <td  height="31">Tipo
		<select name="tipo" class="pretoMedio"  onchange=";if(this.value != 0){$('tbInicio').style.visibility='visible'; $('tbprazo').style.visibility='hidden'; } else { $('tbInicio').style.visibility='hidden'; $('tbprazo').style.visibility='visible'; }">
            <option value="0" selected>Único</option>
			<option value="1" >Diário</option>
			<option value="2"><b>Semanal</b></option>
			<option value="3"><b>Mensal</b></option>
			<option value="4"><b>Bimestral</b></option>
			<option value="5"><b>Trimestral</b></option>
			<option value="6"><b>Semestral</b></option>
			<option value="7"><b>Anual</b></option>
        </select>
      </td>
		<td width="439" height="36" valign="center">
	  	  <table class="pretoMedio" id="tbInicio" style="visibility:hidden">
		  <tr>
			  <td width="92"> <span class="asterisco">*</span> Início </td>
			  <td width="234"><input name="inicio" id="inicio" type="text" size="8" class="pretoMedio">
          <img width="24" height="24" border="0" title="Escolha a Data" src="imagem/calendario2.gif" onClick="javascript:popdate('document.inclusao.inicio','pop_dt_inicio','150',document.inclusao.inicio.value)"> <span id="pop_dt_inicio" style="position:absolute;margin-top:-100px "></span> &nbsp; <br>
			</td>	
			 <td width="92"> <span class="asterisco">*</span> Fim </td>
			  <td width="234"><input name="fim" id="fim" type="text" size="8" class="pretoMedio">
          <img width="24" height="24" border="0" title="Escolha a Data" src="imagem/calendario2.gif" onClick="javascript:popdate('document.inclusao.fim','pop_dt_fim','150',document.inclusao.fim.value)"> <span id="pop_dt_fim" style="position:absolute;margin-top:-100px "></span> &nbsp; <br>			
			</td>	

			
	  </table>
      </td>
    </tr>
	
    <tr>
	  <td width="44">&nbsp;</td>
      <td width="317" height="31"><span class="asterisco">*</span> Data Reunião
          &nbsp;&nbsp;<input name="reuniao" id="reuniao3" type="text" size="8" class="pretoMedio">
          <img width="24" height="24" border="0" title="Escolha a Data" src="imagem/calendario2.gif" onClick="javascript:popdate('document.inclusao.reuniao','pop_dt_reuniao','150',document.inclusao.reuniao.value)"> <span id="pop_dt_reuniao" style="position:absolute;margin-top:-130px "></span> &nbsp; <br>
      </td>
      <td width="439" height="36" valign="center">
	  	  <table class="pretoMedio">
		  <tr>
			  <td width="92"> <span class="asterisco">*</span> Ação </td>
			  <td width="234"><textarea maxlength="5" name="acao" rows="2" cols="30" class="pretoMedio"></textarea></td>
		  </tr>
		  </table>
      </td>
    </tr>
	
    <tr>
      <td>&nbsp;</td>
	  <td height="31" align="left"><span class="asterisco">*</span> Responsável 1
          <select name="resp1" class="pretoMedio">
            <option value="" selected>--Selecione o Respons&aacute;vel--</option>
			<option value="0"><b>Todas</b></option>
		
			
            <%
						
						set rsResp1 = server.CreateObject("adodb.recordset")
						rsResp1.Open "select cod_gerencia,descricao from [UsuariosGIFUG].[dbo].[TblGerencias] Where ativo = 1",conNT005,1,1
						
						while not RsResp1.eof
					%>
            <option value=<%=RsResp1(0)%>><%=RsResp1(1)%></option>
            <%      rsResp1.movenext 
					   Wend
					   rsResp1.close	
					   set rsResp1 = Nothing
			%>            
        </select></td>
      <td width="439"> &nbsp;&nbsp;&nbsp;&nbsp;Respons&aacute;vel 2
		  &nbsp;		  
          <select name="resp2" class="pretoMedio">
            <option value="" selected >--Selecione o Respons&aacute;vel--</option>
            <%
				set rsResp2 = server.CreateObject("adodb.recordset")
				rsResp2.Open "select cod_gerencia,descricao from [UsuariosGIFUG].[dbo].[TblGerencias]  Where ativo = 1 ",conNT005,1,1
				
				while not RsResp2.eof
			%>
            <option value=<%=RsResp2(0)%>><%=RsResp2(1)%></option>
            <% rsResp2.movenext 
					 Wend
			   rsResp2.close	
			   set rsResp2 = Nothing
			%>
          </select>
      </td>
    </tr>
 
    <tr>
      <td>&nbsp;</td>
	  <td height="31" valign="middle"><div id="tbprazo">
		  <span class="asterisco">*&nbsp;</span> Data Prazo<span id="pop_dt_prazo" style="position:absolute "></span>
		  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name="prazo" type="text" size="8">
		  <img width="24" height="24" border="0" title="Escolha a Data" src="imagem/calendario2.gif" onClick="javascript:popdate('document.inclusao.prazo','pop_dt_prazo','150',document.inclusao.prazo.value)"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		  </div> 		  		
      </td>
	  
	  <td>

		  &nbsp;&nbsp;&nbsp;&nbsp;Data Finalizado
		  <input name="finalizado" id="finalizado3" type="text" size="8" class="pretoMedio">
		  <img width="24" height="24" border="0" title="Escolha a Data" src="imagem/calendario2.gif" onClick="javascript:popdate('document.inclusao.finalizado','pop_dt_finalizado','150',document.inclusao.finalizado.value)"> <span id="pop_dt_finalizado" style="position:absolute "></span> 	  	  	
	  </td>     
    </tr>
    
    <tr>
	  <td>&nbsp;</td>	
      <td>
	  	<span class="observacao">* Campos Obrigatórios</span>
	  </td>
	  <td>
		  <div align="left"><br>
			  <input type="submit" name="submeter" value="Salvar" class="botaoBranco">
		  </div>	  	  
	  </td>
    </tr>
  </table>
</form>

<br />

<%	'verifica se o usuario é do APOIO ou é ADMIN
	set conNT005 = server.CreateObject("adodb.connection")
	conNT005.open "Provider=SQLOLEDB.1;Password=todosce;Persist Security Info=True;User ID=todos;Initial Catalog=UsuariosGIFUG;Data Source=ce7180nt005"
	
	matricula = Session("matricula")
	set rsUsuario = server.CreateObject("adodb.recordset")
	rsUsuario.open "SELECT * FROM [UsuariosGIFUG].[dbo].[TblUsuarios] WHERE Matricula LIKE '" & matricula & "%'",conNT005,1,1
	'response.write  ">>>" & rsUsuario("Cod_gerencia")
	'response.write "SELECT * FROM [UsuariosGIFUG].[dbo].[TblUsuarios] WHERE Matricula LIKE '" & matricula & "%'"
	if ( rsUsuario ("Cod_gerencia") = 6 or left(rsUsuario ("Matricula"),5) = "ADMIN" ) then%>
<table width="95%" border="0" cellpadding="0" cellspacing="0" style="border-bottom: 1 solid #808080;">
<tr><td></td></tr></table>
<br />

<form method="post" name="upload" action="Estrategias/upload_arquivo.asp" onSubmit="JavaScript:return Checa_Campos_Upload_Ata()" enctype="multipart/form-data">
  <table width="816" class="pretoMedio" align="center">
  	<tr>
	  <td align="center" colspan="4">Enviar Arquivos (Informativos \ Atas) para o Servidor</td>
	</tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr>
	  <td width="35">&nbsp;</td>
	  <td width="202" height="" valign="top">Selecione o tipo de arquivo:<br />
	  <a onClick="showHide('consulta');" ><input name="tipo" type="radio" value="informativo" /></a>Informativo <br>
	  <a onClick="nShowHide('consulta');" ><input name="tipo" type="radio" value="ata" /></a>Ata</td>
	  
 	  <td width="" valign="top">
	  <span id="consulta" style="display:none ">
	  Número sequencial do Informativo: &nbsp;
	   <input name="numero" id="numero" type="text" size="5" maxlength="3" onKeyUp="return (num(this))"><br />
	  <span class="observacao">*somente números (máximo de 3 dígitos)</span><br />
	  Título do Informativo: &nbsp;
	   <input name="titulo" id="titulo" type="text" size="49" maxlength="120" onkeyup="return (texto(this))"><br />
	  <span class="observacao">*máximo de 120 caracteres</span>
	  </span>
	  </td>
	</tr>
	<tr><td colspan="4">&nbsp;</td></tr>
    <tr>
	  <td width="35">&nbsp;</td>
	  <td width="202" height="">Data
      <input name="data" id="data" type="text" size="8" maxlength="10">&nbsp;&nbsp;<img width="24" height="24" border="0" title="Escolha a Data" src="imagem/calendario2.gif" onClick="javascript:popdate('document.upload.data','pop_dt_data','150',document.upload.data.value)">
	  <span id="pop_dt_data" style="position:absolute "></span><br />
	  <span class="observacao">*Cuidado com atas com a mesma data</span></td>
	  <!--td width="30">&nbsp;</td-->
      <td height="" valign="center" colspan="2">Arquivo &nbsp;
      <input name="arquivo" id="arquivo" type="file" size="60" class="pretoMedio"><br />
	  <span class="observacao">*apenas arquivos pdf</span></td>
    </tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr>
	  <td colspan="4" align="center">
	  <input type="submit" name="enviar" value="Enviar Arquivo" class="botaoBranco"><br /><br />
	  <span class="pretoMedio">Este processo pode demorar alguns minutos...</span></td>
    </tr>
  </table>
</form>

<br />
<%else%>
<br />
<%end if
conNT005.close
set conNT005 = Nothing
conNT001.close
set conNT001 = Nothing
	
msg = Request.QueryString("msg")

	if msg = "ok" then%>
		<script language="javascript">
			alert('Arquivo enviado com sucesso!');
		</script>
	<%end if%>
	
	<%if msg = "nok" then %>
		<script language="javascript">
			alert('Esse formato de arquivo não é valido. Envie apenas arquivos .pdf');
		</script>
	<%end if%>