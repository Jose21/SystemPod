<%@ page import="com.app.sgpod.DocumentoDeProyecto" %>



<div class="control-group fieldcontain ${hasErrors(bean: documentoDeProyectoInstance, field: 'descripcion', 'error')} ">
    <label for="descripcion" class="control-label">
        <g:message code="documentoDeProyecto.descripcion.label" default="Comentarios del Notario" />

    </label>
    <div class="controls">
        <g:textArea class="span6" name="descripcion" cols="400" rows="5" maxlength="10240" value="${documentoDeProyectoInstance?.descripcion}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: documentoDeProyectoInstance, field: 'documentos', 'error')} ">
    <label for="documentos" class="control-label">
        <g:message code="documentoDeProyecto.documentos.label" default="Carta de Instrucción" />

    </label>
    <div class="controls">

        <!--li class="add">
            <g:link controller="documento" action="create" params="['documentoDeProyecto.id': documentoDeProyectoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'documento.label', default: 'Documento')])}</g:link>
            </li-->
        <input type="file" name="documento" required=""/>  
    </div>
</div>

