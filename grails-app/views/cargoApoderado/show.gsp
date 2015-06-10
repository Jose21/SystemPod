
<%@ page import="com.app.sgpod.CargoApoderado" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cargoApoderado.label', default: 'Cargo de Apoderado')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <div class="btn-group">                
                <g:link class="btn btn-success tip-bottom" action="index">
                    <i class="icon-list"> Lista: Cargo Apoderado</i>                    
                </g:link>                
            </div>
        </div>

        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>
            <div class="well">

                <g:if test="${cargoApoderadoInstance?.nombreCargo}">
                    <dl>
                        <dt><g:message code="cargoApoderado.nombreCargo.label" default="Nombre Cargo" /></dt>

                        <dd><g:fieldValue bean="${cargoApoderadoInstance}" field="nombreCargo"/></dd>

                    </dl>
                </g:if>

                <g:if test="${cargoApoderadoInstance?.categoriasDeTipoDePoder}">
                    <dl>
                        <dt><g:message code="cargoApoderado.categoriasDeTipoDePoder.label" default="Categorias De Tipo De Poder" /></dt>

                        <g:each in="${cargoApoderadoInstance.categoriasDeTipoDePoder}" var="c">
                            <dd>- ${c.detalles}</dd>
                        </g:each>

                    </dl>
                </g:if>

            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${cargoApoderadoInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${cargoApoderadoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>                    
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
