
<%@ page import="com.app.sgpod.MotivoDeRevocacion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-motivoDeRevocacion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                </ul>
            </div>
            <div id="list-motivoDeRevocacion" class="content scaffold-list" role="main">
                <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>

                        <g:sortableColumn property="nombre" title="${message(code: 'motivoDeRevocacion.nombre.label', default: 'Nombre')}" />

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${motivoDeRevocacionInstanceList}" status="i" var="motivoDeRevocacionInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" id="${motivoDeRevocacionInstance.id}">${fieldValue(bean: motivoDeRevocacionInstance, field: "nombre")}</g:link></td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${motivoDeRevocacionInstanceCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
