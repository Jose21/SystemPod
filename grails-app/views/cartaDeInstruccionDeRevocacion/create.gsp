<%@ page import="com.app.sgpod.CartaDeInstruccionDeRevocacion" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainPoderes">
    <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
            <h1>Crear: Carta de Instrucción de Revocación de Poder</h1>
    </div>

    <div class="container-fluid">
      <br/>
      <g:if test="${flash.message}">
        <div class="alert">
          <strong>¡Atención!</strong> ${flash.message}
        </div>
      </g:if>

      <g:hasErrors bean="${cartaDeInstruccionDeRevocacionInstance}">
        <ul class="errors" role="alert">
          <g:eachError bean="${cartaDeInstruccionDeRevocacionInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
          </g:eachError>
        </ul>
      </g:hasErrors>

      
          <g:form class="form-horizontal" action="save" >
            <g:render template="form"/>
            <g:hiddenField name="revocacionDePoderId" value="${revocacionDePoderId}"/>
            <div class="form-actions">
              <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
            </div>
          </g:form>
      
    </div>
  </body>
</html>
