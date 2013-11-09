<%@ page import="com.app.sgpod.FormatoDeCartaDeInstruccion" %>

<div class="control-group fieldcontain ${hasErrors(bean: formatoDeCartaDeInstruccionInstance, field: 'registro', 'error')} required">
    <label for="registro" class="control-label">
        <g:message code="formatoDeCartaDeInstruccion.registro.label" default="Registro" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="registro" required="" value="${formatoDeCartaDeInstruccionInstance?.registro}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: formatoDeCartaDeInstruccionInstance, field: 'fecha', 'error')} required">
    <label for="fecha" class="control-label">
        <g:message code="formatoDeCartaDeInstruccion.fecha.label" default="Fecha" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="fecha" required="" value="${formatoDeCartaDeInstruccionInstance?.fecha}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: formatoDeCartaDeInstruccionInstance, field: 'contenido', 'error')} required">
    <label for="contenido" class="control-label">
        <g:message code="formatoDeCartaDeInstruccion.contenido.label" default="Contenido" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textArea class="ckeditor" name="contenido" cols="40" rows="5" maxlength="1048576" required="" value="${formatoDeCartaDeInstruccionInstance?.contenido}"/>
    </div>
</div>

<g:javascript src="ckeditor/ckeditor.js"/>