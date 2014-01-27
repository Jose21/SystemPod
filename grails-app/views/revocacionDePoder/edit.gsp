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
            <div class="page-header position-relative">
                <h1>Editar: Revocación de Poder</h1>
                <div class="btn-group">
                    <g:link controller="tarea" action="create" class="btn btn-small btn-inverse tip-bottom" params="[ idRevocacionDePoder : revocacionDePoderInstance?.id ]">
                        <i class="icon-external-link"></i> Asociar Turno
                    </g:link>
                    <a class="btn btn-small btn-purple tip-bottom" href="#tareasAsociadas" data-toggle="modal">
                        <i class="icon-comments"></i> Turnos Asociados
                    </a>
                </div>
            </div>

            <div class="container-fluid">
                <g:render template="/shared/alerts" />
                <br/>

                <g:hasErrors bean="${revocacionDePoderInstance}">
                    <div class="alert alert-block alert-warning">            
                        <g:eachError bean="${revocacionDePoderInstance}" var="error">
                            - <g:message error="${error}"/> <br/>
                        </g:eachError>
                    </div>
                </g:hasErrors>

                <g:if test="${revocacionDePoderInstance.tipoDeRevocacion == "Parcial"}">
                    <h3 id="bloqueApoderados"  class="header smaller lighter blue">Elimine los Apoderados a quien desee omitir en esta  Solicitud.</h3>       

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
                                    <td>${apoderado.nombre}</td>
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
                        </tbody>
                    </table>
                </g:if>
                <g:else>
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

                </g:else>


                <g:form class="form-horizontal" method="post" enctype="multipart/form-data">
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
                    <h3 id="bloqueDatosComplementarios"  class="header smaller lighter blue">Datos Complementarios</h3>
                    <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'motivoDeRevocacion', 'error')} required">
                        <label for="motivoDeRevocacion" class="control-label">
                            <g:message code="revocacionDePoder.motivoDeRevocacion.label" default="Motivo De Revocación" />
                            <span class="required-indicator">*</span>
                        </label>
                        <div class="controls">
                            <g:select readonly="readonly" noSelection="['':'Elige una opción']" id="motivoDeRevocacion" name="motivoDeRevocacion.id" from="${com.app.sgpod.MotivoDeRevocacion.list()}" optionKey="id" required="" value="${revocacionDePoderInstance?.motivoDeRevocacion?.id}" class="many-to-one"/>
                            <span class="add-on" href="#agregarMotivoDeRevocacionModal" data-toggle="modal">
                                <i class="icon-plus"></i>
                            </span>        
                        </div>    
                    </div>                                        
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
