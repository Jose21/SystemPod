
<%@ page import="com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'Revocacion De Poder')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-revocacionDePoder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                </ul>
            </div>
            <div id="list-revocacionDePoder" class="content scaffold-list" role="main">
                <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>

                        <g:sortableColumn property="escrituraPublica" title="${message(code: 'revocacionDePoder.escrituraPublica.label', default: 'Escritura Publica')}" />

                        <g:sortableColumn property="notario" title="${message(code: 'revocacionDePoder.notario.label', default: 'Notario')}" />

                        <g:sortableColumn property="nombre" title="${message(code: 'revocacionDePoder.nombre.label', default: 'Nombre')}" />                        

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${revocacionDePoderInstanceList}" status="i" var="revocacionDePoderInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" id="${revocacionDePoderInstance.id}">${fieldValue(bean: revocacionDePoderInstance, field: "escrituraPublica")}</g:link></td>

                            <td>${fieldValue(bean: revocacionDePoderInstance, field: "notario")}</td>

                            <td>${fieldValue(bean: revocacionDePoderInstance, field: "nombre")}</td>
                           
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${revocacionDePoderInstanceCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
