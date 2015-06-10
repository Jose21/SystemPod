
<%@ page import="com.app.sgpod.CategoriaDeTipoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'categoriaDeTipoDePoder.label', default: 'Categoria de Tipo de Poder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>        
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            </br>
            <div class="btn-group">
                <g:link class="btn btn-success tip-bottom" action="index">
                    <i class="icon-list"> Lista: Categorias</i>                    
                </g:link>
                <g:link class="btn btn-warning tip-bottom" action="create">
                    <i class="icon-folder-open"> Nueva categoria </i>                    
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

                <g:if test="${categoriaDeTipoDePoderInstance?.nombre}">
                    <dl>
                        <dt><g:message code="categoriaDeTipoDePoder.nombre.label" default="Nombre" /></dt>
                        <dd><g:fieldValue bean="${categoriaDeTipoDePoderInstance}" field="nombre"/></dd>
                    </dl>
                </g:if>                               
                <dl>
                    <dt><g:message code="categoriaDeTipoDePoder.detalles.label" default="Descripción del Modelo" /></dt>
                    <dd><g:fieldValue bean="${categoriaDeTipoDePoderInstance}" field="detalles"/></dd>
                </dl>               
                <g:if test="${categoriaDeTipoDePoderInstance?.tipoDePoder}">
                    <dl>
                        <dt><g:message code="categoriaDeTipoDePoder.tipoDePoder.label" default="Tipo De Poder" /></dt>
                        <dd> ${categoriaDeTipoDePoderInstance?.tipoDePoder?.nombre} </dd>
                    </dl>
                </g:if>
            </div>
            <g:form class="form-actions">
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${categoriaDeTipoDePoderInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${categoriaDeTipoDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <!--g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /-->
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
