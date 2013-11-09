
<%@ page import="com.app.sgcon.Convenio" %>

<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <title>Reporte: Convenios Por Rango De Fecha</title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Reporte: Convenios Por Rango De Fecha</h1>      
    </div>
    <div class="container-fluid">
      <br/>
      <g:render template="/shared/alerts" />
      <g:form method="post">
        <label for="objeto" class="control-label">
          Rango de Fechas:
        </label>
        <div class="control-group">
          <div class="row-fluid input-prepend">
            <span class="add-on">
              <i class="icon-calendar"></i>
            </span>
            <input class="span5" type="text" name="rangoDeFecha" id="rangoDeFecha" value="${rangoDeFecha?:""}" readonly="true" />
            <g:actionSubmit class="btn btn-primary" action="conveniosPorFecha" value="Buscar" />
          </div>
        </div>
      </g:form>
      <br/>
      <div id="containerTotalDeConvenios" style="min-width: 310px; height: 400px; margin: 0 auto"></div>      
    </div>    
  </body>  
</html>
