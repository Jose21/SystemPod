<%@ page import="com.app.sgcon.StatusDelConvenio" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <g:set var="entityName" value="${message(code: 'statusDelConvenio.label', default: 'StatusDelConvenio')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Crear: Status Del Convenio</h1>
      <div class="btn-group">
        <g:link class="btn btn-small tip-bottom" action="index">
          <i class="icon-file"></i>
          <g:message code="default.list.label" args="[entityName]" />
        </g:link>
      </div>
    </div>

    <div class="container-fluid">
      <br/>
      <g:if test="${flash.message}">
        <div class="alert">
          <strong>¡Atención!</strong> ${flash.message}
        </div>
      </g:if>

      <g:hasErrors bean="${statusDelConvenioInstance}">
        <ul class="errors" role="alert">
          <g:eachError bean="${statusDelConvenioInstance}" var="error">
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
