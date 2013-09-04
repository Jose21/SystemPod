<%@ page import="com.app.sgtask.Nota" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'nota.label', default: 'Nota')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Editar: Nota</h1>      
    </div>
    
    <div class="container-fluid">
      <br/>
      <g:render template="/shared/alerts"/>

      <g:hasErrors bean="${notaInstance}">
        <ul class="errors" role="alert">
          <g:eachError bean="${notaInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
          </g:eachError>
        </ul>
      </g:hasErrors>

          <g:form class="form-horizontal" method="post" >
            <g:hiddenField name="id" value="${notaInstance?.id}" />
            <g:hiddenField name="version" value="${notaInstance?.version}" />
            <g:hiddenField name="tarea" id="tarea.id" value="${notaInstance?.tarea?.id}"/>
            <g:render template="form"/>
            <div class="form-actions">
              <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
              
            </div>
          </g:form>

    </div>
  </body>
</html>
