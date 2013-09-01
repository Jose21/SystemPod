<%@ page import="com.app.sgtask.Tarea" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Tarea')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>    
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Crear: Tarea</h1>      
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

      
          <g:form class="form-horizontal" action="save" >
            <g:render template="form"/>
            <div class="form-actions">
              <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
            </div>
          </g:form>
        
    </div>
  </body>
</html>
