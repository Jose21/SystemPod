<%@ page import="com.app.sgpod.Factura" %>



<div class="control-group fieldcontain ${hasErrors(bean: facturaInstance, field: 'nota', 'error')} ">
    <label for="nota" class="control-label">
        <g:message code="factura.nota.label" default="Nota" />

    </label>
    <div class="controls">                
        <g:textArea  class="span6" name="nota" cols="40" rows="5" maxlength="1048576" value="${facturaInstance?.nota}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: facturaInstance, field: 'documentos', 'error')} ">
    <label for="documentos" class="control-label">
        <g:message code="factura.documentos.label" default="Pdf" />
    </label>    
    <div class="controls">        
        <input type="file" id="archivo" name="archivo" class="validate[required]"/><br/>       
    </div>
    <label for="documentos" class="control-label">
        <g:message code="factura.documentos.label" default="Cotización" />
    </label>    
    <div class="controls">        
        <input type="file" id="archivo2" name="archivo2" class="validate[required]"/><br/>
    </div>
    <label for="documentos" class="control-label">
        <g:message code="factura.documentos.label" default="Xml" />
    </label>    
    <div class="controls">        
        <input type="file" id="archivo2" name="archivo3" class="validate[required]"/><br/>
    </div>    
</div>

