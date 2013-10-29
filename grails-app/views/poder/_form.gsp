<%@ page import="com.app.sgpod.Poder;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'numeroDeFolio', 'error')} required">
	<label for="numeroDeFolio" class="control-label">
		<g:message code="poder.numeroDeFolio.label" default="Numero De Folio" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="numeroDeFolio" required="" value="${poderInstance?.numeroDeFolio}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'registroDeLaSolicitud', 'error')} required">
	<label for="registroDeLaSolicitud" class="control-label">
		<g:message code="poder.registroDeLaSolicitud.label" default="Registro De Solicitud" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
            <div class="row-fluid input-append">
                <input readonly="readonly" class="span10 date-picker" id="registroDeLaSolicitud" type="text" value="${poderInstance?.registroDeLaSolicitud?(new SimpleDateFormat("dd/MM/yyyy")).format(poderInstance?.registroDeLaSolicitud):""}" data-date-format="dd/mm/yyyy" name="registroDeLaSolicitud" />      
                <span class="add-on">
                    <i class="icon-calendar"></i>
                </span>
            </div>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'tipoDePoder', 'error')} required">
	<label for="tipoDePoder" class="control-label">
		<g:message code="poder.tipoDePoder.label" default="Tipo De Poder" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:select name="tipoDePoder" from="${poderInstance.constraints.tipoDePoder.inList}" required="" value="${poderInstance?.tipoDePoder}" valueMessagePrefix="poder.tipoDePoder"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'delegacion', 'error')} required">
	<label for="delegacion" class="control-label">
		<g:message code="poder.delegacion.label" default="Delegacion" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="delegacion" required="" value="${poderInstance?.delegacion}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'puesto', 'error')} required">
	<label for="puesto" class="control-label">
		<g:message code="poder.puesto.label" default="Puesto" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="puesto" required="" value="${poderInstance?.puesto}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'contrato', 'error')} required">
	<label for="contrato" class="control-label">
		<g:message code="poder.contrato.label" default="Contrato" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="contrato" required="" value="${poderInstance?.contrato}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'poderSolicitado', 'error')} required">
	<label for="poderSolicitado" class="control-label">
		<g:message code="poder.poderSolicitado.label" default="Poder Solicitado" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textArea class="span6" name="poderSolicitado" cols="40" rows="5" maxlength="1048576" required="" value="${poderInstance?.poderSolicitado}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'motivoDeOtorgamiento', 'error')} required">
	<label for="motivoDeOtorgamiento" class="control-label">
		<g:message code="poder.motivoDeOtorgamiento.label" default="Motivo De Otorgamiento" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:select id="motivoDeOtorgamiento" name="motivoDeOtorgamiento.id" from="${com.app.sgpod.MotivoDeOtorgamiento.list()}" optionKey="id" required="" value="${poderInstance?.motivoDeOtorgamiento?.id}" class="many-to-one"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'solicitadoPor', 'error')} required">
	<label for="solicitadoPor" class="control-label">
		<g:message code="poder.solicitadoPor.label" default="Solicitado Por" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="solicitadoPor" required="" value="${poderInstance?.solicitadoPor}"/>
        </div>
</div>
