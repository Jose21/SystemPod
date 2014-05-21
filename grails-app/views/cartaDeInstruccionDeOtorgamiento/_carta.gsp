<table style="width: 100%;border-collapse: collapse" border="0">
    <tr>
        <td style="text-align: center;width: 20%">
            <img src="${resource(dir:'images',file:'infonavit_logo.png')}" height="84" width="120">
        </td>
        <td style="text-align: center;width: 60%">
            <span style="font-family: sans-serif;font-size: 16;font-weight: bold">
                INFONAVIT</span><br/>
            <span style="font-family: sans-serif;font-size: 14">
                CARTA DE INSTRUCCION DE OTORGAMIENTO DE PODER</span><br/>                                       
        </td>
        <td style="text-align: center;width: 20%">            
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
                            ${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.tipoDePoder?.nombre}
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
                            ${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.nombre}
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
                            ${otorgamientoDePoderInstance?.delegacion?.nombre}
                        </span>
                    </td>
                </tr>
            </table>
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
                    <g:each in="${otorgamientoDePoderInstance?.apoderados.sort{it.nombre}}" status="i" var="apoderado">
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
    <tr>
        <td bgcolor="#E7EBEB" style="text-align: left">
            <span style="font-family: sans-serif;font-size: 14px;font-weight: bold">
                MOTIVO DE OTORGAMIENTO
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <span style="font-family: sans-serif;font-size: 13px;">
                ${otorgamientoDePoderInstance?.motivoDeOtorgamiento?.nombre}
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
