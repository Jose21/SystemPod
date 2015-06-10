
<%@ page import="com.app.sgpod.TipoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'tipoDePoder.label', default: 'Tipo De Poder')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="page-header position-relative">
            <h1>
                <g:message code="default.list.label" args="[entityName]" />                
            </h1>
            </br>
            <div class="btn-group">
                <g:link class="btn btn-warning tip-bottom" action="create">
                    <i class="icon-legal"> Nuevo Tipo de Poder </i>                    
                </g:link>
                <g:link class="btn btn-success tip-bottom" controller="categoriaDeTipoDePoder" action="create">
                    <i class="icon-folder-open"> Nueva Categoria </i>                    
                </g:link>
                <g:link class="btn btn-purple tip-bottom" controller="categoriaDeTipoDePoder" action="list">
                    <i class="icon-folder-open"> Editar Categorias </i>                    
                </g:link>
            </div> 

        </div><!--/.page-header-->


        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>
            <br/>
            <div class="widget-content nopadding">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <g:sortableColumn property="nombre" title="${message(code: 'tipoDePoder.nombre.label', default: 'Tipo de Poder')}" />
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${tipoDePoderInstanceList}" status="i" var="tipoDePoderInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><g:link action="show" id="${tipoDePoderInstance.id}">${fieldValue(bean: tipoDePoderInstance, field: "nombre")}</g:link></td>
                                </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${tipoDePoderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
