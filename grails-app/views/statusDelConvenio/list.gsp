
<%@ page import="com.app.sgcon.StatusDelConvenio" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <g:set var="entityName" value="${message(code: 'statusDelConvenio.label', default: 'StatusDelConvenio')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    
    <div class="page-header position-relative">
      <h1>
        Lista: Status De Convenio
      </h1>
      <div class="btn-group">
        <g:link class="btn btn-small tip-bottom" action="create">
          <i class="icon-file"></i>
          <g:message code="default.new.label" args="[entityName]" />
        </g:link>
      </div>
    </div><!--/.page-header-->

                                        
    <div class="container-fluid">
      
      <g:render template="/shared/alerts" />
      
      <div class="widget-content nopadding">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
  
          <g:sortableColumn property="nombre" title="${message(code: 'statusDelConvenio.nombre.label', default: 'Nombre')}" />
        
          <g:sortableColumn property="dateCreated" title="${message(code: 'statusDelConvenio.dateCreated.label', default: 'Date Created')}" />
        
          <g:sortableColumn property="lastUpdated" title="${message(code: 'statusDelConvenio.lastUpdated.label', default: 'Last Updated')}" />
        
          </tr>
          </thead>
          <tbody>
          <g:each in="${statusDelConvenioInstanceList}" status="i" var="statusDelConvenioInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  
                <td><g:link action="show" id="${statusDelConvenioInstance.id}">${fieldValue(bean: statusDelConvenioInstance, field: "nombre")}</g:link></td>
      
            <td><g:formatDate date="${statusDelConvenioInstance.dateCreated}" /></td>
        
            <td><g:formatDate date="${statusDelConvenioInstance.lastUpdated}" /></td>
        
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>        
      <div class="pagination">
        <g:paginate total="${statusDelConvenioInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
