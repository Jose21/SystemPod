<table style="width: 100%;border-collapse: collapse" border="1">
    <tr>
        <td style="text-align: right">
            <span style="font-family: sans-serif;font-size: 13px;">
                <span><g:formatDate date="${otorgamientoDePoderInstance?.fechaDeEnvio}" /></span>
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
                                    ${otorgamientoDePoderInstance?.creadaPor?.firstName} ${otorgamientoDePoderInstance?.creadaPor?.lastName}
                                </span>
                            </td>
                            <td>
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    ${otorgamientoDePoderInstance?.creadaPor?.email} 
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
                ${otorgamientoDePoderInstance?.delegacion}
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
            <span style="font-family: sans-serif;font-size: 13px;">
                ${otorgamientoDePoderInstance?.id}-O
            </span>
        </td>

    </tr>
    <tr>
        <td bgcolor="#E7EBEB">
            <span style="font-family: sans-serif;font-size: 13px;">
                N&Uacute;MERO DE FOLIO
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
                                    ${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.tipoDePoder?.nombre}
                                </span>
                            </td>
                            <td>
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    ${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.nombre}
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
    <tr><td></br></td></tr>
    <tr>
        <td>
            <table style="height: 100%; width: 100%;border-collapse: collapse" border="1">
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>APODERADOS   </dd>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <g:each in="${otorgamientoDePoderInstance?.apoderados}" var="a">
                                <dd>   ${a?.nombre.encodeAsHTML()}</dd>
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
                            PODER SOLICITADO 
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   ${otorgamientoDePoderInstance?.poderSolicitado}</dd>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            MOTIVO DE OTORGAMIENTO
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   ${otorgamientoDePoderInstance?.motivoDeOtorgamiento}</dd>
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
                            <dd>   ${otorgamientoDePoderInstance?.solicitadoPor}</dd>
                        </span>
                    </td>        
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            GESTOR
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd>   ${otorgamientoDePoderInstance?.asignar}</dd>
                        </span>
                    </td>            
                </tr>
            </table> 
        </td>
    </tr>
    <!--datos complemntarios-->    
    <g:if test="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}">
        <tr><td></br></td></tr>
        <tr bgcolor="#CAC8C7">
            <td>
                <span style="font-family: sans-serif;font-size: 15px;">               
                    DATOS COMPLEMENTARIOS
                </span>
            </td>
        </tr>
        <tr>
            <td>
                <table style="height: 100%; width: 100%;border-collapse: collapse" border="1">
                    <tr>
                        <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                FECHA DE OTORGAMIENTO
                            </span>
                        </td>                    
                        <td style="width:70%;text-align: left">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                <dd>   <g:formatDate date="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}"/></dd>
                            </span>
                        </td>                           
                    </tr>
                    <tr>
                        <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                ESCRITURA P&Uacute;BLICA
                            </span>
                        </td>                    
                        <td style="width:70%;text-align: left">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                <dd>   ${otorgamientoDePoderInstance?.escrituraPublica}</dd>
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
                                <dd>   ${otorgamientoDePoderInstance?.comentarios}</dd>
                            </span>
                        </td>                           
                    </tr>
                </table>
            </td>
        </tr>
    </g:if>
</table>