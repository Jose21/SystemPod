
<%@ page import="com.app.sgpod.CategoriaDeTipoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'categoriaDeTipoDePoder.label', default: 'Categoria de tipo de Poder')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>
                <g:message code="default.list.label" args="[entityName]" />
            </h1>
            </br>         
            <div class="btn-group">
                <g:link class="btn btn-success tip-bottom" action="create">
                    <i class="icon-folder-open"> Nueva Categoria</i>                    
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
                            <th><g:message code="categoriaDeTipoDePoder.nombre.label" default="Nombre" /></th>
                            <th style="width:60%"><g:message code="categoriaDeTipoDePoder.detalles.label" default="Descripción del Modelo" /></th>
                            <th><g:message code="categoriaDeTipoDePoder.tipoDePoder.label" default="Tipo De Poder" /></th>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${categoriaDeTipoDePoderInstanceList.sort{it.nombre}}" status="i" var="categoriaDeTipoDePoderInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><g:link action="show" id="${categoriaDeTipoDePoderInstance.id}">${fieldValue(bean: categoriaDeTipoDePoderInstance, field: "nombre")}</g:link></td>
                                <td>${fieldValue(bean: categoriaDeTipoDePoderInstance, field: "detalles")}</td>
                                <td>${fieldValue(bean: categoriaDeTipoDePoderInstance, field: "tipoDePoder")}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${categoriaDeTipoDePoderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
