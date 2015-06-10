
<%@ page import="com.app.sgpod.TipoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'tipoDePoder.label', default: 'Tipo De Poder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>        
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <div class="btn-group">
                <g:link class="btn btn-success tip-bottom" action="index">
                    <i class="icon-list"> Lista: Tipo de Poder</i>                    
                </g:link>
                <g:link class="btn btn-warning tip-bottom" action="create">
                    <i class="icon-legal"> Nuevo: Tipo de Poder </i>                    
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
                <g:if test="${tipoDePoderInstance?.nombre}">
                    <dl>
                        <dt><g:message code="tipoDePoder.nombre.label" default="Nombre" /></dt>

                        <dd><g:fieldValue bean="${tipoDePoderInstance}" field="nombre"/></dd>

                    </dl>
                </g:if>
                <g:if test="${tipoDePoderInstance?.categorias}">
                    <dl>
                        <dt><g:message code="tipoDePoder.categorias.label" default="Categorias" /></dt>
                        <g:each in="${tipoDePoderInstance.categorias.sort{it.id}}" var="c">
                            <dd>- ${c.detalles}</dd>
                        </g:each>
                    </dl>
                </g:if>                
            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${tipoDePoderInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${tipoDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <!--g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /-->
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
