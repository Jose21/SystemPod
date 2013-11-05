
<%@ page import="com.app.sgpod.Delegacion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'delegacion.label', default: 'Delegacion')}" />    
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

                            <g:sortableColumn property="nombre" title="${message(code: 'delegacion.nombre.label', default: 'Nombre')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${delegacionInstanceList}" status="i" var="delegacionInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:link action="show" id="${delegacionInstance.id}">${fieldValue(bean: delegacionInstance, field: "nombre")}</g:link></td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${delegacionInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
