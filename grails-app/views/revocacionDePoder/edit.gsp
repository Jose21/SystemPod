<%@ page import="com.app.sgpod.RevocacionDePoder;java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'Revocación De Poder')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="content-header">            
            <g:form class="form-horizontal" controller="revocacionDePoder" method="post">            
                <div class="page-header position-relative">
                    <h1>Solicitud de Revocación de Poder
                    </h1>
                    <div class="span12">
                        <div id="fuelux-wizard" class="row-fluid" data-target="#step-container">
                            <ul class="wizard-steps">
                                <li data-target="#step1" style="width: 50%;">
                                    <span class="step">1</span>
                                    <span class="title">Datos de la solicitud</span>
                                </li>
                                <li data-target="#step2" class="active" style="width: 50%;">
                                    <span class="step">2</span>
                                    <span class="title">Apoderados</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <g:if test="${revocacionDePoderInstance.motivoDeRevocacion && revocacionDePoderInstance.apoderados}">
                        <div class="btn-group">                                            
                            <g:hiddenField name="revocacionDePoder.id" value="${revocacionDePoderInstance?.id}" />
                            <g:hiddenField name="otorgamientoDePoder" value="${otorgamientoDePoderId}" />
                            <g:actionSubmit class="btn btn-warning btn-btn" action="enviarSolicitud" value="Enviar Solicitud" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </div>
                    </g:if>
                </div>

                <div class="container-fluid">
                    <g:render template="/shared/alerts" />                

                    <g:hasErrors bean="${revocacionDePoderInstance}">
                        <div class="alert alert-block alert-warning">            
                            <g:eachError bean="${revocacionDePoderInstance}" var="error">
                                - <g:message error="${error}"/> <br/>
                            </g:eachError>
                        </div>
                    </g:hasErrors>

                    <g:if test="${revocacionDePoderInstance.tipoDeRevocacion == "Parcial" && revocacionDePoderInstance.apoderados && revocacionDePoderInstance.agregarApoderado != true}">
                        <h3 id="bloqueApoderados"  class="header smaller lighter blue">Seleccione los apoderados a quien desee revocar el poder.</h3>       

                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <g:if test="${revocacionDePoderInstance.apoderados}">
                                        <th></th>
                                        <th>Nombre</th>
                                        <th>Puesto</th>                
                                        <th>Institución</th>
                                        <th>Email</th>
                                        </g:if>
                                        <g:else>
                                        <th colspan="4">Nombre</th>
                                        </g:else>                                
                                </tr>
                            </thead>
                            <tbody>                                                            
                                <g:each in="${revocacionDePoderInstance.apoderados}" status="i" var="apoderado">            
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td style="text-align:center"><g:checkBox id="${apoderado.id}" name="apoderadoList" value="${apoderado.id}" checked="false"/></td>
                                        <td>${apoderado.nombre}</td>
                                        <td>${apoderado.puesto}</td>
                                        <td>${apoderado.institucion}</td>
                                        <td>${apoderado.email}</td>                                    
                                    </tr>                                
                                </g:each>
                                <tr>
                                    <td colspan="5" style="text-align:right">                                                                                                                                    
                                        <!--g:actionSubmit class="btn btn-danger btn-mini" action="removeApoderado" value="Aceptar" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /-->
                                    </td>
                                </tr>                            
                            </tbody>
                        </table>
                    </g:if>                                

                    <g:if test="${revocacionDePoderInstance.tipoDeRevocacion == "Total" && revocacionDePoderInstance.apoderados && revocacionDePoderInstance.agregarApoderado != true}">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Nombre</th>
                                    <th>Puesto</th>                
                                    <th>Institución</th>
                                    <th>Email</th>
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${revocacionDePoderInstance.apoderados}" status="i" var="apoderado">            
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>${apoderado.nombre}</td>
                                        <td>${apoderado.puesto}</td>
                                        <td>${apoderado.institucion}</td>
                                        <td>${apoderado.email}</td>                                    
                                    </tr>            
                                </g:each>         
                            </tbody>
                        </table>

                    </g:if>

                </g:form>    

                <g:if test="${revocacionDePoderInstance.agregarApoderado == true}">
                    <h3 id="bloqueApoderados"  class="header smaller lighter blue">Agregar Apoderados</h3>       

                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <g:if test="${revocacionDePoderInstance.apoderados}">
                                    <th>Nombre</th>
                                    <th>Puesto</th>                
                                    <th>Institución</th>
                                    <th>Email</th>
                                    </g:if>
                                    <g:else>
                                    <th colspan="4">Nombre</th>
                                    </g:else>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${revocacionDePoderInstance.apoderados}" status="i" var="apoderado">            
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td>                    
                                        <div id="editarApoderadoModal${i}" class="modal hide" style="width:600px;">
                                            <div class="modal-header">
                                                <button data-dismiss="modal" class="close" type="button">×</button>
                                                <h3>Editar Datos del Apoderado</h3>
                                            </div>
                                            <div class="modal-body">
                                                <g:form class="form-horizontal" controller="apoderado" method="post">
                                                    <g:hiddenField name="anchor" value="bloqueApoderados" />
                                                    <g:hiddenField name="revocacionDePoder.id" value="${revocacionDePoderInstance?.id}" />
                                                    <g:hiddenField name="id" value="${apoderado?.id}" />
                                                    <g:hiddenField name="version" value="${apoderado?.version}" />
                                                    <g:render template="/apoderado/itForm" bean="${apoderado}"/>            
                                                    <div class="form-actions">
                                                        <g:actionSubmit class="btn btn-primary" action="updateItRevocacion" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                                    </div>
                                                </g:form>
                                            </div>
                                        </div>
                                        <a href="#editarApoderadoModal${i}" data-toggle="modal">
                                            <i class="icon-edit bigger-110"></i>
                                        </a>
                                        ${apoderado.nombre}</td>
                                    <td>${apoderado.puesto}</td>
                                    <td>${apoderado.institucion}</td>
                                    <td>${apoderado.email}</td>
                                    <td>
                                        <g:form class="form-horizontal" controller="revocacionDePoder" method="post" >
                                            <!--g:hiddenField name="anchor" value="bloqueApoderado" /-->
                                            <g:hiddenField name="revocacionDePoder.id" value="${revocacionDePoderInstance?.id}" />
                                            <g:hiddenField name="apoderado.id" value="${apoderado?.id}" />
                                            <g:actionSubmit class="btn btn-danger btn-mini" action="removeApoderado" value="Quitar" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                        </g:form>
                                    </td>
                                </tr>            
                            </g:each>        
                            <g:form controller="revocacionDePoder" method="post">
                                <tr>
                                    <td colspan="4">                  
                                        <!--g:hiddenField name="anchor" value="bloqueApoderados" /-->
                                        <g:textField class="span6"  name="apoderado" value="" autocomplete="off"/>
                                    </td>
                                    <td>
                                        <g:hiddenField name="revocacionDePoder.id" value="${revocacionDePoderInstance?.id}"/>                                        
                                        <g:actionSubmit class="btn btn-primary btn-mini" action="addApoderado" value="Agregar" />
                                    </td>
                                </tr>
                            </g:form>
                        </tbody>
                    </table>
                </g:if>


                <g:form class="form-horizontal" method="post" enctype="multipart/form-data">                    
                    <h3 id="finBloqueDatosComplementarios"  class="header smaller lighter blue"></h3>
                    <g:hiddenField name="id" value="${revocacionDePoderInstance?.id}" />
                    <g:hiddenField name="version" value="${revocacionDePoderInstance?.version}" />
                    <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'id', 'error')}">
                        <label for="id" class="control-label">
                            <g:message code="revocacionDePoderInstance.id.label" default="Número De Folio" />
                        </label>
                        <div class="controls">
                            <span class="badge">${revocacionDePoderInstance?.id}-R</span>
                        </div>
                    </div>
                    <g:render template="form"/>                                                                                                   
                    <div class="form-actions">
                        <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    </div>
                </g:form>
            </div>            
            <div id="agregarMotivoDeRevocacionModal" class="modal hide" style="width:600px;">
                <div class="modal-header">
                    <button data-dismiss="modal" class="close" type="button">×</button>
                    <h3>Agregar Motivo de Revocacion</h3>
                </div>
                <div class="modal-body">
                    <g:form class="form-horizontal" controller="motivoDeRevocacion" method="post">
                        <g:hiddenField name="anchor" value="bloqueDatosComplementarios" />
                        <g:hiddenField name="revocacionDePoder.id" value="${revocacionDePoderInstance?.id}" />
                        <g:render template="/motivoDeRevocacion/itForm" bean="${it}"/>            
                        <div class="form-actions">
                            <g:actionSubmit class="btn btn-primary"  action="nuevoMotivoDeRevocacion" value="Crear" />
                        </div>
                    </g:form>
                </div>
            </div>
            <div id="tareasAsociadas" class="modal hide" style="width:600px;">
                <div class="modal-header">
                    <button data-dismiss="modal" class="close" type="button">×</button>
                    <h3>Turnos asociados a la Revocación de Poder</h3>
                </div>
                <div class="modal-body">     
                    <g:if test="${revocacionDePoderInstance?.tareas.findAll{ it.cerrada == false }}">
                        <div class="widget-box">
                            <div class="widget-header widget-header-flat widget-header-small">
                                <h5><i class="icon-circle"></i>Turnos Abiertos</h5>                    
                            </div>
                            <div class="widget-body">
                                <div class="widget-main">
                                    <g:each in="${revocacionDePoderInstance?.tareas.findAll{ it.cerrada == false }}" var="tarea">
                                        <g:link class="btn btn-mini btn-info btn-block" controller="tarea" action="show" id="${tarea.id}" params="[ idRevocacionDePoder : revocacionDePoderInstance?.id ]">
                                            <span class="label label-large label-info arrowed-in-right arrowed-in">Turno: ${tarea.id}</span>
                                            ${tarea.nombre}
                                        </g:link></br>
                                    </g:each>
                                </div><!--/widget-main-->
                            </div><!--/widget-body-->
                        </div><!--/widget-box-->
                    </g:if>
                    <g:if test="${revocacionDePoderInstance?.tareas.findAll{ it.cerrada == true }}">
                        <br/>
                        <div class="widget-box">
                            <div class="widget-header widget-header-flat widget-header-small">
                                <h5><i class="icon-circle"></i>Turnos Cerrados</h5>                    
                            </div>
                            <div class="widget-body">
                                <div class="widget-main">
                                    <g:each in="${revocacionDePoderInstance?.tareas.findAll{ it.cerrada == true }}" var="tarea">
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
            $(document).scrollTop( $("#${anchor?:""}").offset().top );
            })(jQuery);
        </script>
    </body>
</html>
