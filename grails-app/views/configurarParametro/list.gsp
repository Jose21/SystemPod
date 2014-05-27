
<%@ page import="com.app.sgpod.ConfigurarParametro" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'configurarParametro.label', default: 'ConfigurarParametro')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="page-header position-relative">
            <h1>
                <g:message code="default.list.label" args="[entityName]" />
            </h1>
            <div class="btn-group">
                <g:link class="btn btn-small tip-bottom" action="create">
                    <i class="icon-file"></i>
                    <g:message code="default.new.label" args="[entityName]" />
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
                            
                                <g:sortableColumn property="estadoCriticoPoder" title="${message(code: 'configurarParametro.estadoCriticoPoder.label', default: 'Estado Critico Poder')}" />
                                
                                <g:sortableColumn property="estadoSemiPoder" title="${message(code: 'configurarParametro.estadoSemiPoder.label', default: 'Estado Semi Poder')}" />                                                                
                                
                                <g:sortableColumn property="estadoCriticoSolicitud" title="${message(code: 'configurarParametro.estadoCriticoSolicitud.label', default: 'Estado Critico Solicitud')}" />
                                
                                <g:sortableColumn property="estadoSemiSolicitud" title="${message(code: 'configurarParametro.estadoSemiSolicitud.label', default: 'Estado Semi Solicitud')}" />                                                                
                                
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${configurarParametroInstanceList}" status="i" var="configurarParametroInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><g:link action="show" id="${configurarParametroInstance.id}">${fieldValue(bean: configurarParametroInstance, field: "estadoCriticoPoder")}</g:link></td>
                                
                                <td>${fieldValue(bean: configurarParametroInstance, field: "estadoSemiPoder")}</td>                                                                
                                
                                <td>${fieldValue(bean: configurarParametroInstance, field: "estadoCriticoSolicitud")}</td>
                                
                                <td>${fieldValue(bean: configurarParametroInstance, field: "estadoSemiSolicitud")}</td>                                                                
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${configurarParametroInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
