  <%
  	matricula = request("matricula")
  %>
  <div class='tabela'>
    <table>
      <tr>
      	<td>Extrato de horas para Acompanhamento Médico</td>
      </tr>
      <tr>
        <td>Data</td>
        <td>Matrícula</td>
        <td>Quantidade</td>
        <td>Saldo</td>
      </tr>
      <%
	  
	  CO_MATRICULA, CO_USUARIO_OPERACAO, DT_OPERACAO, TIPO_OPERACAO, QTD_MODIFICADA, SALDO_ANTERIOR, SALDO, CO_AFASTAMENTO
	  	queryHistorico = "SELECT * FROM TB_ACOMPANHAMENTO_HISTORICO WHERE CO_MATRICULA = '"&matricula&"'"
		set rsHistorico = Server.CreateObject("ADODB.RecordSet")
		rsHistorico.Open queryHistorico, dados_sys
		
		do until rsHistorico.eof
			%>
              <tr>
                <td><%=rsHistorico("DT_OPERACAO")%></td>
                <td><%=rsHistorico("CO_USUARIO_OPERACAO")%></td>
                <td><% 		
					if TIPO_OPERACAO = 1
						cor = "#0F0"
						sinal = "+"
					else
						cor = "#F00"
						sinal = "-"
					end if
					%>
                <span style="color:<%=cor%>"><%=sinal%><%=rsHistorico("QTD_MODIFICADA")%></span>
                </td>
                <td><%=rsHistorico("SALDO")%></td>
              </tr>
      		<%
			rsHistorico.movenext
		loop
		
		rsHistorico.close
	  %>
    </table>
  </div>
