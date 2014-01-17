
<%@ page import="com.app.sgpod.CartaDeInstruccionDeOtorgamiento" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Carta de Instrucción de Otorgamiento de Poder</h1>
        </div>

        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>
            <div class="well">

                <g:if test="${cartaDeInstruccionDeOtorgamientoInstance?.registro}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeOtorgamiento.registro.label" default="Registro" /></dt>

                        <dd><g:fieldValue bean="${cartaDeInstruccionDeOtorgamientoInstance}" field="registro"/></dd>

                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionDeOtorgamientoInstance?.fecha}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeOtorgamiento.fecha.label" default="Fecha" /></dt>

                        <dd><g:fieldValue bean="${cartaDeInstruccionDeOtorgamientoInstance}" field="fecha"/></dd>

                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionDeOtorgamientoInstance?.contenido}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeOtorgamiento.contenido.label" default="Contenido" /></dt>
                        <dd class="well"><br/><%=cartaDeInstruccionDeOtorgamientoInstance?.contenido%></dd>
                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionDeOtorgamientoInstance?.lastUpdated}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeOtorgamiento.lastUpdated.label" default="Última Modificación" /></dt>

                        <dd><g:formatDate date="${cartaDeInstruccionDeOtorgamientoInstance?.lastUpdated}" /></dd>

                    </dl>
                </g:if>

            </div>
            <!--g:form class="form-actions"-->
                <!--fieldset class="buttons">
                    <g:hiddenField name="id" value="${cartaDeInstruccionDeOtorgamientoInstance?.id}" />
                    <g:hiddenField name="otorgamientoDePoder" value="${otorgamientoDePoderInstance?.id}"/>
                    <g:link class="btn btn-primary" action="edit" id="${cartaDeInstruccionDeOtorgamientoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset-->
            <!--/g:form-->
                <div class="form-actions">
                    <g:link class="btn btn-primary btn-mini" action="regresar" id="${cartaDeInstruccionDeOtorgamientoInstance?.id}">Regresar</g:link>
                </div>
            </div>
        </body>
    </html>
