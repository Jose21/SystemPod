<%@ page import="com.app.sgpod.CartaDeInstruccionDeOtorgamiento" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Crear: Carta de Instrucción de Otorgamiento de Poder</h1>
        </div>

        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>

            <g:hasErrors bean="${cartaDeInstruccionDeOtorgamientoInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${cartaDeInstruccionDeOtorgamientoInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>


            <g:form class="form-horizontal" action="save" >
                <g:hiddenField name="otorgamientoDePoderId" value="${otorgamientoDePoderId}"/>
                <g:render template="form"/>
                <h3 id="bloqueAsignacionExpedientes"  class="header smaller lighter blue">Asignación de Expediente</h3>
                <br/>
                <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'asignar', 'error')} required">
                    <label for="asignar" class="control-label">
                        <g:message code="otorgamientoDePoder.asignar.label" default="Asignar A" />
                    </label>
                    <div class="controls">
                        <g:select id="asignar" name="asignar.id" from="${usuarios}" optionKey="id"  value="${otorgamientoDePoderInstance?.asignar?.id}" noSelection="['':'-Elige Responsable-']" class="many-to-one"/>
                    </div>
                </div>
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </div>
            </g:form>

        </div>
    </body>
</html>
