
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
            <h1>Ver: Solicitud de Otorgamiento de Poder</h1>
            <br/>            
            <div class="btn-group">
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${!otorgamientoDePoderInstance.documentos && ocultarBoton != true && !otorgamientoDePoderInstance.tareas}">
                        <g:link class="btn btn-success btn-small tip-bottom" action="existe" id="${otorgamientoDePoderInstance?.id}">
                            <i class="icon-external-link"></i> Aceptar Solicitud
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${!otorgamientoDePoderInstance.documentos && !otorgamientoDePoderInstance.tareas && ocultarBoton != true}">
                        <g:link controller="tarea" action="create" class="btn btn-small btn-danger tip-bottom" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id ]">
                            <i class="icon-external-link"></i> Rechazar Solicitud
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
                            <i class="icon-external-link"></i> Notificar Envio de Documento Físico
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
            </div>
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>

            <div class="well">

                <g:if test="${otorgamientoDePoderInstance?.id}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.numeroDeFolio.label" default="Número de Folio" /></dt>					
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="id"/>-O</dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.registroDeLaSolicitud}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.registroDeLaSolicitud.label" default="Registro De La Solicitud" /></dt>					
                        <dd><g:formatDate date="${otorgamientoDePoderInstance?.registroDeLaSolicitud}" /></dd>					
                    </dl>
                </g:if>
                
                <g:if test="${otorgamientoDePoderInstance?.fechaDeEnvio}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.fechaDeEnvio.label" default="Fecha de Envío" /></dt>					
                        <dd><g:formatDate date="${otorgamientoDePoderInstance?.fechaDeEnvio}" /></dd>					
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.categoriaDeTipoDePoder}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.categoriaDeTipoDePoder.tipoDePoder.label" default="Tipo De Poder" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="categoriaDeTipoDePoder.tipoDePoder.nombre"/></dd>
                        <dt><g:message code="otorgamientoDePoder.categoriaDeTipoDePoder.label" default="Categoria" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="categoriaDeTipoDePoder.nombre"/></dd>
                    </dl>
                </g:if>              

                <g:if test="${otorgamientoDePoderInstance?.apoderados}">
                    <dt><g:message code="otorgamientoDePoder.apoderados.label" default="Apoderados" /></dt>
                    <g:each in="${otorgamientoDePoderInstance.apoderados}" var="a">
                        <dd>- ${a?.nombre.encodeAsHTML()}</dd>
                    </g:each>                    
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.delegacion}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="delegacion"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.poderSolicitado}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.poderSolicitado.label" default="Poder Solicitado" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="poderSolicitado"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.motivoDeOtorgamiento}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.motivoDeOtorgamiento.label" default="Motivo De Otorgamiento" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="motivoDeOtorgamiento"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.solicitadoPor}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.solicitadoPor.label" default="Solicitado Por" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="solicitadoPor"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.asignar}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.asignar.label" default="Asignado A" /></dt>
                        <dd>${otorgamientoDePoderInstance?.asignar?.firstName} ${otorgamientoDePoderInstance?.asignar?.lastName}</dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.fechaDeOtorgamiento.label" default="Fecha De Otorgamiento" /></dt>
                        <dd><g:formatDate date="${otorgamientoDePoderInstance?.fechaDeOtorgamiento}" /></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.escrituraPublica}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.escrituraPublica.label" default="Escritura Pública De Otorgamiento" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="escrituraPublica"/></dd>
                    </dl>
                </g:if>

                <g:if test="${otorgamientoDePoderInstance?.comentarios}">
                    <dl>
                        <dt><g:message code="otorgamientoDePoder.comentarios.label" default="Comentarios" /></dt>
                        <dd><g:fieldValue bean="${otorgamientoDePoderInstance}" field="comentarios"/></dd>
                    </dl>
                </g:if>

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
            <!--g:form class="form-actions"-->
                <!--fieldset class="buttons">
                    <g:hiddenField name="id" value="${otorgamientoDePoderInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${otorgamientoDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>                    
                    </fieldset-->
            <!--/g:form-->            
        </div>
    </body>
</html>
