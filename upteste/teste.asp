    <html>
    <head>
    <title>Upload de Imagem</title>
    </head>
    <body>
    <form name="form" enctype="multipart/form-data" method="post" action="javascript:verifica_extencao()" id="form">
    <p>Escolha a foto:</p>
    <p><input type="file" name="arq" size="20" class="form2" id="arq"></p>
     
    <script>
    function verifica_extencao() {
    var extensoesOk = ",.gif,.jpg,";
     
    var extensao = "," + document.form.arq.value.substr( document.form.arq.value.length - 4 ).toLowerCase() + ",";
    if (document.form.arq.value == "")
    {alert("O campo do endere�o da imagem est� vazio!!")}
    else if( extensoesOk.indexOf( extensao ) == -1 )
    { alert( document.form.arq.value + "nN�o possui uma extens�o v�lida" );javascript:location.reload()}
    else {javascript:tamanhos()}
     
    }
     
    function tamanhos() {
    tamanhoArqMax = 15000
    imagem=new Image();
    imagem.src=document.form.arq.value;
    tamanho_imagem = imagem.fileSize
    img_tan = tamanho_imagem
    if (tamanho_imagem < 0)
    {javascript:tamanhos()}
    else if (tamanho_imagem > tamanhoArqMax)
    {alert("O tamanho da Imagem � muito grande ... "+tamanho_imagem+" Bytes!! n Tamanho M�ximo suportado : "+tamanhoArqMax+" Bytes n S�o "+(tamanho_imagem-tamanhoArqMax)+" Bytes a Mais!");javascript:location.reload()}
    else
    {javascript:ativafigura()}
    }
     
    function ativafigura() {
    document.getElementById('foto').innerHTML = "<img border="0" src=""+document.form.arq.value+"" name="img" style="visibility: hidden" >"
    largura = document.getElementById("img").width;
    altura = document.getElementById("img").height;
    if (largura > 350 || altura > 225 )
    {alert("A imagem � "+largura+"x"+altura+" est� fora do padr�o requerido");javascript:location.reload()}
    else
    {alert("O arquivo foi Aceito... n Localiza��o: "+document.form.arq.value+"n Tamanho: "+tamanho_imagem+" Bytes n Dimens�es :"+largura+"x"+altura)}
    }
     
     
    </script>
     
     
    </form>
    <p><a href="javascript:verifica_extencao()">GRAVAR!!</a></p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <div id="foto"></div>
    </body>
    </html>
