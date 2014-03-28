
<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<br/>
<br/>
<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'asignar', 'error')} required">
    <label for="asignar" class="control-label">
        <g:message code="otorgamientoDePoder.asignar.label" default="Nombre" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select id="asignar" name="asignar.id" from="${usuariosReasignacion}" optionKey="id" value="${otorgamientoDePoderInstance?.asignar?.id}" noSelection="['':'-Elige un usuario-']" class="span6 many-to-one validate[required]"/>        
    </div>
</div>
