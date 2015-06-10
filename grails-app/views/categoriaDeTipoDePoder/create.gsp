<%@ page import="com.app.sgpod.CategoriaDeTipoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'categoriaDeTipoDePoder.label', default: 'Categoria De Tipo De Poder')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            </br>            
        </div>

        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>

            <g:hasErrors bean="${categoriaDeTipoDePoderInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${categoriaDeTipoDePoderInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>


            <g:form class="form-horizontal" action="save" >
                <g:render template="form"/>
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </g:form>

        </div>
    </body>
</html>
