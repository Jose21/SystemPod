<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Consulta Revocación')}" />    
        <title>Consulta de Revocación</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Consulta de Revocación de Poderes</h1>
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
                <li class="${porDelegacionActive?:""}">
                    <a data-toggle="tab" href="#porDelegacion">
                        <i class="icon-home bigger-130"></i>
                        <span class="bigger-110">Por Delegación<span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porNombreNotarioActive?:""}">
                    <a data-toggle="tab" href="#porNombreNotario">
                        <i class="icon-legal bigger-130"></i>
                        <span class="bigger-110">Por Nombre del Notario <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porFechaRevocacionActive?:""}">
                    <a data-toggle="tab" href="#porFechaRevocacion">
                        <i class="icon-calendar bigger-130"></i>
                        <span class="bigger-110">Por Fecha de Revocación<span class="badge"></span></span>
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
                                    <g:message code="revocacionDePoder.nombre.label" default="Nombre" />
                                </label>
                                <g:textField name="nombre" required="" value="${revocacionDePoderInstance?.nombre}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarNombreApoderadoRevocacion" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porDelegacion" class="tab-pane ${porDelegacionActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porDelegacion"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="delegacion" class="control-label">
                                    <g:message code="revocacionDePoder.delegacion.label" default="Delegación" />
                                </label>
                                <g:textField name="delegacion" required="" value="${revocacionDePoderInstance?.delegacion}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorDelegacionRevocacion" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porNombreNotario" class="tab-pane ${porNombreNotarioActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porNombreNotario"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="nombreNotario" class="control-label">
                                    <g:message code="revocacionDePoder.nombreNotario.label" default="Nombre del Notario" />
                                </label>
                                <g:textField name="nombreNotario" required="" value="${revocacionDePoderInstance?.nombreDeNotario}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorNombreNotarioRevocacion" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFechaRevocacion" class="tab-pane ${porFechaRevocacionActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porFechaRevocacion"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                                <input class="span5" type="text" name="rangoDeFechaRevocacion" id="rangoDeFechaRevocacion" value="${rangoDeFechaRevocacion?rangoDeFechaRevocacion:""}" readonly="true" />
                                <g:actionSubmit class="btn btn-primary" action="buscarPorFechaRevocacion" value="Buscar" />
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
                                    <g:message code="revocacionDePoder.tags.label" default="Palabra Clave" />
                                </label>
                                <g:textField name="tags" required="" value="${revocacionDePoderInstance?.tags}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorTagsRevocacion" value="Buscar" />
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
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NOMBRE DEL APODERADO: ${params.nombre}</th>
                    </tr>
                </g:if>
                <g:if test="${params.delegacion}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR DELEGACIÓN: ${params.delegacion}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.nombreNotario}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NOMBRE DEL PODER: ${params.nombreNotario}</th>
                    </tr>
                </g:if>
                <g:if test="${rangoDeFechaRegistro}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR FECHA DE REGISTRO: ${rangoDeFechaRegistro}</br></br></th>
                    </tr>
                </g:if> 
                <g:if test="${params.tags}">
                    <tr>
                        <th colspan="10" style="text-align:center;font-size:16px">RESULTADO PARA LA PALABRA: ${params.tags}</br></br></th>
                    </tr>
                </g:if>
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

