
<%@ page import="com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'Revocacion De Poder')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="page-header position-relative">
            <h1>Lista: Revocación de Poder</h1>            
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>
            
            <div class="widget-content nopadding">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>

                            <g:sortableColumn property="id" title="${message(code: 'revocacionDePoder.id.label', default: 'Identificador')}" />
                            
                            <g:sortableColumn property="escrituraPublica" title="${message(code: 'revocacionDePoder.escrituraPublica.label', default: 'Escritura Publica')}" />

                            <g:sortableColumn property="notario" title="${message(code: 'revocacionDePoder.notario.label', default: 'Notario')}" />

                            <g:sortableColumn property="nombre" title="${message(code: 'revocacionDePoder.nombre.label', default: 'Nombre')}" />

                            <g:sortableColumn property="puesto" title="${message(code: 'revocacionDePoder.puesto.label', default: 'Puesto')}" />

                            <g:sortableColumn property="contrato" title="${message(code: 'revocacionDePoder.contrato.label', default: 'Contrato')}" />

                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${revocacionDePoderInstanceList}" status="i" var="revocacionDePoderInstance">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td><g:link action="edit" id="${revocacionDePoderInstance.id}"><span class="badge">${fieldValue(bean: revocacionDePoderInstance, field: "id")}</span></g:link></td>
                                
                                <td>${fieldValue(bean: revocacionDePoderInstance, field: "escrituraPublica")}</td>

                                <td>${fieldValue(bean: revocacionDePoderInstance, field: "notario")}</td>

                                <td>${fieldValue(bean: revocacionDePoderInstance, field: "nombre")}</td>

                                <td>${fieldValue(bean: revocacionDePoderInstance, field: "puesto")}</td>

                                <td>${fieldValue(bean: revocacionDePoderInstance, field: "contrato")}</td>

                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="${revocacionDePoderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
