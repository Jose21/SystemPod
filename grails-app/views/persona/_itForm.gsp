<%@ page import="com.app.sgcon.Persona" %>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'nombre', 'error')} required">
  <label for="nombre" class="control-label">
    <g:message code="persona.nombre.label" default="Nombre" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="nombre" required="" value="${it?.nombre}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'puesto', 'error')} ">
  <label for="puesto" class="control-label">
    <g:message code="persona.puesto.label" default="Puesto" />
  </label>
  <div class="controls">
    <g:textField name="puesto" value="${it?.puesto}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'area', 'error')} ">
  <label for="area" class="control-label">
    <g:message code="persona.area.label" default="Area" />
  </label>
  <div class="controls">
    <g:textField name="area" value="${it?.area}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'institucion', 'error')} ">
	<label for="institucion" class="control-label">
		<g:message code="persona.institucion.label" default="Institución" />
		
	</label>
        <div class="controls">
          <g:textField name="institucion" value="${it?.institucion}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'email', 'error')} ">
  <label for="email" class="control-label">
    <g:message code="persona.email.label" default="Email" />
  </label>
  <div class="controls">
    <g:field type="email" name="email" value="${it?.email}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'telefono', 'error')} ">
  <label for="telefono" class="control-label">
    <g:message code="persona.telefono.label" default="Telefono" />
  </label>
  <div class="controls">
    <g:textField name="telefono" value="${it?.telefono}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'extension', 'error')} ">
  <label for="extension" class="control-label">
    <g:message code="persona.extension.label" default="Extension" />
  </label>
  <div class="controls">
    <g:textField name="extension" value="${it?.extension}"/>
  </div>
</div>

