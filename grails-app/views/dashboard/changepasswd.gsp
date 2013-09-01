<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="main"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cambiar Contraseña</title>
  </head>
  <body>
    <div class="page-content">
      <div class="page-header position-relative">
        <h1>Cambiar contraseña</h1>
      </div><!--/.page-header-->

      <g:render template="/shared/alerts" />

      <div class="row-fluid">
        <div class="span12">
          <g:form class="form-horizontal" action="updatepasswd">
            <div class="control-group">
              <label class="control-label" for="form-field-1">Contraseña actual</label>
              <div class="controls">
                <input type="password" name="oldPasswd" id="form-field-1" value=""/>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="form-field-2">Nueva contraseña</label>
              <div class="controls">
                <input type="password" name="newPasswd1"  id="form-field-2" value="" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="form-field-3">Repite la nueva contraseña</label>
              <div class="controls">
                <input type="password" name="newPasswd2"  id="form-field-3" value="" />
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
