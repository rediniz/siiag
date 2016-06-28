<h3 class="titulos" style="text-align:center;">Atualização de Equipamentos - Micros</h3>


<table width="400" border="0" cellpadding="0" align="center">
  <tr>
    <td><label>Tipo :</label></td>
    <td><input class="form-field"/></td>
  </tr>
  <tr>
    <td><label>Endereço Lógico :</label></td>
    <td><input class="form-field" /></td>
  </tr>
  <tr>
    <td><label>Usuário :</label></td>
    <td><input class="form-field"/></td>
  </tr>
 
  <tr>
    
<%

nomePesquisa = Request("nomePesquisa")

QueryRamais =	"SELECT USUARIOS.CO_MATRICULA, USUARIOS.NO_NOME, USUARIOS_CONTATOS.CO_CONTATO, CONTATOS.DE_CONTATO FROM TB_USUARIOS USUARIOS INNER JOIN TB_USUARIOS_CONTATOS USUARIOS_CONTATOS ON USUARIOS_CONTATOS.CO_MATRICULA = USUARIOS.CO_MATRICULA INNER JOIN TB_CONTATOS CONTATOS ON CONTATOS.CO_CONTATO = USUARIOS_CONTATOS.CO_CONTATO WHERE(USUARIOS.NO_NOME LIKE '%"&nomePesquisa&"%') AND(USUARIOS.IC_ATIVO = 1) AND (CONTATOS.CO_TIPO = 5) ORDER BY USUARIOS.NO_NOME"

	set objConn =server.CreateObject("ADODB.Connection")
	dados_sys ="Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce"
	objConn.open dados_sys
	set ramais =	Server.CreateObject("ADODB.RecordSet")
	ramais.Open QueryRamais, dados_sys
	
	Response.Write "<td><label>Gerência :</label></td>"
	
	DO UNTIL ramais.eof
	
	
		NO_NOME = ramais("NO_NOME")
		DE_CONTATO = ramais("DE_CONTATO")
		
			response.write "<tr>"
			response.write "<td id='NO_NOME'>"& NO_NOME & "</td>"
			response.write "<td id='DE_CONTATO'>"& DE_CONTATO &"</td>"
			response.write "</tr>"
		
		
			
			'response.Write "<li class='textosAgenda'> <strong>Empregado: </strong>"&NO_NOME&"<br/><strong>Contato: </strong>"&DE_CONTATO&"</li><hr class='linhaSeparadora'/>"
		
		

		ramais.movenext
		
	LOOP
	END IF
	
objConn.close 
set ramais = 	nothing
set objConn = 		nothing 



%>
    <td><input class="form-field"/></td>
  </tr>
  <tr>
    <td><label>Nº de Série :</label></td>
    <td><input class="form-field" /></td>
  </tr>
  <tr>
    <td><label>Marca :</label></td>
    <td><input class="form-field" /></td>
  </tr>
  <tr>
    <td><label>Modelo :</label></td>
    <td><input class="form-field" /></td>
  </tr>
  <tr>
    <td><label>Sistema Operacional :</label></td>
    <td><input class="form-field" /></td>
  </tr>
  <tr>
    <td colspan="2"><input type="button" style="margin-left:24%;margin-top:5%;" class="myButton" value="Atualizar Informações"/> </td>
  </tr>
</table>

