
<%@ page import="com.app.sgpod.Notario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'notario.label', default: 'Notario')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-notario" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                </ul>
            </div>
            <div id="list-notario" class="content scaffold-list" role="main">
                <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
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
            <div class="pagination">
                <g:paginate total="${notarioInstanceCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
