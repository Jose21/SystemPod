
<%@ page import="com.app.sgcon.Convenio" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <g:set var="entityName" value="${message(code: 'convenio.label', default: 'Convenio')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div id="content-header">
      <h1>Mostrar: Convenio</h1>
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
    <g:render template="/shared/alerts"/>
    <div class="well">
			
				<g:if test="${convenioInstance?.objeto}">
                                  <dl>
                                      <dt><g:message code="convenio.objeto.label" default="Objeto" /></dt>
					
                                                <dd><g:fieldValue bean="${convenioInstance}" field="objeto"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${convenioInstance?.sustentoNormativo}">
                                  <dl>
                                      <dt><g:message code="convenio.sustentoNormativo.label" default="Sustento Normativo" /></dt>
					
                                                <dd><g:fieldValue bean="${convenioInstance}" field="sustentoNormativo"/></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${convenioInstance?.fechaDeFirma}">
                                  <dl>
                                      <dt><g:message code="convenio.fechaDeFirma.label" default="Fecha De Firma" /></dt>
					
						<dd><g:formatDate date="${convenioInstance?.fechaDeFirma}" /></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${convenioInstance?.status}">
                                  <dl>
                                      <dt><g:message code="convenio.status.label" default="Status" /></dt>
					
						<dd><g:link controller="statusDeConvenio" action="show" id="${convenioInstance?.status?.id}">${convenioInstance?.status?.encodeAsHTML()}</g:link></dd>
					
                                  </dl>
				</g:if>
			
				<g:if test="${convenioInstance?.compromisos}">
                                  <dl>
                                      <dt><g:message code="convenio.compromisos.label" default="Compromisos" /></dt>
					
						<g:each in="${convenioInstance.compromisos}" var="c">
                                                  <dd><g:link controller="acuerdo" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></dd>
						</g:each>
					
                                  </dl>
				</g:if>
			
				<g:if test="${convenioInstance?.firmantes}">
                                  <dl>
                                      <dt><g:message code="convenio.firmantes.label" default="Firmantes" /></dt>
					
						<g:each in="${convenioInstance.firmantes}" var="f">
                                                  <dd><g:link controller="persona" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></dd>
						</g:each>
					
                                  </dl>
				</g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${convenioInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${convenioInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
