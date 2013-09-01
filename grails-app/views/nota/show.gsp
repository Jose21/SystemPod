
<%@ page import="com.app.sgtask.Nota" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Mostrar: Nota</h1>
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
			
				<g:if test="${notaInstance?.titulo}">
                                  <dl>
                                      <dt><g:message code="nota.titulo.label" default="Titulo" /></dt>
					
                                                <dd><g:fieldValue bean="${notaInstance}" field="titulo"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${notaInstance?.descripcion}">
                                  <dl>
                                      <dt><g:message code="nota.descripcion.label" default="Descripcion" /></dt>
					
                                                <dd><g:fieldValue bean="${notaInstance}" field="descripcion"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${notaInstance?.tarea}">
                                  <dl>
                                      <dt><g:message code="nota.tarea.label" default="Tarea" /></dt>
					
						<dd><g:link controller="tarea" action="show" id="${notaInstance?.tarea?.id}">${notaInstance?.tarea?.encodeAsHTML()}</g:link></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${notaInstance?.documentos}">
                                  <dl>
                                      <dt><g:message code="nota.documentos.label" default="Documentos" /></dt>
					
						<g:each in="${notaInstance.documentos}" var="d">
                                                  <dd><g:link controller="documento" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></dd>
						</g:each>
					
                                  </dl>
				</g:if>
			
				<g:if test="${notaInstance?.dateCreated}">
                                  <dl>
                                      <dt><g:message code="nota.dateCreated.label" default="Date Created" /></dt>
					
						<dd><g:formatDate date="${notaInstance?.dateCreated}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${notaInstance?.lastUpdated}">
                                  <dl>
                                      <dt><g:message code="nota.lastUpdated.label" default="Last Updated" /></dt>
					
						<dd><g:formatDate date="${notaInstance?.lastUpdated}" /></dd>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${notaInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${notaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
