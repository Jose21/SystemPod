<%@ page import="com.app.sgpod.RevocacionDePoder" %>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'escrituraPublica', 'error')} required">
    <label for="escrituraPublica" class="control-label">
        <g:message code="revocacionDePoder.escrituraPublica.label" default="Escritura Publica" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="escrituraPublica" required="" value="${revocacionDePoderInstance?.escrituraPublica}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'notario', 'error')} required">
    <label for="delegacion" class="control-label">
        <g:message code="revocacionDePoder.notario.label" default="Notario" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <select class="chosen-select" id="notario" name="notario" data-placeholder="Elige un notario..." required="">
            <g:each in="${com.app.sgpod.Notario.list()}" var="notario">
                <g:if test="${notario?.id == revocacionDePoderInstance?.notario?.id}">                    
                    <option value="${notario.id}" selected>${notario.nombre}</option>
                </g:if>
                <g:else>
                    <option value="${notario.id}">${notario.nombre}</option>
                </g:else>
            </g:each>
        </select>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'nombre', 'error')} required">
    <label for="nombre" class="control-label">
        <g:message code="revocacionDePoder.nombre.label" default="Nombre (Apoderado)" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="nombre" required="" value="${revocacionDePoderInstance?.nombre}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'puesto', 'error')} required">
    <label for="puesto" class="control-label">
        <g:message code="revocacionDePoder.puesto.label" default="Puesto" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="puesto" required="" value="${revocacionDePoderInstance?.puesto}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'contrato', 'error')} required">
    <label for="contrato" class="control-label">
        <g:message code="revocacionDePoder.contrato.label" default="Contrato" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="contrato" required="" value="${revocacionDePoderInstance?.contrato}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'tipoDePoder', 'error')} required">
    <label for="tipoDePoder" class="control-label">
        <g:message code="revocacionDePoder.tipoDePoder.label" default="Tipo De Poder" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="tipoDePoder" from="${revocacionDePoderInstance.constraints.tipoDePoder.inList}" required="" value="${revocacionDePoderInstance?.tipoDePoder}" valueMessagePrefix="revocacionDePoder.tipoDePoder"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'delegacion', 'error')} required">
    <label for="delegacion" class="control-label">
        <g:message code="revocacionDePoder.delegacion.label" default="Delegación" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <select class="chosen-select" id="delegacion" name="delegacion" data-placeholder="Elige una delegación..." required="">
            <g:each in="${com.app.sgpod.Delegacion.list()}" var="delegacion">
                <g:if test="${delegacion?.id == revocacionDePoderInstance?.delegacion?.id}">                    
                    <option value="${delegacion.id}" selected>${delegacion.nombre}</option>
                </g:if>
                <g:else>
                    <option value="${delegacion.id}">${delegacion.nombre}</option>
                </g:else>
            </g:each>
        </select>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'motivoDeRevocacion', 'error')} required">
    <label for="motivoDeRevocacion" class="control-label">
        <g:message code="revocacionDePoder.motivoDeRevocacion.label" default="Motivo De Revocacion" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select id="motivoDeRevocacion" name="motivoDeRevocacion.id" from="${com.app.sgpod.MotivoDeRevocacion.list()}" optionKey="id" required="" value="${revocacionDePoderInstance?.motivoDeRevocacion?.id}" class="many-to-one"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'solicitadoPor', 'error')} required">
    <label for="solicitadoPor" class="control-label">
        <g:message code="revocacionDePoder.solicitadoPor.label" default="Solicitado Por" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField class="span6" name="solicitadoPor" required="" value="${revocacionDePoderInstance?.solicitadoPor}"/>
    </div>
</div>

<h3 id="bloqueTags" class="header smaller lighter blue">Agrega palabras clave para búsquedas avanzadas.</h3>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'tags', 'error')}">
    <label for="tags" class="control-label">
        <g:message code="revocacionDePoder.tags.label" default="Tags" />
    </label>
    <div class="controls">
        <g:textField class="span6" name="tags" value="${revocacionDePoderInstance?.tags}"/>
    </div>
</div>