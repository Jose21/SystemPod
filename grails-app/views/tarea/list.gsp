
<%@ page import="com.app.sgtask.Tarea" %>
<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="mainTareas">    
    <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Tarea')}" />    
    <title><g:message code="default.list.label" args="[entityName]" /></title>
  </head>
  <body>    
    
    <div class="page-header position-relative">
      <h1>
        Bandeja de Tareas        
      </h1>      
    </div><!--/.page-header-->

    <div class="container-fluid">
      <br/>
      <g:render template="/shared/alerts" />
      <br/>
      <div class="widget-content nopadding">
        <div class="message-container">
          <!-- BANDEJA -->
          <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
            <div class="message-bar">
              <div class="message-infobar" id="id-message-infobar">
                <span class="blue bigger-150">
                  <g:if test="${session.opt == 'hoy'}">
                    Tareas para Hoy
                  </g:if>
                  <g:elseif test="${session.opt == 'programadas'}">
                    Tareas Programadas
                  </g:elseif>
                  <g:elseif test="${session.opt == 'retrasadas'}">
                    Tareas Retrasadas
                  </g:elseif>
                  <g:elseif test="${session.opt == 'asignadas'}">
                    Tareas Asignadas
                  </g:elseif>
                </span>                
              </div>
            </div>

            <div>
              <div class="messagebar-item-right">
                <div class="inline position-relative">
                  <!--<a href="#" data-toggle="dropdown" class="dropdown-toggle">
                    Ordenar por &nbsp;
                    <i class="icon-caret-down bigger-125"></i>
                  </a>-->

                  <ul class="dropdown-menu dropdown-lighter pull-right dropdown-100">
                    <li>
                      <a href="#">
                        <i class="icon-ok green"></i>
                        Número de tarea
                      </a>
                    </li>

                    <li>
                      <a href="#">
                        <i class="icon-ok invisible"></i>
                        Fecha
                      </a>
                    </li>

                    <li>
                      <a href="#">
                        <i class="icon-ok invisible"></i>
                        Grupo
                      </a>
                    </li>
                  </ul>
                </div>
              </div>

              <!--
              <div class="nav-search minimized">
                <form class="form-search">
                  <span class="input-icon">
                    <input type="text" autocomplete="off" class="input-small nav-search-input" placeholder="Número de tarea ..." />
                    <i class="icon-search nav-search-icon"></i>
                  </span>
                </form>
              </div>
              -->
            </div>
          </div>

          <div class="message-list-container">
            <div class="message-list" id="message-list">
              <g:each in="${tareaInstanceList}" status="i" var="tareaInstance">
                <div class="message-item message-unread">
                  <label class="inline">
                    <g:link action="historial" id="${tareaInstance?.id}" class="btn btn-info btn-mini">
                      <i class="icon-calendar bigger-110 icon-only"></i>
                    </g:link>                    
                  </label>
                  <!-- Prioridad 
                  <i class="message-star icon-star orange2"></i>
                  -->
                  <span class="sender" title="Folio de la Tarea">
                    <g:link action="show" id="${tareaInstance.id}">
                      <span class="label label-success arrowed-in">
                        ${tareaInstance?.id}
                      </span>
                    </g:link>
                  </span>
                  <span class="time" title="Fecha Límite" style="width:150px">
                    <g:formatDate date="${tareaInstance.fechaLimite}" />
                  </span>

                  <span class="summary" title="Título de la Tarea">
                    <g:link action="show" id="${tareaInstance.id}">
                      <span class="text">
                        ${tareaInstance?.nombre}
                      </span>
                    </g:link>
                  </span>
                  <span class="summary" title="Grupo">
                    <g:link action="show" id="${tareaInstance.id}">
                      <span class="text">
                        ${tareaInstance?.grupo?.nombre}
                      </span>
                    </g:link>
                  </span>
                </div>
              </g:each>
            </div>
          </div><!--/.message-list-container-->

          <div class="message-footer clearfix">
            <div class="pull-left"> ${tareaInstanceTotal} tarea(s) en total. </div>
            <div class="pull-right">
              <div class="pagination">
                <g:paginate total="${tareaInstanceTotal}" />
              </div>
            </div>
          </div>
        </div><!--/.message-container-->
      </div>        
    </div>    
  </body>
</html>
