<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="newPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento de Poder')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>        
    </head>
    <body>
        <div class="page-header">
            <h1>Nuevo: Otorgamiento de Poder</h1>      
        </div>
        <g:render template="/shared/alerts" />
        <g:hasErrors bean="${otorgamientoDePoderInstance}">
            <div class="alert alert-block alert-warning">            
                <g:eachError bean="${otorgamientoDePoderInstance}" var="error">
                    - <g:message error="${error}"/> <br/>
                </g:eachError>
            </div>
        </g:hasErrors>
        <div class="row-fluid">
            <div class="span12">
            <div id="fuelux-wizard" class="row-fluid" data-target="#step-container">
                <ul class="wizard-steps">
                    <li data-target="#step1" class="active" style="width: 50%;">
                        <span class="step">1</span>
                        <span class="title">Datos de la solicitud</span>
                    </li>
                    <li data-target="#step2" style="width: 50%;">
                        <span class="step">2</span>
                        <span class="title">Apoderados</span>
                    </li>
                </ul>
            </div>
            </div>
            <div class="span12">
            <hr />
            <div class="step-content" class="row-fluid" id="step-container">
                <div class="step-pane active" id="step1">
                    <g:form class="form-horizontal" action="save" >
                        <g:render template="form"/>                  
                        <div class="form-actions">
                            <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                        </div>
                    </g:form>
                </div>
            </div>
           </div> 
           </div>
    </body>    
</html>
