<%@ page import="com.app.sgpod.Delegacion" %>

<div class="control-group fieldcontain ${hasErrors(bean: delegacionInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="control-label">
		<g:message code="delegacion.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="nombre" required="" value="${delegacionInstance?.nombre}"/>
        </div>
</div>

