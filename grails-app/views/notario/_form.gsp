<%@ page import="com.app.sgpod.Notario" %>



<div class="control-group fieldcontain ${hasErrors(bean: notarioInstance, field: 'nombre', 'error')} required">
    <label for="nombre" class="control-label">
        <g:message code="notario.nombre.label" default="Nombre" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="nombre" required="" value="${notarioInstance?.nombre}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: notarioInstance, field: 'numeroDeNotaria', 'error')} required">
    <label for="numeroDeNotaria" class="control-label">
        <g:message code="notario.numeroDeNotaria.label" default="Numero De Notaria" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="numeroDeNotaria" required="" value="${notarioInstance?.numeroDeNotaria}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: notarioInstance, field: 'direccion', 'error')} ">
    <label for="direccion" class="control-label">
        <g:message code="notario.direccion.label" default="Direccion" />

    </label>
    <div class="controls">
        <g:textField name="direccion" value="${notarioInstance?.direccion}"/>
    </div>
</div>

