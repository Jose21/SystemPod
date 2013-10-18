c<%@ page import="com.app.sgcon.Convenio" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainConvenios">
    <g:set var="entityName" value="${message(code: 'convenio.label', default: 'Convenio')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <calendar:resources lang="es" theme="aqua"/>
  </head>
  <body>
    <div class="content-header">
      <div class="page-header position-relative">
        <h1 id="editarConvenio">Editar: Convenio</h1>
        <div class="btn-group">
          <a class="btn btn-small btn-success tip-bottom" href="#vincularConvenio" data-toggle="modal">
            <i class="icon-user"></i> Vincular convenio al que modifica
          </a>
          <g:link action="share" class="btn btn-small btn-info tip-bottom" id="${convenioInstance?.id}">          
            <i class="icon-share-alt"></i> Compartir
          </g:link>
          <g:link controller="tarea" action="create" class="btn btn-small btn-inverse tip-bottom" params="[ idConvenio : convenioInstance?.id ]">
            <i class="icon-external-link"></i> Asociar Turno
          </g:link>
          <a class="btn btn-small btn-purple tip-bottom" href="#tareasAsociadas" data-toggle="modal">
            <i class="icon-comments"></i> Turnos Asociados
          </a>
        </div>
      </div><!--/.page-header-->
    
      <div class="container-fluid">      
        <g:render template="/shared/alerts" />

        <g:hasErrors bean="${convenioInstance}">
          <ul class="errors" role="alert">
            <g:eachError bean="${convenioInstance}" var="error">
              <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
          </ul>
        </g:hasErrors>
      
        <g:if test="${convenioInstance?.modificaA || convenioInstance?.esModificadoPor}">
          <div class="row-fluid">
            <div class="span6">
              <g:if test="${convenioInstance?.modificaA}">
                <div class="widget-box">
                  <div class="widget-header widget-header-flat widget-header-small">
                    <h5><i class="icon-circle"></i>Modifica un Convenio</h5>
                    <div class="widget-toolbar no-border">
                      <g:form controller="convenio">
                        <g:hiddenField name="convenio.id" value="${convenioInstance?.id}" />
                        <g:hiddenField name="modificaA.id" value="${convenioInstance?.modificaA?.id}" />                      
                        <g:link class="btn btn-minier btn-primary" name="convenioQueModifica" controller="convenio" action="edit" id="${convenioInstance?.modificaA?.id}">
                          Ver
                        </g:link>
                        <g:actionSubmit class="btn btn-minier btn-primary" action="unlinkToConvenioQueModifica" value="Quitar vínculo" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                      </g:form>
                    </div>
                  </div>
                  <div class="widget-body">
                    <div class="widget-main">
                      Número de Convenio: <b>${convenioInstance?.modificaA?.numeroDeConvenio}<br/></b>
                      Objeto: <b>${convenioInstance?.modificaA?.objeto}</b>                    
                    </div><!--/widget-main-->
                  </div><!--/widget-body-->
                </div><!--/widget-box-->
              </g:if>
            </div>
            <div class="span6">
              <g:if test="${convenioInstance?.esModificadoPor}">
                <div class="widget-box">
                  <div class="widget-header widget-header-flat widget-header-small">
                    <h5><i class="icon-circle"></i>Tiene un convenio modificatorio</h5>
                    <div class="widget-toolbar no-border">
                      <g:form controller="convenio">
                      <g:link class="btn btn-minier btn-primary" controller="convenio" action="edit" id="${convenioInstance?.esModificadoPor?.id}">
                        Ver
                      </g:link>
                      </g:form>
                    </div>
                  </div>
                  <div class="widget-body">
                    <div class="widget-main">
                      Número de Convenio: <b>${convenioInstance?.esModificadoPor?.numeroDeConvenio}</b><br/>
                      Objeto: <b>${convenioInstance?.esModificadoPor?.objeto}</b>                    
                    </div><!--/widget-main-->
                  </div><!--/widget-body-->
                </div><!--/widget-box-->              
              </g:if>
            </div>
          </div>
        </g:if>
        
        <h3 id="bloqueDatosDelConvenio" class="header smaller lighter blue">Datos del Convenio</h3>								
        
        <g:form class="form-horizontal" method="post" >
          <g:hiddenField name="anchor" value="bloqueDatosDelConvenio" />
          <g:hiddenField name="id" value="${convenioInstance?.id}" />
          <g:hiddenField name="version" value="${convenioInstance?.version}" />
          <div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'id', 'error')}">
            <label for="id" class="control-label">
              <g:message code="convenio.id.label" default="Identificador interno" />
            </label>
            <div class="controls">
              <span class="badge">${convenioInstance?.id}</span>
            </div>
          </div>
          <g:render template="form"/>
          <div class="form-actions">
            <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />              
          </div>
        </g:form>          
      
        <h3 id="bloqueFirmantes"  class="header smaller lighter blue">Firmantes</h3>       
        
        <table class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>Editar</th>
              <g:sortableColumn property="nombre" title="${message(code: 'persona.nombre.label', default: 'Nombre')}" />        
              <g:sortableColumn property="puesto" title="${message(code: 'persona.puesto.label', default: 'Puesto')}" />        
              <g:sortableColumn property="area" title="${message(code: 'persona.area.label', default: 'Área')}" />
              <g:sortableColumn property="institucion" title="${message(code: 'persona.institucion.label', default: 'Institución')}" />
              <th></th>
            </tr>
            </thead>
            <tbody>
              <g:each in="${convenioInstance.firmantes}" status="i" var="firmante">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                  <td>
                    <a href="#editarFirmanteModal${i}" data-toggle="modal" class="btn btn-success btn-mini">
                      <i class="icon-edit bigger-110"></i>
                    </a>
                    <div id="editarFirmanteModal${i}" class="modal hide" style="width:600px;">
                      <div class="modal-header">
                        <button data-dismiss="modal" class="close" type="button">×</button>
                        <h3>Editar Datos de la Persona</h3>
                      </div>
                      <div class="modal-body">
                        <g:form class="form-horizontal" controller="persona" method="post">
                            <g:hiddenField name="anchor" value="bloqueFirmantes" />
                            <g:hiddenField name="convenio.id" value="${convenioInstance?.id}" />
                            <g:hiddenField name="id" value="${firmante?.id}" />
                            <g:hiddenField name="version" value="${firmante?.version}" />
                            <g:render template="/persona/itForm" bean="${firmante}"/>            
                            <div class="form-actions">
                              <g:actionSubmit class="btn btn-primary" action="updateIt" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                            </div>
                          </g:form>
                      </div>
                    </div>
                  </td>
                  <td>${firmante.nombre}</td>
                  <td>${firmante.puesto}</td>
                  <td>${firmante.area}</td>
                  <td>${firmante.institucion}</td>
                  <td>
                    <g:form class="form-horizontal" controller="convenio" method="post" >
                      <g:hiddenField name="anchor" value="bloqueFirmantes" />
                      <g:hiddenField name="convenio.id" value="${convenioInstance?.id}" />
                      <g:hiddenField name="firmante.id" value="${firmante?.id}" />
                      <g:actionSubmit class="btn btn-danger btn-mini" action="removeFirmante" value="Quitar" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:form>
                  </td>
                </tr>
              </g:each>
              <g:form controller="convenio" method="post">
              <tr>
                <td colspan="5">                  
                  <g:hiddenField name="anchor" value="bloqueFirmantes" />
                  <g:textField class="span6" name="firmante" value="" autocomplete="off"/>
                </td>
                <td>
                  <g:hiddenField name="convenio.id" value="${convenioInstance?.id}"/>
                  <g:actionSubmit class="btn btn-primary btn-mini" action="addFirmante" value="Agregar" />
                </td>
              </tr>
              </g:form>
            </tbody>
          </table>
        
          <h3 id="bloqueResponsables" class="header smaller lighter blue">Responsables del Seguimiento</h3>
        
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>  
                <th>Editar</th>
                <g:sortableColumn property="nombre" title="${message(code: 'persona.nombre.label', default: 'Nombre')}" />        
                <g:sortableColumn property="puesto" title="${message(code: 'persona.puesto.label', default: 'Puesto')}" />        
                <g:sortableColumn property="area" title="${message(code: 'persona.area.label', default: 'Área')}" />
                <g:sortableColumn property="institucion" title="${message(code: 'persona.institucion.label', default: 'Institución')}" />
                <th></th>
              </tr>
            </thead>
            <tbody>
              <g:each in="${convenioInstance.responsables}" status="i" var="responsable">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                  <td>
                    <a href="#editarResponsableModal${i}"  data-toggle="modal" class="btn btn-success btn-mini">
                      <i class="icon-edit bigger-110"></i>
                    </a>
                    <div id="editarResponsableModal${i}" class="modal hide" style="width:600px;">
                      <div class="modal-header">
                        <button data-dismiss="modal" class="close" type="button">×</button>
                        <h3>Editar Datos de la Persona</h3>
                      </div>
                      <div class="modal-body">
                        <g:form class="form-horizontal" controller="persona" method="post">
                            <g:hiddenField name="anchor" value="bloqueResponsables" />
                            <g:hiddenField name="convenio.id" value="${convenioInstance?.id}" />
                            <g:hiddenField name="id" value="${responsable?.id}" />
                            <g:hiddenField name="version" value="${responsable?.version}" />
                            <g:render template="/persona/itForm" bean="${responsable}"/>            
                            <div class="form-actions">
                              <g:actionSubmit class="btn btn-primary" action="updateIt" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                            </div>
                          </g:form>
                      </div>
                    </div>
                  </td>
                  <td>${responsable.nombre}</td>
                  <td>${responsable.puesto}</td>
                  <td>${responsable.area}</td>
                  <td>${responsable.institucion}</td>
                  <td>
                    <g:form class="form-horizontal" controller="convenio" method="post" >
                      <g:hiddenField name="anchor" value="bloqueResponsables" />
                      <g:hiddenField name="convenio.id" value="${convenioInstance?.id}" />
                      <g:hiddenField name="responsable.id" value="${responsable?.id}" />
                      <g:actionSubmit class="btn btn-danger btn-mini" action="removeResponsable" value="Quitar" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                    </g:form>
                  </td>
                </tr>
              </g:each>
              <g:form controller="convenio" method="post">
              <tr>
                <td colspan="5">
                  <g:hiddenField name="anchor" value="bloqueResponsables" />
                  <g:textField class="span6" name="responsable" value="" autocomplete="off"/>
                </td>
                <td>
                  <g:hiddenField name="convenio.id" value="${convenioInstance?.id}"/>
                  <g:actionSubmit class="btn btn-primary btn-mini" action="addResponsable" value="Agregar" />
                </td>
              </tr>
              </g:form>
            </tbody>
          </table>
          
          <h3 id="bloqueCopiaElectronica" class="header smaller lighter blue">Copia Electrónica del Convenio</h3>
      
          <table class="table table-bordered table-striped">
            <thead>
              <tr>
                <th>Subir copia electrónica</th>
                <g:if test="${convenioInstance?.nombreDeCopiaElectronica}">
                  <th>Descargar copia electrónica</th>
                </g:if>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>
                  <g:uploadForm class="form-horizontal" action="uploadCopiaElectronica" >
                    <g:hiddenField name="anchor" value="bloqueCopiaElectronica" />
                    <g:hiddenField name="convenio.id" value="${convenioInstance?.id}" />                    
                    <div class="control-group">
                      <div class="controls">          
                        <input type="file" name="copiaElectronica"/>          
                      </div>
                    </div>
                    <div class="form-actions">
                      <g:submitButton name="adjuntar" class="btn btn-primary" value="Adjuntar" />
                    </div>
                  </g:uploadForm>
                </td>
                <g:if test="${convenioInstance?.nombreDeCopiaElectronica}">
                  <td style="text-align:center">                  
                    <g:link controller="convenio" action="downloadCopiaEletronica" params="[convenioId: convenioInstance.id]">
                      <g:img dir="images" file="download.png" width="64px" height="64px"/>
                      <br/>${convenioInstance?.nombreDeCopiaElectronica}
                    </g:link>
                  </td>
                </g:if>
              </tr>
            </tbody>
          </table>          
        
      </div>
      <div id="vincularConvenio" class="modal hide" style="width:600px;">
        <div class="modal-header">
          <button data-dismiss="modal" class="close" type="button">×</button>
          <h3>Vincular convenio al que modifica</h3>
        </div>
        <div class="modal-body">
          <g:form class="form-horizontal" controller="convenio" method="post">
            <g:hiddenField name="convenio.id" value="${convenioInstance?.id}" />
            <div class="control-group fieldcontain ${hasErrors(bean: convenioInstance, field: 'modificaA', 'error')} required">
              <label for="modificaA" class="control-label">
                <g:message code="convenio.modificaA.label" default="Convenio al que modifica" />
                <span class="required-indicator">*</span>
              </label>
              <div class="controls">
                <g:select id="modificaA" name="modificaA.id" from="${com.app.sgcon.Convenio.findAll { id != convenioInstance.id }}" optionKey="id" required="" value="${convenioInstance?.modificaA?.id}" class="many-to-one"/>
              </div>
            </div>
            <div class="form-actions">
              <g:actionSubmit class="btn btn-primary" action="linkToConvenioQueModifica" value="${message(code: 'default.button.update.label', default: 'Update')}" />
            </div>
          </g:form>
        </div>        
      </div>
      <div id="tareasAsociadas" class="modal hide" style="width:600px;">
          <div class="modal-header">
            <button data-dismiss="modal" class="close" type="button">×</button>
            <h3>Turnos asociados al convenio</h3>
          </div>
          <div class="modal-body">     
            <g:if test="${convenioInstance?.tareas.findAll{ it.cerrada == false }}">
              <div class="widget-box">
                <div class="widget-header widget-header-flat widget-header-small">
                  <h5><i class="icon-circle"></i>Turnos Abiertos</h5>                    
                </div>
                <div class="widget-body">
                  <div class="widget-main">
                    <g:each in="${convenioInstance?.tareas.findAll{ it.cerrada == false }}" var="tarea">
                      <g:link class="btn btn-mini btn-info btn-block" controller="tarea" action="show" id="${tarea.id}" params="[ idConvenio : convenioInstance?.id ]">
                        <span class="label label-large label-info arrowed-in-right arrowed-in">Turno: ${tarea.id}</span>
                        ${tarea.nombre}
                      </g:link></br>
                    </g:each>
                  </div><!--/widget-main-->
                </div><!--/widget-body-->
              </div><!--/widget-box-->
            </g:if>
            <g:if test="${convenioInstance?.tareas.findAll{ it.cerrada == true }}">
              <br/>
              <div class="widget-box">
                <div class="widget-header widget-header-flat widget-header-small">
                  <h5><i class="icon-circle"></i>Turnos Cerrados</h5>                    
                </div>
                <div class="widget-body">
                  <div class="widget-main">
                    <g:each in="${convenioInstance?.tareas.findAll{ it.cerrada == true }}" var="tarea">
                      <g:link class="btn btn-mini btn-light btn-block" controller="tarea" action="show" id="${tarea.id}" params="[ idConvenio : convenioInstance?.id ]">
                        <span class="label label-large label-light arrowed-in-right arrowed-in">Turno: ${tarea.id}</span>
                        ${tarea.nombre}
                      </g:link></br>
                    </g:each>
                  </div><!--/widget-main-->
                </div><!--/widget-body-->
              </div><!--/widget-box-->
            </g:if>
          </div>
        </div>
    </div>
    <script lang="javascript" type="text/javascript">
          (function($) { 
            $(document.body).animate({
                'scrollTop':   $("#"+${anchor?:"editarConvenio"}).offset().top
            }, 0);
            $('#firmante').autocomplete({
              source : function(request, response){
                $.ajax({
                 url: '/<g:meta name='app.name'/>/persona/ajaxFinder', 
                  data: request,
                  success: function(data){
                    response(data); 
                  },
                  error: function(){ 
                  }
                });
              },
              minLength: 3,
              select: function(event, ui) {
                $('#firmante').val(ui.item.nasSymbol + "-")
              }
            });

            $('#responsable').autocomplete({
              source : function(request, response){
                $.ajax({
                 url: '/<g:meta name='app.name'/>/persona/ajaxFinder', 
                  data: request,
                  success: function(data){
                    response(data); 
                  },
                  error: function(){ 
                  }
                });
              },
              minLength: 3,
              select: function(event, ui) {
                $('#responsable').val(ui.item.nasSymbol + "-")
              }
            });
          })(jQuery);
    </script>
  </body>
</html>
