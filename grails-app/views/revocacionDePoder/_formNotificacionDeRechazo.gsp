<%@ page import="com.app.sgpod.RevocacionDePoder;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'notificacionDeRechazo', 'error')} ">
    <label for="notificacionDeRechazo" class="control-label">
        <g:message code="revocacionDePoder.notificacionDeRechazo.label" default="Motivos" />		
    </label>
    <div class="controls">
        <textArea class="span8 validate[required]" rows="6" id="notificacionDeRechazo" name="notificacionDeRechazo" maxlength="5000">${revocacionDePoderInstance?.notificacionDeRechazo}</textArea>
        </div>
</div>