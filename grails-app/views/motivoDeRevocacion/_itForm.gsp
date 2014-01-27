<%@ page import="com.app.sgpod.MotivoDeRevocacion" %>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'nombre', 'error')} required">
    <label for="nombre" class="control-label">
        <g:message code="motivoDeRevocacion.nombre.label" default="Nombre" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="nombre" required="" value="${it?.nombre}"/>
    </div>
</div>

