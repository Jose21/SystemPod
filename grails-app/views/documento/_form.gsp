<%@ page import="com.app.sgtask.Documento" %>

<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'archivo', 'error')} required">
	<label for="archivo" class="control-label">
		<g:message code="documento.archivo.label" default="Archivo" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <input type="file" id="archivo" name="archivo" />
        </div>
</div>

<div class="fieldcontain ${hasErrors(bean: documentoInstance, field: 'nota', 'error')} required">
	<label for="nota" class="control-label">
		<g:message code="documento.nota.label" default="Nota" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:select id="nota" name="nota.id" from="${com.app.sgtask.Nota.list()}" optionKey="id" required="" value="${documentoInstance?.nota?.id}" class="many-to-one"/>
        </div>
</div>

