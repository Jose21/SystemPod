<%@ page import="com.app.sgtask.Nota" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainTareas">
        <g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <g:if test="${session.revocacionDePoderId}">
                <br/>
                <h1>Enviar Testimonio de Escritura Pública</h1>
                <br/>
            </g:if>
            <g:if test="${session.otorgamientoDePoderId}">
                <br/>
                <h1>Notificación de Envio de Documento Físico</h1>
                <br/>
            </g:if>
            <g:else>
                <h1>Crear: Nota</h1>
            </g:else>
        </div>

        <div class="container-fluid">
            <br/>
            <g:render template="/shared/alerts"/>

            <g:hasErrors bean="${notaInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${notaInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>

            <g:form class="form-horizontal" action="save" enctype="multipart/form-data">
                <g:hiddenField name="tarea" id="tarea.id" value="${session.tareaId}"/>
                <g:render template="form"/>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES">
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_PODERES_NOTARIO, ROLE_PODERES_RESOLVEDOR">
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.label', default: 'Enviar')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </div>
                </sec:ifAnyGranted>
            </g:form>

        </div>
    </body>
</html>
