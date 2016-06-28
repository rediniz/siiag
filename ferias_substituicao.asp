<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<%
	Response.Expires = -1
	Response.ExpiresAbsolute = Now() - 1
	Response.AddHeader "pragma","no-cache"
	Response.AddHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	acao = request("acao")
	
	select case acao
	
		case "checarCoordenador"
			checarCoordenador()
		case "carregarSubstituicao"
			carregarSubstituicao()
		case else

	end select

	sub checarCoordenador()
	
		matriculaFerias = request("matriculaFerias")
		queryChecaPerfil = "SELECT CO_CARGO FROM VW_USUARIOS WHERE CO_MATRICULA = '"&matriculaFerias&"'"
		set rs = Server.CreateObject("ADODB.RecordSet")
		rs.Open queryChecaPerfil, dados_sys
		coordenador = "não"
		
		if not rs.eof then
			if rs("CO_CARGO") = 1 or rs ("CO_CARGO") = 2 then
					coordenador = "sim"
			end if
		end if
		
		response.write coordenador
	
	end sub
	
	sub carregarSubstituicao()
		
		matriculaFerias = request("matriculaFerias")
		nomeFerias = request("nomeFerias")
		dataInicioFerias = request("dataInicioFerias")
		diasDeGozo = cint(request("diasDeGozo"))
		dataFimFerias = DateAdd("d",diasDeGozo-1,dataInicioFerias)
%>
        <form id="form_substituicao">
          <table>
            <tr>
              <td><label>Empregado a ser substituído:</label></td>
              <td><select name="empregado" id="empregado" class="form-select">
                  <option value="<%=matriculaFerias%>"><%=nomeFerias%></option>
                </select></td>
            </tr>
            <tr>
              <td><label>Empregado substituto:</label></td>
              <td><select id="substituto" name="substituto" class="form-select">
                  <option value="">Selecione um empregado...</option>
                  <%
                        matriculaUsuario = matriculaFerias
						if matriculaUsuario = "C022903" then
							queryColaboradores = "SELECT * FROM VW_USUARIOS WHERE CO_MATRICULA <> '"&matriculaUsuario&"' AND IC_ATIVO=1 AND LETRA = 'C' AND CO_UNIDADE = 7180 ORDER BY NO_NOME"
						else
							queryColaboradores = "SELECT * FROM VW_USUARIOS WHERE CO_GS = (SELECT CO_GS FROM TB_USUARIOS WHERE CO_MATRICULA = '"&matriculaUsuario&"') AND IC_ATIVO=1 AND LETRA = 'C' AND CO_MATRICULA <> '"&matriculaUsuario&"' ORDER BY NO_NOME"
						end if
     
                        set ds=Server.CreateObject("ADODB.RecordSet")
                        ds.Open queryColaboradores, dados_sys 
                        
                        DO UNTIL ds.eof			
                            %>
                  <option value=<%=ds("CO_MATRICULA")%>><%=ds("NO_NOME")%></option>
                  <%
                            ds.movenext
                        LOOP
                        ds.close
                    %>
                </select></td>
            </tr>
            <tr>
              <td><label>Motivo:</label></td>
              <td><select id="motivo" name="motivo" class="form-select">
                  <option value="49">Férias - 61</option>
                </select></td>
            </tr>
            <tr>
              <td><label>Data In&iacute;cio:</label></td>
              <td><input  name="data_inicio" id="data_inicio" class="datepicker" type="text" size="10" maxlength="8" value="<%=dataInicioFerias%>"/></td>
            </tr>
            <tr>
              <td><label>Data Final:</label></td>
              <td><input  name="data_final" id="data_final" class="datepicker" type="text" size="10" maxlength="8" value="<%=dataFimFerias%>"/></td>
            </tr>
          </table>
          <br />
          <div align="center">
                <input name="salvar" class="myButton" type="button" value="Salvar" id="salvarSubstituicao" style="margin-left:7px"/>
         </div>
        </form>
<%
	end sub
%>