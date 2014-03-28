<%@ page import="com.app.sgpod.RevocacionDePoder" %>
<br/>
<br/>
<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'asignar', 'error')} required">
    <label for="asignar" class="control-label">
        <g:message code="revocacionDePoder.asignar.label" default="Nombre" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select id="asignar" name="asignar.id" from="${usuariosReasignacion}" optionKey="id"  value="${revocacionDePoderInstance?.asignar?.id}" noSelection="['':'-Elige un usuario-']" class="span6 many-to-one validate[required]"/>        
    </div>
</div>

