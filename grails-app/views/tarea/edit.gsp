<%@ page import="com.app.sgtask.Tarea" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Tarea')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <calendar:resources lang="es" theme="aqua"/>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Editar: Tarea</h1>
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
            <g:render template="form"/>
            <div class="form-actions">
              <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
              <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
            </div>
          </g:form>

    </div>
  </body>
</html>
