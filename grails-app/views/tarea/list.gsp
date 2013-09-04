
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
        <g:if test="${session.opt == 'hoy'}">
          Tareas para Hoy
        </g:if>
        <g:elseif test="${session.opt == 'programadas'}">
          Tareas Programadas
        </g:elseif>
        <g:elseif test="${session.opt == 'retrasadas'}">
          Tareas Retrasadas
        </g:elseif>
        <g:elseif test="${session.opt == 'asignadas'}">
          Tareas Asignadas
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
              <g:sortableColumn property="id" title="${message(code: 'tarea.id.label', default: 'Identificador')}" />
              <g:sortableColumn property="nombre" title="${message(code: 'tarea.nombre.label', default: 'Nombre')}" />
              <g:sortableColumn property="fechaLimite" title="${message(code: 'tarea.fechaLimite.label', default: 'Fecha Limite')}" />        
              <th><g:message code="tarea.grupo.label" default="Grupo" /></th>
              <th>Historial</th>
            </tr>
          </thead>
          <tbody>
          <g:each in="${tareaInstanceList}" status="i" var="tareaInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">              
              <td>
                <g:link action="show" id="${tareaInstance.id}">
                <span class="label label-success arrowed-in">
                  ${fieldValue(bean: tareaInstance, field:"id")}
                </span>
                </g:link>
              </td>
              <td><g:link action="show" id="${tareaInstance.id}">${fieldValue(bean: tareaInstance, field: "nombre")}</g:link></td>
              <td><g:formatDate date="${tareaInstance.fechaLimite}" /></td>
              <td>${fieldValue(bean: tareaInstance, field: "grupo")}</td>
              <td>
                <g:link action="historial" id="${tareaInstance?.id}" class="btn btn-info btn-mini">
                  <i class="icon-calendar bigger-110 icon-only"></i>
                </g:link>
              </td>
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
