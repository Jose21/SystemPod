<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="mainTareas">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reporte: Turnos Por Rango De Fecha</title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Reporte: Turnos Por Rango De Fecha</h1>      
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
            <input class="span5" type="text" name="rangoDeFecha" id="rangoDeFecha" value="${rangoDeFecha?rangoDeFecha:""}" readonly="true" />
            <g:actionSubmit class="btn btn-primary" action="buscarTurnosPorFecha" value="Buscar" />
          </div>
        </div>
      </g:form>
      <br/>      
    </div>    
  </body>  
</html>
