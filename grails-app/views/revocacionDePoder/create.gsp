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
            <h1>Nuevo: Solicitud de Revocación de Poder</h1>            
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
            <h3 id="busquedaPorEscrituraPublica"  class="header smaller lighter blue">Búsqueda por Escritura Pública</h3>
            <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'escrituraPublica', 'error')} required">
                <label for="escrituraPublica" class="control-label">
                    <g:message code="revocacionDePoder.escrituraPublica.label" default="Escritura Publica" />
                    <span class="required-indicator">*</span>
                </label>
                <div class="controls">
                    <g:form method="post">
                        <div class="row-fluid input-append">
                            <g:textField class="span4" name="escrituraPublica" required="" value="${revocacionDePoderInstance?.escrituraPublica}"/>
                            <g:actionSubmit class="btn btn-small" action="create" value="Buscar" />
                        </div>
                    </g:form>
                </div>
            </div>
            <h3 id="FinBusquedaPorEscrituraPublica"  class="header smaller lighter blue"></h3>
            <g:form class="form-horizontal" action="save" enctype="multipart/form-data">
                <g:render template="form"/>
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                </div>
            </g:form>

        </div>
    </body>
</html>
