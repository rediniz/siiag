

        
		<style type="text/css">
		
			#container {
				width: 300px;
			}
			
			#pages {
				width: 92px;
				height: 18px;
				margin: 5px auto 0 auto;
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
					
		</style>


<div id="content">
			<h1>more advanced example: callbacks, custom navigation and auto mode</h1>
			
			<div id="container">
				<div id="carousel">
					<img src="images/001.jpg" />
					<img src="images/002.jpg" />
					<img src="images/003.jpg" />
					<img src="images/004.jpg" />
					<img src="images/005.jpg" />
					<img src="images/006.jpg" />
					<img src="images/007.jpg" />
					<img src="images/008.jpg" />
					<img src="images/009.jpg" />
					<img src="images/010.jpg" />
                    
				</div>
				<div id="pages"></div>
			</div>
		</div>
        

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
					auto: {enabled: true},
					start: generatePages,
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

<div class="aniversariantes"><!--calendario -->

</div> <!--fim do calendario -->