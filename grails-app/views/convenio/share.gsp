<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="mainTareas">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Compartir Convenio</title>
  </head>
  <body>
    <h1>Convenio: ${convenioInstance?.id}</h1>
    <br/>
    <g:render template="/shared/alerts" />
    <g:form class="form-horizontal" controller="convenio" method="post">
      <g:hiddenField name="id" value="${convenioInstance?.id}" />
      <div class="control-group required">
        <label for="compartirCon" class="control-label">
          Compartir con:
        </label>
        <div class="controls">
          <g:select id="compartidoCon" name="compartidoCon.id" 
                    from="${com.app.security.Usuario.findAll { enabled }}" optionKey="id" 
                    required="" value="" class="many-to-one"/>
        </div>
      </div>            
      <div class="form-actions">
        <g:actionSubmit class="btn btn-mini btn-primary" action="addUsuarioToConvenio" value="Aceptar" />        
      </div>
    </g:form>
    <table class="table table-bordered table-striped">
      <thead>
        <tr>          
          <th>Usuario</th>
          <th>Nombre</th>
          <th>Email</th>
          <th>Creador del Convenio</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <g:if test="${convenioInstance?.usuariosDeConvenio}">
          <g:each in="${convenioInstance?.usuariosDeConvenio}" var="usuarioDeConvenio" status="i">
          <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <td>
              <g:hiddenField name="usuario" value="${usuarioDeConvenio.usuario.id}"/>
              ${usuarioDeConvenio.usuario.username}
            </td>
            <td>${usuarioDeConvenio.usuario.firstName} ${usuarioDeConvenio.usuario.lastName}</td>
            <td>${usuarioDeConvenio.usuario.email}</td>
            <td style="text-align:center;">
              <g:if test="${usuarioDeConvenio.owner}">
                <span class="label label-large label-purple arrowed-in-right arrowed-in">Si</span>
              </g:if>
              <g:else>
                <span class="label label-large label-grey arrowed-in-right arrowed-in">No</span>
              </g:else>              
            </td>
            <td>
              <g:if test="${!usuarioDeConvenio.owner}">
                <g:form name="removeUserFromConvenio" controller="convenio" action="removeUsuarioFromConvenio">
                  <g:hiddenField name="convenioId" value="${convenioInstance.id}"/>
                  <g:hiddenField name="usuarioId" value="${usuarioDeConvenio.usuario.id}"/>
                  <g:submitButton class="btn btn-danger btn-mini" name="btnRemove" value="Quitar"/>
                </g:form>
              </g:if>
            </td>
          </tr>
          </g:each>
        </g:if>
        <g:else>
          <tr>
            <td colspan="4" style="text-align:center;">El convenio aún no ha sido compartido.</td>
          </tr>
        </g:else>
      </tbody>
    </table>   
  </body>
</html>
