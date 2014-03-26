<%@ page import="com.app.sgpod.Prorroga;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: prorrogaInstance, field: 'titulo', 'error')} ">
    <label for="titulo" class="control-label">
        <g:message code="prorroga.titulo.label" default="Titulo" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="titulo" value="${prorrogaInstance?.titulo}" required=""/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: prorrogaInstance, field: 'motivos', 'error')}">
    <label for="motivos" class="control-label">
        <g:message code="prorroga.motivos.label" default="Motivos" />        
    </label>
    <div class="controls">
        <g:textArea class="span6" name="motivos" cols="40" rows="5" maxlength="1048576"  value="${prorrogaInstance?.motivos}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: prorrogaInstance, field: 'fechaProrroga', 'error')}">
    <label for="fechaProrroga" class="control-label">
        <g:message code="prorroga.fechaProrroga.label" default="Fecha Limite" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <div class="row-fluid input-append">
            <input readonly="readonly" class="span6 date-picker validate[required]"   id="fechaProrroga" type="text" value="${prorrogaInstance?.fechaProrroga?(new SimpleDateFormat("dd/MM/yyyy")).format(prorrogaInstance?.fechaProrroga):""}" data-date-format="dd/mm/yyyy" name="fechaProrroga" />      
            <span class="add-on">
                <i class="icon-calendar"></i>
            </span>
        </div>
    </div>
</div>





