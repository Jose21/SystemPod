
<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento De Poder')}"/>
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">            
            <div class="btn-group">
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${!otorgamientoDePoderInstance.documentos && ocultarBoton != true && !otorgamientoDePoderInstance.tareas}">
                        <g:link class="btn btn-success btn-small tip-bottom" action="existe" id="${otorgamientoDePoderInstance?.id}">
                            <i class="icon-thumbs-up"></i> Aceptar Solicitud
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${!otorgamientoDePoderInstance.documentos && !otorgamientoDePoderInstance.tareas && ocultarBoton != true}">
                        <g:link controller="tarea" action="create" class="btn btn-small btn-danger tip-bottom" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id ]">
                            <i class="icon-thumbs-down"></i> Rechazar Solicitud
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>                
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO">
                    <g:if test="${cartaDeInstruccion}">
                        <g:link controller="cartaDeInstruccionDeOtorgamiento" action="show" class="btn btn-small btn-info tip-bottom" params="[ id : cartaDeInstruccion.id]">
                            <i class="icon-external-link"></i> Ver Carta de Instrucción
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_NOTARIO">
                    <g:if test="${!otorgamientoDePoderInstance.documentos}">
                        <g:link  action="edit" class="btn btn-small btn-warning tip-bottom" params="[ id : otorgamientoDePoderInstance?.id]">
                            <i class="icon-external-link"></i> Enviar Copia Electronica
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${otorgamientoDePoderInstance.documentos && ocultarBoton == false}">
                        <g:link  action="entregarCopiaSolicitante" class="btn btn-small btn-purple tip-bottom" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Enviar Copia al Solicitante
                        </g:link>
                    </g:if>
                    <g:if test="${otorgamientoDePoderInstance.documentos && ocultarBoton == true && !otorgamientoDePoderInstance.notas}">                        
                        <g:link  controller="nota" action="create" class="btn btn-small btn-purple tip-bottom" params="[ otorgamientoDePoderId : otorgamientoDePoderInstance?.id]">
                            <i class="icon-file-text"></i> Notificar Envio de Documento Físico
                        </g:link>
                    </g:if>   
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_GESTOR">
                    <g:if test="${ocultarBoton != true}">
                        <g:link action="turnarResolvedor" class="btn btn-small btn-info tip-bottom" params="[ id : otorgamientoDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Turnar a Resolvedor
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <g:link action="imprimir" class="btn btn-small btn-pink tip-bottom" params="[ id : otorgamientoDePoderInstance?.id]" target="_blank">
                    <i class="icon-print"></i> Imprimir Solcitud
                </g:link>
            </div>
        </div>
        <div class="page-content">
            <g:render template="/shared/alerts" />
            <div class="row">
                <div class="col-xs-12">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="widget-box">
                                <div class="widget-header widget-header-blue widget-header-flat">
                                    <h4 class="lighter"><i class="icon-file-text"></i> Solicitud de Otorgamiento de Poder </h4>
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <g:render template="/otorgamientoDePoder/solicitudOtorgamiento" />
                                        <div class="modal-footer wizard-actions col-xs-12">
                                            <g:if test="${otorgamientoDePoderInstance?.documentos}"> 
                                                <table class="table table-bordered table-striped" border="2">
                                                    <thead>
                                                        <tr>
                                                            <th><g:message code="otorgamientoDePoder.documentos.label" default="Copia de Escritura Pública" /></th>                            
                                                        </tr>                            
                                                    </thead>
                                                    <tbody>                            
                                                        <tr>
                                                            <td style="text-align:center">
                                                                Descargar
                                                            </td>
                                                            <td style="text-align:center">
                                                                <g:each in="${otorgamientoDePoderInstance?.documentos}" var="d">
                                                                    <g:link controller="documentoDePoder" action="downloadArchivo" class="btn btn-small btn-danger tip-bottom" id="${d.id}">
                                                                        ${d?.encodeAsHTML()}
                                                                        <i class="icon-download"></i>
                                                                    </g:link>
                                                                </g:each>
                                                            </td>                        
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </g:if>                                            
                                            <g:if test="${otorgamientoDePoderInstance?.tareas}">
                                                <div class="widget-box ">
                                                    <div class="widget-header">
                                                        <h4 class="lighter smaller">
                                                            <i class="icon-comment blue"></i>
                                                            Notificación de Rechazo
                                                        </h4>
                                                    </div>

                                                    <div class="widget-body">
                                                        <div class="widget-main no-padding">
                                                            <div class="dialogs">                
                                                                <g:each var="tarea" in="${otorgamientoDePoderInstance?.tareas.sort { it.dateCreated }}">
                                                                    <div class="itemdiv dialogdiv">                                            
                                                                        <div class="body">
                                                                            <div class="time">                        
                                                                                <span>Enviada Por: ${tarea?.creadaPor?.firstName} ${tarea?.creadaPor?.lastName}</span><br/>
                                                                                <i class="icon-time"></i>
                                                                                <span class="green">Fecha de Envío: <g:formatDate date="${tarea?.dateCreated}" type="datetime" style="MEDIUM"/></span>                                                    
                                                                            </div>

                                                                            <div class="name">
                                                                                Título: ${tarea?.nombre}
                                                                            </div>
                                                                            <div class="text">
                                                                                Motivos: <%=tarea?.descripcion%>                                                                                              
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </g:each>
                                                            </div>
                                                        </div><!--/widget-main-->
                                                    </div><!--/widget-body-->
                                                </div><!--/widget-box-->
                                            </g:if>	
                                        </div>
                                    </div>
                                </div>
                                <g:if test="${otorgamientoDePoderInstance?.notas}">
                                    <div class="widget-box ">
                                        <div class="widget-header">
                                            <h4 class="lighter smaller">
                                                <i class="icon-comment blue"></i>
                                                Notificación de Envío de Documento Físico
                                            </h4>
                                        </div>

                                        <div class="widget-body">
                                            <div class="widget-main no-padding">
                                                <div class="dialogs">                
                                                    <g:each var="nota" in="${otorgamientoDePoderInstance?.notas?.sort { it.dateCreated }}">
                                                        <div class="itemdiv dialogdiv">                                            
                                                            <div class="body">
                                                                <div class="time">                        
                                                                    <span>Agregada Por: ${nota?.agregadaPor?.firstName} ${nota?.agregadaPor?.lastName}</span><br/>
                                                                    <i class="icon-time"></i>
                                                                    <span class="green">Fecha de Creación: <g:formatDate date="${nota?.dateCreated}" type="datetime" style="MEDIUM"/></span>                                                    
                                                                </div>

                                                                <div class="name">
                                                                    Título: ${nota?.titulo}
                                                                </div>
                                                                <div class="text">
                                                                    Descripcion: <%=nota?.descripcion%>
                                                                    <g:if test="${nota?.documentos}">
                                                                        Archivos adjuntos<br/>
                                                                        <g:each in="${nota?.documentos}" var="documento">                            
                                                                            <g:link controller="documento" action="downloadArchivo" id ="${documento?.id}">
                                                                                --${documento?.nombre} 
                                                                            </g:link><br/>
                                                                        </g:each>
                                                                    </g:if>                                                
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </g:each>
                                                </div>
                                            </div><!--/widget-main-->
                                        </div><!--/widget-body-->
                                    </div><!--/widget-box-->
                                </g:if>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>        
        <div class="container-fluid">                                    
            <!--g:form class="form-actions"-->
                <!--fieldset class="buttons">
                    <g:hiddenField name="id" value="${otorgamientoDePoderInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${otorgamientoDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>                    
                    </fieldset-->
            <!--/g:form-->            
        </div>
    </body>
</html>
