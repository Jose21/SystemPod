<%@ page import="com.app.sgpod.Apoderado" %>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'nombre', 'error')} required">
    <label for="nombre" class="control-label">
        <g:message code="apoderado.nombre.label" default="Nombre" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="nombre" required="" value="${it?.nombre}"/>
    </div>
</div>

<g:if test="${it?.puesto}">
    <div class="control-group fieldcontain ${hasErrors(bean: it, field: 'puesto', 'error')} ">
        <label for="puesto" class="control-label">
            <g:message code="apoderado.puesto.label" default="Puesto" />
        </label>
        <div class="controls">
            <g:textField name="puesto" value="${it?.puesto}"/>
        </div>
    </div>
</g:if>
<g:else>
    <div class="control-group fieldcontain ${hasErrors(bean: it, field: 'cargoApoderado', 'error')} ">
        <label for="cargoApoderado" class="control-label">
            <g:message code="apoderado.cargoApoderado.label" default="Puesto" />
        </label>
        <div class="controls">
            <g:select id="cargoApoderado" name="cargoApoderado" value="${it?.cargoApoderado}" from="${listCargos}" optionKey="id" required="" noSelection="['':'Elige una opción.']" class="many-to-one"/>
        </div>
    </div>
</g:else>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'institucion', 'error')} ">
    <label for="institucion" class="control-label">
        <g:message code="apoderado.institucion.label" default="Institución" />

    </label>
    <div class="controls">
        <g:textField name="institucion" value="${it?.institucion}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'email', 'error')} ">
    <label for="email" class="control-label">
        <g:message code="apoderado.email.label" default="Email" />
    </label>
    <div class="controls">
        <g:field type="email" name="email" value="${it?.email}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'numeroIN', 'error')} ">
    <label for="numeroIN" class="control-label">
        <g:message code="apoderado.numeroIN.label" default="IN" />
    </label>
    <div class="controls">
        <g:textField name="numeroIN" value="${it?.numeroIN}"/>
    </div>
</div>
