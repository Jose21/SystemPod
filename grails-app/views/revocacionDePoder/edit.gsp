<%@ page import="com.app.sgpod.RevocacionDePoder;java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Editar: Revocación de Poder</h1>            
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>

            <g:hasErrors bean="${revocacionDePoderInstance}">
                <div class="alert alert-block alert-warning">            
                    <g:eachError bean="${revocacionDePoderInstance}" var="error">
                        - <g:message error="${error}"/> <br/>
                    </g:eachError>
                </div>
            </g:hasErrors>


            <g:form class="form-horizontal" method="post" >
                <g:hiddenField name="id" value="${revocacionDePoderInstance?.id}" />
                <g:hiddenField name="version" value="${revocacionDePoderInstance?.version}" />
                <g:render template="form"/>

                <br/>
                <h3 id="bloqueDatosComplementarios"  class="header smaller lighter blue">Datos Complementarios</h3>

                <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'fechaDeRevocacion', 'error')} ">
                    <label for="fechaDeRevocacion" class="control-label">
                        <g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha De Revocacion" />
                    </label>
                    <div class="controls">
                        <div class="row-fluid input-append">
                            <input readonly="readonly" class="span10 date-picker" id="fechaDeRevocacion" type="text" value="${revocacionDePoderInstance?.fechaDeRevocacion?(new SimpleDateFormat("dd/MM/yyyy")).format(revocacionDePoderInstance?.fechaDeRevocacion):""}" data-date-format="dd/mm/yyyy" name="fechaDeRevocacion" />      
                            <span class="add-on">
                                <i class="icon-calendar"></i>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'escrituraPublicaDeRevocacion', 'error')} ">
                    <label for="escrituraPublicaDeRevocacion" class="control-label">
                        <g:message code="revocacionDePoder.escrituraPublicaDeRevocacion.label" default="Escritura Publica De Revocacion" />
                    </label>
                    <div class="controls">
                        <g:textField class="span6" name="escrituraPublicaDeRevocacion" value="${revocacionDePoderInstance?.escrituraPublicaDeRevocacion}"/>
                    </div>
                </div>
                <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'comentarios', 'error')} ">
                    <label for="comentarios" class="control-label">
                        <g:message code="revocacionDePoder.comentarios.label" default="Comentarios" />
                    </label>
                    <div class="controls">
                        <g:textArea class="span6" name="comentarios" cols="40" rows="5" maxlength="1048576" value="${revocacionDePoderInstance?.comentarios}"/>
                    </div>
                </div>
                <div class="form-actions">
                    <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
