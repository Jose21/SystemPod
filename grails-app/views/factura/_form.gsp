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
        <g:message code="factura.documentos.label" default="Documentos" />
    </label>
    <div class="controls">
        <g:each in="${facturaInstance?.documentos}" var="d">
            <g:link controller="documentoDePoder" action="deleteArchivo" id ="${d.id}">
                <i class="icon-remove red"></i>
            </g:link>                      -
            <g:link controller="documentoDePoder" action="downloadArchivo" id="${d.id}">${d?.encodeAsHTML()}</g:link>
                <br/>
        </g:each>
        <input type="file" id="archivo" name="archivo" class="validate[required]"/><br/>
        <input type="file" id="archivo2" name="archivo2"/>
    </div>
</div>

