
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="mainTareas">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Historial de Tareas</title>
  </head>
  <body>
    <div class="page-header position-relative">
      <h1>
        Historial de Tareas
      </h1>      
    </div><!--/.page-header-->

    <div id="timeline-2">
      <div class="row-fluid">
        <div class="offset1 span10">

          <div class="timeline-container timeline-style2">
            <span class="timeline-label">
              <b>Tarea: ${tareaInstance.id}</b>
            </span>

            <div class="timeline-items">
              <g:each in="${histList}" var="historial">
                <div class="timeline-item clearfix">
                  <div class="timeline-info">
                    <span class="timeline-date">
                      <g:formatDate date="${historial.cuando}" type="datetime" style="MEDIUM"/>
                    </span>
                    <i class="timeline-indicator btn btn-info no-hover"></i>
                  </div>
                  <div class="widget-box transparent">
                    <div class="widget-body">
                      <div class="widget-main no-padding">
                        <span class="bigger-110">
                          <span class="green bolder">${historial.quien.username}</span>
                          <g:if test="${historial.que == 'Leyó una tarea'}">
                            <span class="red bolder">${historial.que}
                            </span>
                          </g:if>
                          <g:else>
                            ${historial.que}
                          </g:else>
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </g:each> 
            </div><!--/.timeline-items-->
          </div><!--/.timeline-container-->
        </div>
      </div>
    </div>
    <div class="form-actions">
      <g:link controller="tarea" action="${session.opt}" class="btn btn-info">
        Regresar
      </g:link>
    </div>
  </body>
</html>
