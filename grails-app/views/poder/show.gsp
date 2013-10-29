
<%@ page import="com.app.sgpod.Poder" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainPoderes">
    <g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
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
			
				<g:if test="${poderInstance?.numeroDeFolio}">
                                  <dl>
                                      <dt><g:message code="poder.numeroDeFolio.label" default="Numero De Folio" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="numeroDeFolio"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.registroDeLaSolicitud}">
                                  <dl>
                                      <dt><g:message code="poder.registroDeLaSolicitud.label" default="Registro De La Solicitud" /></dt>
					
						<dd><g:formatDate date="${poderInstance?.registroDeLaSolicitud}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.tipoDePoder}">
                                  <dl>
                                      <dt><g:message code="poder.tipoDePoder.label" default="Tipo De Poder" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="tipoDePoder"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.delegacion}">
                                  <dl>
                                      <dt><g:message code="poder.delegacion.label" default="Delegacion" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="delegacion"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.puesto}">
                                  <dl>
                                      <dt><g:message code="poder.puesto.label" default="Puesto" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="puesto"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.contrato}">
                                  <dl>
                                      <dt><g:message code="poder.contrato.label" default="Contrato" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="contrato"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.poderSolicitado}">
                                  <dl>
                                      <dt><g:message code="poder.poderSolicitado.label" default="Poder Solicitado" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="poderSolicitado"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.motivoDeOtorgamiento}">
                                  <dl>
                                      <dt><g:message code="poder.motivoDeOtorgamiento.label" default="Motivo De Otorgamiento" /></dt>
					
						<dd><g:link controller="motivoDeOtorgamiento" action="show" id="${poderInstance?.motivoDeOtorgamiento?.id}">${poderInstance?.motivoDeOtorgamiento?.encodeAsHTML()}</g:link></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.solicitadoPor}">
                                  <dl>
                                      <dt><g:message code="poder.solicitadoPor.label" default="Solicitado Por" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="solicitadoPor"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.fechaDeOtorgamientoDePoder}">
                                  <dl>
                                      <dt><g:message code="poder.fechaDeOtorgamientoDePoder.label" default="Fecha De Otorgamiento De Poder" /></dt>
					
						<dd><g:formatDate date="${poderInstance?.fechaDeOtorgamientoDePoder}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.escrituraPublicaDeOtorgamiento}">
                                  <dl>
                                      <dt><g:message code="poder.escrituraPublicaDeOtorgamiento.label" default="Escritura Publica De Otorgamiento" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="escrituraPublicaDeOtorgamiento"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${poderInstance?.comentarios}">
                                  <dl>
                                      <dt><g:message code="poder.comentarios.label" default="Comentarios" /></dt>
					
                                                <dd><g:fieldValue bean="${poderInstance}" field="comentarios"/></dd>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${poderInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${poderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
