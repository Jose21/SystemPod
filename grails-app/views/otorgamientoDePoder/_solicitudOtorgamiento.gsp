<table style="width: 100%;border-collapse: collapse" border="1">
    <tr>
        <td style="text-align: right">
            <span style="font-family: sans-serif;font-size: 13px;">
                <span><b>Fecha de Registro:</b> <g:formatDate format="dd MMMM yyyy" date="${otorgamientoDePoderInstance?.registroDeLaSolicitud}"  /></span>
            </span>
        </td>
    </tr>    
    <tr bgcolor="#CAC8C7">
        <td style="text-align: center">
            <span style="font-family: sans-serif;font-size: 15px;">
                </br>
                <b>Datos del  Solicitante</b>
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
                                        ${otorgamientoDePoderInstance?.delegacion}
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
                <g:if test="${otorgamientoDePoderInstance?.creadaPor?.nombreDespachoExterno}">
                    <tr>
                        <td>
                            <span style="font-family: sans-serif;font-size: 13px;">
                                ${otorgamientoDePoderInstance?.creadaPor?.nombreDespachoExterno} 
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
            <span style="font-family: sans-serif;font-size: 13px;">
                ${otorgamientoDePoderInstance?.id}-O
            </span>
        </td>

    </tr>
    <tr>
        <td bgcolor="#E7EBEB">
            <span style="font-family: sans-serif;font-size: 13px;">
                <b>N&uacute;mero de Folio</b>
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
                                    ${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.detalles}
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
    <tr><td></br></td></tr>    
    <tr>
        <td>
            <table style="height: 100%; width: 100%;border-collapse: collapse" border="1">
                <g:if test="${otorgamientoDePoderInstance?.poderSolicitado}">
                    <tr>
                        <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                <b>Facultades</b>
                            </span>
                        </td>                    
                        <td style="width:70%;text-align: left">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                &nbsp;&nbsp;&nbsp;${otorgamientoDePoderInstance?.poderSolicitado}
                            </span>
                        </td>
                    </tr>
                </g:if>
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <b>Motivo de Ortorgamiento</b>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            &nbsp;&nbsp;&nbsp;${otorgamientoDePoderInstance?.motivoDeOtorgamiento}
                        </span>
                    </td>
                </tr>                
                <tr>
                    <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <b>Gestor</b>
                        </span>
                    </td>                    
                    <td style="width:60%;text-align: left">
                        <span style="font-family: sans-serif;font-size: 13px;">                            
                            &nbsp;&nbsp;&nbsp;${otorgamientoDePoderInstance?.usuarioGestor}                             
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
                            <dd><b>Apoderados  </b></dd>
                        </span>
                    </td>                    
                    <td style="width:70%;text-align:left">
                        <span style="font-family: sans-serif;font-size: 13px;">
                            <g:each in="${otorgamientoDePoderInstance?.apoderados.sort{it.nombre}}" var="a">
                                <dd>  - ${a?.nombre}</dd>
                            </g:each> 
                        </span>
                    </td>                           
                </tr>
            </table>
        </td>
    </tr>
    <!--datos complementarios--> 
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_ENLACE, ROLE_PODERES_GESTOR">                        
        <g:if test="${datosNotario}">
            <tr><td></br></td></tr>
            <tr bgcolor="#CAC8C7">
                <td>
                    <span style="font-family: sans-serif;font-size: 15px;">               
                        <b>Datos del Notario Otorgante</b>
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
    <g:if test="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}">
        <tr><td></br></td></tr>
        <tr bgcolor="#CAC8C7">
            <td>
                <span style="font-family: sans-serif;font-size: 15px;">               
                    <b>Datos Complementarios</b>
                </span>
            </td>
        </tr>
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
                                <b>Fecha de Vencimiento</b>
                            </span>
                        </td>                    
                        <td style="width:70%;text-align: left">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                &nbsp;&nbsp;&nbsp;<g:formatDate format="dd-MMM-yyyy" date="${otorgamientoDePoderInstance?.fechaVencimiento}"/>
                            </span>
                        </td>                           
                    </tr>
                    <tr>
                        <td bgcolor="#E7EBEB" style="width:30%;text-align: right">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                <b>Escritura P&uacute;blica</b>
                            </span>
                        </td>                    
                        <td style="width:70%;text-align: left">
                            <span style="font-family: sans-serif;font-size: 13px;">
                                &nbsp;&nbsp;&nbsp;${otorgamientoDePoderInstance?.escrituraPublica}
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
                                &nbsp;&nbsp;&nbsp;${otorgamientoDePoderInstance?.comentarios}
                            </span>
                        </td>                           
                    </tr>
                </table>
            </td>
        </tr>
    </g:if>
</table>