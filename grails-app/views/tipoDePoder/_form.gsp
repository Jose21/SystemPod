<%@ page import="com.app.sgpod.TipoDePoder" %>



<div class="control-group fieldcontain ${hasErrors(bean: tipoDePoderInstance, field: 'categorias', 'error')} ">
    <label for="categorias" class="control-label">
        <g:message code="tipoDePoder.categorias.label" default="Categorias" />

    </label>
    <div class="controls">

        <ul class="one-to-many">
            <g:each in="${tipoDePoderInstance?.categorias}" var="c">
                <li> ${c.nombre} </li>
                <div class="controls">
                    <g:textArea class="span8" name="nombre" maxlength="5000" value="${c?.nombre}" autocomplete="off"/>
                </div>
            </g:each>
        <!--li class="add">
            <g:link controller="categoriaDeTipoDePoder" action="create" params="['tipoDePoder.id': tipoDePoderInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder')])}</g:link>                
        </li-->
        </ul>

    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: tipoDePoderInstance, field: 'nombre', 'error')} ">
    <label for="nombre" class="control-label">
        <g:message code="tipoDePoder.nombre.label" default="Nombre" />

    </label>
    <div class="controls">
        <g:textField name="nombre" value="${tipoDePoderInstance?.nombre}"/>
    </div>    
</div>



