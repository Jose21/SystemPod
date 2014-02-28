<%@ page import="com.app.sgpod.Prorroga" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'prorroga.label', default: 'Prorroga')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <div class="btn-group">        
            </div>
        </div>
        <div class="container-fluid">      
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>
            <g:hasErrors bean="${prorrogaInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${prorrogaInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form class="form-horizontal" action="save" >
                <g:render template="form"/>
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.label', default: 'Enviar')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
