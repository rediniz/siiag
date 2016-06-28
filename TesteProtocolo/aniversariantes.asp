
<h3 class="titulos">Aniversariantes do M&ecirc;s </h3>
<% 

data = Request("data")

if data <> "" Then

dataTotal = data

else

dataTotal=(DAY(DATE()) &"/"& MONTH(DATE())&"/"& YEAR(DATE())) 'pegando a data do dia para comparacao com o banco'

END IF 


mesCorrente = int(Month(dataTotal)) 'Pegando o mes atual

				
strQuery = "select * from TB_USUARIOS WHERE IC_ATIVO=1 ORDER BY NO_NOME; " 
set objConn = server.CreateObject("ADODB.Connection") 
dados_sys = "Provider=sqloledb;Data Source=CE7180nt005;Initial Catalog=GIFUG;User Id=todos;Password=todosce;"
objConn.open dados_sys
set rs=Server.CreateObject("ADODB.RecordSet")
rs.Open strQuery, dados_sys


 'Agora iremos exibir os dados do Recordset gerado pela consulta SQL
 'Vamos percorrer o recordset até chegar no final do arquivo
 	response.Write "<div id='container'>"
	response.Write "<div id='carousel'>"
  DO UNTIL rs.eof
  
 'atribuindo os valores dos campos as variáveis
  Matricula=rs("CO_MATRICULA")
  Digito=rs("CO_DIGITO")
  Nome=rs("NO_NOME")
  Cargo=rs("CO_CARGO")
  Data_Nascimento=rs("DT_NASCIMENTO")
  Jornada=rs("NU_JORNADA")
  Foto=rs("IM_FOTO")
  Ativo=rs("IC_ATIVO")
 
 mesdoBanco=Month(Data_Nascimento)
 diadoBanco = Day(Data_Nascimento)


' escrevendo os campos em uma tabela para exibição via um Browser
  'cellstart="<td align=""top"">"
  if mesCorrente = mesdoBanco Then
  	
   'response.write "<tr>"
   'response.write "<td>" & Foto & "</td>"
   'response.write "<br/>"
   'response.write "<td>" & diadoBanco & "</td>"
   'response.write "<br/>"   
   'response.write "</tr>"
    if (Foto = Empty) then
 
  response.Write "<img  title='"&nome&" - "& DAY(Data_Nascimento) &"/"& MONTH(Data_Nascimento)&"'src='imagens//usuarios//X000000.png'/>"
  else 
     response.Write "<img  title='"&nome&" - "& DAY(Data_Nascimento) &"/"& MONTH(Data_Nascimento)&"' src='imagens//usuarios//"&Matricula&".png'/>"
  end if

 	End If
  rs.movenext
 
LOOP
	
	response.Write "</div>"
    response.Write "<div id='pages'></div>"
	response.Write "<a href='#' id='ui-carousel-next'><span>next</span></a>"
	response.Write "<a href='#' id='ui-carousel-prev'><span>prev</span></a>"
	response.Write	"</div>"

objConn.close 
set rs = nothing
set objConn = nothing 
%> 



<style type="text/css">
			#container {
				width: 100%;
				position: relative;
				margin-bottom:5%;
			}
			
			#carousel {
				
				margin: 0 auto;
			}

			#carousel img {
				border: 2px;
				border-color:#FF9933;
			}

			#ui-carousel-next, #ui-carousel-prev {
				width: 60px;
				height: 100px;
				background: url(images/arrow-left.png) #fff center center no-repeat;
				display: block;
				position: absolute;
				top: 0;
				z-index: 100;
			}

			#ui-carousel-next {
				right: 0;
				background-image: url(images/arrow-right.png);
			}

			#ui-carousel-prev {
				left: 0;
			}		
			#ui-carousel-next > span, #ui-carousel-prev > span {
				display: none;
			}
			
		
			#pages {
				width: 92px;
				height: 18px;
				margin: 10px auto 0 auto;
			}
			
			.bullet {
				background: url(images/page-off.png) center center no-repeat;
				display: block;
				width: 18px;
				height: 18px;
				margin: 0;
				margin-right: 5px;
				float: left;				
			}
			
			#container > img{
			
			height:100px;
			width:1px;
			
			}
			
		</style>
 
			<!--<div id="container">
				<div id="carousel">
					<img src="images/E712237.png"/>
					<img src="images/E711000.png"/>
					<img src="images/C124937.png"/>
					<img src="images/C053498.png"/>
					<img src="images/C082291.png"/>
					<img src="images/C097105.png"/>
					<img src="images/C054423.png" />
					<img src="images/C022942.png" />
					<img src="images/E689507.png" />
					<img src="images/010.jpg" />
                    
				</div>
                	<div id="pages"></div>
				<a href="#" id="ui-carousel-next"><span>next</span></a>
				<a href="#" id="ui-carousel-prev"><span>prev</span></a>
			
		</div> -->

		<script type="text/javascript" src="scripts/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="lib/jquery.ui.core.js"></script>
		<script type="text/javascript" src="lib/jquery.ui.widget.js"></script>
		<script type="text/javascript" src="lib/jquery.ui.rcarousel.js"></script>
        
        	<style>
	label {
		display: inline-block;
		width: 2em;
	}
	</style>
	<script>
	$(function() {
		$( document ).tooltip({
			track: true
		});
	});
	</script>
        
	<script type="text/javascript">
			jQuery(function($) {
				function generatePages() {
					var _total, i, _link;
					
					_total = $( "#carousel" ).rcarousel( "getTotalPages" );
					
					for ( i = 0; i < _total; i++ ) {
						_link = $( "<a href='#'></a>" );
						
						$(_link)
							.bind("click", {page: i},
								function( event ) {
									$( "#carousel" ).rcarousel( "goToPage", event.data.page );
									event.preventDefault();
								}
							)
							.addClass( "bullet off" )
							.appendTo( "#pages" );
					}
					
					// mark first page as active
					$( "a:eq(0)", "#pages" )
						.removeClass( "off" )
						.addClass( "on" )
						.css( "background-image", "url(images/page-on.png)" );

				}

				function pageLoaded( event, data ) {
					$( "a.on", "#pages" )
						.removeClass( "on" )
						.css( "background-image", "url(images/page-off.png)" );

					$( "a", "#pages" )
						.eq( data.page )
						.addClass( "on" )
						.css( "background-image", "url(images/page-on.png)" );
				}				

				$( "#carousel" ).rcarousel({
					auto: {enabled: true, interval:3000},
					start: generatePages,
					step: 5,
					visible: 5,
					margin: 10,
					height:100,
					width: 75,
					pageLoaded: pageLoaded
				});
							
				$( ".bullet" )
					.hover(
						function() {
							$( this ).css( "opacity", 0.7 );
						},
						function() {
							$( this ).css( "opacity", 1.0 );
						}
					);					
			});
			
		</script>