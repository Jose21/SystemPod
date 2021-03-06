<%@ page import="com.app.sgtask.Tarea" %>

<html>
    <head>
        <meta name="layout" content="mainTareas">    
        <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Turno')}" />    
        <title>Busqueda</title>
    </head>
    <body>
    <r:require module="export"/>    
    <div class="container-fluid">      
        <g:render template="/shared/alerts" />
        <br/>
        <div class="tabbable">
            <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                <li class="${porTagsActive?:""}">
                    <a data-toggle="tab" href="#porTags">              
                        <i class="icon-tag bigger-130"></i>
                        <span class="bigger-110">Palabras Clave<span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porFolioActive?:""}">
                    <a data-toggle="tab" href="#porFolio">
                        <i class="icon-folder-open bigger-130"></i>
                        <span class="bigger-110">Por Folio <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porFechaRegistroActive?:""}">
                    <a data-toggle="tab" href="#porFechaRegistro">
                        <i class="icon-check bigger-130"></i>
                        <span class="bigger-110">Por Fecha de Registro <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${rangoDeFechaActive?:""}">
                    <a data-toggle="tab" href="#porFecha">
                        <i class="icon-calendar bigger-130"></i>
                        <span class="bigger-110">Por Fecha Límite <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${nombreResponsablesActive?:""}">
                    <a data-toggle="tab" href="#nombreResponsables">              
                        <i class="icon-group bigger-130"></i>
                        <span class="bigger-110">Por Nombre de Responsables <span class="badge"></span></span>
                    </a>
                </li>                
            </ul>
        </div>
    </div>    
    <div class="tab-content no-border no-padding">
        <div id="porTags" class="tab-pane ${porTagsActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porTags"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="tags" class="control-label">
                                    <g:message code="tarea.tags.label" default="Palabra Clave" />
                                </label>
                                <g:textField name="tags" required="" value="${tareaInstance?.tags}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorTags" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFolio" class="tab-pane ${porFolioActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porFolio"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="id" class="control-label">
                                    <g:message code="tarea.id.label" default="Número de Turno"/>
                                </label>
                                <g:textField type="number" class="span2" name="id" required="" maxlength="100" value="${tareaInstance?.id}"autocomplete="off"/>                               
                                <g:actionSubmit class="btn btn-primary" action="buscarPorFolio" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFechaRegistro" class="tab-pane ${porFechaRegistroActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porFechaRegistro"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                                <input class="span5" type="text" name="rangoDeFechaRegistro" id="rangoDeFechaRegistro" value="${rangoDeFechaRegistro?rangoDeFechaRegistro:""}" readonly="true" />
                                <g:actionSubmit class="btn btn-primary" action="buscarPorFechaRegistro" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFecha" class="tab-pane ${rangoDeFechaActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="rangoDeFecha"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                                <input class="span5" type="text" name="rangoDeFecha" id="rangoDeFecha" value="${rangoDeFecha?rangoDeFecha:""}" readonly="true" />
                                <g:actionSubmit class="btn btn-primary" action="rangoDeFecha" value="Buscar" />
                            </div>
                        </div>
                    </g:form>         
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="nombreResponsables" class="tab-pane ${nombreResponsablesActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="nombreResponsables"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">               
                                <label for="usuario" class="control-label">
                                    <g:message code="convenio.usuario.label" default="Nombre" />
                                </label>                                
                                <g:textField name="nombre" required="" value="${usuarioDeTareaInstance?.nombre}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorNombreResponsables" value="Buscar" />            
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>        
        <table class="table table-bordered table-striped">
            <thead>
                <g:if test="${id}">
                    <tr>
                        <th colspan="9"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR FOLIO: ${id}</th>
                    </tr>
                </g:if>
                <g:if test="${rangoDeFechaRegistro}">
                    <tr>
                        <th colspan="9" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR FECHA DE REGISTRO: ${rangoDeFechaRegistro}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${rangoDeFecha}">
                    <tr>
                        <th colspan="9" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR FECHA LíMITE: ${rangoDeFecha}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.username}">
                    <tr>
                        <th colspan="9" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR RESPONSABLE: ${params.username}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.tags}">
                    <tr>
                        <th colspan="10" style="text-align:center;font-size:16px">RESULTADO PARA LA PALABRA: ${params.tags}</br></br></th>
                    </tr>
                </g:if>
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
                <th><g:message code="tarea.label" default="Imprimir"/></th>
            </tr>
            </thead>
            <tbody>
                <g:each in="${tareaInstanceList}" status="i" var="tareaInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td style="text-align:center"><g:link action="show" id="${tareaInstance.id}"><span class="badge">${tareaInstance?.id}</span></g:link></td>

                        <td>${fieldValue(bean: tareaInstance, field: "nombre")}</td>
                        <td>${fieldValue(bean: tareaInstance, field: "grupo")}</td>
                        <td><g:formatDate date="${tareaInstance.dateCreated}" /></td>
                        <td>${fieldValue(bean: tareaInstance, field: "responsable")}</td>
                        <td><dd><%=tareaInstance?.descripcion%></dd></td>                                
                <td>${fieldValue(bean: tareaInstance, field: "prioridad")}</td>
                <td><g:formatDate date="${tareaInstance.fechaLimite}" /></td>
                <td style="text-align:center"><g:link class="icon-print bigger-120" action="detalles"  target="_blank" id="${tareaInstance?.id}" /></td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="message-footer clearfix">
            <div class="pull-left"> ${tareaInstanceTotal?:0} resultado(s) en total. </div>
        </div>
        <g:if test="${tareaInstanceTotal}">
            <export:formats formats="['excel', 'pdf']" action="generarReporte"/>
        </g:if>
    </div>
</body>
</html>
