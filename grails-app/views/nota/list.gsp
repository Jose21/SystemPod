
<%@ page import="com.app.sgtask.Nota" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    
    <g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Lista: Notas</h1>
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
  
          <g:sortableColumn property="titulo" title="${message(code: 'nota.titulo.label', default: 'Titulo')}" />
        
          <g:sortableColumn property="descripcion" title="${message(code: 'nota.descripcion.label', default: 'Descripcion')}" />
        
              <th><g:message code="nota.tarea.label" default="Tarea" /></th>
        
          <g:sortableColumn property="dateCreated" title="${message(code: 'nota.dateCreated.label', default: 'Date Created')}" />
        
          <g:sortableColumn property="lastUpdated" title="${message(code: 'nota.lastUpdated.label', default: 'Last Updated')}" />
        
          </tr>
          </thead>
          <tbody>
          <g:each in="${notaInstanceList}" status="i" var="notaInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  
                <td><g:link action="show" id="${notaInstance.id}">${fieldValue(bean: notaInstance, field: "titulo")}</g:link></td>
      
                <td>${fieldValue(bean: notaInstance, field: "descripcion")}</td>

                <td>${fieldValue(bean: notaInstance, field: "tarea")}</td>

                <td><g:formatDate date="${notaInstance.dateCreated}" /></td>

                <td><g:formatDate date="${notaInstance.lastUpdated}" /></td>

            </tr>
          </g:each>
          </tbody>
        </table>
      </div>        
      <div class="pagination">
        <g:paginate total="${notaInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
