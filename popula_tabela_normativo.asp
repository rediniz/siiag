<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!-- #INCLUDE FILE ="include/Conexao.asp" -->
<!-- #INCLUDE FILE ="include/funcoes.asp" -->
<%
	dim manuais(42)
	
	manuais(1) = "AD013 > Pronto Pagamento"
	manuais(2) = "AD020 > Solicitação de Contratação para Aquisição de Bens e Prestação de Serviços"
	manuais(3) = "AD028 > Contratação sem licitação"
	manuais(4) = "AD065 > Suprimentos - Recursos de Infraestrutura para Eventos"
	manuais(5) = "AD157 > Contratações com Utilização da Verba de Reconhecimento e Valorização"
	manuais(6) = "AE053 > Marketing - Identidade Visual Corporativa"
	manuais(7) = "CR111 > Controle e Acompanhamento da Execução Orçamentária de Dispêndios"
	manuais(8) = "CR127 > IR, CSLL, COFINS e PIS/PASEP - Retenção nos Pagamentos Efetuados a Pessoa Jurídica pelo Fornecimento de Bens ou Prestação de Serviços em Geral, Inclusive Obras"
	manuais(9) = "OR003 > Correio Eletrônico - Padrão e Regras de Utilização"
	manuais(10) = "OR016 > Tratamento da Informação"
	manuais(11) = "OR083 > Funcionamento dos Comitês de Reconhecimento e Valorização"
	manuais(12) = "PO020 > Política de Reconhecimento e Valorização de Pessoas e Equipes na CAIXA"
	manuais(13) = "RH001 > Férias"
	manuais(14) = "RH002 > Admissão"
	manuais(15) = "RH003 > PCMSO - Programa de Controle Médico de Saúde Ocupacional"
	manuais(16) = "RH005 > Destacamento"
	manuais(17) = "RH009 > Licença por Doença em Pessoa da Família"
	manuais(18) = "RH010 > Licença – Maternidade"
	manuais(19) = "RH016 > Licença-Prêmio"
	manuais(20) = "RH020 > Ausência Permitida – Folga e Conversão"
	manuais(21) = "RH035 > Jornada de Trabalho e Registro no SIPON"
	manuais(22) = "RH040 > Programa de Seleção Interna por Competência"
	manuais(23) = "RH052 > LAT - Licença Acidente do Trabalho"
	manuais(24) = "RH059 > Declaração de Bens e Valores - Apresentação à CAIXA"
	manuais(25) = "RH069 > Transferência de Empregado"
	manuais(26) = "RH087 > Contrato de Trabalho - Rescisão a Pedido"
	manuais(27) = "RH089 > Registros Funcionais"
	manuais(28) = "RH100 > Fiscalização Trabalhista"
	manuais(29) = "RH101 > Licença Saúde"
	manuais(30) = "RH103 > Código de Ética da CAIXA"
	manuais(31) = "RH111 > Programa Estágio na CAIXA"
	manuais(32) = "RH116 > Vale-transporte"
	manuais(33) = "RH118 > Programas Adolescente Aprendiz e Jovem Aprendiz"
	manuais(34) = "RH128 > Soluções de Capacitação e Desenvolvimento Profissional"
	manuais(35) = "RH139 > Declarações de Relação de Trabalho CAIXA"
	manuais(36) = "RH148 > Currículo"
	manuais(37) = "RH150 > Desenvolvimento e Capacitação"
	manuais(38) = "RH175 > Estrutura de Cargos Efetivos"
	manuais(39) = "RH176 > Promoção por Sistemática Anual"
	manuais(40) = "RH183 > Estrutura de Funções Gratificadas"
	manuais(41) = "RH184 > Exercício de Função Gratificada/Cargo em Comissão"
	manuais(42) = "RH200 > Código de Conduta dos Empregados e Dirigentes da CAIXA"

	
	for i = 1 to 42
		valores = split(manuais(i), ">")
		co_manual = trim(valores(0))
		de_manual = trim(valores(1))
		link_manual = "http://sismn.caixa/sistema/asp/ConsultaPesquisa/pdf_comum.asp?id=N"&co_manual&""
		
		sql = "INSERT INTO TB_MANUAIS_NORMATIVOS VALUES ('"&co_manual&"','"&de_manual&"','"&link_manual&"')"
		objConn.execute(sql)
	next
			
%>
