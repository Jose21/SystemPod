
<%@ page import="com.app.sgpod.DocumentoDeProyecto" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'documentoDeProyecto.label', default: 'Documento De Proyecto')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <div class="btn-group">
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${!documentoDeProyectoInstance.motivosDeRechazo && documentoDeProyectoInstance.voboCartaDeInstruccion == false}">
                        <g:link class="btn btn-success btn-small tip-bottom" action="aceptarVoBo" id="${documentoDeProyectoInstance?.id}">
                            <i class="icon-check"></i> Aceptar la carta de instruccion y enviar.
                        </g:link>  
                    </g:if>
                    <g:if test="${!documentoDeProyectoInstance.motivosDeRechazo && documentoDeProyectoInstance.voboCartaDeInstruccion == false}">
                        <a class="btn btn-small btn-warning tip-bottom" href="#enviarCancelacion" data-toggle="modal">
                            <i class="icon-thumbs-down"></i> Cancelar y enviar motivos de rechazo
                        </a>
                    </g:if>
                </sec:ifAnyGranted>
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
                                    <table style="width: 100%;border-collapse: collapse" border="1">
                                        <tr>
                                            <td style="width:50%">
                                                <table style="width: 100%;border-collapse: collapse" border="1">
                                                    <tr>
                                                        <td style="width:50%">
                                                            <h4 class="lighter"><i class="icon-file"></i> Validación de Carta de Instrucción </h4>
                                                        </td>
                                                        <td style="width:50%">
                                                            <g:if test="${documentoDeProyectoInstance?.otorgamientoDePoder?.id}">                                                                                                                                                              
                                                                <span>Asociado a la Solcitud de Otorgamiento de Poder   </span>                                                                
                                                                <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoDePoderInstance?.id}">
                                                                    <span class="label label-success arrowed-in">
                                                                        ${documentoDeProyectoInstance?.otorgamientoDePoder?.id}-O
                                                                    </span>
                                                                </g:link>                                                                                              
                                                            </g:if>                                                            
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>                                                                        
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">                                        
                                        <div class="well">                                             
                                            <g:if test="${documentoDeProyectoInstance?.descripcion}">
                                                <dl>
                                                    <dt><g:message code="documentoDeProyecto.descripcion.label" default="Descripcion" /></dt>
                                                    <dd><g:fieldValue bean="${documentoDeProyectoInstance}" field="descripcion"/></dd>
                                                </dl>
                                            </g:if>
                                            <g:if test="${documentoDeProyectoInstance?.fechaDeEnvio}">
                                                <dl>
                                                    <dt><g:message code="documentoDeProyecto.fechaDeEnvio.label" default="Fecha De Envio" /></dt>
                                                    <dd><g:formatDate date="${documentoDeProyectoInstance?.fechaDeEnvio}" /></dd>
                                                </dl>
                                            </g:if>                                           
                                        </div>                          
                                    </div>
                                </div>  
                                <div class="modal-footer wizard-actions col-xs-12">
                                    <g:if test="${documentoDeProyectoInstance?.documentos}"> 
                                        <table class="table table-bordered table-striped" border="2">
                                            <thead>
                                                <tr>
                                                    <th colspan="2"><g:message code="otorgamientoDePoder.documentos.label" default="Documentos" /></th>                            
                                                </tr>                            
                                            </thead>
                                            <tbody>                            
                                                <tr>
                                                    <td style="text-align:center">
                                                        Descargar
                                                    </td>
                                                    <td style="text-align:center">
                                                        <g:each in="${documentoDeProyectoInstance?.documentos}" var="d">
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
                                <g:if test="${documentoDeProyectoInstance?.motivosDeRechazo}"> 
                                    <div class="widget-box ">
                                        <div class="widget-header">
                                            <h4 class="lighter smaller">
                                                <i class="icon-comment blue"></i>
                                                Notificación de Rechazo de Carta Instruccion
                                            </h4>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main no-padding">
                                                <div class="dialogs">                                                                    
                                                    <div class="itemdiv dialogdiv">                                            
                                                        <div class="body">
                                                            <div class="time">                        
                                                                <span>Enviada Por: ${documentoDeProyectoInstance?.asignadoPor?.firstName} ${documentoDeProyectoInstance?.asignadoPor?.lastName}</span><br/>
                                                                <i class="icon-time"></i>
                                                                <span class="green">Fecha de Envío: <g:formatDate date="${documentoDeProyectoInstance?.dateCreated}" type="datetime" style="MEDIUM"/></span>                                                    
                                                            </div>
                                                            <div class="text">
                                                                Motivos: ${documentoDeProyectoInstance.motivosDeRechazo}                                                                                              
                                                            </div>
                                                        </div>
                                                    </div>                                                    
                                                </div>
                                            </div><!--/widget-main-->
                                        </div><!--/widget-body-->
                                    </div><!--/widget-box-->
                                </g:if>
                            </div>
                            <div id="enviarCancelacion" class="modal hide" style="width:600px;">
                                <div class="modal-header">
                                    <button data-dismiss="modal" class="close" type="button">×</button>
                                    <h3>Usuarios</h3>
                                </div>
                                <div class="modal-body">
                                    <g:form name="myForm" class="form-horizontal" method="post">                                            
                                        <g:hiddenField name="documentoDeProyecto.id" value="${documentoDeProyectoInstance?.id}" />                                            
                                        <g:hiddenField name="version" value="${documentoDeProyectoInstance?.version}" />
                                        <g:render template="/documentoDeProyecto/enviarCancelacion" bean="${documentoDeProyecto}"/>            
                                        <div class="form-actions">
                                            <g:actionSubmit class="btn btn-primary" action="enviarCancelacion" value="${message(code: 'default.button.label', default: 'Enviar')}" />
                                        </div>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>            
        </div>      
    </div>
</body>
</html>
