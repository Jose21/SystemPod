<%@ page import="com.app.sgtask.Grupo" %>

<div class="control-group fieldcontain ${hasErrors(bean: grupoInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="control-label">
		<g:message code="grupo.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="nombre" class="span6" maxlength="140" required="" value="${grupoInstance?.nombre}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: grupoInstance, field: 'descripcion', 'error')} ">
	<label for="descripcion" class="control-label">
		<g:message code="grupo.descripcion.label" default="Descripcion" />
		
	</label>
        <div class="controls">
          <g:textArea name="descripcion" class="span6" maxlength="1024" value="${grupoInstance?.descripcion}"/>
        </div>
</div>

