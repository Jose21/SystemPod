<%@ page import="com.app.sgpod.CartaDeInstruccionDeOtorgamiento" %>



<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeOtorgamientoInstance, field: 'registro', 'error')} required">
    <label for="registro" class="control-label">
        <g:message code="cartaDeInstruccionDeOtorgamiento.registro.label" default="Registro" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="registro" required="" value="${cartaDeInstruccionDeOtorgamientoInstance?.registro}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeOtorgamientoInstance, field: 'fecha', 'error')} required">
    <label for="fecha" class="control-label">
        <g:message code="cartaDeInstruccionDeOtorgamiento.fecha.label" default="Fecha" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="fecha" required="" value="${cartaDeInstruccionDeOtorgamientoInstance?.fecha}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeOtorgamientoInstance, field: 'contenido', 'error')} required">
    <label for="contenido" class="control-label">
        <g:message code="cartaDeInstruccionDeOtorgamiento.contenido.label" default="Contenido" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textArea class="ckeditor" name="contenido" cols="40" rows="5" maxlength="1048576" required="" value="${cartaDeInstruccionDeOtorgamientoInstance?.contenido}"/>
    </div>
</div>
<div class="controls">
    <g:hiddenField id="otorgamientoDePoderId" name="otorgamientoDePoder.id" required="" value="${otorgamientoDePoderId}" class="many-to-one"/>
</div>

<g:javascript src="ckeditor/ckeditor.js"/>