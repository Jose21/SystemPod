<div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'categoriaDeTipoDePoder', 'error')} required">
    <label for="categoriaDeTipoDePoder" class="control-label">
        <g:message code="otorgamientoDePoder.categoriaDeTipoDePoder.detalles.label" default="Detalles del Modelo" />        
    </label>
    <div class="controls">
        <g:textArea readonly="readonly"  class="span6" name="valor" cols="40" rows="5" maxlength="1048576" required="" value="${siEs}" />
    </div>
</div>

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
    <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'documentoPoderEspecial', 'error')} ">
        <label for="documentoPoderEspecial" class="control-label">            
            <g:message code="otorgamientoDePoder.documentoPoderEspecial.label" default="Documento de Justificación" />
            <span class="required-indicator">*</span>
        </label>
        <div class="controls">       
            <br/>
            <input type="file" id="documentoPoderEspecial" name="documentoPoderEspecial" required=""/>
        </div>
    </div> 
</g:if>
<g:else>
    <g:hiddenField name="poderSolicitado" value="${otorgamientoDePoderInstance?.poderSolicitado}"/>
</g:else>

