
<%@ page import="com.app.sgpod.FormatoDeCartaDeInstruccion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-formatoDeCartaDeInstruccion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                </ul>
            </div>
            <div id="list-formatoDeCartaDeInstruccion" class="content scaffold-list" role="main">
                <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>

                        <g:sortableColumn property="registro" title="${message(code: 'formatoDeCartaDeInstruccion.registro.label', default: 'Registro')}" />

                        <g:sortableColumn property="fecha" title="${message(code: 'formatoDeCartaDeInstruccion.fecha.label', default: 'Fecha')}" />

                        <g:sortableColumn property="contenido" title="${message(code: 'formatoDeCartaDeInstruccion.contenido.label', default: 'Contenido')}" />

                        <g:sortableColumn property="dateCreated" title="${message(code: 'formatoDeCartaDeInstruccion.dateCreated.label', default: 'Date Created')}" />

                        <g:sortableColumn property="lastUpdated" title="${message(code: 'formatoDeCartaDeInstruccion.lastUpdated.label', default: 'Last Updated')}" />

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${formatoDeCartaDeInstruccionInstanceList}" status="i" var="formatoDeCartaDeInstruccionInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" id="${formatoDeCartaDeInstruccionInstance.id}">${fieldValue(bean: formatoDeCartaDeInstruccionInstance, field: "registro")}</g:link></td>

                            <td>${fieldValue(bean: formatoDeCartaDeInstruccionInstance, field: "fecha")}</td>

                            <td>${fieldValue(bean: formatoDeCartaDeInstruccionInstance, field: "contenido")}</td>

                            <td><g:formatDate date="${formatoDeCartaDeInstruccionInstance.dateCreated}" /></td>

                            <td><g:formatDate date="${formatoDeCartaDeInstruccionInstance.lastUpdated}" /></td>

                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${formatoDeCartaDeInstruccionInstanceCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
