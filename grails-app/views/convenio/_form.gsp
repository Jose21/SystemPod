<%@ page import="com.app.sgcon.Convenio;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'numeroDeConvenio', 'error')} required">
  <label for="numeroDeConvenio" class="control-label">
    <g:message code="convenio.numeroDeConvenio.label" default="Número de Convenio" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField class="span5" name="numeroDeConvenio" maxlength="100" required="" value="${convenioInstance?.numeroDeConvenio}" autocomplete="off"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'objeto', 'error')} required">
  <label for="objeto" class="control-label">
    <g:message code="convenio.objeto.label" default="Objeto" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField class="span5" name="objeto" maxlength="100" required="" value="${convenioInstance?.objeto}" autocomplete="off"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'compromisos', 'error')} required">
  <label for="compromisos" class="control-label">
    <g:message code="convenio.v.label" default="Compromisos" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textArea name="compromisos" class="ckeditor" cols="50" rows="15" value="${convenioInstance?.compromisos}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'sustentoNormativo', 'error')} required">
  <label for="sustentoNormativo" class="control-label">
    <g:message code="convenio.sustentoNormativo.label" default="Sustento Normativo" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField class="span5" name="sustentoNormativo" maxlength="200" required="" value="${convenioInstance?.sustentoNormativo}" autocomplete="off"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'fechaDeFirma', 'error')} required">
  <label for="fechaDeFirma" class="control-label">
    <g:message code="convenio.fechaDeFirma.label" default="Fecha De Firma" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">          
    <div class="row-fluid input-append">
      <input readonly="readonly" class="span10 date-picker" id="fechaDeFirma" type="text" value="${convenioInstance?.fechaDeFirma?(new SimpleDateFormat("dd/MM/yyyy")).format(convenioInstance?.fechaDeFirma):""}" data-date-format="dd/mm/yyyy" name="fechaDeFirma" />      
      <span class="add-on">
        <i class="icon-calendar"></i>
      </span>
    </div>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'vigencia', 'error')} required">
  <label for="vigencia" class="control-label">
    <g:message code="convenio.vigencia.label" default="Vigencia" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">          
    <div class="row-fluid input-append">
      <input readonly="readonly" class="span10 date-picker" id="vigencia" type="text" value="${convenioInstance?.vigencia?(new SimpleDateFormat("dd/MM/yyyy")).format(convenioInstance?.vigencia):"Indefinida"}" data-date-format="dd/mm/yyyy" name="vigencia" />
      <input class="btn btn-small" type="button" name="btnIndefinida" id="btnIndefinida" value="Indefinida"></input>
    </div>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'status', 'error')} required">
  <label for="status" class="control-label">
    <g:message code="convenio.status.label" default="Status" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:select id="status" name="status.id" from="${com.app.sgcon.StatusDelConvenio.list()}" optionKey="id" required="" value="${convenioInstance?.status?.id}" class="many-to-one"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'tipoDeConvenio', 'error')} required">
  <label for="tipoDeConvenio" class="control-label">
    <g:message code="convenio.tipoDeConvenio.label" default="Tipo de Convenio" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField class="span5" name="tipoDeConvenio" maxlength="255" required="" value="${convenioInstance?.tipoDeConvenio}" autocomplete="off"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'institucion', 'error')} required">
  <label for="institucion" class="control-label">
    <g:message code="convenio.institucion.label" default="Institución" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField class="span5" name="institucion" maxlength="255" required="" value="${convenioInstance?.institucion}" autocomplete="off"/>
  </div>
</div>

<g:javascript src="ckeditor/ckeditor.js"/>