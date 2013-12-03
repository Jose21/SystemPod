<%@ page import="com.app.sgpod.CartaDeInstruccionDeRevocacion" %>



<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeRevocacionInstance, field: 'registro', 'error')} required">
	<label for="registro" class="control-label">
		<g:message code="cartaDeInstruccionDeRevocacion.registro.label" default="Registro" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="registro" required="" value="${cartaDeInstruccionDeRevocacionInstance?.registro}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeRevocacionInstance, field: 'fecha', 'error')} required">
	<label for="fecha" class="control-label">
		<g:message code="cartaDeInstruccionDeRevocacion.fecha.label" default="Fecha" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField name="fecha" required="" value="${cartaDeInstruccionDeRevocacionInstance?.fecha}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeRevocacionInstance, field: 'contenido', 'error')} required">
	<label for="contenido" class="control-label">
		<g:message code="cartaDeInstruccionDeRevocacion.contenido.label" default="Contenido" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textArea class="ckeditor" name="contenido" cols="40" rows="5" maxlength="1048576" required="" value="${cartaDeInstruccionDeRevocacionInstance?.contenido}"/>
        </div>
</div>
<g:javascript src="ckeditor/ckeditor.js"/>