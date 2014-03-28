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
            <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_SOLICITANTE">
                <div class="page-header position-relative">                
                    <h1>Solicitud de Otorgamiento de Poder
                        <small>
                            <i class="icon-double-angle-right"></i>
                            Agregar Apoderados y Enviar Solicitud.
                        </small>
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
                    <g:if test="${otorgamientoDePoderInstance.apoderados}">
                        <div class="btn-group">                    
                            <g:link action="asignarA" class="btn btn-small btn-warning tip-bottom" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id ]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                <i class="icon-share"></i> Enviar Solicitud
                            </g:link>    
                        </div>
                    </g:if>                
                </div>
            </sec:ifAnyGranted>            
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
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_SOLICITANTE">
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
                            <g:each in="${otorgamientoDePoderInstance.apoderados.sort{it.nombre}}" status="i" var="apoderado">            
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
                                            <!--g:hiddenField name="anchor" value="bloqueApoderado" /-->
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
                                        <!--g:hiddenField name="anchor" value="bloqueApoderados" /-->
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
                </sec:ifAnyGranted>

                <g:form  name="myForm" class="form-horizontal" method="post"  enctype="multipart/form-data">
                    <g:hiddenField name="id" value="${otorgamientoDePoderInstance?.id}" />
                    <g:hiddenField name="version" value="${otorgamientoDePoderInstance?.version}" />
                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_SOLICITANTE">
                        <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'id', 'error')}">
                            <label for="id" class="control-label">
                                <g:message code="otorgamientoDePoder.id.label" default="Número De Folio" />
                            </label>
                            <div class="controls">
                                <span class="badge">${otorgamientoDePoderInstance?.id}-O</span>
                            </div>
                        </div>
                        <g:render template="form"/>
                    </sec:ifAnyGranted>

                    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_NOTARIO">
                        <h3 id="bloqueDatosComplementarios"  class="header smaller lighter blue">Enviar Copia de Escritura Pública</h3>
                        <br/>                        
                        <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'fechaDeOtorgamiento', 'error')}">
                            <label for="fechaDeOtorgamiento" class="control-label">
                                <g:message code="otorgamientoDePoder.fechaDeOtorgamiento.label" default="Fecha De Otorgamiento" />
                                <span class="required-indicator">*</span>
                            </label>
                            <div class="controls">
                                <div class="row-fluid input-append">
                                    <input readonly="readonly" class="span6 date-picker validate[required]"   id="fechaDeOtorgamiento" type="text" value="${otorgamientoDePoderInstance?.fechaDeOtorgamiento?(new SimpleDateFormat("dd/MM/yyyy")).format(otorgamientoDePoderInstance?.fechaDeOtorgamiento):""}" data-date-format="dd/mm/yyyy" name="fechaDeOtorgamiento" />      
                                    <span class="add-on">
                                        <i class="icon-calendar"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'escrituraPublica', 'error')} ">
                            <label for="escrituraPublica" class="control-label">
                                <g:message code="otorgamientoDePoder.escrituraPublica.label" default="Escritura Pública" />
                                <span class="required-indicator">*</span>
                            </label>
                            <div class="controls">
                                <g:textField class="span4 validate[required]" name="escrituraPublica" value="${otorgamientoDePoderInstance?.escrituraPublica}"/>
                            </div>
                        </div>
                        <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'comentarios', 'error')} ">
                            <label for="comentarios" class="control-label">
                                <g:message code="otorgamientoDePoder.comentarios.label" default="Comentarios" />
                            </label>
                            <div class="controls">
                                <g:textArea class="span6" cols="40" rows="5" maxlength="1048576" name="comentarios" value="${otorgamientoDePoderInstance?.comentarios}"/>
                            </div>
                        </div>
                        <h3 id="bloqueAdjuntarArchivos"  class="header smaller lighter blue">Adjuntar Documentos</h3>
                        <div class="control-group fieldcontain ${hasErrors(bean: otorgamientoDePoderInstance, field: 'documentos', 'error')} ">
                            <label for="documentos" class="control-label">
                                <g:hiddenField name="anchor" value="bloqueAdjuntarArchivos"/>
                                <g:message code="otorgamientoDePoder.documentos.label" default="Documentos" />
                            </label>
                            <div class="controls">
                                <g:each in="${otorgamientoDePoderInstance?.documentos}" var="d">
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
                                <input type="file" id="archivo" name="archivo" class="validate[required]"/>
                            </div>
                        </div>                        
                    </sec:ifAnyGranted>
                </div>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_SOLICITANTE">
                    <div class="form-actions">
                        <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    </div>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_PODERES_NOTARIO">
                    <div class="form-actions">
                        <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.label', default: 'Enviar')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    </div>
                </sec:ifAnyGranted>
            </g:form>                        
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
