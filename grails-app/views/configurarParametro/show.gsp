
<%@ page import="com.app.sgpod.ConfigurarParametro" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'configurarParametro.label', default: 'ConfigurarParametro')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>      
        </div>

        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>
            <div class="well">

                <g:if test="${configurarParametroInstance?.estadoCriticoPoder}">
                    <dl>
                        <dt><g:message code="configurarParametro.estadoCriticoPoder.label" default="Estado Critico Poder" /></dt>

                        <dd><g:fieldValue bean="${configurarParametroInstance}" field="estadoCriticoPoder"/></dd>

                    </dl>
                </g:if>

                <g:if test="${configurarParametroInstance?.estadoSemiPoder}">
                    <dl>
                        <dt><g:message code="configurarParametro.estadoSemiPoder.label" default="Estado Semi Poder" /></dt>

                        <dd><g:fieldValue bean="${configurarParametroInstance}" field="estadoSemiPoder"/></dd>

                    </dl>
                </g:if>							

                <g:if test="${configurarParametroInstance?.estadoCriticoSolicitud}">
                    <dl>
                        <dt><g:message code="configurarParametro.estadoCriticoSolicitud.label" default="Estado Critico Solicitud" /></dt>

                        <dd><g:fieldValue bean="${configurarParametroInstance}" field="estadoCriticoSolicitud"/></dd>

                    </dl>
                </g:if>

                <g:if test="${configurarParametroInstance?.estadoSemiSolicitud}">
                    <dl>
                        <dt><g:message code="configurarParametro.estadoSemiSolicitud.label" default="Estado Semi Solicitud" /></dt>

                        <dd><g:fieldValue bean="${configurarParametroInstance}" field="estadoSemiSolicitud"/></dd>

                    </dl>
                </g:if>							

            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${configurarParametroInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${configurarParametroInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <!--g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /-->
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
