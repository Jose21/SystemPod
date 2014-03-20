
<%@ page import="com.app.sgpod.Bitacora" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'bitacora.label', default: 'Bitacora')}" />    
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
                            
                                <g:sortableColumn property="diasProrrogas" title="${message(code: 'bitacora.diasProrrogas.label', default: 'Dias Prorrogas')}" />
                                
                                <g:sortableColumn property="fechaDeCreacion" title="${message(code: 'bitacora.fechaDeCreacion.label', default: 'Fecha De Creacion')}" />
                                
                                <g:sortableColumn property="fechaDeEnvio" title="${message(code: 'bitacora.fechaDeEnvio.label', default: 'Fecha De Envio')}" />
                                
                                <g:sortableColumn property="fechaDeVencimiento" title="${message(code: 'bitacora.fechaDeVencimiento.label', default: 'Fecha De Vencimiento')}" />
                                
                                <g:sortableColumn property="fechaFactura" title="${message(code: 'bitacora.fechaFactura.label', default: 'Fecha Factura')}" />
                                
                                <g:sortableColumn property="fechaOtorgamientoRevocacion" title="${message(code: 'bitacora.fechaOtorgamientoRevocacion.label', default: 'Fecha Otorgamiento Revocacion')}" />
                                
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${bitacoraInstanceList}" status="i" var="bitacoraInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><g:link action="show" id="${bitacoraInstance.id}">${fieldValue(bean: bitacoraInstance, field: "diasProrrogas")}</g:link></td>
                                
                                <td><g:formatDate date="${bitacoraInstance.fechaDeCreacion}" /></td>
                                
                                <td><g:formatDate date="${bitacoraInstance.fechaDeEnvio}" /></td>
                                
                                <td><g:formatDate date="${bitacoraInstance.fechaDeVencimiento}" /></td>
                                
                                <td><g:formatDate date="${bitacoraInstance.fechaFactura}" /></td>
                                
                                <td><g:formatDate date="${bitacoraInstance.fechaOtorgamientoRevocacion}" /></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${bitacoraInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
