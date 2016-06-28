<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Inclus&atilde;o de Protocolo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.5.2.min.js" language="javascript"></script>
<script src="scripts/jquery.autocomplete.js" language="javascript"></script>
<script src="scripts/jquery-1.9.1.js" language="javascript"></script>
<script src="scripts/jquery.ui.core.js"></script>
<link rel="shortcut icon" href="imagens/siiag-logo.ico" type="image/x-icon">
<!--favicon -->
<!--CSS-->
    <style type="text/css">
    <!--
        .style2 {
            font-size: 14
        }
        .style3 {
            color: #5683C4
        }


	.tipoarea{
	/*border:#000000 solid 1px;*/ float:left;
	
	}
	
	.destinoConteudo{
	/*border:#000000 solid 1px;*/
	float:right;
	
	
	}
	
	.responsavelFile{/*border:#000000 solid 1px;*/float:left;margin-top:15px;}
	
	#receberLink{/*border:#000000 solid 1px;*/ float:left;margin-top:15%;}
	
	.arOficio{/*border:#000000 solid 1px;*/}
	
	.arOficio label{margin-left:28%;}
	.arOficio input{margin-left:21%;margin-bottom:10%;}
	
	
-->
    </style>
    
    
<script language="javascript">

    	function ChamarLink()
		
{
	var areaProtocolo = document.getElementById("areaProtocolo").value;
	var tipoProtocolo = document.getElementById("tipoProtocolo").value;
	
	
		
		if (areaProtocolo = 2){
		
		 document.getElementById("receberAROficio").innerHTML = "<div class='arOficio'><br/><label>Adicionar AR ao Of&iacute;cio</label><br/><br/> <input name='teste' id='teste' type='text' size='25' maxlength='100' onchange='salvar();' /></div>";
		
		}
		document.getElementById("receberLink").innerHTML = "<button  id='enviarArquivo' onclick='salvar()' class='myButton 'style='margin:16px;'>ENVIAR</button>";
		
}

 		
          	
			function salvar(){
			
		var areaProtocolo = document.getElementById("areaProtocolo").value;
		var tipoProtocolo = document.getElementById("tipoProtocolo").value;
		var textoDestinoProtocolo = document.formProtocolo.textoDestinoProtocolo.value;
		var conteudoProtocolo = document.formProtocolo.conteudoProtocolo.value;
		var responsavelProtocolo = document.formProtocolo.responsavelProtocolo.value;
		
		var AR = document.formProtocolo.teste.value;
		
		
		
		
		if (areaProtocolo != "" && tipoProtocolo != "" && textoDestinoProtocolo != "" && conteudoProtocolo != "" && responsavelProtocolo != "" && AR != "" ){	
			
			
			
			alert("deu certo, com a area do Protocolo sendo " + areaProtocolo +", e o tipo do protocolo sendo "+tipoProtocolo + ", com o texto : "+textoDestinoProtocolo + ", tendo como responsavel o Sr(a) : " +responsavelProtocolo +", e constando como conteudo "+conteudoProtocolo+ " e AR:"+AR );
			
			}
			
					}
				
</script>
        

</head>

<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo_protocolo.asp" -->
<%
'****** CONEXÃO COM O BANCO DE DADOS
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set ds=Server.CreateObject("ADODB.RecordSet")
			
'******
%>
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li class='active'><a href='protocolo.asp'><span>Inclus&atilde;o</span></a></li>
              <li><a href='protocolo_consultar.asp'><span>Consulta</span></a></li>
              <li><a href='protocolo_editar.asp'><span>Editar</span></a></li>
              <li><a href='protocolo_relatorio.asp'><span>Relat&oacute;rios</span></a></li>
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Inclus&atilde;o de Protocolo</legend>
          <table width="200" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="70" align="right"><span class="tipoarea">Tipo:</span></td>
              <td>
                <select style="margin-left:2px;padding-right:2.5px;" id="tipoProtocolo" name="tipoProtocolo" onchange="ChamarLink();">
                  <option value="nenhum">Selecione o Tipo de Protocolo</option>
                  <%
            Query3 ="select CO_TIPO, DE_TIPO from TB_PROTOCOLO_TIPO" 
            ds.Open Query3, dados_sys 
            DO UNTIL ds.eof
				tipoProtocolo=ds("DE_TIPO")
				codigoTipoProtocolo=ds("CO_TIPO")
				response.write "<option value="& codigoTipoProtocolo &">"&tipoProtocolo&"</option>"							 
	            ds.movenext
            LOOP
			set ds = nothing
            %>
                </select>
              </span></td>
              <td><span class="tipoarea">&Aacute;rea:</span></td>
              <td><p class="tipoarea">&nbsp;</p>
                <p class="tipoarea">&nbsp;</p>
                <p class="tipoarea">
                  <select id="areaProtocolo" style="margin-top:10px;" name="areaProtocolo" onchange="ChamarLink();">
                    <option  value="nenhum">Selecione a &Aacute;rea do Protocolo</option>
                    <%
            
            Query4 ="select CO_AREA,NO_AREA from TB_PROTOCOLO_AREAS" 
            'set objConn = server.CreateObject("ADODB.Connection") 
            'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
            'objConn.open dados_sys
            set ds=Server.CreateObject("ADODB.RecordSet")
            ds.Open Query4, dados_sys 
            DO UNTIL ds.eof
				codigoArea=ds("CO_AREA")
				nomeArea=ds("NO_AREA")
				response.write "<option value="& codigoArea &">"&nomeArea&"</option>"							 
				ds.movenext
            LOOP
            set ds = nothing
            %>
                  </select>
                  </p></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><span class="responsavelFile">Respons&aacute;vel</span></td>
              <td><span class="responsavelFile">
                <input class="form-field" style="margin-left:5px;" name="textoResponsavelProtocolo" id="responsavelProtocolo" size="40" maxlength="300" type="text" onchange="ChamarLink();" />
              </span></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td align="center">&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><span style="text-align:left" class="destinoConteudo">Destino:</span></td>
              <td align="left"><span class="destinoConteudo">
                <input align="left" class="form-field" name="textoDestinoProtocolo" id="destinoProtocolo" type="text" size="25" maxlength="100" onchange="ChamarLink();" />
              </span></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td><span class="destinoConteudo">
                <label>Conte&uacute;do: </label>
              </span></td>
              <td><span class="destinoConteudo">
                <textarea class="form-field" name="conteudoProtocolo" id="conteudoProtocolo" style="max-height:100px;min-height:100px;max-width:300px;min-width:300px;" onchange="ChamarLink();"  ></textarea>
              </span></td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
          </table>
          <p class="paragrafoteste style2"> 
<span class="style4 style2">
            
            <form name="formProtocolo" method="POST" enctype="multipart/form-data">
            
            
            
            <div class="tipoarea"><!--tipoarea -->
            <label></label>
            <div id="receberAROficio" class="recebeArOficio"></div>                        
                        
			
            
            <label ></label>
            </div> 
            <!--fim tipoarea -->
            
            
            <div class="destinoConteudo"> <!-- comeco destinoConteudo -->
            
            <label></label>
            <br/>
            <br/>
            <label></label>
            <br/>
            <br/>
            </div>
            <!--fim tipoarea -->
            
            
            
            
            
            <div class="responsavelFile"> <!-- inicio do responsavelFile -->
            <label>: </label>
            
            <br/>
            <br/>
            <br/>
            <br/>
            
            <input type="file" style="width:272px;margin-left:5px;" id="arquivo" name="arquivo" >
            
            </div><!-- fim do responsavelFile -->
			
            
            <!--<input  name="incluir_material" class="myButton" type="button"  value="Salvar" id="adicionarRecurso" style="padding-right:10px; padding-left:10px; margin:16px; padding-top:1px; padding-bottom:1px;font-size:15px;"/>-->
            
            

    <div id="receberLink"></div>
     
            </span>
            
     </form>      

    </div>
  </div>
<% objConn.close%>
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
