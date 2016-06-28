<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Edi&ccedil;&atilde;o de Jornada</title>
<!--CSS -->
<link rel="stylesheet" href="estilo.css" type="text/css"/>
<link rel="stylesheet" href="abas.css" type="text/css"/>
<link href="botao_azul.css" rel="stylesheet" type="text/css" />
<link href="tabela.css" rel="stylesheet" type="text/css" />
<link href="menu.css" rel="stylesheet" type="text/css" />
<link href="form.css" rel="stylesheet" type="text/css" />
<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
<!--CSS-->
<script src="scripts/jquery.ui.core.js"></script>
<script src="scripts/jquery.ui.widget.js"></script>
<script src="scripts/jquery-1.9.1.js"></script>
<script src="scripts/jquery.ui.datepicker.js"></script>
<script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

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

.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce;
	font-weight: bold;
	color: #c77405;
}
.ui-widget {
	font-family: Arial,sans-serif;
	font-size: 0.8em;
}
.ui-widget .ui-widget {
	font-size: 0.8em;
}

.ui-menu .ui-menu-item a{
    height:14px;
    font-size:13px;
}

.ui-autocomplete {

height:200px;
overflow-y:scroll;
overflow-x:hidden;
}

body{

background:#FFFFFF;

}

    </style>

    

<script language="javascript">
	function validaCampos()
	{
	
		formProtocolo.submit();
		
	}
</script>


  
<script>
$(document).ready(function() {

	$('#editar').on('click',function(){



			var confirmacao = window.confirm("Confirmar a Edição?");
			
			if (confirmacao ==1){

			//alert("Editado com Sucesso");
			
			var CO_MATRICULA = $("#CO_MATRICULA").val();
			var NO_NOME = $("#NO_NOME").val();
			var CO_SITUACAO = $("#CO_SITUACAO").val();
			var DH_ENTRADA = $("#DH_ENTRADA").val();
			var DH_SAIDA = $("#DH_SAIDA").val();
			var DH_VIGENCIA = $("#DH_VIGENCIA").val();
			var CO_JORNADA = $("#CO_JORNADA").val();
	
			window.location.assign("jornada_editar_con.asp?CO_MATRICULA="+CO_MATRICULA+"&NO_NOME="+NO_NOME+"&CO_SITUACAO="+CO_SITUACAO+"&DH_ENTRADA="+DH_ENTRADA+"&DH_SAIDA="+DH_SAIDA+"&DH_VIGENCIA="+DH_VIGENCIA+"&CO_JORNADA="+CO_JORNADA+"&nome="+nome+"");
			
			}
		});
});
	
</script>  


</head>

<body>
  <!--fundo azul do meio-->

<!--'****** CONEXÃO COM O BANCO DE DADOS -->
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
CO_JORNADA = Request("codigo")
set ds=Server.CreateObject("ADODB.RecordSet")
SQL = "SELECT JORNADA.CO_JORNADA, USUARIOS.NO_NOME, JORNADA.CO_UNIDADE, JORNADA.CO_MATRICULA, JORNADA.DH_ENTRADA, JORNADA.DH_SAIDA, JORNADA.DH_VIGENCIA,JORNADA.CO_SITUACAO FROM TB_JORNADA AS JORNADA INNER JOIN VW_USUARIOS AS USUARIOS ON JORNADA.CO_MATRICULA = USUARIOS.CO_MATRICULA WHERE JORNADA.CO_JORNADA = "&CO_JORNADA&""
'response.write SQL
ds.Open SQL, dados_sys

%>

 <!--corpo-->
          </p>
          <fieldset class="testess" style=" border-color: #FFCC66; border:#FFCC66 1px solid; border-radius:4px; margin-top:-15px; margin-bottom:0px">
      
          <legend class="style2 style3">Edi&ccedil;&atilde;o de Jornada</legend>
         
<span class="style4 style2">
            
            <form ACTION="jornada_editar_con.asp" name="formferias" method="POST">
            
            
			<br/>
            <label>Matr&iacute;cula:</label><input style="border:none;" disabled="disabled" id="CO_MATRICULA" value="<% =ds("CO_MATRICULA")%>"/>
 	
              
              <br/>  
              <br/>
                
                
              <label>Nome: <input style="border:none;" disabled="disabled" id="NO_NOME" value="<% response.write(DS("NO_NOME"))%>"/></label>
            	
                
              <br/>  
              
                
                
                
              <label>Situa&ccedil;&atilde;o:</label>
              
              <select name="CO_SITUACAO" id="CO_SITUACAO" style="margin-right:8px;">
           			<option value="1" <% if DS("CO_SITUACAO")= 1 Then response.Write " selected='selected' " End If%>> Solicitado </option>
                    <option value="2" <% if DS("CO_SITUACAO")= 2 Then response.Write " selected='selected' " End If%>> Confirmado </option>
                    <option value="3" <% if DS("CO_SITUACAO")= 3 Then response.Write " selected='selected' " End If%>> Pendente </option>
                    <option value="5" <% if DS("CO_SITUACAO")= 5 Then response.Write " selected='selected' " End If%>> Gozado </option>
                    <option value="6" <% if DS("CO_SITUACAO")= 6 Then response.Write " selected='selected' " End If%>> N&atilde;o Atendido </option>
                    <option value="7" <% if DS("CO_SITUACAO")= 7 Then response.Write " selected='selected' " End If%>> Cancelado </option>
                    <option value="8" <% if DS("CO_SITUACAO")= 8 Then response.Write " selected='selected' " End If%>> Em Andamento </option>

               </select>
              
             
     
              <label>Entrada: </label>
              
              <input class="form-field" style="margin-top:5px;" name="DH_ENTRADA" id="DH_ENTRADA" size="2" type="text" value="<% response.write(HOUR(DS("DH_ENTRADA")))&":00"%>" />
              
              <br/>
              
          
              <div style="border:#000000 solid 0px;">
              
              
               <label>Sa&iacute;da</label>
   		 		<input class="form-field" style="margin-top:5px;" name="DH_SAIDA" id="DH_SAIDA" size="2" style="width:30px;max-width:30px;" type="text" value="<% response.write(HOUR(DS("DH_SAIDA")))&":00"%>"/>
                
                
              
              <label>Vig&ecirc;ncia</label>
              <input class="form-field" name="DH_VIGENCIA" id="DH_VIGENCIA" size="1" style="max-width:70px;width:70px;margin-top:5px;" type="text" value="<% response.write(DS("DH_VIGENCIA"))%>"/>
              
              
              
              <br/>

    		</div>

    <div id="receberLink"></div>
     
     <div align="center">
     <p/>
    <!-- <input type = "submit" class="myButton" id='salvar' style='margin:16px;' value="Salvar" > -->
    <input type = "button" class="myButton" id='editar'  value="Confirmar Edi&ccedil;&atilde;o"/ >
    
     </div>
<input type="hidden" name="CO_JORNADA" id="CO_JORNADA" value="<% response.write(request("codigo"))%>"/> 
</form>      
    </div>
  </div>
<% objConn.close%>
  <!--fim do corpo-->
</div>

        <%
		'MOSTRA MENSAGEM DE SUCESSO OU ERRO APÓS A INSERÇÃO DO PROTOCOLO
		sucesso = Request("sucesso")	

		
		if ( sucesso="true" ) then
			
			response.write ("<script language=""javascript""> alert('Jornada editado com sucesso.'); </script>")
			response.write ("<script language=""javascript""> window.opener.location.reload(); </script>")
			response.write ("<script language=""javascript""> window.close(); </script>")
		
		else 
		
			if( sucesso="false" ) then
		
				response.write ("<script language=""javascript""> alert('Erro na edição das f&eacute;rias.'); </script>")
		
			end if	
				
		end if
		
		%>
<!--teste-->
</body>
</html>
