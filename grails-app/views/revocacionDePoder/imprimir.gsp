<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Solicitud</title>
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
                        SOLICITUD DE REVOCACION DE PODER</span><br/>                                       
                </td>                
            </tr>
        </table>
        <g:render template="/revocacionDePoder/solicitudRevocacion" />
    </body>
</html>

