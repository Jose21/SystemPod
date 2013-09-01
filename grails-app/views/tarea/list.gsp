
<%@ page import="com.app.sgtask.Tarea" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">    
    <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Tarea')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>    
    
    <div class="page-header position-relative">
      <h1>
        Lista: 
        <g:if test="${opt == 'hoy'}">
          Tareas para Hoy
        </g:if>
        <g:elseif test="${opt == 'programadas'}">
          Tareas Programadas
        </g:elseif>
        <g:elseif test="${opt == 'retrasadas'}">
          Tareas Retrasadas
        </g:elseif>
      </h1>      
    </div><!--/.page-header-->

    <div class="container-fluid">
      <br/>
      <g:render template="/shared/alerts" />
      <br/>
      <div class="widget-content nopadding">
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
  
          <g:sortableColumn property="nombre" title="${message(code: 'tarea.nombre.label', default: 'Nombre')}" />
        
          
        
          <g:sortableColumn property="fechaLimite" title="${message(code: 'tarea.fechaLimite.label', default: 'Fecha Limite')}" />
        
              <th><g:message code="tarea.grupo.label" default="Grupo" /></th>
        
          </tr>
          </thead>
          <tbody>
          <g:each in="${tareaInstanceList}" status="i" var="tareaInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  
                <td><g:link action="show" id="${tareaInstance.id}">${fieldValue(bean: tareaInstance, field: "nombre")}</g:link></td>
      
            
        
            <td><g:formatDate date="${tareaInstance.fechaLimite}" /></td>
        
            <td>${fieldValue(bean: tareaInstance, field: "grupo")}</td>
        
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>        
      <div class="pagination">
        <g:paginate total="${tareaInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
