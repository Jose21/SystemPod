<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cambiar Información del Usuario</title>
  </head>
  <body>
    <div class="content-header">
      <div class="page-header position-relative">
        <h1>Cambiar Información del Usuario</h1>
      </div><!--/.page-header-->

      <g:render template="/shared/alerts" />

      <div class="row-fluid">
        <div class="span12">
          <g:form class="form-horizontal" action="updateinfo">
            <div class="control-group">
              <label class="control-label" for="form-field-1">Email</label>
              <div class="controls">
                <input type="text" name="email" id="form-field-1" value="${user.email}"/>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="form-field-2">Nombre(s)</label>
              <div class="controls">
                <input type="text" name="firstName" id="form-field-2" value="${user.firstName}"/>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="form-field-3">Apellidos</label>
              <div class="controls">
                <input type="text" name="lastName" id="form-field-3" value="${user.lastName}"/>
              </div>
            </div>
            <div class="form-actions">
              <g:link action="index" class="btn btn-info">
                Regresar
              </g:link>
              <g:submitButton name="Enviar" class="btn btn-info"/>
            </div>
          </g:form>
        </div>
      </div>
    </div>
  </body>
</html>
