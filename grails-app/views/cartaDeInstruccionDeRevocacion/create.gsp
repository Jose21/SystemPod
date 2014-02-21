<%@ page import="com.app.sgpod.CartaDeInstruccionDeRevocacion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Crear y Enviar: Carta de Instrucción de Revocación de Poder</h1>
        </div>

        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>

            <g:hasErrors bean="${cartaDeInstruccionDeRevocacionInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${cartaDeInstruccionDeRevocacionInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>


            <g:form name="myForm" class="form-horizontal" action="save" >
                <g:render template="form"/>
                <g:hiddenField name="revocacionDePoderId" value="${revocacionDePoderId}"/>
                <h3 id="bloqueAsignacionExpedientes"  class="header smaller lighter blue">Asignación de Expediente</h3>
                <br/>
                <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'asignar', 'error')} required">
                    <label for="asignar" class="control-label">
                        <g:message code="revocacionDePoder.asignar.label" default="Asignar A" />
                        <span class="required-indicator">*</span>
                    </label>
                    <div class="controls">
                        <g:select id="asignar" name="asignar.id" from="${usuarios}" optionKey="id"  value="${revocacionDePoderInstance?.asignar?.id}" noSelection="['':'-Elige Responsable-']" class="many-to-one validate[required]"/>
                    </div>
                </div>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES">
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </div>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_PODERES_RESOLVEDOR">
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.label', default: 'Enviar')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </div>
                </sec:ifAnyGranted>
            </g:form>

        </div>
    </body>
</html>
