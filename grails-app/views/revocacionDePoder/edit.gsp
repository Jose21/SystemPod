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

                    <br/>
                    <h3 id="bloqueDatosComplementarios"  class="header smaller lighter blue">Datos Complementarios</h3>

                    <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'fechaDeRevocacion', 'error')} ">
                        <label for="fechaDeRevocacion" class="control-label">
                            <g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha De Revocacion" />
                        </label>
                        <div class="controls">
                            <div class="row-fluid input-append">
                                <input readonly="readonly" class="span10 date-picker" id="fechaDeRevocacion" type="text" value="${revocacionDePoderInstance?.fechaDeRevocacion?(new SimpleDateFormat("dd/MM/yyyy")).format(revocacionDePoderInstance?.fechaDeRevocacion):""}" data-date-format="dd/mm/yyyy" name="fechaDeRevocacion" />      
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'escrituraPublicaDeRevocacion', 'error')} ">
                        <label for="escrituraPublicaDeRevocacion" class="control-label">
                            <g:message code="revocacionDePoder.escrituraPublicaDeRevocacion.label" default="Escritura Publica De Revocacion" />
                        </label>
                        <div class="controls">
                            <g:textField class="span6" name="escrituraPublicaDeRevocacion" value="${revocacionDePoderInstance?.escrituraPublicaDeRevocacion}"/>
                        </div>
                    </div>
                    <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'comentarios', 'error')} ">
                        <label for="comentarios" class="control-label">
                            <g:message code="revocacionDePoder.comentarios.label" default="Comentarios" />
                        </label>
                        <div class="controls">
                            <g:textArea class="span6" name="comentarios" cols="40" rows="5" maxlength="1048576" value="${revocacionDePoderInstance?.comentarios}"/>
                        </div>
                    </div>
                    <h3 id="bloqueAdjuntarArchivos"  class="header smaller lighter blue">Adjuntar Documentos</h3>
                    <div class="control-group fieldcontain ${hasErrors(bean: revocacionDePoderInstance, field: 'documentos', 'error')} ">
                        <label for="documentos" class="control-label">
                            <g:hiddenField name="anchor" value="bloqueAdjuntarArchivos"/>
                            <g:message code="revocacionDePoder.documentos.label" default="Documentos" />
                        </label>
                        <div class="controls">
                            <g:each in="${revocacionDePoderInstance?.documentos?}" var="d">
                                <div class="pull-left action-buttons">
                                    <g:link class="red" controller="revocacionDePoder" action="deleteArchivo" id ="${d.id}" params="[revocacionDePoderId:revocacionDePoderInstance?.id, anchor:'bloqueAdjuntarArchivos']">
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
                    <div class="form-actions">
                        <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    </div>
                </g:form>
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
