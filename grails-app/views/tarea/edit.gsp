<%@ page import="com.app.sgtask.Tarea" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Turno')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <calendar:resources lang="es" theme="aqua"/>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Editar: Turno</h1>
    </div>
    
    <div class="container-fluid">
      <br/>
      <g:render template="/shared/alerts" />

      <g:hasErrors bean="${tareaInstance}">
        <ul class="errors" role="alert">
          <g:eachError bean="${tareaInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
          </g:eachError>
        </ul>
      </g:hasErrors>

          <g:form class="form-horizontal" method="post" >
            <g:hiddenField name="id" value="${tareaInstance?.id}" />
            <g:hiddenField name="version" value="${tareaInstance?.version}" />
            <div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'id', 'error')}">
              <label for="id" class="control-label">
                <g:message code="tarea.id.label" default="Identificador" />
              </label>
              <div class="controls">
                <span class="label label-success arrowed-in">${tareaInstance?.id}</span>
              </div>
            </div>
            <g:render template="form"/>
            <div class="form-actions">
              <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
            </div>
          </g:form>

    </div>
  </body>
</html>
