
<%@ page import="com.app.sgpod.CartaDeInstruccionDeRevocacion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Carta de Instrucción de Revocación de Poder</h1>
        </div>

        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>
            <div class="well">

                <g:if test="${cartaDeInstruccionDeRevocacionInstance?.registro}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeRevocacion.registro.label" default="Registro" /></dt>

                        <dd><g:fieldValue bean="${cartaDeInstruccionDeRevocacionInstance}" field="registro"/></dd>

                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionDeRevocacionInstance?.fecha}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeRevocacion.fecha.label" default="Fecha" /></dt>

                        <dd><g:fieldValue bean="${cartaDeInstruccionDeRevocacionInstance}" field="fecha"/></dd>

                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionDeRevocacionInstance?.contenido}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeRevocacion.contenido.label" default="Contenido" /></dt>

                        <dd class="well"><br/><%=cartaDeInstruccionDeRevocacionInstance?.contenido%></dd

                    </dl>
                </g:if>

                <g:if test="${cartaDeInstruccionDeRevocacionInstance?.lastUpdated}">
                    <dl>
                        <dt><g:message code="cartaDeInstruccionDeRevocacion.lastUpdated.label" default="Última Actualización" /></dt>

                        <dd><g:formatDate date="${cartaDeInstruccionDeRevocacionInstance?.lastUpdated}" /></dd>

                    </dl>
                </g:if>

            </div>
            <!--g:form class="form-actions"-->
                <!--fieldset class="buttons">
                    <g:hiddenField name="id" value="${cartaDeInstruccionDeRevocacionInstance?.id}" />
                    <g:hiddenField name="revocacionDePoder" value="${revocacionDePoderInstance?.id}"/>
                </fieldset-->
            <!--/g:form-->
                <div class="form-actions">
                    <g:link class="btn btn-primary btn-mini" action="regresar" id="${cartaDeInstruccionDeRevocacionInstance?.id}">Regresar</g:link>
                </div>
            </div>
        </body>
    </html>
