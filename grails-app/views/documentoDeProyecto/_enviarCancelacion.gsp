<div class="control-group fieldcontain ${hasErrors(bean: documentoDeProyectoInstance, field: 'motivosDeRechazo', 'error')} ">
    <label for="motivosDeRechazo" class="control-label">
        <g:message code="documentoDeProyecto.motivosDeRechazo.label" default="Motivos De Rechazo" />

    </label>
    <div class="controls">
        <g:textArea name="motivosDeRechazo" cols="40" rows="5" maxlength="10240" value="${documentoDeProyectoInstance?.motivosDeRechazo}"/>
    </div>
</div>