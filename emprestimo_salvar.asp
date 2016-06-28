<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%



  query = "INSERT INTO TB_JORNADA (CO_UNIDADE, CO_MATRICULA, DH_ENTRADA, DH_INTERVALO_INICIO, DH_INTERVALO_FIM, DH_SAIDA, DH_VIGENCIA, CO_SITUACAO, DH_CRIACAO, CO_CRIADOR) VALUES ("&unidade&",'"&matricula&"', '"&hora_entrada&"', '"&intervalo_inicio&"', '"&intervalo_fim&"','"&hora_saida&"','"&data_vigencia&"',"&situacao&", '"&data_criacao&"', '"&criador&"')"
  
  set query = nothing
  set objConn = nothing

%>