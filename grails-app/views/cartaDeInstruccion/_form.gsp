<%@ page import="com.app.sgpod.CartaDeInstruccion" %>



<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionInstance, field: 'registro', 'error')} required">
    <label for="registro" class="control-label">
        <g:message code="cartaDeInstruccion.registro.label" default="Registro" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="registro" required="" value="${cartaDeInstruccionInstance?.registro}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionInstance, field: 'fecha', 'error')} required">
    <label for="fecha" class="control-label">
        <g:message code="cartaDeInstruccion.fecha.label" default="Fecha" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="fecha" required="" value="${cartaDeInstruccionInstance?.fecha}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionInstance, field: 'contenido', 'error')} required">
    <label for="contenido" class="control-label">
        <g:message code="cartaDeInstruccion.contenido.label" default="Contenido" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">      
        <div name="contenido" class="wysiwyg-editor" id="editor1">
            ${raw(cartaDeInstruccionInstance?.contenido)}
        </div>
        <g:hiddenField name="contenido" />
    </div>
</div>

<script type="text/javascript">    
    $('.form-horizontal').submit(function()
    {    
    $('#contenido').val($('#editor1').html());    
    });    
</script>