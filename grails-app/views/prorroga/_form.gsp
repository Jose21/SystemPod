<%@ page import="com.app.sgpod.Prorroga" %>

<div class="control-group fieldcontain ${hasErrors(bean: prorrogaInstance, field: 'titulo', 'error')} ">
    <label for="titulo" class="control-label">
        <g:message code="prorroga.titulo.label" default="Titulo" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="titulo" value="${prorrogaInstance?.titulo}" required=""/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: prorrogaInstance, field: 'motivos', 'error')} requiered">
    <label for="motivos" class="control-label">
        <g:message code="prorroga.motivos.label" default="Motivos" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textArea class="span6" name="motivos" cols="40" rows="5" maxlength="1048576" required="" value="${prorrogaInstance?.motivos}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: prorrogaInstance, field: 'dias', 'error')} required">
    <label for="dias" class="control-label">
        <g:message code="prorroga.dias.label" default="Plazo" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:field class="span1" name="dias" type="number" value="${prorrogaInstance.dias}" required=""/> día(s).
    </div>
</div>





