<%@ page import="com.app.sgcon.StatusDelConvenio" %>

<div class="control-group fieldcontain ${hasErrors(bean: statusDelConvenioInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="control-label">
		<g:message code="statusDelConvenio.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="nombre" required="" value="${statusDelConvenioInstance?.nombre}"/>
        </div>
</div>

