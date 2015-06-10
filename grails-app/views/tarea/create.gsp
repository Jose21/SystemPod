<%@ page import="com.app.sgtask.Tarea;com.app.sgcon.Convenio;com.app.sgpod.OtorgamientoDePoder;com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainTareas">
        <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Turno')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>    
    </head>
    <body>
        <div class="page-header position-relative">
            <g:if test="${session.idOtorgamientoDePoder}">
                <br/>
                <h1>Crear Notificación de Rechazo</h1>
                <br/>
            </g:if>
            <g:else><h1>Crear: Turno</h1></g:else>

        </div>
        <div class="container-fluid">
            <g:if test="${session.idConvenio}">
                <br/>
                <g:link class="btn btn-small btn-info btn-block" controller="convenio" action="edit" id="${Convenio.get(session.idConvenio).id}">
                    El turno se asociará al convenio: ${Convenio.get(session.idConvenio).id} - Objeto: ${Convenio.get(session.idConvenio).objeto}
                </g:link>
                <br/>
            </g:if>
            <g:if test="${session.idOtorgamientoDePoder}">
                <br/>
                <g:link class="btn btn-small btn-info btn-block" controller="otorgamientoDePoder" action="show" id="${OtorgamientoDePoder.get(session.idOtorgamientoDePoder).id}">
                    La notificación se asociará a la solicitud de Otorgamiento De Poder: ${OtorgamientoDePoder.get(session.idOtorgamientoDePoder).id}-O
                </g:link>
                <br/>
            </g:if>
            <g:if test="${session.idRevocacionDePoder}">
                <br/>
                <g:link class="btn btn-small btn-info btn-block" controller="revocacionDePoder" action="edit" id="${RevocacionDePoder.get(session.idRevocacionDePoder).id}">
                    El turno se asociará a la Revocación De Poder: ${RevocacionDePoder.get(session.idRevocacionDePoder).id}-R
                </g:link>
                <br/>
            </g:if>
            <br/>
            <g:render template="/shared/alerts" />

            <g:hasErrors bean="${tareaInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${tareaInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form name="myForm" class="form-horizontal" action="save" >
                <g:render template="form"/>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_CONVENIOS_ADMIN, ROLE_CONVENIOS_STANDARD, ROLE_TURNOS_ADMIN, ROLE_TURNOS_STANDARD">
                    <div class="form-actions">
                        <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </div>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_PODERES_RESOLVEDOR, ROLE_GESTOR_EXTERNO, ROLE_PODERES_GESTOR">
                    <div class="form-actions">
                        <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.label', default: 'Enviar')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </div>
                </sec:ifAnyGranted>
            </g:form>
        </div>
        <script lang="javascript" type="text/javascript">
            $(document).ready(function() {
            // binds form submission and fields to the validation engine
            $("#myForm").validationEngine();
            });     

             $('.form-horizontal').submit(function()
             {    
             $('#descripcion').val($('#editor1').html());    
             });   
            
        </script>  
    </body>
</html>
