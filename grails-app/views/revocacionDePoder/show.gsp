
<%@ page import="com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1><g:message code="default.show.label" args="[entityName]" /></h1>
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
    <g:if test="${flash.message}">
      <br/>
      <div class="alert alert-info">
        <strong>¡Información!</strong> ${flash.message}
      </div>
    </g:if>
    <div class="well">
			
				<g:if test="${revocacionDePoderInstance?.escrituraPublica}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.escrituraPublica.label" default="Escritura Publica" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="escrituraPublica"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.nombreDeNotario}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.nombreDeNotario.label" default="Nombre De Notario" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="nombreDeNotario"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.numeroDeNotario}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.numeroDeNotario.label" default="Numero De Notario" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="numeroDeNotario"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.nombre}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.nombre.label" default="Nombre" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="nombre"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.puesto}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.puesto.label" default="Puesto" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="puesto"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.contrato}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.contrato.label" default="Contrato" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="contrato"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.tipoDePoder}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.tipoDePoder.label" default="Tipo De Poder" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="tipoDePoder"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.delegacion}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.delegacion.label" default="Delegacion" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="delegacion"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.motivoDeRevocacion}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.motivoDeRevocacion.label" default="Motivo De Revocacion" /></dt>
					
						<dd><g:link controller="motivoDeRevocacion" action="show" id="${revocacionDePoderInstance?.motivoDeRevocacion?.id}">${revocacionDePoderInstance?.motivoDeRevocacion?.encodeAsHTML()}</g:link></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.solicitadoPor}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.solicitadoPor.label" default="Solicitado Por" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="solicitadoPor"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.fechaDeRevocacion}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha De Revocacion" /></dt>
					
						<dd><g:formatDate date="${revocacionDePoderInstance?.fechaDeRevocacion}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.escrituraPublicaDeRevocacion}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.escrituraPublicaDeRevocacion.label" default="Escritura Publica De Revocacion" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="escrituraPublicaDeRevocacion"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${revocacionDePoderInstance?.comentarios}">
                                  <dl>
                                      <dt><g:message code="revocacionDePoder.comentarios.label" default="Comentarios" /></dt>
					
                                                <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="comentarios"/></dd>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${revocacionDePoderInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${revocacionDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
