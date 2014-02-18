<g:if test="${ocultarCampo == true}">
<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'poderSolicitado', 'error')} requiered">
    <label for="poderSolicitado" class="control-label">
        <g:message code="otorgamientoDePoder.poderSolicitado.label" default="Especificar Facultades" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textArea class="span6" name="poderSolicitado" cols="40" rows="5" maxlength="1048576" required="" value="${otorgamientoDePoderInstance?.poderSolicitado}"/>
    </div>
</div>
</g:if>
<g:else>
    <g:hiddenField name="poderSolicitado" value="${otorgamientoDePoderInstance?.poderSolicitado}"/>
</g:else>

