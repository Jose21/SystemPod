
<%@ page import="com.app.sgtask.Documento" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    
    <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Lista: Documentos</h1>
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
  
          <g:sortableColumn property="archivo" title="${message(code: 'documento.archivo.label', default: 'Archivo')}" />
        
              <th><g:message code="documento.nota.label" default="Nota" /></th>
        
          </tr>
          </thead>
          <tbody>
          <g:each in="${documentoInstanceList}" status="i" var="documentoInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
  
                <td><g:link action="show" id="${documentoInstance.id}">${fieldValue(bean: documentoInstance, field: "archivo")}</g:link></td>
      
            <td>${fieldValue(bean: documentoInstance, field: "nota")}</td>
        
            </tr>
          </g:each>
          </tbody>
        </table>
      </div>        
      <div class="pagination">
        <g:paginate total="${documentoInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
