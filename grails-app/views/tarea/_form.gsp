<%@ page import="com.app.sgtask.Tarea;java.text.SimpleDateFormat" %>

<div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'nombre', 'error')} required">
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES">
        <label for="nombre" class="control-label">
            <g:message code="tarea.nombre.label" default="Nombre" />
            <span class="required-indicator">*</span>
        </label>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_PODERES_RESOLVEDOR">
        <label for="nombre" class="control-label">
            <g:message code="tarea.nombre.label" default="Título" />
            <span class="required-indicator">*</span>
        </label>
    </sec:ifAnyGranted>
    <div class="controls">
        <g:textField name="nombre" class="span6" maxlength="140" required="" value="${tareaInstance?.nombre}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'descripcion', 'error')}">
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES">
        <label for="descripcion" class="control-label">
            <g:message code="tarea.descripcion.label" default="Descripción" />
        </label>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_PODERES_RESOLVEDOR">
        <label for="descripcion" class="control-label">
            <g:message code="tarea.descripcion.label" default="Motivos" />
        </label>
    </sec:ifAnyGranted>
    <div class="controls">
        <g:textArea name="descripcion" class="ckeditor" maxlength="10240" value="${tareaInstance?.descripcion}"/>
    </div>
</div>

<g:if test="${!session.idOtorgamientoDePoder}">

    <div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'fechaLimite', 'error')}">
        <label for="fechaLimite" class="control-label">
            <g:message code="tarea.fechaLimite.label" default="Fecha Límite" />
        </label>
        <div class="controls">
            <div class="row-fluid input-append">
                <input readonly="readonly" class="span10 date-picker" id="fechaLimite" type="text" value="${tareaInstance?.fechaLimite?(new SimpleDateFormat("dd/MM/yyyy")).format(tareaInstance?.fechaLimite):""}" data-date-format="dd/mm/yyyy" name="fechaLimite" />
                <input class="btn btn-small" type="button" name="btnLimpiar" id="btnLimpiar" value="Limpiar"></input>
            </div>
        </div>
    </div>

    <div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'alertaVencimiento', 'error')} required">
        <label for="alertaVencimiento" class="control-label">
            <g:message code="tarea.prioridad.label" default="Alerta De Vencimiento" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:select name="alertaVencimiento" from="${tareaInstance.constraints.alertaVencimiento.inList}" required="" value="${tareaInstance?.alertaVencimiento}" valueMessagePrefix="tarea.alertaVencimiento"/>
            <g:message code="tarea.prioridad.label" default=" día(s) con anticipación. " />
        </div>
    </div>

    <div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'prioridad', 'error')} required">
        <label for="prioridad" class="control-label">
            <g:message code="tarea.prioridad.label" default="Prioridad" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:select name="prioridad" from="${tareaInstance.constraints.prioridad.inList}" required="" value="${tareaInstance?.prioridad}" valueMessagePrefix="tarea.prioridad"/>
        </div>
    </div>

    <div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'grupo', 'error')} required">
        <label for="grupo" class="control-label">
            <g:message code="tarea.grupo.label" default="Grupo" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:select id="grupo" name="grupo.id" from="${com.app.sgtask.Grupo.list()}" optionKey="id" required="" value="${tareaInstance?.grupo?.id}" class="many-to-one"/>
        </div>
    </div>

    <div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'responsable', 'error')} required">
        <label for="grupo" class="control-label">
            <g:message code="tarea.responsable.label" default="Responsable" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">
            <g:select id="responsable" name="responsable.id" from="${com.app.security.Usuario.list()}" optionKey="id" required="" value="${tareaInstance?.responsable?.id}" class="many-to-one"/>
        </div>
    </div>

    <h3 id="bloqueTags" class="header smaller lighter blue">Agrega palabras clave para búsquedas avanzadas.</h3>

    <div class="control-group fieldcontain ${hasErrors(bean: tareaInstance, field: 'tags', 'error')}">
        <label for="tags" class="control-label">
            <g:message code="tarea.tags.label" default="Tags" />
        </label>
        <div class="controls">
            <g:textField class="span6" name="tags" value="${tareaInstance?.tags}"/>
        </div>
    </div>

</g:if>
<g:javascript src="ckeditor/ckeditor.js"/>