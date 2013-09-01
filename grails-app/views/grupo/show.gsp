
<%@ page import="com.app.sgtask.Grupo" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'grupo.label', default: 'Grupo')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Mostrar: Grupo</h1>
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
			
				<g:if test="${grupoInstance?.nombre}">
                                  <dl>
                                      <dt><g:message code="grupo.nombre.label" default="Nombre" /></dt>
					
                                                <dd><g:fieldValue bean="${grupoInstance}" field="nombre"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${grupoInstance?.descripcion}">
                                  <dl>
                                      <dt><g:message code="grupo.descripcion.label" default="Descripcion" /></dt>
					
                                                <dd><g:fieldValue bean="${grupoInstance}" field="descripcion"/></dd>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${grupoInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${grupoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
