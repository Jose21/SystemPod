
<%@ page import="com.app.sgpod.CartaDeInstruccion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion')}" />    
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
                            
                                <g:sortableColumn property="registro" title="${message(code: 'cartaDeInstruccion.registro.label', default: 'Registro')}" />
                                
                                <g:sortableColumn property="fecha" title="${message(code: 'cartaDeInstruccion.fecha.label', default: 'Fecha')}" />
                                
                                <g:sortableColumn property="contenido" title="${message(code: 'cartaDeInstruccion.contenido.label', default: 'Contenido')}" />
                                
                                <g:sortableColumn property="dateCreated" title="${message(code: 'cartaDeInstruccion.dateCreated.label', default: 'Date Created')}" />
                                
                                <g:sortableColumn property="lastUpdated" title="${message(code: 'cartaDeInstruccion.lastUpdated.label', default: 'Last Updated')}" />
                                
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${cartaDeInstruccionInstanceList}" status="i" var="cartaDeInstruccionInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><g:link action="show" id="${cartaDeInstruccionInstance.id}">${fieldValue(bean: cartaDeInstruccionInstance, field: "registro")}</g:link></td>
                                
                                <td>${fieldValue(bean: cartaDeInstruccionInstance, field: "fecha")}</td>
                                
                                <td>${fieldValue(bean: cartaDeInstruccionInstance, field: "contenido")}</td>
                                
                                <td><g:formatDate date="${cartaDeInstruccionInstance.dateCreated}" /></td>
                                
                                <td><g:formatDate date="${cartaDeInstruccionInstance.lastUpdated}" /></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${cartaDeInstruccionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
