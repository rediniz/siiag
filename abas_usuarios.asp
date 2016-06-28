<%


aba1 = ""
aba2 = ""
aba3 = ""
aba4 = ""
aba5 = ""
aba6 = ""
select case aba_ativa
case 1
	aba1 = "active"
case 2
	aba2 = "active"
case 3
	aba3 = "active"
case 4
	aba4 = "active"
case 5
	aba5 = "active"
case 6
	aba6 = "active"
end select

%>

              <li class='<%=aba1%>'><a href='usuario.asp'><span>Consultar</span></a></li>
			<% if  perfil_acesso_admin_siiag or request.Cookies("ic_gerente_siiag") then %>
                <li class='<%=aba2%>' ><a href='usuario_cadastrar.asp'><span>Cadastrar</span></a></li>
            <% end if %>
			<% if tem_acesso("10") then  %>
                <li class='<%=aba3%>' ><a href='coordenacao.asp'><span>Coordenações</span></a></li>
                <li class='<%=aba4%>' ><a href='usuario_lista.asp'><span>Usuários/Coordenações</span></a></li>
            <% end if %>               
            <li class='<%=aba5%>' ><a href='usuario_lista_frequencia.asp'><span>Lista de Usuários</span></a></li>
	        <% if tem_acesso("31") then %>
	            <li class='<%=aba6%>' ><a href='usuario_lista_estagiario.asp'><span>Folha de Frequência Estagiários</span></a></li>
			<% end if%>