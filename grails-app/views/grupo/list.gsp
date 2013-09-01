
<%@ page import="com.app.sgtask.Grupo" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'grupo.label', default: 'Grupo')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Lista: Grupos</h1>
      <div class="btn-group">
        <g:link class="btn btn-small tip-bottom" action="create">
          <i class="icon-file"></i>
          <g:message code="default.new.label" args="[entityName]" />
        </g:link>
      </div>
    </div>

    <div class="container-fluid">
      <br/>
      <g:render template="/shared/alerts"/>
      <br/>
      <div class="widget-content nopadding">
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
  
          <g:sortableColumn property="nombre" title="${message(code: 'grupo.nombre.label', default: 'Nombre')}" />
        
          <g:sortableColumn property="descripcion" title="${message(code: 'grupo.descripcion.label', default: 'Descripcion')}" />
        
          </tr>
          </thead>
          <tbody>
          <g:each in="${grupoInstanceList}" status="i" var="grupoInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  
                <td><g:link action="show" id="${grupoInstance.id}">${fieldValue(bean: grupoInstance, field: "nombre")}</g:link></td>
      
            <td>${fieldValue(bean: grupoInstance, field: "descripcion")}</td>
        
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>        
      <div class="pagination">
        <g:paginate total="${grupoInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
