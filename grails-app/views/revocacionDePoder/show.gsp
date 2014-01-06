
<%@ page import="com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Ver: Revocación De Poder</h1>
            <br/>
            <g:link class="btn btn-success btn-small tip-bottom" controller="revocacionDePoder" action="existe" id="${revocacionDePoderInstance?.id}">
                <i class="icon-external-link"></i> Carta de Instrucción
            </g:link>
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>

            <div class="well">

                <g:if test="${revocacionDePoderInstance?.escrituraPublica}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.escrituraPublica.label" default="Escritura Pública" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="escrituraPublica"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.nombreDeNotario}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.nombreDeNotario.label" default="Nombre De Notario" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="nombreDeNotario"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.numeroDeNotario}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.numeroDeNotario.label" default="Número De Notario" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="numeroDeNotario"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.nombre}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.nombre.label" default="Nombre" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="nombre"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.puesto}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.puesto.label" default="Puesto" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="puesto"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.contrato}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.contrato.label" default="Contrato" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="contrato"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.tipoDePoder}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.tipoDePoder.label" default="Tipo De Poder" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="tipoDePoder"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.delegacion}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.delegacion.label" default="Delegación" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="delegacion"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.motivoDeRevocacion}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.motivoDeRevocacion.label" default="Motivo De Revocación" /></dt>

                        <dd><g:link controller="motivoDeRevocacion" action="show" id="${revocacionDePoderInstance?.motivoDeRevocacion?.id}">${revocacionDePoderInstance?.motivoDeRevocacion?.encodeAsHTML()}</g:link></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.solicitadoPor}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.solicitadoPor.label" default="Solicitado Por" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="solicitadoPor"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.asignar}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.asignar.label" default="Asignado A" /></dt>
                        <dd>${revocacionDePoderInstance?.asignar?.firstName} ${revocacionDePoderInstance?.asignar?.lastName}</dd>
                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.fechaDeRevocacion}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha De Revocación" /></dt>

                        <dd><g:formatDate date="${revocacionDePoderInstance?.fechaDeRevocacion}" /></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.escrituraPublicaDeRevocacion}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.escrituraPublicaDeRevocacion.label" default="Escritura Pública De Revocación" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="escrituraPublicaDeRevocacion"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.comentarios}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.comentarios.label" default="Comentarios" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="comentarios"/></dd>

                    </dl>
                </g:if>

            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${revocacionDePoderInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${revocacionDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>                    
                    </fieldset>
            </g:form>
        </div>
    </body>
</html>
