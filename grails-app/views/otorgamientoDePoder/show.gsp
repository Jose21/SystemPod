
<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento De Poder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Ver: Otorgamiento De Poder</h1>
            <br/>
            <g:link class="btn btn-success btn-small tip-bottom" controller="otorgamientoDePoder" action="existe" id="${otorgamientoDePoderInstance?.id}">
                <i class="icon-external-link"></i> Carta de Instrucción
            </g:link>
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>

            <div class="well">

                <g:if test="${otorgamientoDePoderInstance?.id}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.numeroDeFolio.label" default="Número de Folio" /></dt>					
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="id"/>-O</dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.registroDeLaSolicitud}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.registroDeLaSolicitud.label" default="Registro De La Solicitud" /></dt>					
                        <dd><g:formatDate date="${otorgamientoDePoderInstance?.registroDeLaSolicitud}" /></dd>					
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.tipoDePoder}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.tipoDePoder.label" default="Tipo De Poder" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="tipoDePoder"/></dd>
                    </dl>
                </g:if>              

                <g:if test="${otorgamientoDePoderInstance?.apoderados}">
                    <dt><g:message code="otorgamientoDePoder.apoderados.label" default="Apoderados" /></dt>           
                    <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="apoderados.nombre"/></dd>              
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.delegacion}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="delegacion"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.poderSolicitado}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.poderSolicitado.label" default="Poder Solicitado" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="poderSolicitado"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.motivoDeOtorgamiento}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.motivoDeOtorgamiento.label" default="Motivo De Otorgamiento" /></dt>
                        <dd><g:link controller="motivoDeOtorgamiento" action="show" id="${otorgamientoDePoderInstance?.motivoDeOtorgamiento?.id}">${otorgamientoDePoderInstance?.motivoDeOtorgamiento?.encodeAsHTML()}</g:link></dd>
                        </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.solicitadoPor}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.solicitadoPor.label" default="Solicitado Por" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="solicitadoPor"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.asignar}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.asignar.label" default="Asignado A" /></dt>
                        <dd>${otorgamientoDePoderInstance?.asignar?.firstName} ${otorgamientoDePoderInstance?.asignar?.lastName}</dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.fechaDeOtorgamiento.label" default="Fecha De Otorgamiento" /></dt>
                        <dd><g:formatDate date="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}" /></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.escrituraPublicaDeOtorgamiento}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.escrituraPublicaDeOtorgamiento.label" default="Escritura Pública De Otorgamiento" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="escrituraPublicaDeOtorgamiento"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.comentarios}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.comentarios.label" default="Comentarios" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="comentarios"/></dd>
                    </dl>
                </g:if>

            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${otorgamientoDePoderInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${otorgamientoDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>                    
                    </fieldset>
            </g:form>
        </div>
    </body>
</html>
