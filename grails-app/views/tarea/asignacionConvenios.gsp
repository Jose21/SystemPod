<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainTareas">   
        <title>Asignaciones</title>
    </head>
    <body>
        <div class="container-fluid">      
            <g:render template="/shared/alerts" />
            <br/>
            <div class="tabbable">
                <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                    <li class="active">
                        <a data-toggle="tab" href="#inbox">
                            <i class="blue icon-inbox bigger-130"></i>
                            <span class="bigger-110">Asignaciones de convenios <span class="badge">${tareaInstanceTotal}</span></span>
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
                                        Pendientes
                                    </span>
                                </div>
                            </div>
                        </div>
                        <table class="box-style" width="100%" border="2">
                            <thead>
                                <tr>
                                    <th scope="col"></th>
                                    <th scope="col">Número de Folio</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Fecha Limite</th>
                                    <th scope="col">Días para Alerta</th>
                                    <th scope="col">Responsable(s)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${tareaInstanceList}" status="i" var="tareaInstance">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>
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
                                        </td>
                                        <td>
                                            <g:link action="show" id="${tareaInstance.id}">
                                                <span class="label label-success arrowed-in">
                                                    ${tareaInstance?.id}
                                                </span>
                                            </g:link>
                                        </td>
                                        <td>${fieldValue(bean: tareaInstance, field: "nombre")}</td>
                                        <td><g:formatDate date="${tareaInstance?.fechaLimite}" /></td>
                                        <td>${fieldValue(bean: tareaInstance, field: "alertaVencimiento")}</td>
                                        <td><span class="text">
                                                ${tareaInstance?.responsable.firstName} ${tareaInstance?.responsable.lastName} 
                                            </span>
                                        </td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>    
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
            </div>
        </div>
    </body>
</html>
