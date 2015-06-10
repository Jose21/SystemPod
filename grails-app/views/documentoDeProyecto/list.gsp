
<%@ page import="com.app.sgpod.DocumentoDeProyecto" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="page-header position-relative">
            <h1>
                <g:message code="default.list.label" args="[entityName]" />
            </h1>
            <div class="btn-group">
                <g:link class="btn btn-small tip-bottom" action="create">
                    <i class="icon-file"></i>
                    <g:message code="default.new.label" args="[entityName]" />
                </g:link>
            </div>
        </div><!--/.page-header-->


        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>
            <br/>
            <div class="widget-content nopadding">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            
                                <g:sortableColumn property="descripcion" title="${message(code: 'documentoDeProyecto.descripcion.label', default: 'Descripcion')}" />
                                
                                <g:sortableColumn property="motivosDeRechazo" title="${message(code: 'documentoDeProyecto.motivosDeRechazo.label', default: 'Motivos De Rechazo')}" />
                                
                                <g:sortableColumn property="fechaDeEnvio" title="${message(code: 'documentoDeProyecto.fechaDeEnvio.label', default: 'Fecha De Envio')}" />
                                
                                <g:sortableColumn property="dateCreated" title="${message(code: 'documentoDeProyecto.dateCreated.label', default: 'Date Created')}" />
                                
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${documentoDeProyectoInstanceList}" status="i" var="documentoDeProyectoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><g:link action="show" id="${documentoDeProyectoInstance.id}">${fieldValue(bean: documentoDeProyectoInstance, field: "descripcion")}</g:link></td>
                                
                                <td>${fieldValue(bean: documentoDeProyectoInstance, field: "motivosDeRechazo")}</td>
                                
                                <td><g:formatDate date="${documentoDeProyectoInstance.fechaDeEnvio}" /></td>
                                
                                <td><g:formatDate date="${documentoDeProyectoInstance.dateCreated}" /></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${documentoDeProyectoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
