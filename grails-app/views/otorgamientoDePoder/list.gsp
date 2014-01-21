
<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento De Poder')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>    
        <div class="page-header position-relative">
            <h1>
                Lista: Otorgamiento De Poderes
            </h1>
        </div><!--/.page-header-->

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>

            <div class="widget-content nopadding">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'otorgamientoDePoder.id.label', default: 'Número de Folio')}" />
                            <g:sortableColumn property="registroDeLaSolicitud" title="${message(code: 'otorgamientoDePoder.registroDeLaSolicitud.label', default: 'Registro De La Solicitud')}" />               
                            <g:sortableColumn property="categoriaDeTipoDePoder" title="${message(code: 'otorgamientoDePoder.categoriaDeTipoDePoder.label', default: 'Tipo De Poder')}" />
                            <g:sortableColumn property="delegacion" title="${message(code: 'otorgamientoDePoder.delegacion.label', default: 'Delegación')}" />
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${otorgamientoDePoderInstanceList}" status="i" var="otorgamientoDePoderInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><g:link action="edit" id="${otorgamientoDePoderInstance.id}"><span class="badge">${fieldValue(bean: otorgamientoDePoderInstance, field: "id")}-O</span></g:link></td>
                                <td><g:formatDate date="${otorgamientoDePoderInstance.registroDeLaSolicitud}" /></td>                                                 
                                <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "categoriaDeTipoDePoder.nombre")}</td>
                                <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "delegacion")}</td>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${otorgamientoDePoderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
