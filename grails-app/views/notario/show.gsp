
<%@ page import="com.app.sgpod.Notario" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'notario.label', default: 'Notario')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <div class="btn-group">
                <g:link class="btn btn-small tip-bottom" action="index">
                    <i class="icon-file"></i>
                    <g:message code="default.list.label" args="[entityName]" />
                </g:link>
                <g:link class="btn btn-small tip-bottom" action="create">
                    <i class="icon-file"></i>
                    <g:message code="default.new.label" args="[entityName]" />
                </g:link>
            </div>
        </div>

        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>
            <div class="well">
                <g:if test="${notarioInstance?.nombre}">
                    <dl>
                        <dt><g:message code="notario.nombre.label" default="Nombre" /></dt>
                        <dd><g:fieldValue bean="${notarioInstance}" field="nombre"/></dd>
                    </dl>
                </g:if>
                <g:if test="${notarioInstance?.numeroDeNotaria}">
                    <dl>
                        <dt><g:message code="notario.numeroDeNotaria.label" default="Numero De Notaria" /></dt>
                        <dd><g:fieldValue bean="${notarioInstance}" field="numeroDeNotaria"/></dd>
                    </dl>
                </g:if>
                <g:if test="${notarioInstance?.direccion}">
                    <dl>
                        <dt><g:message code="notario.direccion.label" default="Direccion" /></dt>
                        <dd><g:fieldValue bean="${notarioInstance}" field="direccion"/></dd>
                    </dl>
                </g:if>
            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${notarioInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${notarioInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
