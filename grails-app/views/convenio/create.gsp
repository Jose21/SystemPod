<%@ page import="com.app.sgcon.Convenio" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainConvenios">
        <g:set var="entityName" value="${message(code: 'convenio.label', default: 'Convenio')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>

    </head>
    <body>
        <div class="content-header">
            <div class="page-header position-relative">
                <h1>Crear: Nuevo Convenio</h1>
            </div><!--/.page-header-->

            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">

                        <g:render template="/shared/alerts" />

                        <g:hasErrors bean="${convenioInstance}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${convenioInstance}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                    </g:eachError>
                            </ul>
                        </g:hasErrors>

                        <g:form name="myForm" class="form-horizontal" action="save" >
                            <g:render template="form"/>
                            <div class="form-actions">
                                <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                            </div>
                        </g:form>
                    </div>
                </div>
            </div>
        </div>
        <script lang="javascript" type="text/javascript">
            $(document).ready(function() {
            // binds form submission and fields to the validation engine
            $("#myForm").validationEngine();
            });          
        </script> 
    </body>
</html>
