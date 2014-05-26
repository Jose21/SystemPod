<%@ page import="com.app.sgcon.Convenio;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'numeroDeConvenio', 'error')} required">
    <label for="numeroDeConvenio" class="control-label">
        <g:message code="convenio.numeroDeConvenio.label" default="Número de Convenio" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="numeroDeConvenio" maxlength="100" required="" value="${convenioInstance?.numeroDeConvenio}" autocomplete="off"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'objeto', 'error')} required">
    <label for="objeto" class="control-label">
        <g:message code="convenio.objeto.label" default="Objeto" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textArea class="span6" name="objeto" maxlength="5000" required="" value="${convenioInstance?.objeto}" autocomplete="off"/>
    </div>
</div>

<g:hiddenField name="nombreDeCopiaElectronica" value="${convenioInstance.nombreDeCopiaElectronica?:""}" />

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'compromisos', 'error')} required">
    <label for="compromisos" class="control-label">
        <g:message code="convenio.v.label" default="Compromisos" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <textArea class="span6" rows="6" id="compromisos" name="compromisos" maxlength="5000">${convenioInstance?.compromisos}</textArea>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'sustentoNormativo', 'error')} required">
  <label for="sustentoNormativo" class="control-label">
        <g:message code="convenio.sustentoNormativo.label" default="Sustento Normativo" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
        <g:textArea class="span6" name="sustentoNormativo" maxlength="5000" required="" value="${convenioInstance?.sustentoNormativo}" autocomplete="off"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'fechaDeFirma', 'error')} required">
  <label for="fechaDeFirma" class="control-label">
        <g:message code="convenio.fechaDeFirma.label" default="Fecha De Firma" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">          
    <div class="row-fluid input-append">
      <input readonly="readonly" class="span5 date-picker validate[required]" id="fechaDeFirma" type="text" value="${convenioInstance?.fechaDeFirma?(new SimpleDateFormat("dd/MM/yyyy")).format(convenioInstance?.fechaDeFirma):""}" data-date-format="dd/mm/yyyy" name="fechaDeFirma" />      
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
      <input readonly="readonly" class="span5 date-picker" id="vigencia" type="text" value="${convenioInstance?.vigencia?(new SimpleDateFormat("dd/MM/yyyy")).format(convenioInstance?.vigencia):"Indefinida"}" data-date-format="dd/mm/yyyy" name="vigencia" />
      <input class="btn btn-small" type="button" name="btnIndefinida" id="btnIndefinida" value="Indefinida"/>
    </div>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'status', 'error')} required">
  <label for="status" class="control-label">
        <g:message code="convenio.status.label" default="Status" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
        <g:select id="status" name="status.id" from="${com.app.sgcon.StatusDelConvenio.list()}" optionKey="id" required="" value="${convenioInstance?.status?.id}"  noSelection="['':'-Elige un usuario-']" class="many-to-one validate[required]"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'tipoDeConvenio', 'error')} required">
  <label for="tipoDeConvenio" class="control-label">
        <g:message code="convenio.tipoDeConvenio.label" default="Tipo de Convenio" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
        <g:textArea class="span6" name="tipoDeConvenio" maxlength="5000" required="" value="${convenioInstance?.tipoDeConvenio}" autocomplete="off"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'institucion', 'error')} required">
  <label for="institucion" class="control-label">
        <g:message code="convenio.institucion.label" default="Institución" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
        <g:textArea class="span6" name="institucion" maxlength="5000" required="" value="${convenioInstance?.institucion}" autocomplete="off"/>
  </div>
</div>

<h3 id="bloqueTags" class="header smaller lighter blue">Agrega palabras clave para búsquedas avanzadas.</h3>

<div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'tags', 'error')}">
  <label for="tags" class="control-label">
        <g:message code="convenio.tags.label" default="Tags" />
  </label>
  <div class="controls">
        <g:textArea class="span6" name="tags" maxlength="5000" value="${convenioInstance?.tags}" autocomplete="off"/>
  </div>
</div>

	
<!--div id="tag-success" class="input-append">
    <input type="text" name="tags" id="form-field-tags" placeholder="Ingresa los tags...">
        <button class="btn" type="button" ><i class="icon-plus"></i></button>
</div-->
<!--ul id="tag-cloud"></ul-->

<!--div class="profile-user-info profile-user-info-striped">
    <div class="profile-info-row">
        <div class="profile-info-name"> Tags </div>

        <div class="profile-info-value">
            <input type="text" name="tags" id="form-field-tags" value="Tag Input Control" placeholder="Enter tags ..." />
            <div class="editable-buttons">
                <button id="tag_click" class="btn btn-info editable-submit" type="submit">
                    <i class="icon-ok icon-white"></i>
                </button>
            </div>
        </div>
    </div>
</div-->

