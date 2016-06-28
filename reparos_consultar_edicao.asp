<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<meta http-equiv="Content-Type" content="text/html; charSet=utf-8" />

<style>

	label {
	font-family: Futura,Arial,Verdana;
	width: 150px;
	padding-right: 5px;
	padding-left: 5px;
	vertical-align:middle;
	color: #666;
	font-size: 15px;
	font-weight: bold;
	}
	.link a{
		color: #00F;
	}
	.link a:hover{
		color: #00F;	
		text-decoration:underline;
	}
		
	.ui-dialog .ui-dialog-title {
	text-align: center;
	width: 100%;
	color: #666;
    }
</style>


<script>


	$(document).ready(function() {
		
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
		//alert(co_reparo);
		$("#salvar").on("click", function(){
			//o erro era aqui!
			var co_reparo= $("#det_co_reparo").val();
			var situacao = $("#det_situacao").val();	
			var dt_ini_atdmt = $("#dt_ini_atdmt").val();
			var dt_prev_conc = $("#dt_prev_conc").val();
			
			//1 #ALTERADO EM 19/04/2016--------------------------
			var observacaoEdicao = $("#observacaoEdicao").val();
				
			window.location.assign("reparos_editar.asp?co_reparo="+co_reparo+"&co_situacao="+situacao+"&dt_ini_atdmt="+dt_ini_atdmt+"&dt_prev_conc="+dt_prev_conc+"&observacaoEdicao="+observacaoEdicao);
			//----------------------------------------------------
		});

	});
</script>

<%
	response.Expires = 0		

	det_co_reparo = request("co_reparo")
	
	consulta_CO_REPARO = "SELECT * FROM TB_REPAROS where co_reparo="&det_co_reparo
	
	Set hs          = Server.CreateObject("ADODB.RecordSet")
	hs.Open consulta_CO_REPARO, dados_sys
	det_descricao       = hs("DE_DESCRICAO")
	det_situacao	    = hs("CO_SITUACAO")
	det_dh_criacao		= hs("DH_CRIACAO")
	
	'#ALTERADO em 04/12/2015 (adicionado)#=====
	dt_ini_atdmt = hs("DT_INI_ATDMT")
	dt_prev_conc = hs("dt_prev_conc")
	'===========================================
	
	'2 #ALTERADO EM 19/04/2016
	observacaoEdicao = hs("obs_edicao")

%>



<table width='auto' height="auto" border="0" cellpadding='0' cellspacing='0' >
	<tr>
    <input type="hidden" id= "det_co_reparo"  name="det_co_reparo" value="<%=det_co_reparo%>"/>
   </tr>
	<tr>
		<td><label>Descrição:</label></td><td><textarea class="form-field" name="descricao" id="descricao" style="width:400px; height:100px"><%=det_descricao%></textarea></td>
	</tr>
    <tr><td>&nbsp;</td></tr>
          <tr>
              	<td><label>Situação</label></td>
          <td width="">
                                    <select class="form-select" style="max-width:150px; min-width:150px;" id="det_situacao" name="det_situacao">
                                    <option value="">Selecione...</option>
                     
                                            <%  
												'#Alterado em 04/12/2015 (usando agora a TB_SITUACOES original)
                                                Query4 ="SELECT * FROM TB_SITUACOES" 
                                                'set objConn = server.CreateObject("ADODB.Connection") 
                                                'dados_sys = "Provider=sqloledb;Data Source=CE7180NT005;Initial Catalog=SIIAG_WEB;User Id=todos;Password=todosce;"
                                                'objConn.open dados_sys
                                                set ds=Server.CreateObject("ADODB.RecordSet")
                                                ds.Open Query4, dados_sys
                                                DO UNTIL ds.eof
                                                    co_situacao=ds("CO_SITUACAO")
                                                    de_situacao=ds("DE_SITUACAO")
																			
                                                    response.write "<option value='" & co_situacao  & "'   "
													if co_situacao = det_situacao then 
													
													   response.write "selected=selected"
													   
													end if 
                                                    response.write " > " & de_situacao & "</option>"							
                                                    ds.movenext
                                                LOOP
                                                set ds = nothing
             
                                            %> 
              
                                        </select>
                                   </td>
     </tr>
      <tr><td>&nbsp;</td></tr>
     <tr>
     <!-- #Alterado em 04/12/2015 (comentado, pois não é mais preciso [apagar depois])
     <td><label>Data Conclusão:</label></td><td><input name="det_data_conclusao" id="det_data_conclusao" class="datepicker" type="text" size="10" maxlength="10" style="max-width:70px; min-width:70px;" value="<%=det_dt_conclusao%>"/></td>-->
     
     </tr>
    <tr>
		<td>&nbsp;</td><td></td>
	</tr>
      <!--#ALTERADO em 04/12/2015 (adicionado)====================#-->
     <%tipo_prazo_demanda = 9%>
     <!-- #INCLUDE FILE ="include_campo_datas.asp" -->
<!-- 3 #ALTERADO em 19/04/2016 ------------------------------------------>
     <tr>
     <td>&nbsp;</td>
     </tr>

     <!-- #INCLUDE FILE ="campo_observacao_edicao.asp" -->
</table>
<br />
<!---------------------------------------------------------------------->
	<div align="center">
		<button id='salvar' class="myButton">Salvar Alterações</button>
	</div>
</div>

