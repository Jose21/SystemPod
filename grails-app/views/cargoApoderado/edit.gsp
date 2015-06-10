<%@ page import="com.app.sgpod.CargoApoderado" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cargoApoderado.label', default: 'Cargo de Apoderado')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <div class="btn-group">
                <g:link class="btn btn-success tip-bottom" action="list">
                    <i class="icon-user"> Lista: Cargo de Apoderado </i>                    
                </g:link>
            </div>
        </div>

        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>

            <g:hasErrors bean="${cargoApoderadoInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${cargoApoderadoInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>

            <g:form class="form-horizontal" method="post" >
                <g:hiddenField name="id" value="${cargoApoderadoInstance?.id}" />
                <g:hiddenField name="version" value="${cargoApoderadoInstance?.version}" />
                <g:render template="form"/>
                <div class="form-actions">
                    <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />                    
                </div>
            </g:form>
        </div>
    </body>
</html>
