<%@ page import="com.app.sgpod.OtorgamientoDePoder;java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento de Poder')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Editar: Otorgamiento de Poder</h1>    
            <!--
            <div class="btn-group">
                
                <g:link controller="cartaDeInstruccion" action="exists" id="${otorgamientoDePoderInstance?.id}" params="[ tipo :'otorgamientoDePoder']" class="btn btn-small btn-success tip-bottom">
                    <i class="icon-external-link"></i> Carta de Instrucción
                </g:link>
            </div>
            -->
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>

            <g:hasErrors bean="${otorgamientoDePoderInstance}">
                <div class="alert alert-block alert-warning">            
                    <g:eachError bean="${otorgamientoDePoderInstance}" var="error">
                        - <g:message error="${error}"/> <br/>
                    </g:eachError>
                </div>
            </g:hasErrors>

            <g:form class="form-horizontal" method="post" >
                <g:hiddenField name="id" value="${otorgamientoDePoderInstance?.id}" />
                <g:hiddenField name="version" value="${otorgamientoDePoderInstance?.version}" />            
                <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'id', 'error')}">
                    <label for="id" class="control-label">
                        <g:message code="otorgamientoDePoder.id.label" default="Identificador interno" />
                    </label>
                    <div class="controls">
                        <span class="badge">${otorgamientoDePoderInstance?.id}</span>
                    </div>
                </div>
                <g:render template="form"/>

                <h3 id="bloqueDatosComplementarios"  class="header smaller lighter blue">Datos Complementarios</h3>
                <br/>
                <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'fechaDeOtorgamiento', 'error')} ">
                    <label for="fechaDeOtorgamiento" class="control-label">
                        <g:message code="otorgamientoDePoder.fechaDeOtorgamiento.label" default="Fecha De Otorgamiento" />
                    </label>
                    <div class="controls">
                        <div class="row-fluid input-append">
                            <input readonly="readonly" class="span10 date-picker" id="fechaDeOtorgamiento" type="text" value="${otorgamientoDePoderInstance?.fechaDeOtorgamiento?(new SimpleDateFormat("dd/MM/yyyy")).format(otorgamientoDePoderInstance?.fechaDeOtorgamiento):""}" data-date-format="dd/mm/yyyy" name="fechaDeOtorgamiento" />      
                            <span class="add-on">
                                <i class="icon-calendar"></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'escrituraPublicaDeOtorgamiento', 'error')} ">
                    <label for="escrituraPublicaDeOtorgamiento" class="control-label">
                        <g:message code="otorgamientoDePoder.escrituraPublicaDeOtorgamiento.label" default="Escritura Publica De Otorgamiento" />
                    </label>
                    <div class="controls">
                        <g:textField class="span6" name="escrituraPublicaDeOtorgamiento" value="${otorgamientoDePoderInstance?.escrituraPublicaDeOtorgamiento}"/>
                    </div>
                </div>
                <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'comentarios', 'error')} ">
                    <label for="comentarios" class="control-label">
                        <g:message code="otorgamientoDePoder.comentarios.label" default="Comentarios" />
                    </label>
                    <div class="controls">
                        <g:textField class="span6" name="comentarios" value="${otorgamientoDePoderInstance?.comentarios}"/>
                    </div>
                </div>
                <div class="form-actions">
                    <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
