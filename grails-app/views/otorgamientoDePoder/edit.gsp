<%@ page import="com.app.sgpod.OtorgamientoDePoder;java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento de Poder')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="content-header">
            <div class="page-header position-relative">
                <h1>Editar: Otorgamiento de Poder</h1>
                <div class="btn-group">
                    <g:link controller="tarea" action="create" class="btn btn-small btn-inverse tip-bottom" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id ]">
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

                <g:hasErrors bean="${otorgamientoDePoderInstance}">
                    <div class="alert alert-block alert-warning">            
                        <g:eachError bean="${otorgamientoDePoderInstance}" var="error">
                            - <g:message error="${error}"/> <br/>
                        </g:eachError>
                    </div>
                </g:hasErrors>

                <g:form class="form-horizontal" method="post"  enctype="multipart/form-data">
                    <g:hiddenField name="id" value="${otorgamientoDePoderInstance?.id}" />
                    <g:hiddenField name="version" value="${otorgamientoDePoderInstance?.version}" />            
                    <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'id', 'error')}">
                        <label for="id" class="control-label">
                            <g:message code="otorgamientoDePoder.id.label" default="Número De Folio" />
                        </label>
                        <div class="controls">
                            <span class="badge">${otorgamientoDePoderInstance?.id}-O</span>
                        </div>
                    </div>
                    <g:render template="form"/>                    

                    <h3 id="bloqueAsignacionExpedientes"  class="header smaller lighter blue">Asignación de Expediente</h3>
                    <br/>
                    <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'asignar', 'error')} required">
                        <label for="asignar" class="control-label">
                            <g:message code="otorgamientoDePoder.asignar.label" default="Asignar A" />
                        </label>
                        <div class="controls">
                            <g:select id="asignar" name="asignar.id" from="${com.app.security.Usuario.list()}" optionKey="id"  value="${otorgamientoDePoderInstance?.asignar?.id}" noSelection="['':'-Elige Responsable-']" class="many-to-one"/>
                        </div>
                    </div>

                    <h3 id="bloqueDatosComplementarios"  class="header smaller lighter blue">Datos Complementarios</h3>
                    <br/>
                    <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'fechaDeOtorgamiento', 'error')} ">
                        <label for="fechaDeOtorgamiento" class="control-label">
                            <g:message code="otorgamientoDePoder.fechaDeOtorgamiento.label" default="Fecha De Otorgamiento" />
                        </label>
                        <div class="controls">
                            <div class="row-fluid input-append">
                                <input readonly="readonly" class="span10 date-picker" id="fechaDeOtorgamiento" type="text" value="${otorgamientoDePoderInstance?.fechaDeOtorgamiento?(new SimpleDateFormat("dd/MM/yyyy")).format(otorgamientoDePoderInstance?.fechaDeOtorgamiento):""}" data-date-format="dd/mm/yyyy" name="fechaDeOtorgamiento" />      
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'escrituraPublicaDeOtorgamiento', 'error')} ">
                        <label for="escrituraPublicaDeOtorgamiento" class="control-label">
                            <g:message code="otorgamientoDePoder.escrituraPublicaDeOtorgamiento.label" default="Escritura Publica De Otorgamiento" />
                        </label>
                        <div class="controls">
                            <g:textField class="span6" name="escrituraPublicaDeOtorgamiento" value="${otorgamientoDePoderInstance?.escrituraPublicaDeOtorgamiento}"/>
                        </div>
                    </div>
                    <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'comentarios', 'error')} ">
                        <label for="comentarios" class="control-label">
                            <g:message code="otorgamientoDePoder.comentarios.label" default="Comentarios" />
                        </label>
                        <div class="controls">
                            <g:textField class="span6" name="comentarios" value="${otorgamientoDePoderInstance?.comentarios}"/>
                        </div>
                    </div>
                    <h3 id="bloqueAdjuntarArchivos"  class="header smaller lighter blue">Adjuntar Documentos</h3>
                    <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'documentos', 'error')} ">
                        <label for="documentos" class="control-label">
                            <g:hiddenField name="anchor" value="bloqueAdjuntarArchivos"/>
                            <g:message code="otorgamientoDePoder.documentos.label" default="Documentos" />
                        </label>
                        <div class="controls">
                            <g:each in="${otorgamientoDePoderInstance?.documentos?}" var="d">
                                <div class="pull-left action-buttons">
                                    <g:link class="red" controller="otorgamientoDePoder" action="deleteArchivo" id ="${d.id}" params="[otorgamientoDePoderId:otorgamientoDePoderInstance?.id, anchor:'bloqueAdjuntarArchivos']">
                                        <i class="icon-trash bigger-130"></i>
                                        <i class="icon-caret-right blue"></i>
                                    </g:link>          
                                </div>
                                <g:link controller="documentoDePoder" action="downloadArchivo" id="${d.id}">${d?.encodeAsHTML()}</g:link>
                                    <br/>
                            </g:each>
                            <br/>
                            <input type="file" id="archivo" name="archivo" />
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </div>
            </g:form>

            <h3 id="bloqueApoderados"  class="header smaller lighter blue">Agregar Apoderados</h3>       

            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <g:if test="${otorgamientoDePoderInstance.apoderados}">
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
                    <g:each in="${otorgamientoDePoderInstance.apoderados}" status="i" var="apoderado">            
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
                                            <g:hiddenField name="otorgamientoDePoder.id" value="${otorgamientoDePoderInstance?.id}" />
                                            <g:hiddenField name="id" value="${apoderado?.id}" />
                                            <g:hiddenField name="version" value="${apoderado?.version}" />
                                            <g:render template="/apoderado/itForm" bean="${apoderado}"/>            
                                            <div class="form-actions">
                                                <g:actionSubmit class="btn btn-primary" action="updateIt" value="${message(code: 'default.button.update.label', default: 'Update')}" />
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
                                <g:form class="form-horizontal" controller="otorgamientoDePoder" method="post" >
                                    <g:hiddenField name="anchor" value="bloqueApoderado" />
                                    <g:hiddenField name="otorgamientoDePoder.id" value="${otorgamientoDePoderInstance?.id}" />
                                    <g:hiddenField name="apoderado.id" value="${apoderado?.id}" />
                                    <g:actionSubmit class="btn btn-danger btn-mini" action="removeApoderado" value="Quitar" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                </g:form>
                            </td>
                        </tr>            
                    </g:each>        
                    <g:form controller="otorgamientoDePoder" method="post">
                        <tr>
                            <td colspan="4">                  
                                <g:hiddenField name="anchor" value="bloqueApoderados" />
                                <g:textField class="span6"  name="apoderado" value="" autocomplete="off"/>
                            </td>
                            <td>
                                <g:hiddenField name="otorgamientoDePoder.id" value="${otorgamientoDePoderInstance?.id}"/>
                                <g:actionSubmit class="btn btn-primary btn-mini" action="addApoderado" value="Agregar" />
                            </td>
                        </tr>
                    </g:form>
                </tbody>
            </table>

            <div id="tareasAsociadas" class="modal hide" style="width:600px;">
                <div class="modal-header">
                    <button data-dismiss="modal" class="close" type="button">×</button>
                    <h3>Turnos asociados al Otorgamiento de Poder</h3>
                </div>
                <div class="modal-body">     
                    <g:if test="${otorgamientoDePoderInstance?.tareas?.findAll{ it.cerrada == false }}">
                        <div class="widget-box">
                            <div class="widget-header widget-header-flat widget-header-small">
                                <h5><i class="icon-circle"></i>Turnos Abiertos</h5>                    
                            </div>
                            <div class="widget-body">
                                <div class="widget-main">
                                    <g:each in="${otorgamientoDePoderInstance?.tareas?.findAll{ it.cerrada == false }}" var="tarea">
                                        <g:link class="btn btn-mini btn-info btn-block" controller="tarea" action="show" id="${tarea.id}" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id ]">
                                            <span class="label label-large label-info arrowed-in-right arrowed-in">Turno: ${tarea.id}</span>
                                            ${tarea.nombre}
                                        </g:link></br>
                                    </g:each>
                                </div><!--/widget-main-->
                            </div><!--/widget-body-->
                        </div><!--/widget-box-->
                    </g:if>
                    <g:if test="${otorgamientoDePoderInstance?.tareas?.findAll{ it.cerrada == true }}">
                        <br/>
                        <div class="widget-box">
                            <div class="widget-header widget-header-flat widget-header-small">
                                <h5><i class="icon-circle"></i>Turnos Cerrados</h5>                    
                            </div>
                            <div class="widget-body">
                                <div class="widget-main">
                                    <g:each in="${otorgamientoDePoderInstance?.tareas?.findAll{ it.cerrada == true }}" var="tarea">
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
            $('#apoderado').autocomplete({
                source : function(request, response){
                    $.ajax({
                        url: '/<g:meta name='app.name'/>/apoderado/ajaxFinder', 
                        data: request,
                        success: function(data){
                            response(data); 
                        },
                        error: function(){}
                    });
                },
                minLength: 3,
                select: function(event, ui) {
                    $('#apoderado').val(ui.item.nasSymbol + "-")
                }
            });                        
            $(document).scrollTop( $("#${anchor?:""}").offset().top );
        })(jQuery);
    </script>       
    </body>
</html>
