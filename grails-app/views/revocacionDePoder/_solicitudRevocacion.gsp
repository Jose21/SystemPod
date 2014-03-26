<table style="width: 100%;border-collapse: collapse" border="1">
    <tr>
        <td style="text-align: right">
            <span style="font-family: sans-serif;font-size: 13px;">
                <span><g:formatDate date="${revocacionDePoderInstance?.fechaDeEnvio}" /></span>
            </span>
        </td>
    </tr>
    <tr bgcolor="#CAC8C7">
        <td style="text-align: center">
            <span style="font-family: sans-serif;font-size: 15px;">
                </br>
                DATOS DEL SOLICITANTE
                </br>                
            </span>
        </td>
    </tr>
    <td>
        <table style="width: 100%;border-collapse: collapse" border="1">
            <tr>            
                <td style="width:33%">
                    <table style="width: 100%;border-collapse: collapse" border="1">
                        <tr>
                            <td style="width:50%">
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    ${revocacionDePoderInstance?.creadaPor?.firstName} ${revocacionDePoderInstance?.creadaPor?.lastName}
                                </span>
                            </td>
                            <td>
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    ${revocacionDePoderInstance?.creadaPor?.email} 
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:50%" bgcolor="#E7EBEB">
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    NOMBRE
                                </span>
                            </td>
                            <td bgcolor="#E7EBEB">
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    CORREO ELECTRONICO
                                </span>
                            </td>
                        </tr>                        
                    </table>
                </td>            
            </tr>
        </table>
    </td>
    <tr>
        <td>
            <span style="font-family: sans-serif;font-size: 13px;">
                ${revocacionDePoderInstance?.delegacion}
            </span>
        </td>
    </tr>
    <tr>
        <td bgcolor="#E7EBEB">
            <span style="font-family: sans-serif;font-size: 13px;">
                DELEGACI&Oacute;N
            </span>
        </td>
    </tr>
    <tr><td></br></td></tr>
    <tr bgcolor="#CAC8C7">
        <td>
            <span style="font-family: sans-serif;font-size: 15px;">               
                DATOS DE LA SOLICITUD
            </span>
        </td>
    </tr>
    <tr>
        <td>
            <table style="width: 100%;border-collapse: collapse" border="1">
                <tr>            
                    <td style="width:33%">
                        <table style="width: 100%;border-collapse: collapse" border="1">
                            <tr>
                                <td style="width:50%">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        ${revocacionDePoderInstance?.id}-R
                                    </span>
                                </td>
                                <td>
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        ${revocacionDePoderInstance?.tipoDeRevocacion}
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:50%" bgcolor="#E7EBEB">                                
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        N&Uacute;MERO DE FOLIO
                                    </span>
                                </td>
                                <td bgcolor="#E7EBEB">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        TIPO DE REVOCACI&Oacute;N
                                    </span>
                                </td>
                            </tr>                        
                        </table>
                    </td>            
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table style="width: 100%;border-collapse: collapse" border="1">
                <tr>            
                    <td style="width:33%">
                        <table style="width: 100%;border-collapse: collapse" border="1">
                            <tr>
                                <td style="width:50%">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        ${revocacionDePoderInstance?.categoriaDeTipoDePoder?.tipoDePoder?.nombre}
                                    </span>
                                </td>
                                <td>
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        ${revocacionDePoderInstance?.categoriaDeTipoDePoder?.nombre}
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:50%" bgcolor="#E7EBEB">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        TIPO DE PODER
                                    </span>
                                </td>
                                <td bgcolor="#E7EBEB">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        CATEGORIA
                                    </span>
                                </td>
                            </tr>                        
                        </table>
                    </td>            
                </tr>
            </table>
        </td>
    </tr>
    <tr><td></br></td></tr>
    <tr>
        <td>
            <table style="height: 100%; width: 100%;border-collapse: collapse" border="1">
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>APODERADOS A QUIEN SE REVOCA EL PODER</dd>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <g:each in="${revocacionDePoderInstance?.apoderadosEliminar.sort{it.nombre}}" var="a">
                                <dd>  - ${a?.nombre.encodeAsHTML()}</dd>
                            </g:each> 
                        </span>
                    </td>                           
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table style="height: 100%; width: 100%;border-collapse: collapse" border="1">                               
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            MOTIVO DE REVOCACI&OacuteN
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   ${revocacionDePoderInstance?.motivoDeRevocacion}</dd>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            SOLICITADO POR
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   ${revocacionDePoderInstance?.solicitadoPor}</dd>
                        </span>
                    </td>        
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            FECHA DE OTORGAMIENTO
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   <g:formatDate date="${revocacionDePoderInstance?.fechaDeRevocacion}"/></dd>
                        </span>
                    </td>                           
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            ESCRITURA P&Uacute;BLICA DE REVOCACI&Oacute;N
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   ${revocacionDePoderInstance?.escrituraPublicaRevocacion}</dd>
                        </span>
                    </td>                           
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            OBSERVACIONES
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   ${revocacionDePoderInstance?.comentarios}</dd>
                        </span>
                    </td>                           
                </tr>
            </table> 
        </td>
    </tr>    
</table>
