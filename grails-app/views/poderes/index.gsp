
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
        <div class="container-fluid">      
            <g:render template="/shared/alerts" />
            <br/>
            <div class="tabbable">
                <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                    <li class="active">
                        <a data-toggle="tab" href="#inbox">
                            <i class="blue icon-inbox bigger-130"></i>
                            <span class="bigger-110">Pendientes <span class="badge">${poderInstanceTotal}</span></span>
                        </a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#shared">
                            <i class="icon-group bigger-130"></i>
                            <span class="bigger-110">Turnados <span class="badge">${poderesAsignadosInstanceTotal}</span></span>
                        </a>
                    </li>
                </ul>
            </div>
            <!--PENDIENTES-->
            <div class="tab-content no-border no-padding">
                <div id="inbox" class="tab-pane in active">  
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
                                    <th scope="col"></th>
                                    <th scope="col">Número de Folio</th>
                                    <th scope="col">Nombre del Apoderado</th>
                                    <th scope="col">Solicitado Por</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${otorgamientoInstanceList}" status="i" var="otorgamientoInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
                                            <g:if test="${otorgamientoInstance.asignar == null}">
                                                <i class=" icon-exclamation-sign orange" title="Sin Asignar"></i>   
                                            </g:if>
                                            <g:else>  
                                                <i class=" icon-exclamation-sign red" title="No Atendido"></i>        
                                            </g:else>
                                        </td>
                                        <td>
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                <span class="label label-info arrowed-in">
                                                    ${otorgamientoInstance?.id}-O
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: otorgamientoInstance, field: "apoderados.nombre")}</td>
                                        <td>${fieldValue(bean: otorgamientoInstance, field: "solicitadoPor")}</td>
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
                                    <th scope="col"></th>
                                    <th scope="col">Número de Folio</th>
                                    <th scope="col">Nombre del Apoderado</th>
                                    <th scope="col">Solicitado Por</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${revocacionInstanceList}" status="i" var="revocacionInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
                                            <g:if test="${revocacionInstance.asignar == null}">
                                                <i class=" icon-exclamation-sign orange" title="Sin Asignar"></i>   
                                            </g:if>
                                            <g:else>  
                                                <i class=" icon-exclamation-sign red" title="No Atendido"></i>        
                                            </g:else>
                                        </td>
                                        <td>
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance?.id}">
                                                <span class="label label-info arrowed-in">
                                                    ${revocacionInstance?.id}-R
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: revocacionInstance, field: "apoderados.nombre")}</td>
                                        <td>${fieldValue(bean: revocacionInstance, field: "solicitadoPor")}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>        

                        <div class="message-footer clearfix">
                            <div class="pull-left"> ${poderInstanceTotal} expediente(s) en total. </div>
                            <div class="pull-right">
                                <div class="pagination">
                                    <g:paginate total="${poderInstanceTotal}" />
                                </div>
                            </div>
                        </div>
                    </div><!--/.message-container-->
                </div>
                                      <!-- PODERES QUE ME ASIGNARON  -->
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
                                    <th scope="col">Número de Folio</th>
                                    <th scope="col">Nombre del Apoderado</th>
                                    <th scope="col">Solicitado Por</th>
                                    <th scope="col">Asignado a</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${otorgamientoAsignadosInstanceList}" status="i" var="otorgamientoAsignadosInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">                                       
                                        <td>
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosInstance?.id}">
                                                <span class="label label-info arrowed-in">
                                                    ${otorgamientoAsignadosInstance?.id}-O
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: otorgamientoAsignadosInstance, field: "apoderados.nombre")}</td>
                                        <td>${fieldValue(bean: otorgamientoAsignadosInstance, field: "solicitadoPor")}</td>
                                        <td>${fieldValue(bean: otorgamientoAsignadosInstance, field: "asignar")}</td>
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
                        <!--Se iteran las revocaciones de poder asiganados-->
                        <table class="box-style" width="100%" border="2">
                            <thead>
                                <tr>
                                    <th scope="col">Número de Folio</th>
                                    <th scope="col">Nombre del Apoderado</th>
                                    <th scope="col">Solicitado Por</th>
                                    <th scope="col">Asignado a</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${revocacionAsignadosInstanceList}" status="i" var="revocacionAsignadosInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">                                       
                                        <td>
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosInstance?.id}">
                                                <span class="label label-info arrowed-in">
                                                    ${revocacionAsignadosInstance?.id}-R
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: revocacionAsignadosInstance, field: "apoderados.nombre")}</td>
                                        <td>${fieldValue(bean: revocacionAsignadosInstance, field: "solicitadoPor")}</td>
                                        <td>${fieldValue(bean: revocacionAsignadosInstance, field: "asignar")}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                        <div class="message-footer clearfix">
                            <div class="pull-left"> ${poderesAsignadosInstanceTotal} expediente(s) en total. </div>
                            <div class="pull-right">
                                <div class="pagination">
                                    <g:paginate total="${poderesAsignadosInstanceTotal}" />
                                </div>
                            </div>
                        </div>
                    </div><!--/.message-container-->
                </div>          
            </div>
        </div>
    </body>
</html>
