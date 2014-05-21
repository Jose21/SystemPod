<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainTareas">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte: Total De Turnos</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Reporte: Total De Turnos</h1>      
        </div>
        <div class="container-fluid">
            <div class="container-fluid">      
                <g:form name="asdas" action="totalDeTurnos" method="POST">
                    <g:hiddenField name="barra" value=""/>
                    <div id="containerTotalDeTurnos" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                </g:form>
            </div>
            <!--div id="tablaResultados"></div-->
            <table class="table table-bordered table-striped">
                <thead>             
                <br>
                <tr>
                    <th><g:message code="tarea.id.label"  default="Número del Turno" /></th>
                    <th><g:message code="tarea.nombre.label"  default="Nombre" /></th>
                    <th><g:message code="tarea.grupo.label" default="Compartida Con" /></th>
                    <th><g:message code="tarea.dateCreated.label" default="Fecha de Registro" /></th>
                    <th><g:message code="tarea.responsable.label" default="Responsable" /></th>
                    <th><g:message code="tarea.descripcion.label" default="Descripción" /></th>
                    <th><g:message code="tarea.prioridad.label" default="Prioridad" /></th>
                    <th><g:message code="tarea.fechaLimite.label" default="Fecha Límite del Turno" />
                </tr>
                </thead>
                <tbody>
                    <g:if test="${turnosPorFechaBean.misTurnos}">
                        <tr><th colspan="8">MIS TURNOS</th></tr>
                                <g:each in="${turnosPorFechaBean.misTurnos}" status="i" var="misTurnos">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="tarea" action="show" id="${misTurnos.id}"><span class="badge">${misTurnos?.id}</span></g:link></td>
                                <td>${fieldValue(bean: misTurnos, field: "nombre")}</td>
                                <td>${fieldValue(bean: misTurnos, field: "grupo")}</td>
                                <td><g:formatDate date="${misTurnos.dateCreated}" /></td>
                                <td>${fieldValue(bean: misTurnos, field: "responsable")}</td>
                                <td><dd><%=misTurnos?.descripcion%></dd></td>                                
                                <td>${fieldValue(bean: misTurnos, field: "prioridad")}</td>
                                <td><g:formatDate date="${misTurnos.fechaLimite}" /></td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:if test="${turnosPorFechaBean.compartidos}">
                        <tr><th colspan="8">COMPARTIDOS</th></tr>
                                <g:each in="${turnosPorFechaBean.compartidos}" status="i" var="compartidos">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="tarea" action="show" id="${compartidos.id}"><span class="badge">${compartidos?.id}</span></g:link></td>
                                <td>${fieldValue(bean: compartidos, field: "nombre")}</td>
                                <td>${fieldValue(bean: compartidos, field: "grupo")}</td>
                                <td><g:formatDate date="${compartidos.dateCreated}" /></td>
                                <td>${fieldValue(bean: compartidos, field: "responsable")}</td>
                                <td><dd><%=compartidos?.descripcion%></dd></td>                                
                                <td>${fieldValue(bean: compartidos, field: "prioridad")}</td>
                                <td><g:formatDate date="${compartidos.fechaLimite}" /></td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:if test="${turnosPorFechaBean.turnados}">
                        <tr><th colspan="8">TURNADOS</th></tr>
                                <g:each in="${turnosPorFechaBean.turnados}" status="i" var="turnados">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="tarea" action="edit" id="${turnados.id}"><span class="badge">${turnados?.id}</span></g:link></td>

                                <td>${fieldValue(bean: turnados, field: "nombre")}</td>
                                <td>${fieldValue(bean: turnados, field: "grupo")}</td>
                                <td><g:formatDate date="${turnados.dateCreated}" /></td>
                                <td>${fieldValue(bean: turnados, field: "responsable")}</td>
                                <td><dd><%=turnados?.descripcion%></dd></td>                                
                                <td>${fieldValue(bean: turnados, field: "prioridad")}</td>
                                <td><g:formatDate date="${turnados.fechaLimite}" /></td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:if test="${turnosPorFechaBean.prioridadUrgente}">
                        <tr><th colspan="8">PRIORIDAD URGENTE</th></tr>
                                <g:each in="${turnosPorFechaBean.prioridadUrgente}" status="i" var="prioridadUrgente">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="tarea" action="show" id="${prioridadUrgente.id}"><span class="badge">${prioridadUrgente?.id}</span></g:link></td>

                                <td>${fieldValue(bean: prioridadUrgente, field: "nombre")}</td>
                                <td>${fieldValue(bean: prioridadUrgente, field: "grupo")}</td>
                                <td><g:formatDate date="${prioridadUrgente.dateCreated}" /></td>
                                <td>${fieldValue(bean: prioridadUrgente, field: "responsable")}</td>
                                <td><dd><%=prioridadUrgente?.descripcion%></dd></td>                                
                                <td>${fieldValue(bean: prioridadUrgente, field: "prioridad")}</td>
                                <td><g:formatDate date="${prioridadUrgente.fechaLimite}" /></td>
                            </tr>
                        </g:each>
                    </g:if>
                    <g:if test="${turnosPorFechaBean.prioridadNormal}">
                        <tr><th colspan="8">PRIORIDAD NORMAL</th></tr>
                                <g:each in="${turnosPorFechaBean.prioridadNormal}" status="i" var="prioridadNormal">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="tarea" action="show" id="${prioridadNormal.id}"><span class="badge">${prioridadNormal?.id}</span></g:link></td>

                                <td>${fieldValue(bean: prioridadNormal, field: "nombre")}</td>
                                <td>${fieldValue(bean: prioridadNormal, field: "grupo")}</td>
                                <td><g:formatDate date="${prioridadNormal.dateCreated}" /></td>
                                <td>${fieldValue(bean: prioridadNormal, field: "responsable")}</td>
                                <td><dd><%=prioridadNormal?.descripcion%></dd></td>                                
                                <td>${fieldValue(bean: prioridadNormal, field: "prioridad")}</td>
                                <td><g:formatDate date="${prioridadNormal.fechaLimite}" /></td>
                            </tr>
                        </g:each>
                    </g:if>
                </tbody>
            </table>
        </div>

    </body>  
</html>
