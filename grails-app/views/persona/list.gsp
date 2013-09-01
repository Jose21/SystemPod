
<%@ page import="com.app.sgcon.Persona" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    
    <div class="page-header position-relative">
      <h1>
        Lista: Personas
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
  
          <g:sortableColumn property="nombre" title="${message(code: 'persona.nombre.label', default: 'Nombre')}" />
        
          <g:sortableColumn property="puesto" title="${message(code: 'persona.puesto.label', default: 'Puesto')}" />
        
          <g:sortableColumn property="area" title="${message(code: 'persona.area.label', default: 'Area')}" />
        
          <g:sortableColumn property="email" title="${message(code: 'persona.email.label', default: 'Email')}" />
        
          <g:sortableColumn property="telefono" title="${message(code: 'persona.telefono.label', default: 'Telefono')}" />
        
          <g:sortableColumn property="extension" title="${message(code: 'persona.extension.label', default: 'Extension')}" />
        
          </tr>
          </thead>
          <tbody>
          <g:each in="${personaInstanceList}" status="i" var="personaInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  
                <td><g:link action="show" id="${personaInstance.id}">${fieldValue(bean: personaInstance, field: "nombre")}</g:link></td>
      
            <td>${fieldValue(bean: personaInstance, field: "puesto")}</td>
        
            <td>${fieldValue(bean: personaInstance, field: "area")}</td>
        
            <td>${fieldValue(bean: personaInstance, field: "email")}</td>
        
            <td>${fieldValue(bean: personaInstance, field: "telefono")}</td>
        
            <td>${fieldValue(bean: personaInstance, field: "extension")}</td>
        
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>        
      <div class="pagination">
        <g:paginate total="${personaInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
