<%@ page import="com.app.sgpod.Bitacora" %>



<div class="control-group fieldcontain ${hasErrors(bean: bitacoraInstance, field: 'diasProrrogas', 'error')} required">
	<label for="diasProrrogas" class="control-label">
		<g:message code="bitacora.diasProrrogas.label" default="Dias Prorrogas" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:field name="diasProrrogas" type="number" value="${bitacoraInstance.diasProrrogas}" required=""/>
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: bitacoraInstance, field: 'fechaDeCreacion', 'error')} required">
	<label for="fechaDeCreacion" class="control-label">
		<g:message code="bitacora.fechaDeCreacion.label" default="Fecha De Creacion" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:datePicker name="fechaDeCreacion" precision="day"  value="${bitacoraInstance?.fechaDeCreacion}"  />
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: bitacoraInstance, field: 'fechaDeEnvio', 'error')} required">
	<label for="fechaDeEnvio" class="control-label">
		<g:message code="bitacora.fechaDeEnvio.label" default="Fecha De Envio" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:datePicker name="fechaDeEnvio" precision="day"  value="${bitacoraInstance?.fechaDeEnvio}"  />
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: bitacoraInstance, field: 'fechaDeVencimiento', 'error')} required">
	<label for="fechaDeVencimiento" class="control-label">
		<g:message code="bitacora.fechaDeVencimiento.label" default="Fecha De Vencimiento" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:datePicker name="fechaDeVencimiento" precision="day"  value="${bitacoraInstance?.fechaDeVencimiento}"  />
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: bitacoraInstance, field: 'fechaFactura', 'error')} required">
	<label for="fechaFactura" class="control-label">
		<g:message code="bitacora.fechaFactura.label" default="Fecha Factura" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:datePicker name="fechaFactura" precision="day"  value="${bitacoraInstance?.fechaFactura}"  />
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: bitacoraInstance, field: 'fechaOtorgamientoRevocacion', 'error')} required">
	<label for="fechaOtorgamientoRevocacion" class="control-label">
		<g:message code="bitacora.fechaOtorgamientoRevocacion.label" default="Fecha Otorgamiento Revocacion" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">
          <g:datePicker name="fechaOtorgamientoRevocacion" precision="day"  value="${bitacoraInstance?.fechaOtorgamientoRevocacion}"  />
        </div>
</div>

