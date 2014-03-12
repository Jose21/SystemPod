<%@ page import="com.app.sgtask.Nota" %>



<div class="control-group fieldcontain ${hasErrors(bean: notaInstance, field: 'titulo', 'error')} required">
  <label for="titulo" class="control-label">
    <g:message code="nota.titulo.label" default="Titulo" />
    <span class="required-indicator">*</span>
  </label>
  <div class="controls">
    <g:textField name="titulo" class="span6" required="" value="${notaInstance?.titulo}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: notaInstance, field: 'descripcion', 'error')} ">
  <label for="descripcion" class="control-label">
    <g:message code="nota.descripcion.label" default="Descripción" />

  </label>
  <div class="controls">
    <g:textArea name="descripcion" class="ckeditor validate[required]" value="${notaInstance?.descripcion}"/>
  </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: notaInstance, field: 'documentos', 'error')} ">
  <label for="documentos" class="control-label">
    <g:message code="nota.documentos.label" default="Documentos" />
  </label>
  <div class="controls">
    <g:each in="${notaInstance?.documentos}" var="d">
      <g:link controller="documento" action="deleteArchivo" id ="${d.id}">
        <i class="icon-remove red"></i>
      </g:link>                      -
      <g:link controller="documento" action="downloadArchivo" id="${d.id}">${d?.encodeAsHTML()}</g:link>
      <br/>
    </g:each>
    <input type="file" id="archivo" name="archivo" class="validate[required]"/>
  </div>
</div>

<g:javascript src="ckeditor/ckeditor.js"/>