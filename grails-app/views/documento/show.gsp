
<%@ page import="com.app.sgtask.Documento" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Mostrar: Documento</h1>
      <div class="btn-group">
        <g:link class="btn btn-small tip-bottom" action="index">
          <i class="icon-file"></i>
          <g:message code="default.list.label" args="[entityName]" />
        </g:link>
        <g:link class="btn btn-small tip-bottom" action="create">
          <i class="icon-file"></i>
          <g:message code="default.new.label" args="[entityName]" />
        </g:link>
      </div>
    </div>

  <div class="container-fluid">
    <g:render template="/shared/alerts"/>
    
    <div class="well">
			
				<g:if test="${documentoInstance?.archivo}">
                                  <dl>
                                      <dt><g:message code="documento.archivo.label" default="Archivo" /></dt>
					
                                  </dl>
				</g:if>
			
				<g:if test="${documentoInstance?.nota}">
                                  <dl>
                                      <dt><g:message code="documento.nota.label" default="Nota" /></dt>
					
						<dd><g:link controller="nota" action="show" id="${documentoInstance?.nota?.id}">${documentoInstance?.nota?.encodeAsHTML()}</g:link></dd>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${documentoInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${documentoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
