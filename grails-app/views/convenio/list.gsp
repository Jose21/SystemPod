
<%@ page import="com.app.sgcon.Convenio" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainConvenios">
        <g:set var="entityName" value="${message(code: 'convenio.label', default: 'Convenio')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
        </div><!--/.page-header-->
    <r:require module="export"/>    
    <div class="container-fluid">      
        <g:render template="/shared/alerts" />
        <br/>
        <div class="tabbable">
            <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
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
                <li class="${porCategoriaActive?:""}">
                    <a data-toggle="tab" href="#porCategoria">
                        <i class="icon-legal bigger-130"></i>
                        <span class="bigger-110">Por Categoria <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${rangoDeFechaActive?:""}">
                    <a data-toggle="tab" href="#porFecha">
                        <i class="icon-calendar bigger-130"></i>
                        <span class="bigger-110">Por Fecha De Firma <span class="badge"></span></span>
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
        <div id="porFolio" class="tab-pane ${porFolioActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porFolio"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="numeroDeConvenio" class="control-label">
                                    <g:message code="convenio.numeroDeConvenio.label" default="Número de Convenio"/>
                                </label>
                                <g:textField class="span5" name="numeroDeConvenio" required="" maxlength="100" value="${convenioInstance?.numeroDeConvenio}" autocomplete="off"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorFolio" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFechaRegistro" class="tab-pane ${porFechaRegistroActive?:""}">  
            <div class="message-container">
              <!-- MIS TAREAS (PROPIAS Y LAS QUE HE COMPARTIDO) -->
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
        <div id="porCategoria" class="tab-pane ${porCategoriaActive?:""}">  
            <div class="message-container">
              <!-- MIS TAREAS (PROPIAS Y LAS QUE HE COMPARTIDO) -->
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porCategoria"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">               
                                <label for="status" class="control-label">
                                    <g:message code="convenio.status.label" default="Status" />
                                </label>
                                <g:select id="status" name="nombre" from="${com.app.sgcon.StatusDelConvenio.list()}" optionKey="nombre" required="" value="${statusDelConvenioInstance?.nombre}" noSelection="['':'-Elige Categoria-']" class="many-to-one"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorCategoria" value="Buscar" />            
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFecha" class="tab-pane ${rangoDeFechaActive?:""}">  
            <div class="message-container">
              <!-- MIS TAREAS (PROPIAS Y LAS QUE HE COMPARTIDO) -->
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
              <!-- MIS TAREAS (PROPIAS Y LAS QUE HE COMPARTIDO) -->
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="nombreResponsables"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="nombre" class="control-label">
                                    <g:message code="persona.nombre.label" default="Nombre" />
                                </label>
                                <g:textField name="nombre" required="" value="${personaInstance?.nombre}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorNombreResponsables" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>

        <table class="table table-bordered table-striped">
            <thead>
                <g:if test="${numeroDeConvenio}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BUSQUEDA POR FOLIO: ${numeroDeConvenio}</th>
                    </tr>
                </g:if>
                <g:if test="${rangoDeFechaRegistro}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BUSQUEDA POR FECHA DE REGISTRO: ${rangoDeFechaRegistro}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.id}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BUSQUEDA POR CATEGORIA: ${params.id}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${rangoDeFecha}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BUSQUEDA POR FECHA DE FIRMA: ${rangoDeFecha}</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.nombre}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BUSQUEDA POR RESPONSABLES: ${params.nombre}</br></br></th>
                    </tr>
                </g:if>
            <br>
            <tr>
                <th><g:message code="convenio.id.label"  default="Identificador interno" /></th>
                <th><g:message code="convenio.numeroDeConvenio.label" default="Número de Convenio" /></th>
                <th><g:message code="convenio.objeto.label" default="Objeto" /></th>
                <th><g:message code="convenio.dateCreated.label" default="Fecha de Registro" /></th>
                <th><g:message code="convenio.responsables.label" default="Responsables" /></th>
                <th><g:message code="convenio.fechaDeFirma.label" default="Fecha De Firma" />
                <th><g:message code="convenio.status.label" default="Status" /></th>
                <th><g:message default="Opciones"/></th>
            </tr>
            </thead>
            <tbody>
                <g:each in="${convenioInstanceList}" status="i" var="convenioInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td style="text-align:center"><g:link action="edit" id="${convenioInstance.id}"><span class="badge">${convenioInstance?.id}</span></g:link></td>
                        <td>${fieldValue(bean: convenioInstance, field: "numeroDeConvenio")}</td>
                        <td>${fieldValue(bean: convenioInstance, field: "objeto")}</td>
                        <td><g:formatDate date="${convenioInstance.dateCreated}" /></td>
                        <td>
                            <g:each in ="${convenioInstance.responsables}" var="responsable">
                                ${responsable.nombre}
                                <br>
                            </g:each>
                        </td>
                        <td><g:formatDate date="${convenioInstance.fechaDeFirma}" /></td>
                        <td>${fieldValue(bean: convenioInstance, field: "status")}</td>
                        <td><g:link class="icon-print bigger-120" action="detalles"  target="_blank" id="${convenioInstance?.id}" /></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        <div class="message-footer clearfix">
            <div class="pull-left"> ${convenioInstanceTotal?:0} resultado(s) en total. </div>
        </div>
        <export:formats formats="['excel', 'pdf']" action="generarReporte"/>
    </div>
</body>      
</html>
