
<%@ page import="com.app.sgtask.Tarea" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">
    <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Tarea')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>Mostrar: Turno</h1>
      <br/>
      <div class="btn-group">        
        <g:link class="btn btn-info btn-small tip-bottom" action="create">
          <i class="icon-asterisk"></i>
          Nuevo
        </g:link>        
        <g:link class="btn btn-success btn-small tip-bottom" controller="nota" action="create" params="[tareaId: tareaInstance?.id]">
          <i class="icon-asterisk"></i>
          Agregar Nota
        </g:link>        
        
        <g:if test="${tareaInstance?.creadaPor.id == currentUser.id || tareaInstance?.responsable.id == currentUser.id}">
          <g:link action="share" class="btn btn-small btn-purple tip-bottom" id="${tareaInstance?.id}">          
              <i class="icon-share-alt"></i> Compartir
          </g:link>
        </g:if>  
        <g:if test="${!tareaInstance?.cerrada && (tareaInstance?.creadaPor.id == currentUser.id || tareaInstance?.responsable.id == currentUser.id)}">
          <g:link class="btn btn-warning btn-small tip-bottom" controller="tarea" action="cerrarTarea" id="${tareaInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
            <i class="icon-asterisk"></i>
            Cerrar
          </g:link>
        </g:if>
      </div>
    </div>
    
    <div class="container-fluid">
      <g:if test="${tareaInstance?.convenio}">
        <br/>
          <g:link class="btn btn-small btn-info btn-block" controller="convenio" action="edit" id="${tareaInstance?.convenio.id}">                
            El turno está asociado al convenio: ${tareaInstance?.convenio.id} - Número de Convenio: ${tareaInstance?.convenio.numeroDeConvenio} - Objeto: ${tareaInstance?.convenio.objeto}
          </g:link>
        <br/>
      </g:if>
      <br/>
      <g:render template="/shared/alerts" />
      <div class="well">        
        <g:if test="${tareaInstance?.id}">
          <dl>
            <dt><g:message code="tarea.id.label" default="Identificador del Turno" /></dt>	
            <dd>
              <span class="label label-success arrowed-in">
                <g:fieldValue bean="${tareaInstance}" field="id"/>
              </span>
            </dd>				
          </dl>
        </g:if>
        <g:if test="${tareaInstance?.nombre}">
          <dl>
            <dt><g:message code="tarea.nombre.label" default="Nombre" /></dt>
            <dd><g:fieldValue bean="${tareaInstance}" field="nombre"/></dd>					
          </dl>
        </g:if>        
        <g:if test="${tareaInstance?.fechaLimite}">
          <dl>
            <dt><g:message code="tarea.fechaLimite.label" default="Fecha Limite" /></dt>
            <dd><g:formatDate date="${tareaInstance?.fechaLimite}" format="dd-MMM-yyyy" /></dd>				
          </dl>
	</g:if>		
        <g:if test="${tareaInstance?.grupo}">
          <dl>
            <dt><g:message code="tarea.grupo.label" default="Grupo" /></dt>				
            <dd><g:link controller="grupo" action="show" id="${tareaInstance?.grupo?.id}">${tareaInstance?.grupo?.encodeAsHTML()}</g:link></dd>				
          </dl>
        </g:if>                 
        <dl>
          <dt><g:message code="tarea.cerrada.label" default="Status" /></dt>
          <dd>${tareaInstance?.cerrada?"Cerrada":"Abierta"}</dd>				
        </dl>
        <dl>
          <dt><g:message code="tarea.responsable.label" default="Responsable asignado" /></dt>
          <dd>${tareaInstance?.responsable?.firstName} ${tareaInstance?.responsable?.lastName}</dd>
        </dl>
        <g:if test="${tareaInstance?.usuariosDeTarea}">
          <dl>
            <dt><g:message code="tarea.usuariosDeTarea.label" default="Turno compartido con" /></dt>
            <dd>
              <ul>
                <g:each in="${tareaInstance?.usuariosDeTarea}" var="usuarioDeTarea">
                  <g:if test="${usuarioDeTarea.usuario.id != tareaInstance}">
                    <li>${usuarioDeTarea.usuario.firstName} ${usuarioDeTarea.usuario.lastName}</li>
                  </g:if>
                </g:each>
              </ul>            
            </dd>
          </dl>
        </g:if>
        <g:if test="${tareaInstance?.descripcion}">
          <dl>
            <dt><g:message code="tarea.descripcion.label" default="Descripción" /> - (Creada: <g:formatDate date="${tareaInstance?.dateCreated}" type="datetime" style="MEDIUM"/>)</dt>			
            <dd class="well" style="background:white">
              <%=tareaInstance?.descripcion%>
            </dd>	
          </dl>
        </g:if>
        
        <g:if test="${tareaInstance?.notas}">
        <div class="widget-box ">
          <div class="widget-header">
            <h4 class="lighter smaller">
              <i class="icon-comment blue"></i>
              Notas del Turno
            </h4>
          </div>

          <div class="widget-body">
            <div class="widget-main no-padding">
              <div class="dialogs">                
                <g:each var="nota" in="${tareaInstance?.notas.sort { it.dateCreated }}">
                  <div class="itemdiv dialogdiv">
                    <div class="user">
                      <g:if test="${nota?.agregadaPor?.id == currentUser.id}">
                        <g:link controller="nota" action="edit" id="${nota?.id}" params="[tareaId:tareaInstance?.id]">
                          <img alt="Nota" src="${resource(dir:'images',file:'note.png')}" />
                        </g:link>
                      </g:if>                      
                      <g:else>
                        <img alt="Nota" src="${resource(dir:'images',file:'noeditnote.png')}" />
                      </g:else>
                    </div>
                    <div class="body">
                      <div class="time">                        
                        <span>Agregada Por: ${nota?.agregadaPor?.firstName} ${nota?.agregadaPor?.lastName}</span><br/>
                        <i class="icon-time"></i>
                        <span class="green">Fecha de Creación: <g:formatDate date="${nota?.dateCreated}" type="datetime" style="MEDIUM"/></span>
                        <g:if test="${nota?.lastUpdated != nota?.dateCreated}">                          
                          <br/>
                          <i class="icon-time"></i>
                          <span class="red">Última Edición: <g:formatDate date="${nota?.lastUpdated}" type="datetime" style="MEDIUM"/></span>                          
                        </g:if>
                      </div>

                      <div class="name">
                        <a href="#">Título: ${nota.titulo}</a>
                      </div>
                      <div class="text">
                        <%=nota.descripcion%>
                        <g:if test="${nota.documentos}">
                        -- Archivos adjuntos<br/>
                          <g:each in="${nota.documentos}" var="documento">
                            <g:link controller="documento" action="downloadArchivo" id ="${documento.id}">
                              ${documento.nombre} 
                            </g:link>
                          </g:each>
                        </g:if>                                                
                      </div>

                    </div>
                  </div>
                </g:each>
              </div>
            </div><!--/widget-main-->
          </div><!--/widget-body-->
        </div><!--/widget-box-->
        </g:if>		
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${tareaInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${tareaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <!--<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />-->
        </fieldset>
      </g:form>
    </div>        
  </body>
  <g:javascript src="ckeditor/ckeditor.js"/>
</html>
