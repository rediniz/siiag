<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<%
data = request("data")  
opcao = request("opcao") '0  = todos, 1 = não enviados

%>
<!-- #INCLUDE FILE ="../include/Conexao.asp" -->
<!-- #INCLUDE FILE ="../include/funcoes.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Cartões de Aniversário</title>

<link href="../css/ui-lightness/jquery-ui-1.10.3.custom.css" title="ui-theme" rel="stylesheet">
<link rel="stylesheet" href="../abas.css" type="text/css"/>
<link href="../botao_azul.css" rel="stylesheet" type="text/css" />
<link href="../tabela.css" rel="stylesheet" type="text/css" />
<link href="../menu.css" rel="stylesheet" type="text/css" />
<link href="../form.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="../imagens/siiag-logo.ico" type="image/x-icon">

<script src="../scripts/jquery-1.9.1.js"></script>
<script src="../scripts/jquery.mousewheel.js"></script>
<script src="../scripts/globalize.js"></script>
<script src="../scripts/globalize.culture.de-DE.js"></script>
<script src="../scripts/jquery.ui.core.js"></script>
<script src="../scripts/jquery.ui.widget.js"></script>
<script src="../scripts/jquery.ui.button.js"></script>
<script src="../scripts/jquery.ui.spinner.js"></script>
<script src="../scripts/jquery.ui.datepicker.js"></script>
<script src="../scripts/globalize.culture.de-DE.js"></script>
<script src="../scripts/jquery.ui.timepicker.js"></script>
<script src="../scripts/jquery.ui.mask.js"></script>
<script src="../scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<style>
.ui-datepicker {
	font-size:12px;
}

.restaurar:hover{

	color:#009933;

}
</style>
<script>
	function enviarAgenda(){
		
		var confirmacao  = window.confirm("Deseja enviar a Agenda?");
		var remetente 	 = $("#matricula").val();
		var destinatario = $("#destinatarios").val();
		
		if(confirmacao){
			alert('enviando');
			enviar_mensagem(remetente,destinatario);
			//window.location.assign("apoio/enviar_email.asp?texto="+texto);
		} else {
			alert('não enviou');
			return false;		
		}	

	}		
		
	$(document).on("click", "#pesquisar_aniversariantes", function(){
	
		var data  = $("#data").val();
		var opcao = $("#opcao").val();
		
		window.location.assign("cartoes_aniversario.asp?data="+data+"&opcao="+opcao);
	
	});
	
	$(document).on("click", "#enviar_cartao", function(){
	
		var contador = 0;
		$(".aniversariante").each(function(){		
			contador++;		
		});
		
		if(contador == 0){		
			alert("Lista de aniversariantes vazia.");
			return false;			
		}
		
		var data 		= $("#data").val();
		var todos 		= $("#todos").val();
		var informacoes = "";
		
		$("#destinatarios").val("");
		$(".aniversariante").each(function(){	
		
			var nome 			 = $(this).find("#nome").text();
			var matricula 		 = $(this).find("#mat").val();
			var data_aniversario = $(this).find("#data_aniversario").text();
			var envio = $(this).find("#envio").text();
			
			if(envio == "Cartão de aniversário enviado"){
			
				alert("Existem cartões já enviados, deseja enviar mesmo assim?");
			
			}

			informacoes = informacoes + nome + "::" +  matricula + "::" + data_aniversario + ";"
							
		});
		
		$("#destinatarios").val(informacoes);
		
		window.location.assign("cartoes_aniversario.asp?data="+data+"&todos="+todos+"&enviar=sim&destinatarios="+informacoes);
	
	});
	
	$(document).on("click", ".X", function(){
	
		$(this).parent().parent().hide();
		$(this).parent().parent().attr("class", "");
	
	});
	
	$(document).on("click", ".restaurar", function(){
	
		$(".X").parent().parent().show();
		$(".X").parent().parent().attr("class", "aniversariante");
	
	});
	
	$(document).ready(function(){	
		$(function() {
			$( ".datepicker" ).datepicker({
				dateFormat: 	'dd/mm/yy',
				dayNames: 		['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado'],
				dayNamesMin: 	['D','S','T','Q','Q','S','S','D'],
				dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
				monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
				monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
				nextText: 'Próximo',
				prevText: 'Anterior'
			});
		});  
	});
</script>

<script>
$(document).ready(function() {

	$('#data').on('change',function(){
	
		//alert("certo");

		//$('#cartoesDeAniversarios').attr('src','apoio/cartoes_aniversario.asp?data=' + $("#dataCartao").val()+'&opcao=' + $("#opcaoCartao").val());
			
		window.location.assign("cartoes_aniversario.asp?data="+$('#data').val()+"&opcao="+ $("#opcao").val()+"");
		//alert($('#data').val());
	});
});
</script>  

 <script>
$(document).ready(function() {

	$('#opcao').on('change',function(){

		//alert("certo");

		//$('#cartoesDeAniversarios').attr('src','apoio/cartoes_aniversario.asp?data=' + $("#dataCartao").val()+'&opcao=' + $("#opcaoCartao").val());
		window.location.assign("cartoes_aniversario.asp?data="+$('#data').val()+"&opcao="+ $("#opcao").val()+"");
		
		//alert($('#opcao').val());

		
	});
});
</script>  



<%
	function enviarCartao(destinatarios)
	
		if left(destinatarios, 1) = ";" then
			destinatarios = right(destinatarios, len(destinatarios)-1)
		end if

		lista 	   = split (destinatarios, ";")				
		data_atual = Formatar_Dia(day(date())) & "/" & Formatar_Mes(month(date())) & "/" & year(date())
	

		%>
		<script language="VBScript" type="text/vbscript">
			on error resume next

			titulo =  "Feliz Aniversário"
			texto  = "<table>" & _
					 "	<tr>" & _
					 "		<td style=""position:relative"">" & _
					 "			<div style=""position:absolute; width:360px; text-align:center; " & _
					 "			font-family:'Trebuchet MS', Verdana, Arial; font-size:16px; " & _
					 "			font-weight:bold; color:#005b90;top:35px; left:60px;""> " & _
					 "				@@@" & _ 
					 "			</div>" & _
					 "			<img src=""***"" />" & _
					 "		</td>" & _
					 "	</tr>" & _
					 "</table>"		
			
			Set OutApl = CreateObject("Outlook.Application")
			Set OutSes = OutApl.GetNameSpace("MAPI")
			OutSes.Logon "","", False, False
			
			<%
			randomize			
			
			set fso = server.CreateObject("Scripting.FileSystemObject")
			set pasta = fso.getfolder("\\ce7180nt005\CaixaNet\Intranet\BibliotecaGIFUG\imagens\cartao")
			
		
			set arquivos = pasta.files
			
			for each f in arquivos
				if instr(1,f.name,"jpg") then total = total + 1
			next	
					
			for i = 0 to ubound(lista)-1

				info 			= split(lista(i), "::")
				nome 			= info(0)
				matricula 	  	= info(1)	
				data_nascimento = info(2)
				
				nome_completo  = split(nome)
				nome_abreviado = nome_completo(0) & " " & nome_completo(1)
				
				if len(nome_completo(1)) < 4 then
				
					nome_abreviado = nome_abreviado & " " & nome_completo(2)
				
				end if
				
				indice = cint(rnd*total)
				z = 0		
					
				for each f in arquivos
					'if instr(1,f.name,"jpg") then
					if instr(1,f.name,"jpg") then
						cartao = f.name
						if indice = z then 
							exit for
						end if
						z = z+ 1
					end if
				next										
			%>
				err.clear
				
				Set OutMsg 		= OutApl.CreateItem(olMailItem)
				OutMsg.Attachments.Add "\\ce7180nt005\CaixaNet\Intranet\BibliotecaGIFUG\imagens\cartao\<%=cartao%>", 1, 0, cartao
				OutMsg.Subject  = titulo
				OutMsg.HtmlBody = replace(replace(texto, "@@@", "<%= nome_abreviado %>"), "***", "<%=cartao%>")
				OutMsg.Recipients.Add  "<%=matricula%>"
				
				OutMsg.Send
				//OutMsg.Display
				
				if err.number <> 0 then 
					msgbox "Erro no envio do cartão: " & vbnewline & "DE: <%= de %>" & vbnewline & "<%= data %>  Nome: <%= nome %> Matrícula: <%=matricula%> " & vbnewline & err.description & vbnewline & vbnewline & "Continuando envio de cartões."
					erro = erro + 1
				else
					sucesso = sucesso + 1
				End if
				
				Set OutMsg = Nothing
				
				
			<%
			ipMaquina = Request.ServerVariables("REMOTE_ADDR")
			
			 
            set objConn = 	server.CreateObject("ADODB.Connection") 
			dados_sys = 	"Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
			objConn.open dados_sys
			
			dia_fds = day(data_nascimento)
			mes_fds = month(data_nascimento)
			ano_fds = year(data_atual)		
			
		    data_fds = Formatar_Dia(dia_fds) & "/" & Formatar_Mes(mes_fds) & "/" & ano_fds		
			
			if data_atual <> data_fds then
			
				query = "USE GIFUG " & _
               		"INSERT INTO TB_LOG (CO_MATRICULA, DT_DATA, DE_TEXTO, CO_TIPO, NO_MAQUINA, CO_SISTEMA) " & _
                	"VALUES ('" & matricula & "', convert(datetime, '" & data_fds & "', 103), " & _
                	"'Cartão de aniversário enviado em " & data_atual & " por " & request.Cookies("co_usuario_siiag") & "', " & _
                	"11, '" & ipMaquina & "', 63)"
			
			else
			
				query = "USE GIFUG " & _
               		"INSERT INTO TB_LOG (CO_MATRICULA, DT_DATA, DE_TEXTO, CO_TIPO, NO_MAQUINA, CO_SISTEMA) " & _
                	"VALUES ('" & matricula & "', convert(datetime, '" & data_atual & "', 103), " & _
                	"'Cartão de aniversário enviado em " & data_atual & " por " & request.Cookies("co_usuario_siiag") & "', " & _
                	"11, '" & ipMaquina & "', 63)"
					
			end if

			'Response.Write query
			objConn.execute(query)
			
			next
			

			%>
				
			Set OutApl = Nothing
					
			msgbox "Cartões enviados: " & sucesso & " sucesso(s) / " & erro & " erro(s)"
			window.location.assign("cartoes_aniversario.asp")	//?data="&data&"
			
		</script>
    	<%
    end function
   
    enviar = request("enviar")
   
	if enviar = "sim" then
		destinatarios = request("destinatarios")
		enviarCartao destinatarios	
	end if
   
   %>
</head>
    <body>
        <div align="center">
            <table>
                <tr>
                    <td>
                        <label class="form">Data:</label>
                    </td>
                    <td>
                        <input  name="data" id="data" class="datepicker form-field" type="text" size="12" maxlength="10" <%if data <> "" Then Response.Write "value='"&data&"'" ELSE RESPONSE.Write "value='"&date()&"'" END IF%>/>
                    </td>
                    <td>
                        <select id = "opcao" name = "opcao" class="form-select">
                            <option value='0' <%if opcao = 0 Then Response.Write "selected='selected'"END IF%>>Todos os aniversariantes</option>
                            <option value='1' <%if opcao = 1 Then Response.Write "selected='selected'"END IF%>>Apenas os não enviados</option>
                        </select>
                    </td>
                    <!--<td>
                    	<!--<button id="pesquisar_aniversariantes" name="pesquisar_aniversariantes" class="myButton" >Pesquisar</button>
                    </td>-->
                </tr>
            </table>
            <br />
            
            <div class="tabela">
                <table>
                    <tr>
                        <td>	</td>
                        <td>Nome</td>
                        <td>Unidade</td>
                        <td>Data de Nascimento</td>
                        <td>Envio</td>
                    </tr>
                    
                    <%       
						data = request("data")  
						opcao = request("opcao") '0  = todos, 1 = não enviados
										                                  
                        if data <> "" then
                        
							ano = year(data)
                            mes = Formatar_Mes(month(data))
                            dia = Formatar_Dia(day(data))
                        
                        else
                             
							ano = year(date())               
                            mes = Formatar_Mes(month(date()))
                            dia = Formatar_Dia(day(date()))
                        
                        end if
                        
                        dados 	= "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=SIIAG;User Id=todos;Password=todosce;"
						
                        set rs	= Server.CreateObject("ADODB.Recordset")

						'query	= "SELECT * FROM usuariosPV.dbo.TB_USUARIOS WHERE month(DT_NASCIMENTO) = '" & mes & "' AND DAY(DT_NASCIMENTO) = '" & dia & "' ORDER BY NO_NOME"
						query = "" & _ 
								"select * from ( " & _
								"( " & _
								"select " & _ 
									"'C'+ left(usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.no_matricula,6) COLLATE Latin1_General_CI_AS as T1, " & _
									"usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.nome COLLATE Latin1_General_CI_AS as T2, " & _
									"usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.co_pv as I1, " & _
									"convert(datetime, " & _
									"right('0'+cast(datepart(dd,convert(datetime,usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.dt_nascimento,103)) as varchar),2)+'/'+ " & _
									"right('0'+cast(datepart(mm,convert(datetime,usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.dt_nascimento,103)) as varchar),2)+'/'+ " & _
									"right('0'+cast(datepart(year,convert(datetime,usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.dt_nascimento,103)) as varchar),4) " & _
									",103) as DT1, " & _
									"cast(gifug.dbo.tb_log.de_texto as varchar) as T3 " & _
								"from " & _ 
									"usuariosPv.dbo.VW_USUARIOS_PV_GIFUG, " & _
									"gifug.dbo.tb_log " & _
								"where " & _ 
									"gifug.dbo.tb_log.co_matricula COLLATE Latin1_General_CI_AS =* 'C' + left(usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.no_matricula ,6) COLLATE Latin1_General_CI_AS and " & _
									"day(convert(datetime, usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.dt_nascimento, 103)) = " & dia & " and " & _
									"month(convert(datetime, usuariosPv.dbo.VW_USUARIOS_PV_GIFUG.dt_nascimento, 103)) = " & mes & " and " & _
									"day(gifug.dbo.tb_log.dt_data) = " & dia & " and " & _
									"month(gifug.dbo.tb_log.dt_data) = " & mes & " and " & _
									"year(gifug.dbo.tb_log.dt_data) = " & ano & " and " & _
									"gifug.dbo.tb_log.co_tipo = 11 " & _
								") union ( " & _ 
								"select " & _ 
									"siiag_web.dbo.tb_usuarios.co_matricula COLLATE Latin1_General_CI_AS, " & _
									"upper(no_nome) COLLATE Latin1_General_CI_AS as no_nome, " & _
									"siiag_web.dbo.tb_gs.co_unidade, " & _
									"convert(datetime," & _
									"right('0'+cast(datepart(dd,dt_nascimento) as varchar),2)+'/'+ " & _
									"right('0'+cast(datepart(mm,dt_nascimento) as varchar),2)+'/'+ " & _
									"right('0'+cast(datepart(year,dt_nascimento) as varchar),4),103), " & _
									"cast(gifug.dbo.tb_log.de_texto as varchar) as de_texto " & _
								"from " & _ 
									"siiag_web.dbo.tb_usuarios, " & _
									"siiag_web.dbo.tb_gs, "  &_
									"gifug.dbo.tb_log " & _
								"where " & _ 
									" gifug.dbo.tb_log.co_matricula =* siiag_web.dbo.tb_usuarios.co_matricula and " &_
									"siiag_web.dbo.tb_gs.co_gs = siiag_web.dbo.tb_usuarios.co_gs and " & _
									"day(siiag_web.dbo.tb_usuarios.dt_nascimento) = " & dia & " and " & _
									"month(siiag_web.dbo.tb_usuarios.dt_nascimento) = " & mes & " and " & _
									"day(gifug.dbo.tb_log.dt_data) = " & dia & " and " & _
									"month(gifug.dbo.tb_log.dt_data) = " & mes & " and " & _
									"year(gifug.dbo.tb_log.dt_data) = " & ano & " and " & _
									"gifug.dbo.tb_log.co_tipo = 11 and siiag_web.dbo.tb_usuarios.ic_ativo = 1 and siiag_web.dbo.tb_usuarios.co_unidade = 7180 " & _
								")" & _
								") tab1  where tab1.T1 <> 'C024251' and " & " tab1.T1 <> 'C001913' " 
				
				if opcao = 1 then
				
					query = query & " and tab1.t3 is null" 
				
				end if
				    
					query = query & " order by T2"
					
                        rs.open query, dados
						'response.write query
                        
                        do until rs.eof
                        
                            nome 	  = rs("T2")
                            unidade   = rs("I1")
                            data	  = rs("DT1")
							matricula = rs("T1")
							envio	  = rs("T3")
                            
                            %>
                            <tr class = "aniversariante">
                                <td><img class="X" src="../imagens/delete_16x16.png"  style="cursor:pointer" title="Remover"/></td>
                                <td id="nome"><%=nome%><input type="hidden" id="mat" name="mat" value="<%=matricula%>"/></td>
                                <td id="unidade"><%=unidade%></td>
                                <td id="data_aniversario"><%=data%></td>
                                <td id="enviado"><%=envio%></td>     						
                            </tr> 
                            <%
                            rs.movenext				
                        loop			
                    %>
                </table>
                
                <input type="hidden" id="destinatarios" name="destinatarios"  />
            </div> 
            <br />
            <div align="left"><span class="restaurar" style="cursor:pointer; font-size:12px; margin-left:10px; padding-top:20px"><img src="../imagens/refresh_16x16.png"/> Restaurar Removidos</span></div>  
            <button id="enviar_cartao" name="enviar_cartao" class="myButton">Enviar cartão de aniversário</button>
        </div>       
    </body>
</html>
	
