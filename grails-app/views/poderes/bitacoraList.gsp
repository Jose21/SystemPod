
<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Poderes')}" />    
        <title>Bitacora</title>
    </head>
    <body>
        <div class="tabbable">
            <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">

                <li class="active">
                    <a data-toggle="tab" href="#otorgamientos">
                        <i class="blue icon-inbox bigger-130"></i>
                        <span class="bigger-110">Otorgamiento De Poder <span class="badge">${otorgamientoDePoderInstanceTotal}</span></span>
                    </a>
                </li>                                        
                <li>
                    <a data-toggle="tab" href="#revocaciones">
                        <i class="icon-group bigger-130"></i>
                        <span class="bigger-110">Revocaciones De Poder <span class="badge">${revocacionDePoderInstanceTotal}</span></span>
                    </a>
                </li>                                                                                                                                                               
            </ul>
        </div>
        <div class="tab-content no-border no-padding">
            <div id="otorgamientos" class="tab-pane in active">  
                <div class="message-container">
                    <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                        <div class="message-bar">
                            <div class="message-infobar" id="id-message-infobar">
                                <span class="blue bigger-130">
                                    Bitacora: Expedientes Otorgamiento de Poder.
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="widget-content nopadding">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <g:sortableColumn property="id" title="${message(code: 'otorgamientoDePoder.id.label', default: 'Número de Folio')}" />
                                    
                                    <g:sortableColumn property="fechaDeCreacion" title="${message(code: 'otorgamientoDePoder.registroDeLaSolicitud.label', default: 'Fecha De Creacion')}" />

                                    <g:sortableColumn property="fechaDeEnvio" title="${message(code: 'otorgamientoDePoder.bitacora.fechaDeEnvio.label', default: 'Fecha De Envio')}" />

                                    <g:sortableColumn property="fechaDeVencimiento" title="${message(code: 'otorgamientoDePoder.bitacora.fechaDeVencimiento.label', default: 'Fecha De Vencimiento')}" />

                                    <g:sortableColumn property="fechaFactura" title="${message(code: 'otorgamientoDePoder.bitacora.fechaFactura.label', default: 'Fecha Factura')}" />

                                    <g:sortableColumn property="fechaOtorgamientoRevocacion" title="${message(code: 'otorgamientoDePoder.bitacora.fechaOtorgamientoRevocacion.label', default: 'Fecha Otorgamiento Revocacion')}" />

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${otorgamientoDePoderInstanceList}" status="i" var="otorgamientoInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        
                                        <td class="center">                                            
                                            <span class="label label-info arrowed-in">
                                                ${otorgamientoInstance?.id}-O
                                            </span>                                            
                                        </td>
                                       
                                        <td><g:formatDate date="${otorgamientoInstance?.registroDeLaSolicitud}" /></td>

                                        <td><g:formatDate date="${otorgamientoInstance?.bitacora?.fechaDeEnvio}" /></td>

                                        <td><g:formatDate date="${otorgamientoInstance?.bitacora?.fechaDeVencimiento}" /></td>

                                        <td><g:formatDate date="${otorgamientoInstance?.bitacora?.fechaFactura}" /></td>

                                        <td><g:formatDate date="${otorgamientoInstance?.bitacora?.fechaOtorgamientoRevocacion}" /></td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>        
                    <div class="pagination pull-right no-margin">
                        <g:paginate total="${otorgamientoDePoderInstanceTotal}" />
                    </div>
                </div>
            </div>
            <div id="revocaciones" class="tab-pane">  
                <div class="message-container">
                    <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                        <div class="message-bar">
                            <div class="message-infobar" id="id-message-infobar">
                                <span class="blue bigger-130">
                                    Bitacora: Expedientes Revocacion de Poder.
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="widget-content nopadding">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>

                                    <g:sortableColumn property="id" title="${message(code: 'revocacionDePoder.id.label', default: 'Número de Folio')}" />

                                    <g:sortableColumn property="fechaDeCreacion" title="${message(code: 'revocacionDePoder.fechaDeCreacion.label', default: 'Fecha De Revocacion')}" />

                                    <g:sortableColumn property="fechaDeEnvio" title="${message(code: 'revocacionDePoder.fechaDeEnvio.label', default: 'Fecha De Envio')}" />

                                    <g:sortableColumn property="fechaDeVencimiento" title="${message(code: 'revocacionDePoder.fechaDeVencimiento.label', default: 'Fecha De Vencimiento')}" />

                                    <g:sortableColumn property="fechaFactura" title="${message(code: 'revocacionDePoder.fechaFactura.label', default: 'Fecha Factura')}" />

                                    <g:sortableColumn property="fechaOtorgamientoRevocacion" title="${message(code: 'revocacionDePoder.fechaOtorgamientoRevocacion.label', default: 'Fecha Otorgamiento Revocacion')}" />

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${revocacionDePoderInstanceList}" status="i" var="revocacionInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                        <td class="center">                                            
                                            <span class="label label-info arrowed-in">
                                                ${revocacionInstance?.id}-R
                                            </span>                                            
                                        </td>

                                        <td><g:formatDate date="${revocacionInstance?.fechaDeRevocacion}" /></td>

                                        <td><g:formatDate date="${revocacionInstance.bitacora?.fechaDeEnvio}" /></td>

                                        <td><g:formatDate date="${revocacionInstance.bitacora?.fechaDeVencimiento}" /></td>

                                        <td><g:formatDate date="${revocacionInstance.bitacora?.fechaFactura}" /></td>

                                        <td><g:formatDate date="${revocacionInstance.bitacora?.fechaOtorgamientoRevocacion}" /></td>

                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>        
                    <div class="pagination pull-right no-margin">
                        <g:paginate total="${revocacionDePoderInstanceTotal}" />
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
