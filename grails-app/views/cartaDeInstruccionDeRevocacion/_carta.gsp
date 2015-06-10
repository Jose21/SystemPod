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
                APODERADOS A REVOCAR EL PODER
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="0">
                <thead>
                    <tr>                    
                        <td style="text-align: left;font-size: 14px;font-weight: bold; width:40%">NOMBRE</td>
                        <td style="text-align: left;font-size: 14px;font-weight: bold; width:30%">PUESTO</td>
                        <td style="text-align: left;font-size: 14px;font-weight: bold; width:30%">INSTITUCION</td>                    
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${revocacionDePoderInstance?.apoderadosEliminar.sort{it.nombre}}" status="i" var="apoderado">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">                        
                            <td style="text-align: left; width:40%">${fieldValue(bean: apoderado, field: "nombre")}</td>
                            <td style="text-align: left; width:30%">${fieldValue(bean: apoderado, field: "puesto")}</td>
                            <td style="text-align: left; width:30%">${fieldValue(bean: apoderado, field: "institucion")}</td>                                                                
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
                Gerente de Coordinación Jurídica
            </span>
        </td>
    </tr>
</table> 
