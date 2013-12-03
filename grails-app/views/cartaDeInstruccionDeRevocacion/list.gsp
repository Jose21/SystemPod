
<%@ page import="com.app.sgpod.CartaDeInstruccionDeRevocacion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion')}" />    
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
                            
                                <g:sortableColumn property="registro" title="${message(code: 'cartaDeInstruccionDeRevocacion.registro.label', default: 'Registro')}" />
                                
                                <g:sortableColumn property="fecha" title="${message(code: 'cartaDeInstruccionDeRevocacion.fecha.label', default: 'Fecha')}" />
                                
                                <g:sortableColumn property="contenido" title="${message(code: 'cartaDeInstruccionDeRevocacion.contenido.label', default: 'Contenido')}" />
                                
                            <th><g:message code="cartaDeInstruccionDeRevocacion.revocacionDePoder.label" default="Revocacion De Poder" /></th>
                                
                                <g:sortableColumn property="dateCreated" title="${message(code: 'cartaDeInstruccionDeRevocacion.dateCreated.label', default: 'Date Created')}" />
                                
                                <g:sortableColumn property="lastUpdated" title="${message(code: 'cartaDeInstruccionDeRevocacion.lastUpdated.label', default: 'Last Updated')}" />
                                
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${cartaDeInstruccionDeRevocacionInstanceList}" status="i" var="cartaDeInstruccionDeRevocacionInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><g:link action="show" id="${cartaDeInstruccionDeRevocacionInstance.id}">${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "registro")}</g:link></td>
                                
                                <td>${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "fecha")}</td>
                                
                                <td>${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "contenido")}</td>
                                
                                <td>${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "revocacionDePoder")}</td>
                                
                                <td><g:formatDate date="${cartaDeInstruccionDeRevocacionInstance.dateCreated}" /></td>
                                
                                <td><g:formatDate date="${cartaDeInstruccionDeRevocacionInstance.lastUpdated}" /></td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${cartaDeInstruccionDeRevocacionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
