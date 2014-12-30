
<%@ page import="com.app.sgcon.StatusDelConvenio" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainConvenios">
        <g:set var="entityName" value="${message(code: 'statusDelConvenio.label', default: 'StatusDelConvenio')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Mostrar: Status del Convenio</h1>
            <div class="btn-group">
                <g:link class="btn btn-small tip-bottom" action="index">
                    <i class="icon-file"></i>
                    Lista: Status de Convenio
                </g:link>
                <g:link class="btn btn-small tip-bottom" action="create">
                    <i class="icon-file"></i>
                    Nuevo: Status de Convenio
                </g:link>
            </div>
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts"/>
            <div class="well">

                <g:if test="${statusDelConvenioInstance?.nombre}">
                    <dl>
                        <dt><g:message code="statusDelConvenio.nombre.label" default="Nombre" /></dt>

                        <dd><g:fieldValue bean="${statusDelConvenioInstance}" field="nombre"/></dd>

                    </dl>
                </g:if>

                <g:if test="${statusDelConvenioInstance?.dateCreated}">
                    <dl>
                        <dt><g:message code="statusDelConvenio.dateCreated.label" default="Date Created" /></dt>

                        <dd><g:formatDate date="${statusDelConvenioInstance?.dateCreated}" /></dd>

                    </dl>
                </g:if>

                <g:if test="${statusDelConvenioInstance?.lastUpdated}">
                    <dl>
                        <dt><g:message code="statusDelConvenio.lastUpdated.label" default="Last Updated" /></dt>

                        <dd><g:formatDate date="${statusDelConvenioInstance?.lastUpdated}" /></dd>

                    </dl>
                </g:if>

            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${statusDelConvenioInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${statusDelConvenioInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
