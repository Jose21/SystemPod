
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
      <h1>Mostrar: Tarea</h1>
      <div class="btn-group">        
        <g:link class="btn btn-small tip-bottom" action="create">
          <i class="icon-file"></i>
          Nueva Tarea
        </g:link>
        <g:if test="${!tareaInstance?.cerrada}">
          <g:link class="btn btn-small tip-bottom" controller="tarea" action="cerrarTarea" id="${tareaInstance?.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
            <i class="icon-file"></i>
            Cerrar Tarea
          </g:link>
        </g:if>
        <g:link class="btn btn-small tip-bottom" controller="nota" action="create" params="[tareaId: tareaInstance?.id]">
          <i class="icon-file"></i>
          Agregar Nota
        </g:link>
      </div>
    </div>
    
    <div class="container-fluid">
      <br/>
      <g:render template="/shared/alerts" />
      <div class="well">		
				<g:if test="${tareaInstance?.nombre}">
                                  <dl>
                                      <dt><g:message code="tarea.nombre.label" default="Nombre" /></dt>
					
                                                <dd><g:fieldValue bean="${tareaInstance}" field="nombre"/></dd>
					
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
				
      
                                <g:if test="${tareaInstance?.notas}">
                                  <dl>
                                  <dt>NOTAS DE LA TAREA <br/></dt>
                                </dl>
                                      <g:each var="nota" in="${tareaInstance?.notas}">
                                        <dl>
                                          <dt>Título: ${nota.titulo} - Creada: <g:formatDate date="${nota?.dateCreated}" type="datetime" style="MEDIUM"/></dt>
                                          <dd class="well" style="background:#ffffb1">
                                            <%=nota.descripcion%>
                                            <g:if test="${nota.documentos}">
                                              -- Archivos adjuntos<br/>
                                              <g:each in="${nota.documentos}" var="documento">
                                                ${documento.nombre} 
                                              </g:each>
                                            </g:if>
                                          </dd>					
                                        </dl>
                                      </g:each>
                                </g:if>
			
      </div>
      <g:form class="form-actions">
        <fieldset class="buttons">
          <g:hiddenField name="id" value="${tareaInstance?.id}" />
          <g:link class="btn btn-primary" action="edit" id="${tareaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
          <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
      </g:form>
    </div>
  </body>
  <g:javascript src="ckeditor/ckeditor.js"/>
</html>
