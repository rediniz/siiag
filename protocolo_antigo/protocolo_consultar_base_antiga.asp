<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Consultar Protocolo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<!--CSS-->



<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<style>
.ui-datepicker {
	font-size:12px;
}
</style>
<script>
    $(function() {
    $( ".datepicker" ).datepicker({
    dateFormat: 'dd/mm/yy',
    dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
    dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
    dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
    monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
    nextText: 'Próximo',
    prevText: 'Anterior'
  });
   });
  </script>
    
    
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

.efeitoArea{
		
			margin-left:8px;
			height:30px;
			border: 1px solid #b5cce2;
			background: #edf4fc;
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
			border-radius: 4px;
			color: #666;
			box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
			padding:6px;
			width:auto;
		
}
		
.efeitoTipo{
			margin-left:8px;
			height:30px;
			border: 1px solid #b5cce2;
			background: #edf4fc;
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
			border-radius: 4px;
			color: #666;
			box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
			padding:6px;
			width:auto;				
}
		
		
.efeitoNumero{
			margin-left:8px;
			height:15px;
			border: 1px solid #b5cce2;
			background: #edf4fc;
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
			border-radius: 4px;
			color: #666;
			box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
			padding:6px;
			width:auto;	
}
		
		
.efeitoNumero:focus {
	background: #fff;
	color: #000000;
	outline:none;
	padding:6px;
	box-shadow: 0 0 5px #9ecaed;
}
		
.datepicker{
			
			height:15px;
			border: 1px solid #b5cce2;
			background: #edf4fc;
			-webkit-border-radius: 4px;
			-moz-border-radius: 4px;
			border-radius: 4px;
			color: #666;
			box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
			padding:6px;
			width:auto;	
}
		
.datepicker:focus {
	background: #fff;
	color: #000000;
	outline:none;
	padding:6px;
	box-shadow: 0 0 5px #9ecaed;
}

.periodoClasse{float:left;/*border: #000000 solid 1px;*/ margin-top:1%;margin-bottom:3%;}
.areatipo{float:left;/*border: #000000 solid 1px;*/margin-top:1%;}
.numeroClasse{/*border:#000000 solid 1px;*/float:left;margin-top:7px;}



-->
    </style>

<script type="text/javascript" language="javascript">
       
	   /*function ChamarLink()
		
{
	var areaProtocolo = document.getElementById("areaProtocolo").value;
	var tipoProtocolo = document.getElementById("tipoProtocolo").value;
		
		
}*/
$(document).ready(function() {
	// Remover linha da tabela
		$('.X').on("click", function(){
			
			var codSeq = $(this).parent().parent().find("#codSeq").val()
			
			var confirma = window.confirm("Tem certeza que deseja excluir o protocolo?")
			
			if(confirma){
				window.location.assign("protocolo_excluir.asp?codSeq="+codSeq+"");
			}else{
				return false;
			}
		
		});
		
				$('.edit').on('click',function(){
								
			var tipoProtocolo = $(this).parent().parent().find("#nomeTipoProtocolo").html()
			var areaProtocolo = $(this).parent().parent().find("#nomeCodigoArea").html()
			var numeroAR = $(this).parent().parent().find("#nuAR").html()
			var destino = $(this).parent().parent().find("#destino").html()
			var conteudo= $(this).parent().parent().find("#conteudo").html()
			var responsavel = $(this).parent().parent().find("#responsavel").html()
			var codSeq = $(this).parent().parent().find("#codSeq").val()

			var top = (window.innerHeight / 4) +80
			var left = (window.innerWidth / 4) -60
			window.open("protocolo_edicao.asp?areaProtocolo="+areaProtocolo+"&tipoProtocolo="+tipoProtocolo+"&destino="+destino+"&conteudo="+conteudo+"&responsavel="+		responsavel+"&numeroAR="+numeroAR+"&codSeq="+codSeq+"", "Teste", "height=340, width=680, scrollbars=no, toolbar=no, resizable=no, location=no, modal=yes, top="+top+", 	left="+left+"");
						
	});
	});

			   
		function FormatarData(campo,e) 
		{
		 if (campo.value=="Data")
		 {
			campo.value="";
		 }
		 var cod="";
		 if(document.all) {cod=event.keyCode;} else {cod=e.which;} 
		 if(cod == 08) return;
		 if (cod < 48 || cod > 57)
		 {
		  if (cod < 45 || cod > 57) alert("Digite somente Caracteres Numéricos!");
		  cod=0;
		  campo.focus(); return false;
		 }
		 tam=campo.value.length; 
		 if(tam > 9) return false;
		 var caract = String.fromCharCode(cod);
		 if(tam == 2 || tam == 5) {campo.value+="/"+caract; return false;};  
		 campo.value+=caract; return false; 
		}
			   
	   
			   
		function ValidarData(variavel)
		{

		 //if (variavel=="") { alert("Favor informar a data."); return false; }
		 if (variavel=="Data") variavel="";
		 if (variavel != "") 
		 { 
			 var Parte=variavel.split("/"); 
			 Ano=Parte[2];
			 Mes=Parte[1];
			 Dia=Parte[0];
			 if (Parte.join("").length != 8 && variavel != "" ) { alert("Digite a Data corretamente."); return false; }
			 if (isNaN(Parte.join(""))) {alert("Data deve ser numérica.");  return false;}
			 if (Ano < 1500) {alert("Verifique o ano."); return false;}
			 Data1 = new Date(Ano,Mes-1,Dia);
			 if (Mes < 1 || Mes > 12) {alert("Mes incorreto, favor retificar."); return false;}
			 if (Dia < 1 || Dia > 31) {alert("Dia incorreto, favor retificar."); return false;}
			 if (Dia > 30 || (Dia > 28 && Mes == 02 )) 
			 {
			  D = Data1.getDate();
			  if (D < Dia)
			  {
			  alert("Data inexistente! Digite novamente.");
			  return false; 
			  }
			 }
			 Hoje = new Date();
			 Ano2 = Hoje.getFullYear();
			 Mes2 = Hoje.getMonth(); 
			 Dia2 = Hoje.getDate(); 
			 if (Mes2 < 10) { Mes2= "0" + Mes2 }
			 if (Dia2 < 10) { Dia2= "0" + Dia2 }
			
			 var Hoje="";
			 var Data = "";
			 Hoje =  Ano2 + "" + Mes2 + "" + Dia2;
			 Data = Ano + "" + Mes + "" + Dia;
			
			 if (Data < Hoje) {alert("Data informada é inferior à data de Hoje! Informe outra data."); return false;}
		  }
			 return true;
		}
	   
	   
	   function pesquisar(){
	   
	   var tipoProtocolo = document.getElementById("tipoProtocolo").value;

	   var areaProtocolo = document.getElementById("areaProtocolo").value;
	   
	   /*var diaInicial = document.getElementById("diaInicial").value;
	   var diaFinal = document.getElementById("diaFinal").value;
	   var mesInicial = document.getElementById("mesInicial").value;
	   var mesFinal = document.getElementById("mesFinal").value;*/
	   
	   var dataInicial=document.getElementById("dataInicial").value
	   var dataFinal=document.getElementById("dataFinal").value
	   var numeroOficio = document.getElementById("numeroOficio").value;
   	   var responsavel_matricula = document.getElementById("f_responsavel_matricula").value;
	   
	   
	   if (tipoProtocolo == "" && areaProtocolo == "" && dataInicial == "" && dataFinal == "" && numeroOficio == "" && responsavel_matricula == ""){
	   
	   
	   
	   alert("Preencha pelo menos um dos campos");
	   
//	   window.location.assign("protocolo_consultar.asp?todos=1");
	   
	   
	   }
	   else{
	   
	   
	   window.location.assign("protocolo_consultar.asp?tipoProtocolo="+tipoProtocolo+"&areaProtocolo="+areaProtocolo+"&dataInicial="+dataInicial+"&dataFinal="+dataFinal+"&numeroOficio="+numeroOficio+"&f_responsavel_matricula="+responsavel_matricula+"");
	   
	   
	   }
	   
	  //alert("deu certo");
	   
	   
	   
	   }   
	   
	              
			
			
</script>



</head>
<body>
<div class="teste">
  <!--fundo azul do meio-->
  <!-- #INCLUDE FILE ="topo_protocolo.asp" -->
 
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2">
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='protocolo.asp'><span>Inclus&atilde;o</span></a></li>
              <li  class='active'><a href='protocolo_consultar.asp'><span>Consulta</span></a></li>
              <li><a href='protocolo_editar.asp'><span>Editar AR - Ofício</span></a></li>
<!--              <li><a href='protocolo_relatorio.asp'><span>Relat&oacute;rios</span></a></li> -->
            </ul>
          </div>
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Consulta de Protocolos</legend>

          
        
        <table border="0" align="left">
        <tr>
        	<td>
	             <label>N&uacute;mero:</label>
            </td>
			<td align="left" colspan="2">
		         <input name="numeroOficio" class="efeitoNumero" id="numeroOficio" type="text" style=" width:220px;max-width:220px;min-width:182px;" size="35" maxlength="1000" onchange="ChamarLink()" value="<%=request("numeroOficio")%>"/> 
            </td>
        </tr>
        <tr>
        	<td>
		         <label>Tipo: </label>
            </td>
			<td align="left" colspan="2">
          		<select id="tipoProtocolo" class="efeitoTipo" style=" width:235px;max-width:235px;min-width:235px;" name="tipoProtocolo"  onchange="ChamarLink();">
            
                    <option value="">Selecione o Tipo de Protocolo</option>
						<%
                        Query3 ="select CO_TIPO, DE_TIPO from TB_PROTOCOLO_TIPO ORDER BY DE_TIPO ASC" 
                        set objConn = server.CreateObject("ADODB.Connection") 
                        dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                        objConn.open dados_sys
                        set ds=Server.CreateObject("ADODB.RecordSet")
                        ds.Open Query3, dados_sys 
						DO UNTIL ds.eof
							tipoProtocolo=ds("DE_TIPO")
							codigoTipoProtocolo=ds("CO_TIPO")
							response.write "<option value='"& codigoTipoProtocolo  & "'"
							if cstr(request("tipoProtocolo"))	= cstr(codigoTipoProtocolo) then
								response.Write(" selected ")
							end if 						
							response.Write ">" & tipoProtocolo & "</option>"							 
							ds.movenext
						LOOP
                        %>
				</select>
             </td>
        </tr>
      <tr>
        	<td>
	          <label>&Aacute;rea:</label>
            </td>
			<td align="left" colspan="2">
         		<select id="areaProtocolo" class="efeitoArea" style="width:235px;max-width:235px;min-width:235px;height:30px;" name="areaProtocolo" onchange="ChamarLink();">
            
            		<option value="">Selecione a &Aacute;rea do Protocolo</option>
							<%
							Query4 ="select CO_AREA,NO_AREA from TB_PROTOCOLO_AREAS ORDER BY NO_AREA ASC" 
							set objConn = server.CreateObject("ADODB.Connection") 
							dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
							objConn.open dados_sys
							set ds=Server.CreateObject("ADODB.RecordSet")
							ds.Open Query4, dados_sys 
							areaProtocolo = request("areaProtocolo")
							if areaProtocolo = "" then areaProtocolo = 0 else areaProtocolo = cInt(areaProtocolo) end if
							DO UNTIL ds.eof
								codigoArea=ds("CO_AREA")
								nomeArea=ds("NO_AREA")
								'response.write "<option value="& codigoArea &">"&nomeArea&"</option>"							 
								response.write "<option value='" & codigoArea  & "'"
								if cint(areaProtocolo)	= cint(codigoArea) then
									response.Write(" selected ")
								end if 						
								response.Write ">" & nomeArea & "</option>"							 

								ds.movenext
							LOOP
							set ds = nothing
                                         
                                                                                 
                            %>
							 
						</select>
             </td>

        </tr>
    <tr>
        	<td>
	          <label>Matr&iacute;cula Respons&aacute;vel:</label>
            </td>
			<td align="left" colspan="2">
                <input name="f_responsavel_matricula"  id="f_responsavel_matricula" class="efeitoNumero" type="text" style=" width:220px;max-width:220px;min-width:182px;" size="35" maxlength="1000" onchange="ChamarLink()" value="<%=request("f_responsavel_matricula")%>"/> 
             </td>
        </tr>
	    <tr>
            <td width="165" valign="top"><label>Per&iacute;odo:</label> 	
          </td>
            <td width="110">
              <label>de:</label><br>
              <input type="text" id="dataInicial" class="datepicker" onchange="ChamarLink();" value="<%=request("dataInicial")%>" size="11" style="margin:6px;" OnKeyPress="return(FormatarData(this,event))"  onblur="return(ValidarData(this.value))"> 
          </td>
          <td width="121" align="left">
            <label>at&eacute;:</label><br>
            <input type="text" id="dataFinal" class="datepicker" onchange="ChamarLink();" value="<%=request("dataFinal")%>" size="11" style="margin:5px;" OnKeyPress="return(FormatarData(this,event))" onblur="return(ValidarData(this.value))"> 
          </td>

		</tr>
        <tr>
          <td  valign="bottom" align="center">
          </td>
	        <td  valign="bottom" align="center" colspan="2">
        		<input value="Pesquisar" class="myButton" style="margin-top:2px;" type="button" onclick="pesquisar()" />
          </td>
        </tr>		  

        </table>

        <br>

 

          
    </div>
	    <br><br>
    
    
    
     <div class="tabela" style="margin-left:0.8%;" >
          <!--<table>
            <tr>
              <td width="1%">N&uacute;mero</td>
              <td width="5%" >Tipo</td>
              <td width="7%">&Aacute;rea</td>
              <td width="7%">Data</td>
              <td width="10%">Respons&aacute;vel</td>
              <td width="15%">Conte&uacute;do</td>
              <td width="12%">Destino</td>
              
            </tr>-->
    
 	 <!-- #INCLUDE FILE ="consultas_protocolo.asp" -->
    
    <!--</table>-->
    </div>
  
  </div>
  
  <!--fim do corpo-->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div>
<!--teste-->
</body>
</html>
