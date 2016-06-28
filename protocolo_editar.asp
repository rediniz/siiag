<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Editar Protocolo</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<!--CSS-->
<link href="scripts/jquery.autocomplete.css" type="text/css" rel="stylesheet"/>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/query.ui.tabs.js"></script>j
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
		
		.inputsBotoes{/*border:#000000 solid 1px;*/}
		
.inputPesquisar{

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

.inputSalvar{
margin-left:25px;
height:15px;
border: 1px solid #b5cce2;
background: #edf4fc;
-webkit-border-radius: 4px;
-moz-border-radius: 4px;
border-radius: 4px;
color: #666;
box-shadow: 0px 1px 1px rgba(255, 255, 255, 0.7), 1px 1px 2px rgba(0, 0, 0, 0.1) inset;
padding:6px;
width:auto
}

.inputSalvar:focus {
	background: #fff;
	color: #000000;
	outline:none;
	padding:6px;
	box-shadow: 0 0 5px #9ecaed;
   

   }
   
.inputPesquisar:focus {
	background: #fff;
	color: #000000;
	outline:none;
	padding:6px;
	box-shadow: 0 0 5px #9ecaed;
   

   }   
-->
    </style>


</head>
<body>
<div class="teste2" >
  <!--fundo azul do meio-->
    <!-- #INCLUDE FILE ="topo.asp" -->
	<!-- #INCLUDE FILE ="include/conexao_protocolo.asp" -->
      <%
		Perfil_Acesso_Cookie("17")   
		if not perfil_acesso_siiag then
			response.Redirect("acesso_negado.asp")
		end if

		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	
		
		if ( sucesso="true" ) then
			
			'response.write("<p style='color:green; font-size: 16px'>Protocolo incluído com sucesso.</p>")
			response.write ("<script language=""javascript""> alert('Alteração realizada com sucesso!'); </script>")
		
		else 
		
			if( sucesso="false" ) then
		
				response.write ("<script language=""javascript""> alert('Erro na inclusão do protocolo.'); </script>")
		
			end if	
				
		end if
		
		%>
 
  <div class="corposite">
    <!--corpo-->
    <div class="container">
      <div class="conteudo2" style="height:550px;">
	 <div class="titulosModulos" ><span >PROTOCOLO</span> </div>
        <div class="usuariodiv">
          <div id='cssmenu'>
            <ul>
              <li><a href='protocolo.asp'><span>Inclus&atilde;o</span></a></li>
              <li><a href='protocolo_consultar.asp'><span>Consulta</span></a></li>
              <li  class='active'><a href='protocolo_editar.asp'><span>Editar AR - Oficio</span></a></li>
              <!--<li><a href='protocolo_relatorio.asp'><span>Relat&oacute;rios</span></a></li>-->
            </ul>
          </div>
          </p>
		   <%
            noficio = Request("noficio")
            anoOficio = request("anoOficio")
			if anoOficio = "" then
				anoOficio = year(date())
			end if
			
            if noficio <> "" Then
            
                'Query4 ="select NU_AR from TB_PROTOCOLO_ARS WHERE NO_PROTOCOLO = '"&noficio&"' AND CO_TIPO = 2 AND AA_PROTOCOLO = '" & request("anoOficio") & "'"
                Query4 ="select A.NO_PROTOCOLO, B.* from TB_PROTOCOLO_ATUAL A LEFT JOIN TB_PROTOCOLO_ARS B ON A.NO_PROTOCOLO = B.NO_PROTOCOLO AND A.AA_PROTOCOLO = B.AA_PROTOCOLO WHERE A.NO_PROTOCOLO = '"&noficio&"' AND A.CO_TIPO = 2 AND A.AA_PROTOCOLO = '" & anoOficio & "'"
                'response.write Query4
                'set objConn = server.CreateObject("ADODB.Connection") 
                'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
                'objConn.open dados_sys
                set ds=Server.CreateObject("ADODB.RecordSet")
                ds.Open Query4, dados_sys 
                'RESPONSE.Write(query4)
				encontrou = true
                if ds.eof Then
					encontrou = false
                else	
                    DO UNTIL ds.eof
                        nuAR =		ds("NU_AR")
                        ds.movenext
                    LOOP
                END IF
                
             END IF	
          %> 
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px;">
          <legend class="style2 style3">Editar Protocolo</legend>
          <form name="f_editar" id="f_editar" action="protocolo_editar_sql.asp" target="_self">

              <p class="paragrafoteste style2"> <span class="style4 style2">
                  <div class="inputsBotoes">
                  <label> N&deg; do Of&iacute;cio: </label>
                  <input class="inputPesquisar" name="nOficio" type="text" id="nOficio" value="<%Response.Write noficio%>" />
                  / <label>Ano:</label> <input class="inputPesquisar" name="anoOficio" type="text" id="anoOficio" value="<%= anoOficio %>" size="2" />
                  <input class="myButton" style="margin-left:10px;height:25px;width:100px;padding:2px;" type="button" value="Pesquisar" onclick="pesquisar()">
          <br/><br/>
			<%
            if not encontrou and noficio <> ""  then
                response.Write "<label><p style='font-family:Arial, Verdana, Helvetica;font-size:15px;'>N&atildeo h&aacute; Protocolo com esse N&uacute;mero.<br> Tente novamente.<p></label>"
            end if
            %>         
          <script type="text/javascript">
      		function pesquisar()
     		 {
        		rec = document.getElementById("nOficio").value;
        		//rec = document.getElementById("nOficio").value.toString().trim();
        		anoOficio = document.getElementById("anoOficio").value;
        		//anoOficio = document.getElementById("anoOficio").value.toString().trim();
        		/*alert(rec);*/
				window.location.assign("protocolo_editar.asp?noficio="+rec+"&anoOficio="+ anoOficio +"");
			/*document.getElementById("receberLink").innerHTML = "<label>N&deg; da AR</label> <input name='nAR' type='text' id='nAR' /><br/><input type='button' value='Salvar' id='addSugestao' onclick='salvar()'>";*/
     		 }
			 
			function salvar(){
			 //alert(document.getElementById("nAR").value);
			 
			 var nAR
			 var nOficio
			 
			 nOficio = document.getElementById("nOficio").value;
			 nAR= document.getElementById("nAR").value;
			 
			 //alert("O numero do Oficio = "+nOficio+" e o numero da AR = "+nAR);
			 
			 
			 }
			 
			 
			 
  		</script>
          
          
          <%
		  
		  numeroficio = Request("numeroficio")
		  numeroAR = Request("nAR")
		
		'if numeroficio <> "" & numeroAR <> "" Then
		
		'Query4 ="UPDATE NU_AR from TB_PROTOCOLO_ARS WHERE NO_PROTOCOLO = '"&numeroAR&"'"
		'set objConn = server.CreateObject("ADODB.Connection") 
		'dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
		'objConn.open dados_sys
		'set ds=Server.CreateObject("ADODB.RecordSet")
		'ds.Open Query4, dados_sys 
	
		'Response.Write "AR Atualizada"	
			
		'END IF	
		%>
		<%if  encontrou then %>
            <!--<div id="receberLink"> -->
            <label>N&deg; da AR:</label>
            <input class="inputSalvar" name="nAR" id="nAR" type="text"  value="<%Response.Write nuAR%>"  />
            <p/>
            <input class="myButton" type="submit"  value="Salvar" onclick="salvar()">
           <!-- </div>  -->
        <%end if%>            
          </form>
	</fieldset>
    </div> <!-- fim div usuariodiv -->
  </div> <!-- fim div conteudo2 -->
</div><!-- fim div container -->
</div><!-- fim div corposite -->
  <!-- #INCLUDE FILE ="rodape.asp" -->
</div><!-- fim div teste -->
<!--teste-->
</body>
</html>
