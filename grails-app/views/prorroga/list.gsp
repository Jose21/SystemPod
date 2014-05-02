
<%@ page import="com.app.sgpod.Prorroga" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'prorroga.label', default: 'Prorroga')}" />    
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
                            
                            <th><g:message code="prorroga.asignadoA.label" default="Asignado A" /></th>
                                
                            <th><g:message code="prorroga.creadoPor.label" default="Creado Por" /></th>
                                
                                <g:sortableColumn property="dateCreated" title="${message(code: 'prorroga.dateCreated.label', default: 'Date Created')}" />                                                                
                                
                                <g:sortableColumn property="fechaDeEnvio" title="${message(code: 'prorroga.fechaDeEnvio.label', default: 'Fecha De Envio')}" />
                                
                                <g:sortableColumn property="motivos" title="${message(code: 'prorroga.motivos.label', default: 'Motivos')}" />
                                
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${prorrogaInstanceList}" status="i" var="prorrogaInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                
                                <td><g:link action="show" id="${prorrogaInstance.id}">${fieldValue(bean: prorrogaInstance, field: "asignadoA")}</g:link></td>
                                
                                <td>${fieldValue(bean: prorrogaInstance, field: "creadoPor")}</td>
                                
                                <td><g:formatDate date="${prorrogaInstance.dateCreated}" /></td>                                                                
                                
                                <td><g:formatDate date="${prorrogaInstance.fechaDeEnvio}" /></td>
                                
                                <td>${fieldValue(bean: prorrogaInstance, field: "motivos")}</td>
                                
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${prorrogaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
