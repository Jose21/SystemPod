
<%@ page import="com.app.sgpod.Notario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'notario.label', default: 'Notario')}" />    
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

                            <g:sortableColumn property="nombre" title="${message(code: 'notario.nombre.label', default: 'Nombre')}" />

                            <g:sortableColumn property="numeroDeNotaria" title="${message(code: 'notario.numeroDeNotaria.label', default: 'Numero De Notaria')}" />

                            <g:sortableColumn property="direccion" title="${message(code: 'notario.direccion.label', default: 'Direccion')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${notarioInstanceList}" status="i" var="notarioInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:link action="show" id="${notarioInstance.id}">${fieldValue(bean: notarioInstance, field: "nombre")}</g:link></td>

                                <td>${fieldValue(bean: notarioInstance, field: "numeroDeNotaria")}</td>

                                <td>${fieldValue(bean: notarioInstance, field: "direccion")}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${notarioInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
