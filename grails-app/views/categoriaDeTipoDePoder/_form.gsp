<%@ page import="com.app.sgpod.CategoriaDeTipoDePoder" %>



<div class="control-group fieldcontain ${hasErrors(bean: categoriaDeTipoDePoderInstance, field: 'nombre', 'error')} ">
    <label for="nombre" class="control-label">
        <g:message code="categoriaDeTipoDePoder.nombre.label" default="Nombre" />

    </label>
    <div class="controls">
        <g:textField class="span8" name="nombre" value="${categoriaDeTipoDePoderInstance?.nombre}"/>
    </div>
</div>
<div class="control-group fieldcontain ${hasErrors(bean: categoriaDeTipoDePoderInstance, field: 'detalles', 'error')} ">
    <label for="detalles" class="control-label">
        <g:message code="categoriaDeTipoDePoder.detalles.label" default="Descripción del Modelo" />		
    </label>
    <div class="controls">
        <textArea class="span8" rows="6" id="detalles" name="detalles" maxlength="5000">${categoriaDeTipoDePoderInstance?.detalles}</textArea>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: categoriaDeTipoDePoderInstance, field: 'tipoDePoder', 'error')} required">
	<label for="tipoDePoder" class="control-label">
        <g:message code="categoriaDeTipoDePoder.tipoDePoder.label" default="Tipo De Poder" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
        <g:select id="tipoDePoder" name="tipoDePoder.id" from="${com.app.sgpod.TipoDePoder.list()}" optionKey="id" required="" value="${categoriaDeTipoDePoderInstance?.tipoDePoder?.id}" class="many-to-one"/>
        </div>
</div>
