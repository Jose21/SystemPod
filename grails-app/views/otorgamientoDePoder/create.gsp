<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento de Poder')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>        
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Nuevo: Otorgamiento de Poder</h1>      
        </div>
        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>
            <g:hasErrors bean="${otorgamientoDePoderInstance}">
                <div class="alert alert-block alert-warning">            
                    <g:eachError bean="${otorgamientoDePoderInstance}" var="error">
                        - <g:message error="${error}"/> <br/>
                    </g:eachError>
                </div>
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
