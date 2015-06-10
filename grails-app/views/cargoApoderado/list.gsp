
<%@ page import="com.app.sgpod.CargoApoderado" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cargoApoderado.label', default: 'Cargo de Apoderado')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="page-header position-relative">
            <h1>
                <g:message code="default.list.label" args="[entityName]" />
            </h1>
            <div class="btn-group">
                <g:link class="btn btn-warning tip-bottom" action="create">
                    <i class="icon-user"> Nuevo Cargo de Apoderado </i>                    
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

                            <th>Nombre</th>
                            <th> Categorias</th>

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${cargoApoderadoInstanceList}" status="i" var="cargoApoderadoInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td><g:link action="show" id="${cargoApoderadoInstance.id}">${fieldValue(bean: cargoApoderadoInstance, field: "nombreCargo")}</g:link></td>
                                    <td>
                                    <g:if test="${cargoApoderadoInstance?.categoriasDeTipoDePoder}">
                                        <dl>                                           
                                            <g:each in="${cargoApoderadoInstance.categoriasDeTipoDePoder}" var="c">
                                                <dd>- ${c.detalles}</dd>
                                            </g:each>
                                        </dl>
                                    </g:if>
                                </td>
                            </tr>

                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${cargoApoderadoInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
