<%@ page import="com.app.sgpod.ConfigurarParametro" %>


<h3 id="bloqueParametrosPoderes"  class="header smaller lighter blue">Valores para Otorgamientos de Poder</h3>
<div class="control-group fieldcontain ${hasErrors(bean: configurarParametroInstance, field: 'estadoCriticoPoder', 'error')} required">
	<label for="estadoCriticoPoder" class="control-label">
		<g:message code="configurarParametro.estadoCriticoPoder.label" default="Valor Estado Critico del Poder" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">          
          Menor a: <g:field class="span1" name="estadoCriticoPoder" type="number" min="0"  value="${configurarParametroInstance.estadoCriticoPoder}" required=""/> d&iacutea(s).
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: configurarParametroInstance, field: 'estadoSemiPoder', 'error')} required">
	<label for="estadoSemiPoder" class="control-label">
		<g:message code="configurarParametro.estadoSemiPoder.label" default="Valor Estado Semi-critico del Poder" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">          
          Menor a: <g:field class="span1" name="estadoSemiPoder" type="number" min="0" value="${configurarParametroInstance.estadoSemiPoder}" required=""/> d&iacuteas.
        </div>
</div>

<h3 id="bloqueParametrosSolicitudes"  class="header smaller lighter blue">Valores para Solicitudes Pendientes</h3>
<div class="control-group fieldcontain ${hasErrors(bean: configurarParametroInstance, field: 'estadoCriticoSolicitud', 'error')} required">
	<label for="estadoCriticoSolicitud" class="control-label">
		<g:message code="configurarParametro.estadoCriticoSolicitud.label" default="Valor Estado Normal en la Solicitud" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">          
          Menor a: <g:field class="span1" name="estadoCriticoSolicitud" type="number" min="0" value="${configurarParametroInstance.estadoCriticoSolicitud}" required=""/> d&iacutea(s).
        </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: configurarParametroInstance, field: 'estadoSemiSolicitud', 'error')} required">
	<label for="estadoSemiSolicitud" class="control-label">
		<g:message code="configurarParametro.estadoSemiSolicitud.label" default="Valor Estado Semi-critico en la Solicitud" />
		<span class="required-indicator">*</span>
	</label>
        <div class="controls">          
          Menor a: <g:field class="span1" name="estadoSemiSolicitud" type="number" min="0" value="${configurarParametroInstance.estadoSemiSolicitud}" required=""/> d&iacuteas.
        </div>
</div>


