<%@ page import="com.app.sgpod.CartaDeInstruccionDeOtorgamiento" %>



<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeOtorgamientoInstance, field: 'registro', 'error')} required">
    <label for="registro" class="control-label">
        <g:message code="cartaDeInstruccionDeOtorgamiento.registro.label" default="Registro" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">        
        <input readonly="readonly" class="span3" id="registro" type="text" value="${cartaDeInstruccionDeOtorgamientoInstance?.registro}" name="registro" />      
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeOtorgamientoInstance, field: 'fecha', 'error')} required">
    <label for="fecha" class="control-label">
        <g:message code="cartaDeInstruccionDeOtorgamiento.fecha.label" default="Fecha" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <div class="row-fluid input-append">
            <input readonly="readonly" class="span4" id="fecha" type="text" value="${cartaDeInstruccionDeOtorgamientoInstance?.fecha}" name="fecha" />      
        </div>
    </div>    
</div>

<div class="control-group fieldcontain ${hasErrors(bean: cartaDeInstruccionDeOtorgamientoInstance, field: 'contenido', 'error')} required">
    <label for="contenido" class="control-label">
        <g:message code="cartaDeInstruccionDeOtorgamiento.contenido.label" default="Contenido" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">       
        <div name="contenido" class="wysiwyg-editor" id="editor1">
            ${raw(cartaDeInstruccionDeOtorgamientoInstance?.contenido)}
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
