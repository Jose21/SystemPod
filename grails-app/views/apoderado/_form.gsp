<%@ page import="com.app.sgpod.Apoderado" %>



<div class="control-group fieldcontain ${hasErrors(bean: apoderadoInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="control-label">
		<g:message code="apoderado.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="nombre" required="" value="${apoderadoInstance?.nombre}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: apoderadoInstance, field: 'puesto', 'error')} ">
	<label for="puesto" class="control-label">
		<g:message code="apoderado.puesto.label" default="Puesto" />
		
	</label>
        <div class="controls">
          <g:textField name="puesto" value="${apoderadoInstance?.puesto}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: apoderadoInstance, field: 'institucion', 'error')} ">
	<label for="institucion" class="control-label">
		<g:message code="apoderado.institucion.label" default="Institucion" />
		
	</label>
        <div class="controls">
          <g:textField name="institucion" value="${apoderadoInstance?.institucion}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: apoderadoInstance, field: 'email', 'error')} ">
	<label for="email" class="control-label">
		<g:message code="apoderado.email.label" default="Email" />
		
	</label>
        <div class="controls">
          <g:field type="email" name="email" value="${apoderadoInstance?.email}"/>
        </div>
</div>

