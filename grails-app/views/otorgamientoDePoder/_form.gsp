<%@ page import="com.app.sgpod.OtorgamientoDePoder;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'registroDeLaSolicitud', 'error')} required">
    <label for="registroDeLaSolicitud" class="control-label">
        <g:message code="otorgamientoDePoder.registroDeLaSolicitud.label" default="Registro De Solicitud" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <div class="row-fluid input-append">
            <input readonly="readonly" class="span6" id="registroDeLaSolicitud" type="text" value="${otorgamientoDePoderInstance?.registroDeLaSolicitud?(new SimpleDateFormat("dd/MM/yyyy")).format(otorgamientoDePoderInstance?.registroDeLaSolicitud):""}" data-date-format="dd/mm/yyyy" name="registroDeLaSolicitud" />      
        </div>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'categoriaDeTipoDePoder', 'error')} required">
    <label for="categoriaDeTipoDePoder" class="control-label">
        <g:message code="otorgamientoDePoder.categoriaDeTipoDePoder.label" default="Tipo de Poder" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select class="chosen-select" optionKey="id" optionValue="nombre" name="tipoDePoder.id" id="tipoDePoder.nombre" from="${com.app.sgpod.TipoDePoder.list()}"
        value="${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.tipoDePoder?.id}"
            noSelection="['':'Elige un tipo de poder']"
        onchange="${remoteFunction(
        controller:'tipoDePoder', 
        action:'ajaxGetCategorias', 
        params:'\'tipoDePoder.id=\' + this.value', 
        update:'categoriaSelection'
        )}"/>
    </div>
    <div class="controls" id="categoriaSelection" >
        <select class="chosen-select" data-placeholder="Elige una categoria...">
            <option>${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.nombre}</option>
        </select>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'poderSolicitado', 'error')} required" id="ocultar">
    <g:hiddenField name="poderSolicitado" value="${otorgamientoDePoderInstance?.poderSolicitado}"/>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'delegacion', 'error')} required">
    <label for="delegacion" class="control-label">
        <g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <select class="chosen-select" id="delegacion" name="delegacion" data-placeholder="Elige una delegación..." required="">
            <g:each in="${com.app.sgpod.Delegacion.list()}" var="delegacion">
                <g:if test="${delegacion?.id == otorgamientoDePoderInstance?.delegacion?.id}">                    
                    <option value="${delegacion.id}" selected>${delegacion.nombre}</option>
                </g:if>
                <g:else>
                    <option value="${delegacion.id}">${delegacion.nombre}</option>
                </g:else>
            </g:each>
        </select>
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

<h3 id="bloqueTags" class="header smaller lighter blue">Agrega palabras clave para búsquedas avanzadas.</h3>

<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'tags', 'error')}">
    <label for="tags" class="control-label">
        <g:message code="otorgamientoDePoder.tags.label" default="Tags" />
    </label>
    <div class="controls">
        <g:textField class="span6" name="tags" value="${otorgamientoDePoderInstance?.tags}"/>
    </div>
</div>
