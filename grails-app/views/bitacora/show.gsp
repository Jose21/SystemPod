
<%@ page import="com.app.sgpod.Bitacora" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'bitacora.label', default: 'Bitacora')}" />
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
			
				<g:if test="${bitacoraInstance?.diasProrrogas}">
                                  <dl>
                                      <dt><g:message code="bitacora.diasProrrogas.label" default="Dias Prorrogas" /></dt>
					
                                                <dd><g:fieldValue bean="${bitacoraInstance}" field="diasProrrogas"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${bitacoraInstance?.fechaDeCreacion}">
                                  <dl>
                                      <dt><g:message code="bitacora.fechaDeCreacion.label" default="Fecha De Creacion" /></dt>
					
						<dd><g:formatDate date="${bitacoraInstance?.fechaDeCreacion}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${bitacoraInstance?.fechaDeEnvio}">
                                  <dl>
                                      <dt><g:message code="bitacora.fechaDeEnvio.label" default="Fecha De Envio" /></dt>
					
						<dd><g:formatDate date="${bitacoraInstance?.fechaDeEnvio}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${bitacoraInstance?.fechaDeVencimiento}">
                                  <dl>
                                      <dt><g:message code="bitacora.fechaDeVencimiento.label" default="Fecha De Vencimiento" /></dt>
					
						<dd><g:formatDate date="${bitacoraInstance?.fechaDeVencimiento}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${bitacoraInstance?.fechaFactura}">
                                  <dl>
                                      <dt><g:message code="bitacora.fechaFactura.label" default="Fecha Factura" /></dt>
					
						<dd><g:formatDate date="${bitacoraInstance?.fechaFactura}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${bitacoraInstance?.fechaOtorgamientoRevocacion}">
                                  <dl>
                                      <dt><g:message code="bitacora.fechaOtorgamientoRevocacion.label" default="Fecha Otorgamiento Revocacion" /></dt>
					
						<dd><g:formatDate date="${bitacoraInstance?.fechaOtorgamientoRevocacion}" /></dd>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${bitacoraInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${bitacoraInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
