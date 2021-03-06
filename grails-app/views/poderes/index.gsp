
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Poderes')}" />    
        <title>Expedientes</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Bandeja Principal</h1>
        </div><!--/.page-header-->             
        <g:render template="/shared/alerts" />
        <br/>        
        <div class="tabbable">
            <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_GESTOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_PODERES_RESOLVEDOR, ROLE_GESTOR_EXTERNO, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                    <g:if test="${isFacturas == false}">
                        <li class="active">
                            <a data-toggle="tab" href="#inbox">
                                <i class="blue icon-inbox bigger-130"></i>
                                <span class="bigger-110">Pendientes <span class="badge">${poderInstanceTotal}</span></span>
                            </a>
                        </li>
                    </g:if>
                    <g:else>
                        <li>
                            <a data-toggle="tab" href="#inbox">
                                <i class="blue icon-inbox bigger-130"></i>
                                <span class="bigger-110">Pendientes <span class="badge">${poderInstanceTotal}</span></span>
                            </a>
                        </li>
                    </g:else>

                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_GESTOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_GESTOR_EXTERNO, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                    <li>
                        <a data-toggle="tab" href="#shared">
                            <i class="icon-group bigger-130"></i>
                            <span class="bigger-110">Enviados <span class="badge">${poderesAsignadosInstanceTotal}</span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">                    
                    <li>
                        <a data-toggle="tab" href="#enviadoNotario">
                            <i class="icon-exchange bigger-130"></i>
                            <span class="bigger-110">Enviados al Notario <span class="badge">${enviadosNotarioTotal}</span></span>
                        </a>
                    </li>                    
                    <li>
                        <a data-toggle="tab" href="#expired">
                            <i class="icon-info-sign bigger-130"></i>
                            <span class="bigger-110">Poderes por Vencer <span class="badge">${poderesPorVencerTotal}</span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_GESTOR, ROLE_GESTOR_EXTERNO">
                    <li>
                        <a data-toggle="tab" href="#enviadoSolicitante">
                            <i class="icon-exchange bigger-130"></i>
                            <span class="bigger-110">Enviados al Solicitante <span class="badge">${enviadosSolicitanteTotal}</span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ENLACE">                                      
                    <li class="active">
                        <a data-toggle="tab" href="#expired">
                            <i class="icon-info-sign bigger-130"></i>
                            <span class="bigger-110">Poderes por Vencer <span class="badge">${poderesPorVencerTotal}</span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>                
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">                    
                    <li>
                        <a data-toggle="tab" href="#prorroga">
                            <i class="icon-calendar bigger-130"></i>
                            <span class="bigger-110">Prorrogas <span class="badge">${prorrogaListTotal}</span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_NOTARIO, ROLE_PODERES_RESOLVEDOR, ROLE_FACTURAS">
                    <g:if test="${isFacturas == true}">
                        <li class="active">
                            <a data-toggle="tab" href="#facturas">
                                <i class="icon-inbox bigger-130"></i>
                                <span class="bigger-110">Facturas Pendientes <span class="badge">${facturaListTotal}</span></span>
                            </a>
                        </li>
                    </g:if>
                    <g:else>
                        <li>
                            <a data-toggle="tab" href="#facturas">
                                <i class="icon-inbox bigger-130"></i>
                                <span class="bigger-110">Facturas Pendientes <span class="badge">${facturaListTotal}</span></span>
                            </a>
                        </li>
                    </g:else>
                    <li>
                        <a data-toggle="tab" href="#facturasEnviadas">
                            <i class="icon-arrow-right bigger-130"></i>
                            <span class="bigger-110">Facturas Enviadas <span class="badge">${facturasEnviadasTotal}</span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_NOTARIO, ROLE_PODERES_RESOLVEDOR">
                    <li>
                        <a data-toggle="tab" href="#proyectos">
                            <i class="icon-arrow-right bigger-130"></i>
                            <span class="bigger-110">Carta de Instrucción<span class="badge">${proyectosTotal}</span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>
            </ul>
        </div>
        <!--PENDIENTES-->
        <div class="tab-content no-border no-padding">
            <g:if test="${isFacturas == false && isEnlace == false}">
                <div id="inbox" class="tab-pane in active">
                </g:if>
                <g:else>
                    <div id="inbox" class="tab-pane">
                    </g:else>
                    <div class="message-container">
                        <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar">
                                    <span class="blue bigger-130">
                                        Expedientes: Otorgamiento de Poder.
                                    </span>
                                </div>
                            </div>
                        </div>
                        <!--Se iteran los otorgamientos de poder-->
                        <table class="box-style" width="100%" border="2">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th scope="col">Número de Solicitud</th>
                                    <th scope="col">Asignado Por</th>
                                    <th scope="col">Creado Por</th>
                                    <th scope="col">Fecha de Envío</th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:form method="post">
                                    <g:each in="${otorgamientosRojosList.sort{it.id}}" status="i" var="otorgamientoInstance">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td>
                                                <g:if test="${otorgamientoInstance.notas}">
                                                    <i class=" icon-exclamation-sign red"></i>   
                                                </g:if>                                            
                                            </td>
                                            <td>
                                                <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                    <span class="label label-important arrowed-in">
                                                        ${otorgamientoInstance?.id}-O
                                                    </span>
                                                </g:link>
                                            </td>
                                            <td>${fieldValue(bean: otorgamientoInstance, field: "asignadaPor")}</td>
                                            <td>${fieldValue(bean: otorgamientoInstance, field: "creadaPor")}</td>                                        
                                            <td><g:formatDate date="${otorgamientoInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                                        <g:if test="${(otorgamientoInstance.voBoDocumentoFisico == true || otorgamientoInstance.tareas) || (solicitudExterno == true)}">
                                            <td>
                                                <a><g:link class="icon-archive bigger-140 red" controller="otorgamientoDePoder" action="ocultarPorSolicitante" id="${otorgamientoInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>                            
                                <g:each in="${otorgamientosAmarillosList.sort{it.id}}" status="i" var="otorgamientoInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
                                            <g:if test="${otorgamientoInstance.notas}">
                                                <i class=" icon-exclamation-sign red"></i>   
                                            </g:if>                                            
                                        </td>
                                        <td>
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                <span class="label label-warning arrowed-in">
                                                    ${otorgamientoInstance?.id}-O
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: otorgamientoInstance, field: "asignadaPor")}</td>
                                        <td>${fieldValue(bean: otorgamientoInstance, field: "creadaPor")}</td>                                        
                                        <td><g:formatDate date="${otorgamientoInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                                        <g:if test="${otorgamientoInstance.voBoDocumentoFisico == true || solicitudExterno == true}">
                                            <td>
                                                <a><g:link class="icon-archive bigger-140 red" controller="otorgamientoDePoder" action="ocultarPorSolicitante" id="${otorgamientoInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>
                                <g:each in="${otorgamientosVerdesList.sort{it.id}}" status="i" var="otorgamientoInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
                                            <g:if test="${otorgamientoInstance.notas}">
                                                <i class=" icon-exclamation-sign red"></i>   
                                            </g:if>                                            
                                        </td>
                                        <td>
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${otorgamientoInstance?.id}-O
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: otorgamientoInstance, field: "asignadaPor")}</td>
                                        <td>${fieldValue(bean: otorgamientoInstance, field: "creadaPor")}</td>                                        
                                        <td><g:formatDate date="${otorgamientoInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                                        <g:if test="${(otorgamientoInstance.voBoDocumentoFisico == true || otorgamientoInstance.tareas) || (solicitudExterno == true)}">
                                            <td>                                                
                                                <a><g:link class="icon-archive bigger-140 red" controller="otorgamientoDePoder" action="ocultarPorSolicitante" id="${otorgamientoInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>
                            </g:form>
                            <g:each in="${otorgamientosNoAsignadosList.sort{it.id}}" status="i" var="otorgamientoInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>
                                        <g:if test="${otorgamientoInstance.notas}">
                                            <i class=" icon-exclamation-sign red"></i>   
                                        </g:if>                                            
                                    </td>
                                    <td>
                                        <g:link controller="otorgamientoDePoder" action="edit" id="${otorgamientoInstance?.id}">
                                            <span class="label label-light arrowed-in">
                                                ${otorgamientoInstance?.id}-O
                                            </span>
                                        </g:link>
                                    </td>
                                    <td>${fieldValue(bean: otorgamientoInstance, field: "asignadaPor")}</td>
                                    <td>${fieldValue(bean: otorgamientoInstance, field: "creadaPor")}</td>                                        
                                    <td><g:formatDate date="${otorgamientoInstance?.fechaDeEnvio}" /></td>                                        
                                </tr>
                            </g:each>
                            </tbody>
                        </table>                    
                        <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar">
                                    <span class="blue bigger-130">
                                        Expedientes: Revocación de Poder.
                                    </span>
                                </div>
                            </div>
                        </div>
                        <!--Se iteran las revocaciones de poder-->
                        <table class="box-style" width="100%" border="2">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th scope="col">Número de Solicitud</th>
                                    <th scope="col">Asignado Por</th>
                                    <th scope="col">Creada Por</th>
                                    <th scope="col">Fecha de Envío</th>
                                    <th scope="col"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:form method="post">
                                    <g:each in="${revocacionesRojosList.sort{it.id}}" status="i" var="revocacionInstance">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td></td>
                                            <td>
                                                <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance?.id}">
                                                    <span class="label label-danger arrowed-in">
                                                        ${revocacionInstance?.id}-R
                                                    </span>
                                                </g:link>
                                            </td>
                                            <td>${fieldValue(bean: revocacionInstance, field: "asignadaPor")}</td>
                                            <td>${fieldValue(bean: revocacionInstance, field: "creadaPor")}</td>
                                            <td><g:formatDate date="${revocacionInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                                        <g:if test="${revocacionInstance.escrituraPublicaRevocacion}">
                                            <td>
                                                <a><g:link class="icon-archive bigger-140 red" controller="revocacionDePoder" action="ocultarPorSolicitante" id="${revocacionInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>                                                      
                                <g:each in="${revocacionesAmarillosList.sort{it.id}}" status="i" var="revocacionInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td></td>
                                        <td>
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance?.id}">
                                                <span class="label label-warning arrowed-in">
                                                    ${revocacionInstance?.id}-R
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: revocacionInstance, field: "asignadaPor")}</td>
                                        <td>${fieldValue(bean: revocacionInstance, field: "creadaPor")}</td>
                                        <td><g:formatDate date="${revocacionInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                                        <g:if test="${revocacionInstance.escrituraPublicaRevocacion}">
                                            <td>
                                                <a><g:link class="icon-archive bigger-140 red" controller="revocacionDePoder" action="ocultarPorSolicitante" id="${revocacionInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>
                                <g:each in="${revocacionesVerdesList.sort{it.id}}" status="i" var="revocacionInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td></td>
                                        <td>
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance?.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${revocacionInstance?.id}-R
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: revocacionInstance, field: "asignadaPor")}</td>
                                        <td>${fieldValue(bean: revocacionInstance, field: "creadaPor")}</td>
                                        <td><g:formatDate date="${revocacionInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                                        <g:if test="${revocacionInstance.escrituraPublicaRevocacion}">
                                            <td>                                                
                                                <a><g:link class="icon-archive bigger-140 red" controller="revocacionDePoder" action="ocultarPorSolicitante" id="${revocacionInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>
                            </g:form>  
                            <g:each in="${revocacionesNoAsignadosList.sort{it.id}}" status="i" var="revocacionInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td></td>
                                    <td>
                                        <g:link controller="revocacionDePoder" action="edit" id="${revocacionInstance?.id}">
                                            <span class="label label-light arrowed-in">
                                                ${revocacionInstance?.id}-R
                                            </span>
                                        </g:link>
                                    </td>
                                    <td>${fieldValue(bean: revocacionInstance, field: "asignadaPor")}</td>
                                    <td>${fieldValue(bean: revocacionInstance, field: "creadaPor")}</td>
                                    <td><g:formatDate date="${revocacionInstance?.fechaDeEnvio}" /></td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>        

                        <div class="message-footer clearfix">
                            <div class="pull-left"> ${poderInstanceTotal} expediente(s) en total. </div>                            
                        </div>                    
                    </div><!--/.message-container-->
                </div>
                                      <!-- SOLICITUDES QUE ENVIE  -->
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_GESTOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_GESTOR_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">    
                    <div id="shared" class="tab-pane">
                        <div class="message-container">
                            <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                <div class="message-bar">
                                    <div class="message-infobar" id="id-message-infobar">
                                        <span class="blue bigger-130">
                                            Expedientes: Otorgamiento de Poder.
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <!--Se iteran los otorgamientos de poder asigandos-->
                            <table class="box-style" width="100%" border="2">
                                <thead>
                                    <tr>
                                        <th></th>                                    
                                        <th scope="col">Número de Solicitud</th>                                    
                                        <th scope="col">Creada Por</th>
                                        <th scope="col">Enviado a</th>
                                        <th scope="col">Fecha de Envío</th>
                                        <th scope="col" align="center"></th> 
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${otorgamientoAsignadosInstanceList.sort{it.id}}" status="i" var="otorgamientoAsignadosInstance">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td></td>
                                            <td>
                                                <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosInstance?.id}">
                                                    <span class="label label-info arrowed-in">
                                                        ${otorgamientoAsignadosInstance?.id}-O
                                                    </span>
                                                </g:link>
                                            </td>                                        
                                            <td>${fieldValue(bean: otorgamientoAsignadosInstance, field: "creadaPor")}</td>
                                            <td>${fieldValue(bean: otorgamientoAsignadosInstance, field: "asignar")}</td>
                                            <td><g:formatDate date="${otorgamientoAsignadosInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_GESTOR_EXTERNO">
                                        <g:if test="${otorgamientoAsignadosInstance?.documentos}">
                                            <td>                                                    
                                                <a><g:link class="icon-archive bigger-140 red" controller="otorgamientoDePoder" action="ocultarPorResolvedor" id="${otorgamientoAsignadosInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                            <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                <div class="message-bar">
                                    <div class="message-infobar" id="id-message-infobar">
                                        <span class="blue bigger-130">
                                            Expedientes: Revocación de Poder.
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <!--Se iteran las revocaciones de poder asignados-->
                            <table class="box-style" width="100%" border="2">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th scope="col">Número de Solicitud</th>                                    
                                        <th scope="col">Creada Por</th>
                                        <th scope="col">Enviado a</th>
                                        <th scope="col">Fecha de Envío</th>
                                        <th scope="col" align="center"></th> 
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:each in="${revocacionAsignadosInstanceList.sort{it.id}}" status="i" var="revocacionAsignadosInstance">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td></td>
                                            <td>
                                                <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosInstance?.id}">
                                                    <span class="label label-info arrowed-in">
                                                        ${revocacionAsignadosInstance?.id}-R
                                                    </span>
                                                </g:link>
                                            </td>                                        
                                            <td>${fieldValue(bean: revocacionAsignadosInstance, field: "creadaPor")}</td>
                                            <td>${fieldValue(bean: revocacionAsignadosInstance, field: "asignar")}</td>
                                            <td><g:formatDate date="${revocacionAsignadosInstance?.fechaDeEnvio}" /></td>
                                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_GESTOR_EXTERNO">
                                        <g:if test="${revocacionAsignadosInstance?.notas}">
                                            <td>                                                    
                                                <a><g:link class="icon-archive bigger-140 red" controller="otorgamientoDePoder" action="ocultarPorResolvedor" id="${revocacionAsignadosInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                            </td>
                                        </g:if>
                                    </sec:ifAnyGranted>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                            <div class="message-footer clearfix">
                                <div class="pull-left"> ${poderesAsignadosInstanceTotal} expediente(s) en total. </div>                                
                            </div>
                        </div><!--/.message-container-->
                    </div>
                </sec:ifAnyGranted>
                <!--Bandeja de Poderes por vencer -->
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_ENLACE">
                    <g:if test="${isEnlace == true}">
                        <div id="expired" class="tab-pane in active">
                        </g:if>
                        <g:else>
                            <div id="expired" class="tab-pane">
                            </g:else>                    
                            <div class="message-container">
                                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                    <div class="message-bar">
                                        <div class="message-infobar" id="id-message-infobar">
                                            <span class="blue bigger-130">
                                                Poderes por Vencer.
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <table class="box-style" width="100%" border="2">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th scope="col"></th>
                                            <th scope="col">Número de Solicitud</th>
                                            <th scope="col">Escritura Pública</th>
                                            <th scope="col">Creado Por</th>
                                            <th scope="col" align="center">Fecha de Vencimiento</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!--Se iteran los poderes criticos de poder-->
                                        <g:each in="${poderCriticoInstanceList.sort{it.fechaDeOtorgamiento}}" status="i" var="otorgamientoInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <span class="label label-important arrowed-in">Critico</span>
                                                </td>
                                                <td>
                                                    <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${otorgamientoInstance?.id}-O
                                                        </span>
                                                    </g:link>
                                                </td> 
                                                <td>${fieldValue(bean: otorgamientoInstance, field: "escrituraPublica")}</td>
                                                <td>${fieldValue(bean: otorgamientoInstance, field: "creadaPor")}</td>
                                                <td align="center"><g:formatDate format="dd-MMM-yyyy" date="${otorgamientoInstance?.fechaVencimiento}" style="MEDIUM"/></td>
                                            </tr>
                                        </g:each>
                                        <!--Se iteran los poderes semi-criticos de poder-->
                                        <g:each in="${poderSemicriticoInstanceList.sort{it.fechaDeOtorgamiento}}" status="i" var="otorgamientoInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <span class="label label-warning">Semi-Critico</span>
                                                </td>
                                                <td>
                                                    <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${otorgamientoInstance?.id}-O
                                                        </span>
                                                    </g:link>
                                                </td> 
                                                <td>${fieldValue(bean: otorgamientoInstance, field: "escrituraPublica")}</td>
                                                <td>${fieldValue(bean: otorgamientoInstance, field: "creadaPor")}</td>
                                                <td align="center"><g:formatDate format="dd-MMM-yyyy" date="${otorgamientoInstance?.fechaVencimiento}" style="MEDIUM" /></td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>                                                                       
                                <div class="message-footer clearfix">
                                    <div class="pull-left"> ${poderesPorVencerTotal} expediente(s) en total. </div>                                    
                                </div>
                            </div><!--/.message-container-->
                        </div>                
                        <!-- SOLICITUDES QUE ENVIO USUARIO RESOLVEDOR AL NOTARIO  -->
                        <div id="enviadoNotario" class="tab-pane">
                            <div class="message-container">
                                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                    <div class="message-bar">
                                        <div class="message-infobar" id="id-message-infobar">
                                            <span class="blue bigger-130">
                                                Expedientes: Otorgamiento de Poder.
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <!--Se iteran los otorgamientos de poder enviados al notario-->
                                <table class="box-style" width="100%" border="2">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th scope="col">Número de Solicitud</th>                                    
                                            <th scope="col">Creada Por</th>
                                            <th scope="col">Enviado a</th>
                                            <th scope="col">Fecha de Envío</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${otorgamientosEnviadosNotarioInstanceList.sort{it.id}}" status="i" var="otorgamientoAsignadosNotarioInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosNotarioInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${otorgamientoAsignadosNotarioInstance?.id}-O
                                                        </span>
                                                    </g:link>
                                                </td>                                        
                                                <td>${fieldValue(bean: otorgamientoAsignadosNotarioInstance, field: "creadaPor")}</td>
                                                <td>${fieldValue(bean: otorgamientoAsignadosNotarioInstance, field: "asignar")}</td>
                                                <td><g:formatDate date="${otorgamientoAsignadosNotarioInstance?.fechaDeEnvio}" /></td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
                                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                    <div class="message-bar">
                                        <div class="message-infobar" id="id-message-infobar">
                                            <span class="blue bigger-130">
                                                Expedientes: Revocación de Poder.
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <!--Se iteran las revocaciones de poder asignados-->
                                <table class="box-style" width="100%" border="2">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th scope="col">Número de Solicitud</th>                                    
                                            <th scope="col">Creada Por</th>
                                            <th scope="col">Enviado a</th>
                                            <th scope="col">Fecha de Envío</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:each in="${revocacionesEnviadosNotarioInstanceList.sort{it.id}}" status="i" var="revocacionAsignadosSolicitanteInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosSolicitanteInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${revocacionAsignadosSolicitanteInstance?.id}-R
                                                        </span>
                                                    </g:link>
                                                </td>                                        
                                                <td>${fieldValue(bean: revocacionAsignadosSolicitanteInstance, field: "creadaPor")}</td>
                                                <td>${fieldValue(bean: revocacionAsignadosSolicitanteInstance, field: "asignar")}</td>
                                                <td><g:formatDate date="${revocacionAsignadosSolicitanteInstance?.fechaDeEnvio}" /></td>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
                                <div class="message-footer clearfix">
                                    <div class="pull-left"> ${enviadosNotarioTotal} expediente(s) en total. </div>                                    
                                </div>
                            </div><!--/.message-container-->
                        </div>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_GESTOR, ROLE_GESTOR_EXTERNO">
                <!-- SOLICITUDES QUE ENVIO USUARIO RESOLVEDOR AL SOLICITANTE  -->
                    <div id="enviadoSolicitante" class="tab-pane">
                        <div class="message-container">
                            <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                <div class="message-bar">
                                    <div class="message-infobar" id="id-message-infobar">
                                        <span class="blue bigger-130">
                                            Expedientes: Otorgamiento de Poder.
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <!--Se iteran los otorgamientos de poder enviados al solicitante-->
                            <table class="box-style" width="100%" border="2">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th scope="col">Número de Solicitud</th>                                    
                                        <th scope="col">Creada Por</th>
                                        <th scope="col">Enviado a</th>
                                        <th scope="col">Fecha de Envío</th>                                    
                                        <th scope="col" align="center">Copia Electronica</th>                                    
                                        <th scope="col" align="center">Documento Físico</th> 
                                        <th scope="col" align="center"></th> 
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:form method="post">
                                        <g:each in="${otorgamientosEnviadosSolicitanteInstanceList.sort{it.id}}" status="i" var="otorgamientoAsignadosSolicitanteInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosSolicitanteInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${otorgamientoAsignadosSolicitanteInstance?.id}-O
                                                        </span>
                                                    </g:link>
                                                </td>                                        
                                                <td>${fieldValue(bean: otorgamientoAsignadosSolicitanteInstance, field: "creadaPor")}</td>
                                                <td>${fieldValue(bean: otorgamientoAsignadosSolicitanteInstance, field: "asignar")}</td>
                                                <td><g:formatDate date="${otorgamientoAsignadosSolicitanteInstance?.fechaDeEnvio}" /></td>
                                                <td align="center">
                                                    <g:if test="${otorgamientoAsignadosSolicitanteInstance.voBoCopiaElectronica == true && otorgamientoAsignadosSolicitanteInstance.documentos}">
                                                        <i class="icon-check bigger-120"></i>   
                                                    </g:if>
                                                    <g:else>
                                                        <i class="icon-ban-circle bigger-120"></i>
                                                    </g:else>
                                                </td>
                                                <td align="center">
                                                    <g:if test="${otorgamientoAsignadosSolicitanteInstance.voBoDocumentoFisico == true && otorgamientoAsignadosSolicitanteInstance.notas}">
                                                        <i class="icon-check bigger-120"></i>   
                                                    </g:if>
                                                    <g:else>
                                                        <i class="icon-ban-circle bigger-120"></i>
                                                    </g:else>
                                                </td>
                                                <g:if test="${otorgamientoAsignadosSolicitanteInstance.voBoDocumentoFisico == true || otorgamientoAsignadosSolicitanteInstance.tareas}">
                                                    <td>                                                    
                                                        <a><g:link class="icon-archive bigger-140 red" controller="otorgamientoDePoder" action="ocultarPorResolvedor" id="${otorgamientoAsignadosSolicitanteInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                                    </td>
                                                </g:if>
                                            </tr>
                                        </g:each>
                                    </g:form>
                                </tbody>
                            </table>
                            <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                <div class="message-bar">
                                    <div class="message-infobar" id="id-message-infobar">
                                        <span class="blue bigger-130">
                                            Expedientes: Revocación de Poder.
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <!--Se iteran las revocaciones de poder asignados-->
                            <table class="box-style" width="100%" border="2">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th scope="col">Número de Solicitud</th>                                    
                                        <th scope="col">Creada Por</th>
                                        <th scope="col">Enviado a</th>
                                        <th scope="col">Fecha de Envío</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:form method="post">
                                        <g:each in="${revocacionesEnviadosSolicitanteInstanceList.sort{it.id}}" status="i" var="revocacionAsignadosSolicitanteInstance">
                                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosSolicitanteInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${revocacionAsignadosSolicitanteInstance?.id}-R
                                                        </span>
                                                    </g:link>
                                                </td>                                        
                                                <td>${fieldValue(bean: revocacionAsignadosSolicitanteInstance, field: "creadaPor")}</td>
                                                <td>${fieldValue(bean: revocacionAsignadosSolicitanteInstance, field: "asignar")}</td>
                                                <td><g:formatDate date="${revocacionAsignadosSolicitanteInstance?.fechaDeEnvio}" /></td>
                                                <g:if test="${revocacionAsignadosSolicitanteInstance.escrituraPublicaRevocacion}">
                                                    <td>                                                    
                                                        <a><g:link class="icon-archive bigger-140 red" controller="revocacionDePoder" action="ocultarPorResolvedor" id="${revocacionAsignadosSolicitanteInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                                    </td>
                                                </g:if>
                                            </tr>
                                        </g:each>
                                    </g:form>
                                </tbody>
                            </table>
                            <div class="message-footer clearfix">
                                <div class="pull-left"> ${enviadosSolicitanteTotal} expediente(s) en total. </div>                                    
                            </div>
                        </div><!--/.message-container-->
                    </div>
                </sec:ifAnyGranted>
                <!-- PRORROGAS  -->
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_SOLICITANTE, ROLE_SOLICITANTE_EXTERNO, ROLE_SOLICITANTE_ESPECIAL">
                    <div id="prorroga" class="tab-pane">
                        <div class="message-container">
                            <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                <div class="message-bar">
                                    <div class="message-infobar" id="id-message-infobar">
                                        <span class="blue bigger-130">
                                            Prorrogas sobre Otorgamiento de Poder.
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <!--Se iteran los otorgamientos de poder enviados al notario-->
                            <table class="box-style" width="100%" border="2">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th scope="col">Folio</th>                                    
                                        <th scope="col">Enviado por</th>
                                        <th scope="col">Fecha de Envío</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:form method="post">
                                        <g:each in="${prorrogaList.sort{it.id}}" status="y" var="prorrogaInstance">
                                            <tr class="${(y % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <g:link controller="prorroga" action="show" id="${prorrogaInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${prorrogaInstance?.id}
                                                        </span>
                                                    </g:link>
                                                </td>                                                                                
                                                <td>${fieldValue(bean: prorrogaInstance, field: "creadoPor")}</td>
                                                <td><g:formatDate date="${prorrogaInstance?.fechaDeEnvio}" /></td>
                                                <td>                                                
                                                    <a><g:link class="icon-archive bigger-140 red" controller="prorroga" action="ocultar" id="${prorrogaInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                                </td>
                                            </tr>
                                        </g:each>
                                    </g:form>
                                </tbody>
                            </table>                                                
                            <div class="message-footer clearfix">
                                <div class="pull-left"> ${prorrogaListTotal} notificación(es) en total. </div>                                
                            </div>
                        </div><!--/.message-container-->
                    </div>
                </sec:ifAnyGranted>
                <!-- FACTURAS PENDIENTES-->
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_NOTARIO, ROLE_PODERES_RESOLVEDOR, ROLE_FACTURAS">
                    <g:if test="${isFacturas == true}">
                        <div id="facturas" class="tab-pane in active">
                        </g:if>
                        <g:else>
                            <div id="facturas" class="tab-pane">
                            </g:else>
                            <div class="message-container">                                                    
                                <table class="box-style" width="100%" border="2">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th scope="col">Folio</th>                                    
                                            <th scope="col">Enviado Por</th>                                        
                                            <th scope="col">Fecha de Envío</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:form method="post">
                                            <g:each in="${facturaList.sort{it.id}}" status="i" var="facturaInstance">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td></td>
                                                    <td>
                                                        <g:link controller="factura" action="show" id="${facturaInstance?.id}">
                                                            <span class="label label-info arrowed-in">
                                                                ${facturaInstance?.id}
                                                            </span>
                                                        </g:link>
                                                    </td>                                        
                                                    <td>${fieldValue(bean: facturaInstance, field: "asignadoPor")}</td>                                        
                                                    <td><g:formatDate date="${facturaInstance?.fechaDeEnvio}" /></td>
                                                    <g:if test="${facturaInstance.fechaDePago || facturaInstance.comentarioDeRechazo}">
                                                        <td>                                                
                                                            <a><g:link class="icon-archive bigger-140 red" controller="factura" action="ocultarPorUsuarioFacturas" id="${facturaInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                                        </td>
                                                    </g:if>
                                                </tr>                                        
                                            </g:each>
                                        </g:form>
                                    </tbody>
                                </table>                                                
                                <div class="message-footer clearfix">
                                    <div class="pull-left"> ${facturaListTotal} factura(s) en total. </div>                                    
                                </div>
                            </div><!--/.message-container-->
                        </div>
                        <!-- FACTURAS ENVIADAS-->
                        <div id="facturasEnviadas" class="tab-pane">
                            <div class="message-container">                                                    
                                <table class="box-style" width="100%" border="2">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th scope="col">Folio</th>                                    
                                            <th scope="col">Enviado A</th>                                        
                                            <th scope="col">Fecha de Envío</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <g:form method="post">
                                            <g:each in="${facturasEnviadasList.sort{it.id}}" status="i" var="facturaInstance">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                                    <td></td>
                                                    <td>
                                                        <g:link controller="factura" action="show" id="${facturaInstance?.id}">
                                                            <span class="label label-info arrowed-in">
                                                                ${facturaInstance?.id}
                                                            </span>
                                                        </g:link>
                                                    </td>                                        
                                                    <td>${fieldValue(bean: facturaInstance, field: "asignadoA")}</td>                                        
                                                    <td><g:formatDate date="${facturaInstance?.fechaDeEnvio}" /></td>
                                                    <g:if test="${facturaInstance.fechaDePago || facturaInstance.comentarioDeRechazo}">
                                                        <td>                                                
                                                            <a><g:link class="icon-archive bigger-140 red" controller="factura" action="ocultarPorResolvedor" id="${facturaInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                                        </td>
                                                    </g:if>
                                                </tr>
                                            </g:each>
                                        </g:form>
                                    </tbody>
                                </table>                                                
                                <div class="message-footer clearfix">
                                    <div class="pull-left"> ${facturasEnviadasTotal} factura(s) en total. </div>                                    
                                </div>
                            </div><!--/.message-container-->
                        </div>
                </sec:ifAnyGranted>
                <div id="proyectos" class="tab-pane">
                        <div class="message-container">
                            <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                                <div class="message-bar">
                                    <div class="message-infobar" id="id-message-infobar">
                                        <span class="blue bigger-130">
                                            Proyectos.
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <!--Se iteran los otorgamientos de poder enviados al notario-->
                            <table class="box-style" width="100%" border="2">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th scope="col">Folio</th>                                    
                                        <th scope="col">Enviado por</th>
                                        <th scope="col">Fecha de Envío</th>
                                        <th scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <g:form method="post">
                                        <g:each in="${proyectosList.sort{it.id}}" status="y" var="proyectoInstance">
                                            <tr class="${(y % 2) == 0 ? 'even' : 'odd'}">
                                                <td></td>
                                                <td>
                                                    <g:link controller="documentoDeProyecto" action="show" id="${proyectoInstance?.id}">
                                                        <span class="label label-info arrowed-in">
                                                            ${proyectoInstance?.id}
                                                        </span>
                                                    </g:link>
                                                </td>                                                                                
                                                <td>${fieldValue(bean: proyectoInstance, field: "asignadoPor")}</td>
                                                <td><g:formatDate date="${proyectoInstance?.fechaDeEnvio}" /></td>
                                                <!--td>                                                
                                                    <a><g:link class="icon-archive bigger-140 red" controller="prorroga" action="ocultar" id="${proyectoInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/> Ocultar</a>
                                                </td-->
                                            </tr>
                                        </g:each>
                                    </g:form>
                                </tbody>
                            </table>                                                
                            <div class="message-footer clearfix">
                                <div class="pull-left"> ${proyectosTotal} carta(s) de instrucción en total. </div>                                
                            </div>
                        </div><!--/.message-container-->
                    </div>
            </div>        
    </body>
</html>
