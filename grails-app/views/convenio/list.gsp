
<%@ page import="com.app.sgcon.Convenio" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <g:set var="entityName" value="${message(code: 'convenio.label', default: 'Convenio')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="content-header">
      <div class="page-header position-relative">
        <h1>Lista: Convenios</h1>
      </div><!--/.page-header-->
      <div class="container-fluid">
        <br/>
        <g:form method="post">
          <div class="control-group">
            <div class="row-fluid input-prepend">
              <span class="add-on">
                <i class="icon-calendar"></i>
              </span>
              <input class="span5" type="text" name="rangoDeFecha" id="rangoDeFecha" />
              <g:actionSubmit class="btn btn-primary" action="buscarConvenios" value="Buscar" />
            </div>
          </div>
        </g:form>
        <div class="widget-content nopadding">
          <table class="table table-bordered table-striped">
            <thead>
              <tr>
                <g:sortableColumn property="id" title="${message(code: 'convenio.id.label', default: 'Identificador interno')}" />
                <g:sortableColumn property="numeroDeConvenio" title="${message(code: 'convenio.numeroDeConvenio.label', default: 'Número de Convenio')}" />
                <g:sortableColumn property="objeto" title="${message(code: 'convenio.objeto.label', default: 'Objeto')}" />
                <g:sortableColumn property="sustentoNormativo" title="${message(code: 'convenio.sustentoNormativo.label', default: 'Sustento Normativo')}" />
                <g:sortableColumn property="fechaDeFirma" title="${message(code: 'convenio.fechaDeFirma.label', default: 'Fecha De Firma')}" />
                <th><g:message code="convenio.status.label" default="Status" /></th>
              </tr>
            </thead>
            <tbody>
            <g:each in="${convenioInstanceList}" status="i" var="convenioInstance">
              <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                <td style="text-align:center"><g:link action="edit" id="${convenioInstance.id}"><span class="badge">${convenioInstance?.id}</span></g:link></td>
                <td>${fieldValue(bean: convenioInstance, field: "numeroDeConvenio")}</td>
                <td>${fieldValue(bean: convenioInstance, field: "objeto")}</td>
                <td>${fieldValue(bean: convenioInstance, field: "sustentoNormativo")}</td>
                <td><g:formatDate date="${convenioInstance.fechaDeFirma}" /></td>
                <td>${fieldValue(bean: convenioInstance, field: "status")}</td>
              </tr>
            </g:each>
            </tbody>
          </table>
        </div>        
        <div class="pagination">
          <g:paginate total="${convenioInstanceTotal}" />
        </div>
      </div>
    </div>
  </body>      
</html>
