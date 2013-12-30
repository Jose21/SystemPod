
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Poderes')}" />    
        <title>Expedientes</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Poderes</h1>
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
                            <span class="bigger-110">Asignados <span class="badge">${poderesAsignadosInstanceTotal}</span></span>
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
                        <div class="message-list-container">
                            <div class="message-list" id="message-list">
                                <g:each in="${otorgamientoInstanceList}" status="i" var="otorgamientoInstance">
                                    <div class="message-item message-unread">
                                        <g:if test="${otorgamientoInstance.asignar == null}">
                                            <i class=" icon-exclamation-sign red" title="Sin Asignar"></i>   
                                        </g:if>
                                        <g:else>  
                                            <i class=" icon-check-empty light-grey" title="No Atendido"></i>        
                                        </g:else>
                                        <span class="sender" title="Folio del Expediente">
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${otorgamientoInstance?.id}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Nombre del Expediente">
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                <span class="text">
                                                    ${otorgamientoInstance?.nombre}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Solicitado Por">
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance?.id}">
                                                <span class="text">
                                                    ${otorgamientoInstance?.solicitadoPor}
                                                </span>
                                            </g:link>
                                        </span>
                                    </div>
                                </g:each>
                            </div>
                        </div><!--/.message-list-container-->
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
                        <div class="message-list-container">
                            <div class="message-list" id="message-list">
                                <g:each in="${revocacionInstanceList}" status="i" var="revocacionInstance">
                                    <div class="message-item message-unread">
                                        <g:if test="${revocacionInstance.asignar == null}">
                                            <i class=" icon-exclamation-sign red" title="Sin Asignar"></i>   
                                        </g:if>
                                        <g:else>  
                                            <i class=" icon-check-empty light-grey" title="No Atendido"></i>        
                                        </g:else>
                                        <span class="sender" title="Folio del Expediente">
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${revocacionInstance?.id}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Nombre del Expediente">
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance?.id}">
                                                <span class="text">
                                                    ${revocacionInstance?.nombre}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Solicitado Por">
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance?.id}">
                                                <span class="text">
                                                    ${revocacionInstance?.solicitadoPor}
                                                </span>
                                            </g:link>
                                        </span>
                                    </div>
                                </g:each>
                            </div>
                        </div><!--/.message-list-container-->

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
                        <div class="message-list-container">
                            <div class="message-list" id="message-list">
                                <g:each in="${otorgamientoAsignadosInstanceList}" status="i" var="otorgamientoAsignadosInstance">
                                    <div class="message-item message-unread">
                                        <span class="sender" title="Folio del Expediente">
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosInstance?.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${otorgamientoAsignadosInstance?.id}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Nombre del Expediente">
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosInstance?.id}">
                                                <span class="text">
                                                    ${otorgamientoAsignadosInstance?.nombre}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Solicitado Por">
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosInstance?.id}">
                                                <span class="text">
                                                    ${otorgamientoAsignadosInstance?.solicitadoPor}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Asignado A">
                                            <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoAsignadosInstance?.id}">
                                                <span class="text">
                                                    ${otorgamientoAsignadosInstance?.asignar}
                                                </span>
                                            </g:link>
                                        </span>
                                    </div>
                                </g:each>
                            </div>
                        </div><!--/.message-list-container-->
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
                        <div class="message-list-container">
                            <div class="message-list" id="message-list">
                                <g:each in="${revocacionAsignadosInstanceList}" status="i" var="revocacionAsignadosInstance">
                                    <div class="message-item message-unread">
                                        <span class="sender" title="Folio del Expediente">
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosInstance.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${revocacionAsignadosInstance?.id}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Nombre del Expediente">
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosInstance?.id}">
                                                <span class="text">
                                                    ${revocacionAsignadosInstance?.nombre}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Solicitado Por">
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosInstance?.id}">
                                                <span class="text">
                                                    ${revocacionAsignadosInstance?.solicitadoPor}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="sender" title="Asignado A">
                                            <g:link controller="revocacionDePoder" action="show" id="${revocacionAsignadosInstance?.id}">
                                                <span class="text">
                                                    ${revocacionAsignadosInstance?.asignar}
                                                </span>
                                            </g:link>
                                        </span>
                                    </div>
                                </g:each>
                            </div>
                        </div><!--/.message-list-container-->
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
