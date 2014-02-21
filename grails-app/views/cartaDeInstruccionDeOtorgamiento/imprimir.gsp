<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Carta de Instruccion</title>
    <script src="${resource(dir:'assets/js',file:'jquery-1.10.2.min.js')}"></script>
    <script type="text/javascript">
        jQuery(document).ready(function() {
        window.print();
        });
    </script>
</head>
<body>
    <table style="width: 100%">
        <tr>
            <td style="text-align: center;width: 10%">
                <img src="${resource(dir:'images',file:'infonavit.jpg')}" height="84" width="120">
            </td>
            <td style="text-align: center;width: 80%">
                <span style="font-family: sans-serif;font-size: 16;font-weight: bold">
                    INFONAVIT</span><br/>
                <span style="font-family: sans-serif;font-size: 14">
                    CARTA DE INSTRUCCION DE OTORGAMIENTO DE PODER</span><br/>                                       
            </td>                
        </tr>
    </table> 
    <table style="width: 100%;border-collapse: collapse" border="0">
        <tr>
            <td style="text-align: right">
                <span style="font-family: sans-serif;font-size: 13px;">
                    ${cartaDeInstruccionDeOtorgamientoInstance?.registro}
                </span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">
                <span style="font-family: sans-serif;font-size: 13px;">
                    ${cartaDeInstruccionDeOtorgamientoInstance?.fecha}
                </span>
            </td>
        </tr>
        <tr>
            <td>
                <span style="font-family: sans-serif;font-size: 13px;">
                    <dd class="well"><br/><%=cartaDeInstruccionDeOtorgamientoInstance?.contenido%></dd>
                </span>
            </td>
        </tr>
    </table>
</body>
</html>

