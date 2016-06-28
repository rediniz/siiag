<%@LANGUAGE="VBScript" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="f_usuario.asp" -->
<%

  matricula = request("matricula")
  nome = request("nome")
  hora_entrada = request("horario_inicio")
  hora_saida = request("horario_fim")
  intervalo_inicio = request("intervalo_inicio")
  intervalo_fim = request("intervalo_fim")
  data_vigencia = request("data")
  situacao = 1 
  data_criacao = day(date()) & "/" & month(date()) & "/" & year(date()) & " " & time()
  criador = request.Cookies("co_usuario_siiag")
  unidade = request.Cookies("co_usuario_unidade_siiag")

  query = "INSERT INTO TB_JORNADA (CO_UNIDADE, CO_MATRICULA, DH_ENTRADA, DH_INTERVALO_INICIO, DH_INTERVALO_FIM, DH_SAIDA, DH_VIGENCIA, CO_SITUACAO, DH_CRIACAO, CO_CRIADOR) VALUES ("&unidade&",'"&matricula&"', '"&hora_entrada&"', '"&intervalo_inicio&"', '"&intervalo_fim&"','"&hora_saida&"','"&data_vigencia&"',"&situacao&", '"&data_criacao&"', '"&criador&"')"
  
  objConn.execute(query)
  
  set query = nothing
  set objConn = nothing

%>