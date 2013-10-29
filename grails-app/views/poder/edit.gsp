<%@ page import="com.app.sgpod.Poder;java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainPoderes">
    <g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Editar: Otorgamiento de Poder</h1>      
    </div>
    
    <div class="container-fluid">
      <g:render template="/shared/alerts" />
      <br/>

      <g:hasErrors bean="${poderInstance}">
        <div class="alert alert-block alert-warning">            
            <g:eachError bean="${poderInstance}" var="error">
                - <g:message error="${error}"/> <br/>
            </g:eachError>
        </div>
      </g:hasErrors>

          <g:form class="form-horizontal" method="post" >
            <g:hiddenField name="id" value="${poderInstance?.id}" />
            <g:hiddenField name="version" value="${poderInstance?.version}" />            
            <div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'id', 'error')}">
                <label for="id" class="control-label">
                  <g:message code="poder.id.label" default="Identificador interno" />
                </label>
                <div class="controls">
                  <span class="badge">${poderInstance?.id}</span>
                </div>
            </div>
            <g:render template="form"/>
            <br/>
            <h3 id="bloqueDatosComplementarios"  class="header smaller lighter blue">Datos Complementarios</h3>       
            <div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'fechaDeOtorgamientoDePoder', 'error')} ">
                <label for="fechaDeOtorgamientoDePoder" class="control-label">
                    <g:message code="poder.fechaDeOtorgamientoDePoder.label" default="Fecha De Otorgamiento De Poder" />
                </label>
                <div class="controls">
                    <div class="row-fluid input-append">
                        <input readonly="readonly" class="span10 date-picker" id="fechaDeOtorgamientoDePoder" type="text" value="${poderInstance?.fechaDeOtorgamientoDePoder?(new SimpleDateFormat("dd/MM/yyyy")).format(poderInstance?.fechaDeOtorgamientoDePoder):""}" data-date-format="dd/mm/yyyy" name="fechaDeOtorgamientoDePoder" />      
                        <span class="add-on">
                            <i class="icon-calendar"></i>
                        </span>
                    </div>
                </div>
            </div>
            <div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'escrituraPublicaDeOtorgamiento', 'error')} ">
                <label for="escrituraPublicaDeOtorgamiento" class="control-label">
                    <g:message code="poder.escrituraPublicaDeOtorgamiento.label" default="Escritura Publica De Otorgamiento" />
                </label>
                <div class="controls">
                    <g:textField class="span6" name="escrituraPublicaDeOtorgamiento" value="${poderInstance?.escrituraPublicaDeOtorgamiento}"/>
                </div>
            </div>
            <div class="control-group fieldcontain ${hasErrors(bean: poderInstance, field: 'comentarios', 'error')} ">
                <label for="comentarios" class="control-label">
                    <g:message code="poder.comentarios.label" default="Comentarios" />
                </label>
                <div class="controls">
                    <g:textField class="span6" name="comentarios" value="${poderInstance?.comentarios}"/>
                </div>
            </div>
            <div class="form-actions">
              <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
            </div>
          </g:form>
    </div>
  </body>
</html>
