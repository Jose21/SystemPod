<%@ page import="com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'Revocacion De Poder')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Notificación de Rechazo de Solicitud de Revocación de Poder</h1>            
        </div>
        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <g:hasErrors bean="${revocacionDePoderInstance}">
                <div class="alert alert-block alert-warning">            
                    <g:eachError bean="${revocacionDePoderInstance}" var="error">
                        - <g:message error="${error}"/> <br/>
                    </g:eachError>
                </div>
            </g:hasErrors>            
            <g:form name="myForm" class="form-horizontal" action="updateNotificacionDeRechazo">
                <g:render template="formNotificacionDeRechazo"/>
                <div class="form-actions">
                    <g:hiddenField name="idRevocacionDePoder" value="${revocacionDePoderInstance?.id}" />
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.label', default: 'Enviar')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </div>
            </g:form>
        </div>
    </body>
</html>

