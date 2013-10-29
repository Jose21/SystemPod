
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

                <g:if test="${otorgamientoDePoderInstance?.numeroDeFolio}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.numeroDeFolio.label" default="Número De Folio" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="numeroDeFolio"/></dd>
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

                <g:if test="${otorgamientoDePoderInstance?.delegacion}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="delegacion"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.puesto}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.puesto.label" default="Puesto" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="puesto"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.contrato}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.contrato.label" default="Contrato" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="contrato"/></dd>
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

                <g:if test="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.fechaDeOtorgamiento.label" default="Fecha De Otorgamiento" /></dt>
                        <dd><g:formatDate date="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}" /></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.escrituraPublicaDeOtorgamiento}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.escrituraPublicaDeOtorgamiento.label" default="Escritura Publica De Otorgamiento" /></dt>
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
                    <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
