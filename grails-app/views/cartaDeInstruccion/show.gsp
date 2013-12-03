
<%@ page import="com.app.sgpod.CartaDeInstruccion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Carta de Instrucción</h1>
        </div>
        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>
            <div class="well">

                <g:if test="${cartaDeInstruccionInstance?.registro}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccion.registro.label" default="Registro" /></dt>

                        <dd><g:fieldValue bean="${cartaDeInstruccionInstance}" field="registro"/></dd>

                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionInstance?.fecha}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccion.fecha.label" default="Fecha" /></dt>

                        <dd><g:fieldValue bean="${cartaDeInstruccionInstance}" field="fecha"/></dd>

                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionInstance?.contenido}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccion.contenido.label" default="Contenido" /></dt>
                        <dd class="well"><br/>${cartaDeInstruccionInstance.contenido}</dd>
                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionInstance?.lastUpdated}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccion.lastUpdated.label" default="Última Modificación" /></dt>

                        <dd><g:formatDate date="${cartaDeInstruccionInstance?.lastUpdated}" /></dd>

                    </dl>
                </g:if>

            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${cartaDeInstruccionInstance?.id}" />
                    <g:link class="btn btn-primary" controller="cartaDeInstruccionDeOtorgamiento"action="edit" id="${cartaDeInstruccionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
