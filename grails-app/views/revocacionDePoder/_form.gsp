<%@ page import="com.app.sgpod.RevocacionDePoder;java.text.SimpleDateFormat" %>


<g:hiddenField name="escrituraPublica" value="${revocacionDePoderInstance?.escrituraPublica}"/>
<g:each in="${revocacionDePoderInstance.apoderados}" status="i" var="apoderado">            
    <g:hiddenField name="apoderado${apoderado.id}" value="${apoderado.id}"/>            
</g:each>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'tipoDeRevocacion', 'error')} required">
    <label for="tipoDeRevocacion" class="control-label">
        <g:message code="revocacionDePoder.tipoDeRevocacion.label" default="Tipo de Revocación" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select name="tipoDeRevocacion" from="${revocacionDePoderInstance.constraints.tipoDeRevocacion.inList}" required="" value="${revocacionDePoderInstance?.tipoDeRevocacion}" valueMessagePrefix="revocacionDePoder.tipoDeRevocacion"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'categoriaDeTipoDePoder', 'error')} required">
    <label for="categoriaDeTipoDePoder" class="control-label">
        <g:message code="revocacionDePoder.categoriaDeTipoDePoder.label" default="Tipo de Poder" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select readonly="readonly" class="chosen-select" optionKey="id" optionValue="nombre" name="tipoDePoder.id" id="tipoDePoder.nombre" from="${com.app.sgpod.TipoDePoder.list()}"
        value="${revocacionDePoderInstance?.categoriaDeTipoDePoder?.tipoDePoder?.id}"
            noSelection="['':'Elige un tipo de poder']"        
        onchange="${remoteFunction(
controller:'tipoDePoder', 
action:'ajaxGetCategorias', 
params:'\'tipoDePoder.id=\' + this.value', 
update:'categoriaSelection'
)}"/>
    </div>
    <div class="controls" id="categoriaSelection" >
        <select readonly="readonly" class="chosen-select" data-placeholder="Elige una categoria..." name="categoriaDeTipoDePoder">
            <option value="${revocacionDePoderInstance?.categoriaDeTipoDePoder?.id}">${revocacionDePoderInstance?.categoriaDeTipoDePoder?.nombre}</option>
        </select>
    </div>    
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'delegacion', 'error')} required">
    <label for="delegacion" class="control-label">
        <g:message code="revocacionDePoder.delegacion.label" default="Delegación" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <select readonly="readonly" class="chosen-select" id="delegacion" name="delegacion" data-placeholder="Elige una delegación..." required="">
            <g:each in="${com.app.sgpod.Delegacion.list()}" var="delegacion">
                <g:if test="${delegacion?.id == revocacionDePoderInstance?.delegacion?.id}">                    
                    <option value="${delegacion.id}" selected>${delegacion.nombre}</option>
                </g:if>
                <g:else>
                    <option value="${delegacion.id}">${delegacion.nombre}</option>
                </g:else>
            </g:each>
        </select>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'solicitadoPor', 'error')}">
    <label for="solicitadoPor" class="control-label">
        <g:message code="revocacionDePoder.solicitadoPor.label" default="Solicitado Por" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField  class="span6" name="solicitadoPor"  value="${revocacionDePoderInstance?.solicitadoPor}" readonly="readonly"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'fechaDeRevocacion', 'error')} ">
    <label for="fechaDeRevocacion" class="control-label">
        <g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha De Revocación" />
    </label>
    <div class="controls">
        <div class="row-fluid input-append">           
            <!--g:formatDate format="dd-MM-yyyy" date="${revocacionDePoderInstance?.fechaDeRevocacion}"/-->
            <g:textField  name="fechaDeRevocacion" required="" value="${revocacionDePoderInstance?.fechaDeRevocacion}" readonly="readonly"/>
        </div>
    </div>
</div> 

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'comentarios', 'error')} ">
    <label for="comentarios" class="control-label">
        <g:message code="revocacionDePoder.comentarios.label" default="Comentarios" />
    </label>
    <div class="controls">
        <g:textArea  class="span6" name="comentarios" cols="40" rows="5" maxlength="1048576" value="${revocacionDePoderInstance?.comentarios}" readonly="readonly"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'documentos', 'error')} ">
    <label for="documentos" class="control-label">
        <g:hiddenField name="anchor" value="bloqueAdjuntarArchivos"/>
        <g:message code="revocacionDePoder.documentos.label" default="Documentos" />
    </label>
    <div class="controls">
        <g:each in="${revocacionDePoderInstance?.documentos}" var="d">
            <div class="pull-left action-buttons">
                <g:link class="red" controller="revocacionDePoder" action="deleteArchivo" id ="${d.id}" params="[revocacionDePoderId:revocacionDePoderInstance?.id, anchor:'bloqueAdjuntarArchivos']">
                    <i class="icon-trash bigger-130"></i>
                    <i class="icon-caret-right blue"></i>
                </g:link>
            </div>
            <g:link controller="documentoDePoder" action="downloadArchivo" id="${d.id}">${d?.encodeAsHTML()}</g:link>
            <g:hiddenField name="documento${d.id}" value="${d.id}" />
            <br/>
        </g:each>
        <br/>
        <input type="file" id="archivo" name="archivo" disabled="disabled"/>
    </div>
</div>

<h3 id="bloqueTags" class="header smaller lighter blue">Agrega palabras clave para búsquedas avanzadas.</h3>

<div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'tags', 'error')}">
    <label for="tags" class="control-label">
        <g:message code="revocacionDePoder.tags.label" default="Tags" />
    </label>
    <div class="controls">
        <g:textField class="span6" name="tags" value="${revocacionDePoderInstance?.tags}"/>
    </div>
</div>

<script lang="javascript" type="text/javascript">
    (function($) {
    $('#escrituraPublica').autocomplete({
    source : function(request, response){
    $.ajax({
            url: '/<g:meta name='app.name'/>/revocacionDePoder/ajaxFinder', 
    data: request,
    success: function(data){
    response(data); 
    },
    error: function(){}
    });
    },
    minLength: 3,
    select: function(event, ui) {
    $('#escrituraPublica').val(ui.item.nasSymbol + "-")
    }
    });                                    
    })(jQuery);
</script>