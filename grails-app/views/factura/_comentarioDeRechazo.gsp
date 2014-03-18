<%@ page import="com.app.sgpod.Factura" %>



<div class="control-group fieldcontain ${hasErrors(bean: facturaInstance, field: 'comentarioDeRechazo', 'error')} ">    
    <div class="controls">        
        <div class="row-fluid input-append">             
            <g:textArea  class="span6" name="comentarioDeRechazo" cols="40" rows="5" maxlength="1048576" value="${facturaInstance?.comentarioDeRechazo}"/>
        </div>
    </div>
</div>
