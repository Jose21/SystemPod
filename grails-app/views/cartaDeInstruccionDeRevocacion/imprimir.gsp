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
                    CARTA DE INSTRUCCION DE REVOCACION DE PODER</span><br/>                                       
            </td>                
        </tr>
    </table> 
    <table style="width: 100%;border-collapse: collapse" border="0">
        <tr>
            <td style="text-align: right">
                <span style="font-family: sans-serif;font-size: 13px;">
                    ${cartaDeInstruccionDeRevocacionInstance?.registro}
                </span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">
                <span style="font-family: sans-serif;font-size: 13px;">
                    ${cartaDeInstruccionDeRevocacionInstance?.fecha}
                </span>
            </td>
        </tr>
        <tr>
            <td>
                <span style="font-family: sans-serif;font-size: 13px;">
                    <dd class="well"><br/><%=cartaDeInstruccionDeRevocacionInstance?.contenido%></dd>
                </span>
            </td>
        </tr>
        <tr>
            <td bgcolor="#E7EBEB" style="text-align: CENTER">
                <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                    APODERADOS
                </span>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0">
                    <thead>
                        <tr>                    
                            <td style="text-align: CENTER;font-size: 14px;font-weight: bold">NOMBRE</td>
                            <td style="text-align: CENTER;font-size: 14px;font-weight: bold">PUESTO</td>
                            <td style="text-align: CENTER;font-size: 14px;font-weight: bold">INSTITUCION</td>                    
                        </tr>
                    </thead>
                    <tbody> 
                        <g:each in="${revocacionDePoderInstance?.apoderados}" status="i" var="apoderado">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">                        
                                <td style="text-align: center">${fieldValue(bean: apoderado, field: "nombre")}</td>
                                <td style="text-align: center">${fieldValue(bean: apoderado, field: "puesto")}</td>
                                <td style="text-align: center">${fieldValue(bean: apoderado, field: "institucion")}</td>                                                                
                            </tr>
                        </g:each>                                
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
    <table style="width: 100%;border-collapse: collapse" border="0">
        <tr>            
            <td style="width:33%">
                <table style="width: 100%;border-collapse: collapse" border="0">
                    <tr>                        
                        <td style="width:50%" bgcolor="#E7EBEB">
                            <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                                TIPO DE PODER
                            </span>
                        </td>                                              
                    </tr>
                    <tr>
                        <td style="width:50%">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                ${revocacionDePoderInstance?.categoriaDeTipoDePoder?.tipoDePoder?.nombre}
                            </span>
                        </td>  
                    </tr>
                    <tr>                        
                        <td bgcolor="#E7EBEB">
                            <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                                CATEGORIA
                            </span>
                        </td>                        
                    </tr>
                    <tr>
                        <td>
                            <span style="font-family: sans-serif;font-size: 13px;">
                                ${revocacionDePoderInstance?.categoriaDeTipoDePoder?.nombre}
                            </span>
                        </td>
                    </tr>
                    <tr>                        
                        <td bgcolor="#E7EBEB">
                            <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                                DELEGACIÓN
                            </span>
                        </td>                        
                    </tr> 
                    <tr>
                        <td>
                            <span style="font-family: sans-serif;font-size: 13px;">
                                ${revocacionDePoderInstance?.delegacion?.nombre}
                            </span>
                        </td>
                    </tr>
                </table>
            </td>            
        </tr>        
        <tr>
            <td bgcolor="#E7EBEB" style="text-align: left">
                <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                    MOTIVO DE REVOCACION
                </span>
            </td>
        </tr>
        <tr>
            <td>
                <span style="font-family: sans-serif;font-size: 13px;">
                    ${revocacionDePoderInstance?.motivoDeRevocacion?.nombre}
                </span>
            </td>
        </tr>
        <tr><td></br></td></tr>
        <tr>
            <td style="text-align: center">
                <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                    Atentamente,
                </span>
            </td>
        </tr>
        <tr><td></br></td></tr>
        <tr>
            <td style="text-align: center">
                <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                    Gerente Jurídico
                </span>
            </td>
        </tr>
    </table>   
</body>
</html>

