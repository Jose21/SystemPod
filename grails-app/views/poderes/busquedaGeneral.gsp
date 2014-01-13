
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Consulta ')}" />    
        <title>Consulta General</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Consulta de Otorgamiento y Revocación de Poderes</h1>
        </div><!--/.page-header-->
    <r:require module="export"/> 
    <div class="container-fluid">      
        <g:render template="/shared/alerts" />
        <br/>
        <div class="tabbable">
            <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                <li class="${nombreApoderadoActive?:""}">
                    <a data-toggle="tab" href="#nombreApoderado">
                        <i class="icon-group bigger-130"></i>
                        <span class="bigger-110">Por Nombre del Apoderado <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${solicitadoPorActive?:""}">
                    <a data-toggle="tab" href="#solicitadoPor">
                        <i class="icon-group bigger-130"></i>
                        <span class="bigger-110">Por Nombre del Solicitante <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porTagsActive?:""}">
                    <a data-toggle="tab" href="#porTags">              
                        <i class="icon-tag bigger-130"></i>
                        <span class="bigger-110">Tags<span class="badge"></span></span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <div class="tab-content no-border no-padding">
        <div id="nombreApoderado" class="tab-pane ${nombreApoderadoActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="nombreApoderado"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="nombre" class="control-label">
                                    <g:message ocode="otorgamientoDePoder.nombre.label" default="Nombre" />
                                </label>
                                <g:textField name="nombre" required="" value="${otorgamientoDePoderInstance?.nombre}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarNombreGeneral" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="solicitadoPor" class="tab-pane ${solicitadoPorActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="solicitadoPor"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="solicitadoPor" class="control-label">
                                    <g:message code="otorgamientoDePoder.solicitadoPor.label" default="Nombre" />
                                </label>
                                <g:textField name="solicitadoPor" required="" value="${otorgamientoDePoderInstance?.solicitadoPor}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorSolicitanteGeneral" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porTags" class="tab-pane ${porTagsActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porTags"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="tags" class="control-label">
                                    <g:message code="otorgamientoDePoder.tags.label" default="Palabra Clave" />
                                </label>
                                <g:textField name="tags" required="" value="${otorgamientoDePoderInstance?.tags}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorTagsGeneral" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <table class="table table-bordered table-striped">
            <thead>
                <g:if test="${params.nombre}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NOMBRE: ${params.nombre}</th>
                    </tr>
                </g:if> 
                <g:if test="${params.solicitadoPor}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NOMBRE: ${params.solicitadoPor}</th>
                    </tr>
                </g:if>
                <g:if test="${params.tags}">
                    <tr>
                        <th colspan="10" style="text-align:center;font-size:16px">RESULTADO PARA LA PALABRA: ${params.tags}</br></br></th>
                    </tr>
                </g:if>
            <th colspan="8"  style="text-align:left;font-size:14px">Otorgamiento de Poder</th>
            <tr>
                <th><g:message code="otorgamientoDePoder.id.label"  default="Número de Folio" /></th>
                <th><g:message code="otorgamientoDePoder.nombre.label" default="Nombre Apoderado" /></th>
                <th><g:message code="otorgamientoDePoder.solicitadoPor.label" default="Solicitado Por" /></th>
                <th><g:message code="otorgamientoDePoder.registroDeLaSolicitud.label" default="Registro De La Solicitud" /></th>
                <th><g:message code="otorgamientoDePoder.tipoDePoder.label" default="Tipo De Poder" /></th>
                <th><g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" />
            </tr>
            </thead>
            <tbody>
                <g:each in="${otorgamientoDePoderInstanceList}" status="i" var="otorgamientoDePoderInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td style="text-align:center"><g:link controller="otorgamientoDePoder" action="edit" id="${otorgamientoDePoderInstance.id}"><span class="badge">${otorgamientoDePoderInstance?.id}-O</span></g:link></td>
                        <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "nombre")}</td>
                        <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "solicitadoPor")}</td>
                        <td><g:formatDate date="${otorgamientoDePoderInstance.registroDeLaSolicitud}" /></td>                        
                        <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "tipoDePoder")}</td>
                        <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "delegacion")}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        <div class="message-footer clearfix">
            <div class="pull-left"> ${otorgamientoDePoderInstanceTotal?:0} resultado(s) en total. </div>
        </div>
        <g:if test="${otorgamientoDePoderInstanceTotal}">
            <export:formats formats="['excel', 'pdf']" action="generarReporteOtorgamiento"/>
        </g:if>
        <br>
        <table class="table table-bordered table-striped">
            <thead>
            <th colspan="7"  style="text-align:left;font-size:14px">Revocación de Poder</th>
            <tr>
                <th><g:message code="revocacionDePoder.id.label"  default="Número de Folio" /></th>
                <th><g:message code="revocacionDePoder.nombre.label" default="Nombre Apoderado" /></th>
                <th><g:message code="revocacionDePoder.solicitadoPor.label" default="Solicitado Por" /></th>
                <th><g:message code="revocacionDePoder.escrituraPublica.label" default="Escritura Publica" /></th>
                <th><g:message code="revocacionDePoder.nombreDeNotario.label" default="Nombre De Notario" /></th>                
                <th><g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha de Revocación" /></th>
            </tr>
            </thead>
            <tbody>
                <g:each in="${revocacionDePoderInstanceList}" status="i" var="revocacionDePoderInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td style="text-align:center"><g:link controller="revocacionDePoder" action="edit" id="${revocacionDePoderInstance.id}"><span class="badge">${revocacionDePoderInstance?.id}-R</span></g:link></td>
                        <td>${fieldValue(bean: revocacionDePoderInstance, field: "nombre")}</td>
                        <td>${fieldValue(bean: revocacionDePoderInstance, field: "solicitadoPor")}</td>
                        <td>${fieldValue(bean: revocacionDePoderInstance, field: "escrituraPublica")}</td>
                        <td>${fieldValue(bean: revocacionDePoderInstance, field: "nombreDeNotario")}</td>                        
                        <td><g:formatDate date="${revocacionDePoderInstance.fechaDeRevocacion}" /></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        <div class="message-footer clearfix">
            <div class="pull-left"> ${revocacionDePoderInstanceTotal?:0} resultado(s) en total. </div>
        </div>
        <g:if test="${revocacionDePoderInstanceTotal}">
            <export:formats formats="['excel', 'pdf']" action="generarReporteRevocacion"/>
        </g:if>
    </div>
</body>
</html>