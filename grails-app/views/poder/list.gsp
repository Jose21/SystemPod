
<%@ page import="com.app.sgpod.Poder" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainPoderes">
    <g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>    
    <div class="page-header position-relative">
      <h1>
        Lista: Otorgamiento De Poderes
      </h1>
    </div><!--/.page-header-->
                                        
    <div class="container-fluid">
      <br/>
      <g:if test="${flash.message}">
        <div class="alert">
          <strong>¡Atención!</strong> ${flash.message}
        </div>
      </g:if>
      <br/>
      <div class="widget-content nopadding">
        <table class="table table-striped table-bordered table-hover">
          <thead>
            <tr>
                <g:sortableColumn property="id" title="${message(code: 'poder.id.label', default: 'Identificador')}" />
                <g:sortableColumn property="numeroDeFolio" title="${message(code: 'poder.numeroDeFolio.label', default: 'Numero De Folio')}" />
                <g:sortableColumn property="registroDeLaSolicitud" title="${message(code: 'poder.registroDeLaSolicitud.label', default: 'Registro De La Solicitud')}" />
                <g:sortableColumn property="tipoDePoder" title="${message(code: 'poder.tipoDePoder.label', default: 'Tipo De Poder')}" />
                <g:sortableColumn property="delegacion" title="${message(code: 'poder.delegacion.label', default: 'Delegacion')}" />
                <g:sortableColumn property="puesto" title="${message(code: 'poder.puesto.label', default: 'Puesto')}" />
                <g:sortableColumn property="contrato" title="${message(code: 'poder.contrato.label', default: 'Contrato')}" />
            </tr>
          </thead>
          <tbody>
            <g:each in="${poderInstanceList}" status="i" var="poderInstance">
              <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                  <td><g:link action="edit" id="${poderInstance.id}"><span class="badge">${fieldValue(bean: poderInstance, field: "id")}</span></g:link></td>
                  <td>${fieldValue(bean: poderInstance, field: "numeroDeFolio")}</td>
                  <td><g:formatDate date="${poderInstance.registroDeLaSolicitud}" /></td>
                  <td>${fieldValue(bean: poderInstance, field: "tipoDePoder")}</td>
                  <td>${fieldValue(bean: poderInstance, field: "delegacion")}</td>
                  <td>${fieldValue(bean: poderInstance, field: "puesto")}</td>
                  <td>${fieldValue(bean: poderInstance, field: "contrato")}</td>
              </tr>
            </g:each>
          </tbody>
        </table>
      </div>        
      <div class="pagination pull-right no-margin">
        <g:paginate total="${poderInstanceTotal}" />
      </div>
    </div>
  </body>
</html>
