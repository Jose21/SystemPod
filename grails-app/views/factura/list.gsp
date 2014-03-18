
<%@ page import="com.app.sgpod.Factura" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}" />    
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
                            
                                <g:sortableColumn property="nota" title="${message(code: 'factura.nota.label', default: 'Nota')}" />
                                
                            <th><g:message code="factura.asignadoA.label" default="Asignado A" /></th>
                                
                            <th><g:message code="factura.asignadoPor.label" default="Asignado Por" /></th>
                                
                                <g:sortableColumn property="fechaDeEnvio" title="${message(code: 'factura.fechaDeEnvio.label', default: 'Fecha De Envio')}" />
                                
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${facturaInstanceList}" status="i" var="facturaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><g:link action="show" id="${facturaInstance.id}">${fieldValue(bean: facturaInstance, field: "nota")}</g:link></td>
                                
                                <td>${fieldValue(bean: facturaInstance, field: "asignadoA")}</td>
                                
                                <td>${fieldValue(bean: facturaInstance, field: "asignadoPor")}</td>
                                
                                <td><g:formatDate date="${facturaInstance.fechaDeEnvio}" /></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${facturaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
