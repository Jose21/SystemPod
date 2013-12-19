
<%@ page import="com.app.sgtask.Tarea" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainTareas">    
        <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Turno')}" />    
        <title>Lista de Turnos</title>
    </head>
    <body>    

        <div class="page-header position-relative">
            <h1>
                <g:if test="${session.opt == 'hoy'}">
                    Turnos para Hoy
                </g:if>
                <g:elseif test="${session.opt == 'programadas'}">
                    Turnos Programados
                </g:elseif>
                <g:elseif test="${session.opt == 'retrasadas'}">
                    Turnos Retrasados
                </g:elseif>  
                <g:elseif test="${session.opt == 'concluidas'}">
                    Turnos Concluídos
                </g:elseif>       
            </h1>
        </div><!--/.page-header-->

        <div class="container-fluid">      
            <g:render template="/shared/alerts" />
            <br/>
            <div class="tabbable">
                <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                    <li class="active">
                        <a data-toggle="tab" href="#inbox">
                            <i class="blue icon-inbox bigger-130"></i>
                            <span class="bigger-110">Mis Turnos <span class="badge">${tareaInstanceTotal}</span></span>
                        </a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#shared">
                            <i class="icon-share-alt bigger-130"></i>
                            <span class="bigger-110">Compartidos <span class="badge">${sharedTaskTotal}</span></span>
                        </a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#turnados">              
                            <i class="icon-arrow-right icon-on-right bigger-130"></i>
                            <span class="bigger-110">Turnados <span class="badge">${turnadosTotal}</span></span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="tab-content no-border no-padding">
                <div id="inbox" class="tab-pane in active">  
                    <div class="message-container">
                      <!-- MIS TAREAS (PROPIAS Y LAS QUE HE COMPARTIDO) -->
                        <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar">
                                    <span class="blue bigger-150">
                                        Mis Turnos
                                    </span>
                                </div>
                            </div>

                            <div>

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
                                        <g:if test="${tareaInstance.prioridad == "Urgente"}">
                                            <i class="icon-star red" title="Urgente"></i>   
                                        </g:if>
                                        <g:else>  
                                            <i class="icon-star-empty light-grey" title="Prioridad Normal"></i>        
                                        </g:else>
                                        <span class="sender" title="Folio del Turno">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${tareaInstance?.id}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="time" title="Fecha Límite" style="width:150px">
                                            <g:formatDate date="${tareaInstance?.fechaLimite}" />
                                        </span>

                                        <span class="summary" title="Título del Turno">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.nombre}
                                                </span>
                                            </g:link>
                                        </span>                                      
                                        <span class="summary" title="Dias para Alerta de Vecimiento">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.alertaVencimiento}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="summary" title="Responsable">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.responsable.firstName} ${tareaInstance?.responsable.lastName} 
                                                </span>
                                            </g:link>
                                        </span>
                                    </div>
                                </g:each>
                            </div>
                        </div><!--/.message-list-container-->

                        <div class="message-footer clearfix">
                            <div class="pull-left"> ${tareaInstanceTotal} turno(s) en total. </div>
                            <div class="pull-right">
                                <div class="pagination">
                                    <g:paginate total="${tareaInstanceTotal}" />
                                </div>
                            </div>
                        </div>
                    </div><!--/.message-container-->
                </div>
                <div id="shared" class="tab-pane">
                    <div class="message-container">
                      <!-- TAREAS QUE ME COMPARTIERON  -->
                        <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar">
                                    <span class="blue bigger-150">
                                        Compartidos
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
                                                    Número de turno
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
                                <g:each in="${sharedTaskList}" status="i" var="tareaInstance">
                                    <div class="message-item message-unread">
                                        <label class="inline">
                                            <g:link action="historial" id="${tareaInstance?.id}" class="btn btn-info btn-mini">
                                                <i class="icon-calendar bigger-110 icon-only"></i>
                                            </g:link>                    
                                        </label>
                                        <g:if test="${tareaInstance.prioridad == "Urgente"}">
                                            <i class="icon-star red" title="Prioridad Urgente"></i>   
                                        </g:if>
                                        <g:else>  
                                            <i class="icon-star-empty light-grey" title="Prioridad Normal"></i>        
                                        </g:else>
                                        <span class="sender" title="Folio del Turno">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${tareaInstance?.id}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="time" title="Fecha Límite" style="width:150px">
                                            <g:formatDate date="${tareaInstance?.fechaLimite}" />
                                        </span>

                                        <span class="summary" title="Título del Turno">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.nombre}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="summary" title="Dias para Alerta de Vecimiento">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.alertaVencimiento}
                                                </span>
                                            </g:link>
                                        </span>
                                    </div>
                                </g:each>
                            </div>
                        </div><!--/.message-list-container-->

                        <div class="message-footer clearfix">
                            <div class="pull-left"> ${sharedTaskTotal} turno(s) en total. </div>
                            <div class="pull-right">
                                <div class="pagination">
                                    <g:paginate total="${sharedTaskTotal?:0}" />
                        </div>
                            </div>
                        </div>
                    </div><!--/.message-container-->

                </div>
                <div id="turnados" class="tab-pane">
                    <div class="message-container">
                      <!-- TAREAS QUE DELEGUÉ  -->
                        <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar">
                                    <span class="blue bigger-150">
                                        Turnados
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
                                                    Número de turno
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
                                <g:each in="${turnadosList}" status="i" var="tareaInstance">
                                    <div class="message-item message-unread">
                                        <label class="inline">
                                            <g:link action="historial" id="${tareaInstance?.id}" class="btn btn-info btn-mini">
                                                <i class="icon-calendar bigger-110 icon-only"></i>
                                            </g:link>                    
                                        </label>
                                        <g:if test="${tareaInstance.prioridad == "Urgente"}">
                                            <i class="icon-star red" title="Prioridad Urgente"></i>   
                                        </g:if>
                                        <g:else>  
                                            <i class="icon-star-empty light-grey" title="Prioridad Normal"></i>        
                                        </g:else>
                                        <span class="sender" title="Folio del Turno">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${tareaInstance?.id}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="time" title="Fecha Límite" style="width:150px">
                                            <g:formatDate date="${tareaInstance?.fechaLimite}" />
                                        </span>

                                        <span class="summary" title="Título del Turno">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.nombre}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="summary" title="Dias para Alerta de Vecimiento">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.alertaVencimiento}
                                                </span>
                                            </g:link>
                                        </span>
                                        <span class="summary" title="Responsable">
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="text">
                                                    ${tareaInstance?.responsable.firstName} ${tareaInstance?.responsable.lastName} 
                                                </span>
                                            </g:link>
                                        </span>
                                    </div>
                                </g:each>
                            </div>
                        </div><!--/.message-list-container-->

                        <div class="message-footer clearfix">
                            <div class="pull-left"> ${turnadosTotal} turno(s) en total. </div>
                            <div class="pull-right">
                                <div class="pagination">
                                    <g:paginate total="${turnadosTotal?:0}" />
                                </div>
                            </div>
                        </div>
                    </div><!--/.message-container-->

                </div>
            </div>
        </div>    
    </body>
</html>
