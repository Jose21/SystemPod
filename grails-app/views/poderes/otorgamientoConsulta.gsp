
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Consulta Otorgamiento')}" />    
        <title>Consulta de Otorgamiento</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Consulta de Otorgamiento de Poderes</h1>
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
                <li class="${porNombrePoderActive?:""}">
                    <a data-toggle="tab" href="#porNombrePoder">
                        <i class="icon-legal bigger-130"></i>
                        <span class="bigger-110">Por Nombre del Poder <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porFechaRegistroActive?:""}">
                    <a data-toggle="tab" href="#porFechaRegistro">
                        <i class="icon-calendar bigger-130"></i>
                        <span class="bigger-110">Por Fecha de Registro <span class="badge"></span></span>
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
                                <label for="solicitadoPor" class="control-label">
                                    <g:message code="otorgamientoDePoder.solicitadoPor.label" default="Nombre" />
                                </label>
                                <g:textField name="solicitadoPor" required="" value="${otorgamientoDePoderInstance?.solicitadoPor}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarNombreApoderado" value="Buscar" />
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
                                    <g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" />
                                </label>
                                <g:select id="delegacion" name="nombre" from="${com.app.sgpod.Delegacion.list()}" optionKey="nombre" required="" value="${delegacionInstance?.nombre}" noSelection="['':'-Elige Delegación-']" class="many-to-one"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorDelegacion" value="Buscar" />            
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porNombrePoder" class="tab-pane ${porNombrePoderActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porNombrePoder"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="nombre" class="control-label">
                                    <g:message code="otorgamientoDePoder.nombre.label" default="Nombre" />
                                </label>
                                <g:textField name="nombre" required="" value="${otorgamientoDePoderInstance?.nombre}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorNombrePoder" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFechaRegistro" class="tab-pane ${porFechaRegistroActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porFechaRegistro"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                                <input class="span5" type="text" name="rangoDeFechaRegistro" id="rangoDeFechaRegistro" value="${rangoDeFechaRegistro?rangoDeFechaRegistro:""}" readonly="true" />
                                <g:actionSubmit class="btn btn-primary" action="buscarPorFechaRegistro" value="Buscar" />
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
                                <g:actionSubmit class="btn btn-primary" action="buscarPorTags" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>

        <table class="table table-bordered table-striped">
            <thead>
                <g:if test="${params.solicitadoPor}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NOMBRE DEL APODERADO: ${params.solicitadoPor}</th>
                    </tr>
                </g:if>
                <g:if test="${params.delegacion}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR DELEGACIÓN: ${params.delegacion.nombre}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.nombre}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NOMBRE DEL PODER: ${params.nombre}</th>
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
    </div>
</body>
</html>
