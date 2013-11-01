<%@ page import="com.app.sgpod.OtorgamientoDePoder;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'numeroDeFolio', 'error')} required">
	<label for="numeroDeFolio" class="control-label">
		<g:message code="otorgamientoDePoder.numeroDeFolio.label" default="Numero De Folio" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="numeroDeFolio" required="" value="${otorgamientoDePoderInstance?.numeroDeFolio}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'registroDeLaSolicitud', 'error')} required">
	<label for="registroDeLaSolicitud" class="control-label">
		<g:message code="otorgamientoDePoder.registroDeLaSolicitud.label" default="Registro De Solicitud" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
            <div class="row-fluid input-append">
                <input readonly="readonly" class="span10 date-picker" id="registroDeLaSolicitud" type="text" value="${otorgamientoDePoderInstance?.registroDeLaSolicitud?(new SimpleDateFormat("dd/MM/yyyy")).format(otorgamientoDePoderInstance?.registroDeLaSolicitud):""}" data-date-format="dd/mm/yyyy" name="registroDeLaSolicitud" />      
                <span class="add-on">
                    <i class="icon-calendar"></i>
                </span>
            </div>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'nombre', 'error')} required">
	<label for="nombre" class="control-label">
		<g:message code="otorgamientoDePoder.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="nombre" required="" value="${otorgamientoDePoderInstance?.nombre}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'puesto', 'error')} required">
	<label for="puesto" class="control-label">
		<g:message code="otorgamientoDePoder.puesto.label" default="Puesto" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="puesto" required="" value="${otorgamientoDePoderInstance?.puesto}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'contrato', 'error')} required">
	<label for="contrato" class="control-label">
		<g:message code="otorgamientoDePoder.contrato.label" default="Contrato" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="contrato" required="" value="${otorgamientoDePoderInstance?.contrato}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'tipoDePoder', 'error')} required">
	<label for="tipoDePoder" class="control-label">
		<g:message code="otorgamientoDePoder.tipoDePoder.label" default="Tipo De Poder" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:select name="tipoDePoder" from="${otorgamientoDePoderInstance.constraints.tipoDePoder.inList}" required="" value="${otorgamientoDePoderInstance?.tipoDePoder}" valueMessagePrefix="otorgamientoDePoder.tipoDePoder"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'delegacion', 'error')} required">
	<label for="delegacion" class="control-label">
		<g:message code="otorgamientoDePoder.delegacion.label" default="Delegacion" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="delegacion" required="" value="${otorgamientoDePoderInstance?.delegacion}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'poderSolicitado', 'error')} required">
	<label for="poderSolicitado" class="control-label">
		<g:message code="otorgamientoDePoder.poderSolicitado.label" default="Poder Solicitado" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textArea class="span6" name="poderSolicitado" cols="40" rows="5" maxlength="1048576" required="" value="${otorgamientoDePoderInstance?.poderSolicitado}"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'motivoDeOtorgamiento', 'error')} required">
	<label for="motivoDeOtorgamiento" class="control-label">
		<g:message code="otorgamientoDePoder.motivoDeOtorgamiento.label" default="Motivo De Otorgamiento" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:select id="motivoDeOtorgamiento" name="motivoDeOtorgamiento.id" from="${com.app.sgpod.MotivoDeOtorgamiento.list()}" optionKey="id" required="" value="${otorgamientoDePoderInstance?.motivoDeOtorgamiento?.id}" class="many-to-one"/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'solicitadoPor', 'error')} required">
	<label for="solicitadoPor" class="control-label">
		<g:message code="otorgamientoDePoder.solicitadoPor.label" default="Solicitado Por" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:textField class="span6" name="solicitadoPor" required="" value="${otorgamientoDePoderInstance?.solicitadoPor}"/>
        </div>
</div>
