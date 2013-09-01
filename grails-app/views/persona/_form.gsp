<%@ page import="com.app.sgcon.Persona" %>



<div class="control-group fieldcontain ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="control-label">
		<g:message code="persona.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="nombre" required="" value="${personaInstance?.nombre}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: personaInstance, field: 'puesto', 'error')} ">
	<label for="puesto" class="control-label">
		<g:message code="persona.puesto.label" default="Puesto" />
		
	</label>
        <div class="controls">
          <g:textField name="puesto" value="${personaInstance?.puesto}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: personaInstance, field: 'area', 'error')} ">
	<label for="area" class="control-label">
		<g:message code="persona.area.label" default="Area" />
		
	</label>
        <div class="controls">
          <g:textField name="area" value="${personaInstance?.area}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: personaInstance, field: 'email', 'error')} ">
	<label for="email" class="control-label">
		<g:message code="persona.email.label" default="Email" />
		
	</label>
        <div class="controls">
          <g:field type="email" name="email" value="${personaInstance?.email}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: personaInstance, field: 'telefono', 'error')} ">
	<label for="telefono" class="control-label">
		<g:message code="persona.telefono.label" default="Telefono" />
		
	</label>
        <div class="controls">
          <g:textField name="telefono" value="${personaInstance?.telefono}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: personaInstance, field: 'extension', 'error')} ">
	<label for="extension" class="control-label">
		<g:message code="persona.extension.label" default="Extension" />
		
	</label>
        <div class="controls">
          <g:textField name="extension" value="${personaInstance?.extension}"/>
        </div>
</div>

