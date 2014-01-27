
<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento De Poder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Ver: Solicitud de Otorgamiento de Poder</h1>
            <br/>            
            <div class="btn-group"> 
                <g:link class="btn btn-success btn-small tip-bottom" controller="otorgamientoDePoder" action="existe" id="${otorgamientoDePoderInstance?.id}">
                    <i class="icon-external-link"></i> Aceptar Solicitud
                </g:link>
                <g:link controller="tarea" action="create" class="btn btn-small btn-inverse tip-bottom" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id ]">
                    <i class="icon-external-link"></i> Rechazar Solicitud
                </g:link>
                <a class="btn btn-small btn-purple tip-bottom" href="#tareasAsociadas" data-toggle="modal">
                    <i class="icon-comments"></i> Notificaciones
                </a>  
                <g:link controller="cartaDeInstruccionDeOtorgamiento" action="show" class="btn btn-small btn-info tip-bottom" params="[ id : idCartaDeInstruccion]">
                    <i class="icon-external-link"></i> Ver Carta de Instrucción
                </g:link>
                <g:link  action="edit" class="btn btn-small btn-warning tip-bottom" params="[ id : otorgamientoDePoderInstance?.id]">
                    <i class="icon-external-link"></i> Enviar Copia Electronica
                </g:link>                
                <g:link  action="entregarCopiaSolicitante" class="btn btn-small btn-info tip-bottom" params="[ idOtorgamientoDePoder : otorgamientoDePoderInstance?.id]">
                    <i class="icon-external-link"></i> Enviar Copia al Solicitante
                </g:link>                    
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

            </div>
            <!--g:form class="form-actions"-->
                <!--fieldset class="buttons">
                    <g:hiddenField name="id" value="${otorgamientoDePoderInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${otorgamientoDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>                    
                    </fieldset-->
            <!--/g:form-->
            <div id="tareasAsociadas" class="modal hide" style="width:600px;">
                <div class="modal-header">
                    <button data-dismiss="modal" class="close" type="button">×</button>
                    <h3>Notificaciones asociados al Otorgamiento de Poder</h3>
                </div>
                <div class="modal-body">     
                    <g:if test="${otorgamientoDePoderInstance?.tareas?.findAll{ it.cerrada == false }}">
                        <div class="widget-box">
                            <div class="widget-header widget-header-flat widget-header-small">
                                <h5><i class="icon-circle"></i>Notificaciones Activas</h5>                    
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
                                <h5><i class="icon-circle"></i>Notificaciones Expiradas</h5>                    
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
    </body>
</html>
