<%@ page import="com.app.sgtask.Tarea;com.app.sgcon.Convenio;com.app.sgpod.OtorgamientoDePoder;com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Turno')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>    
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Crear: Turno</h1>      
    </div>

    <div class="container-fluid">
      <g:if test="${session.idConvenio}">
        <br/>
          <g:link class="btn btn-small btn-info btn-block" controller="convenio" action="edit" id="${Convenio.get(session.idConvenio).id}">
            El turno se asociará al convenio: ${Convenio.get(session.idConvenio).id} - Número de Convenio: ${Convenio.get(session.idConvenio).numeroDeConvenio} - Objeto: ${Convenio.get(session.idConvenio).objeto}
          </g:link>
        <br/>
      </g:if>
      <g:if test="${session.idOtorgamientoDePoder}">
        <br/>
          <g:link class="btn btn-small btn-info btn-block" controller="otorgamientoDePoder" action="edit" id="${OtorgamientoDePoder.get(session.idOtorgamientoDePoder).id}">
            El turno se asociará al Otorgamiento De Poder: ${OtorgamientoDePoder.get(session.idOtorgamientoDePoder).id}-O
          </g:link>
        <br/>
      </g:if>
      <g:if test="${session.idRevocacionDePoder}">
        <br/>
          <g:link class="btn btn-small btn-info btn-block" controller="revocacionDePoder" action="edit" id="${RevocacionDePoder.get(session.idRevocacionDePoder).id}">
            El turno se asociará a la Revocación De Poder: ${RevocacionDePoder.get(session.idRevocacionDePoder).id}-R
          </g:link>
        <br/>
      </g:if>
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
