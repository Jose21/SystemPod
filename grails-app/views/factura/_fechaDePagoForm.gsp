<%@ page import="com.app.sgpod.Factura;java.text.SimpleDateFormat" %>


<br/>
<br/>
<div class="control-group fieldcontain ${hasErrors(bean: facturaInstance, field: 'fechaDePago', 'error')} ">
    <label for="nota" class="control-label">
        <g:message code="factura.fechaDePago.label" default="Fecha De Pago" />
    </label>
    <div class="controls">        
        <div class="row-fluid input-append">
            <input readonly="readonly" class="span6 date-picker validate[required]" id="fechaDePago" type="text" value="${facturaInstance?.fechaDePago?(new SimpleDateFormat("dd/MM/yyyy")).format(facturaInstance?.fechaDePago):""}" data-date-format="dd/mm/yyyy" name="fechaDePago" />      
            <span class="add-on">
                <i class="icon-calendar"></i>
            </span>
        </div>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: facturaInstance, field: 'numeroDeCesta', 'error')} ">
    <label for="numeroDeCesta" class="control-label">
        <g:message code="factura.numeroDeCesta.label" default="Número de Cesta" />
    </label>
    <div class="controls">                         
        <g:field class="span4" name="numeroDeCesta" value="${facturaInstance?.numeroDeCesta}" required=""/>        
    </div>
</div>

