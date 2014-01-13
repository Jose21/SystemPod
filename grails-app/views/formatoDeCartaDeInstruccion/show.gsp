
<%@ page import="com.app.sgpod.FormatoDeCartaDeInstruccion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Formato de Carta de Instrucción</h1>
        </div>
        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>
            <div class="well">
                <g:if test="${formatoDeCartaDeInstruccionInstance?.registro}">
                    <dl>
                        <dt><g:message code="formatoDeCartaDeInstruccion.registro.label" default="Registro" /></dt>
                        <dd><g:fieldValue bean="${formatoDeCartaDeInstruccionInstance}" field="registro"/></dd>
                    </dl>
                </g:if>
                <g:if test="${formatoDeCartaDeInstruccionInstance?.fecha}">
                    <dl>
                        <dt><g:message code="formatoDeCartaDeInstruccion.fecha.label" default="Fecha" /></dt>
                        <dd><g:fieldValue bean="${formatoDeCartaDeInstruccionInstance}" field="fecha"/></dd>
                    </dl>
                </g:if>
                <g:if test="${formatoDeCartaDeInstruccionInstance?.contenido}">
                    <dl>
                        <dt><g:message code="formatoDeCartaDeInstruccion.contenido.label" default="Contenido" /></dt>
                        <dd class="well"><br/><%=formatoDeCartaDeInstruccionInstance.contenido%></dd>
                    </dl>
                </g:if>
                <g:if test="${formatoDeCartaDeInstruccionInstance?.lastUpdated}">
                    <dl>
                        <dt><g:message code="formatoDeCartaDeInstruccion.lastUpdated.label" default="Última Modificación" /></dt>
                        <dd><g:formatDate date="${formatoDeCartaDeInstruccionInstance?.lastUpdated}" /></dd>
                    </dl>
                </g:if>
            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${formatoDeCartaDeInstruccionInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${formatoDeCartaDeInstruccionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    </fieldset>
            </g:form>
        </div>
    </body>
</html>
