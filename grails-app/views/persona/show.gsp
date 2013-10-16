
<%@ page import="com.app.sgcon.Persona" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Mostrar: Persona</h1>
      <div class="btn-group">
        <g:link class="btn btn-small tip-bottom" action="index">
          <i class="icon-file"></i>
          Lista: Personas
        </g:link>
        <g:link class="btn btn-small tip-bottom" action="create">
          <i class="icon-file"></i>
          <g:message code="default.new.label" args="[entityName]" />
        </g:link>
      </div>
    </div>
    
  <div class="container-fluid">
    <g:if test="${flash.message}">
      <br/>
      <div class="alert alert-info">
        <strong>¡Información!</strong> ${flash.message}
      </div>
    </g:if>
    <div class="well">
			
				<g:if test="${personaInstance?.nombre}">
                                  <dl>
                                      <dt><g:message code="persona.nombre.label" default="Nombre" /></dt>
					
                                                <dd><g:fieldValue bean="${personaInstance}" field="nombre"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${personaInstance?.puesto}">
                                  <dl>
                                      <dt><g:message code="persona.puesto.label" default="Puesto" /></dt>
					
                                                <dd><g:fieldValue bean="${personaInstance}" field="puesto"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${personaInstance?.area}">
                                  <dl>
                                      <dt><g:message code="persona.area.label" default="Area" /></dt>
					
                                                <dd><g:fieldValue bean="${personaInstance}" field="area"/></dd>
					
                                  </dl>
				</g:if>
			
                                <g:if test="${personaInstance?.institucion}">
                                  <dl>
                                      <dt><g:message code="persona.institucion.label" default="Institución" /></dt>
					
                                                <dd><g:fieldValue bean="${personaInstance}" field="institucion"/></dd>
					
                                  </dl>
				</g:if>
      
				<g:if test="${personaInstance?.email}">
                                  <dl>
                                      <dt><g:message code="persona.email.label" default="Email" /></dt>
					
                                                <dd><g:fieldValue bean="${personaInstance}" field="email"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${personaInstance?.telefono}">
                                  <dl>
                                      <dt><g:message code="persona.telefono.label" default="Telefono" /></dt>
					
                                                <dd><g:fieldValue bean="${personaInstance}" field="telefono"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${personaInstance?.extension}">
                                  <dl>
                                      <dt><g:message code="persona.extension.label" default="Extension" /></dt>
					
                                                <dd><g:fieldValue bean="${personaInstance}" field="extension"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${personaInstance?.dateCreated}">
                                  <dl>
                                      <dt><g:message code="persona.dateCreated.label" default="Fecha de Creación" /></dt>
					
						<dd><g:formatDate date="${personaInstance?.dateCreated}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${personaInstance?.lastUpdated}">
                                  <dl>
                                      <dt><g:message code="persona.lastUpdated.label" default="Última Actualización" /></dt>
					
						<dd><g:formatDate date="${personaInstance?.lastUpdated}" /></dd>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${personaInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${personaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
