<table style="width: 100%;border-collapse: collapse" border="1">
    <tr>
        <td style="text-align: right">
            <span style="font-family: sans-serif;font-size: 13px;">
                <span><b>Fecha de Registro:</b> <g:formatDate format="dd MMMM yyyy" date="${revocacionDePoderInstance?.registroDeLaSolicitud}" /></span>
            </span>
        </td>
    </tr>    
    <tr bgcolor="#CAC8C7">
        <td style="text-align: center">
            <span style="font-family: sans-serif;font-size: 15px;">
                </br>
                <b>Datos del Solicitante</b>
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
                                    <b>Nombre</b>
                                </span>
                            </td>
                            <td bgcolor="#E7EBEB">
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    <b>Correo Electr&oacute;nico</b>
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
            <table style="width: 100%;border-collapse: collapse" border="1">
                <tr>            
                    <td style="width:33%">
                        <table style="width: 100%;border-collapse: collapse" border="1">
                            <tr>
                                <td style="width:50%">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        ${revocacionDePoderInstance?.delegacion}
                                    </span>
                                </td>
                                <td>
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        <g:if test="${solicitudExterno==true}">
                                            Externo
                                        </g:if>
                                        <g:if test="${solicitanteUSS==true}">
                                            USS
                                        </g:if>
                                        <g:if test="${solicitanteInterno==true}">
                                            Interno
                                        </g:if>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#E7EBEB" style="width:50%">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        <b>Delegaci&oacute;n</b>
                                    </span>
                                </td>
                                <td bgcolor="#E7EBEB">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        <b>Tipo de Solicitante</b>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <g:if test="${revocacionDePoderInstance?.creadaPor?.nombreDespachoExterno}">
                    <tr>
                        <td>
                            <span style="font-family: sans-serif;font-size: 13px;">
                                ${revocacionDePoderInstance?.creadaPor?.nombreDespachoExterno} 
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#E7EBEB">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                <b>Nombre del Despacho</b>
                            </span>
                        </td>
                    </tr>
                </g:if>
            </table>
        </td>  
    </tr>
    <tr><td></br></td></tr>
    <tr bgcolor="#CAC8C7">
        <td>
            <span style="font-family: sans-serif;font-size: 15px;">               
                <b>Datos de la Solicitud</b>
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
                                        <b>N&uacute;mero de Folio</b>
                                    </span>
                                </td>
                                <td bgcolor="#E7EBEB">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        <b>Tipo de Revocación</b>
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
                                        ${revocacionDePoderInstance?.categoriaDeTipoDePoder?.detalles}
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:50%" bgcolor="#E7EBEB">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        <b>Tipo de Poder</b>
                                    </span>
                                </td>
                                <td bgcolor="#E7EBEB">
                                    <span style="font-family: sans-serif;font-size: 13px;">
                                        <b>Categoria</b>
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
                            <b>Fecha de Otorgamiento</b>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            &nbsp;&nbsp;&nbsp;<g:formatDate format="dd-MMM-yyyy" date="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}"/>
                        </span>
                    </td>                           
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <dd><b>Apoderados a quien se revoca el poder</b></dd>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <g:each in="${revocacionDePoderInstance?.apoderadosEliminar.sort{it.nombre}}" var="a">
                                <dd>  - ${a?.nombre}</dd>
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
                            <b>Motivo de revocaci&oacute;n</b>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            &nbsp;&nbsp;&nbsp;${revocacionDePoderInstance?.motivoDeRevocacion}
                        </span>
                    </td>
                </tr>                                
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <b>Escritura P&uacute;blica de Revocaci&oacute;n</b>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            &nbsp;&nbsp;&nbsp;${revocacionDePoderInstance?.escrituraPublicaRevocacion}
                        </span>
                    </td>                           
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <b>Fecha de Revocaci&oacute;n</b>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            &nbsp;&nbsp;&nbsp;<g:formatDate format="dd-MMM-yyyy" date="${revocacionDePoderInstance?.fechaDeRevocacion}"/>
                        </span>
                    </td>                           
                </tr>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <b>Observaciones</b>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            &nbsp;&nbsp;&nbsp;${revocacionDePoderInstance?.comentarios}
                        </span>
                    </td>                           
                </tr>
            </table> 
        </td>
    </tr>  
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_ENLACE, ROLE_PODERES_GESTOR">                        
        <g:if test="${datosNotario && revocacionDePoderInstance?.fechaDeRevocacion}">
            <tr><td></br></td></tr>
            <tr bgcolor="#CAC8C7">
                <td>
                    <span style="font-family: sans-serif;font-size: 15px;">               
                        <b>Datos del Notario - Revocaci&oacute;n</b>
                    </span>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="height: 100%; width: 100%;border-collapse: collapse" border="1">
                        <tr>
                            <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    <b>Titular</b>
                                </span>
                            </td>                    
                            <td style="width:70%;text-align: left">
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    &nbsp;&nbsp;&nbsp;${datosNotario?.notaria_titular}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#E7EBEB" style="width:30%;text-align: right"></td>
                            <td style="width:70%;text-align: left">
                                <span style="font-family: sans-serif;font-size: 13px;">
                                    &nbsp;&nbsp;&nbsp;${datosNotario?.notaria_numero}, ${datosNotario?.notaria_entidad}
                                </span>
                            </td>
                        </tr>                                                                                                                                         
                    </table>
                </td>
            </tr>
        </g:if> 
    </sec:ifAnyGranted>
</table>
