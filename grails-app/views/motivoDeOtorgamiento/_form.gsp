<%@ page import="com.app.sgpod.MotivoDeOtorgamiento" %>



<div class="control-group fieldcontain ${hasErrors(bean: motivoDeOtorgamientoInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="control-label">
		<g:message code="motivoDeOtorgamiento.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="nombre" required="" value="${motivoDeOtorgamientoInstance?.nombre}"/>
        </div>
</div>

