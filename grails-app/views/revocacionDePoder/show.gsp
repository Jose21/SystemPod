
<%@ page import="com.app.sgpod.RevocacionDePoder" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">            
            <div class="btn-group">
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${!cartaDeInstruccion | !revocacionDePoderInstance.escrituraPublicaRevocacion && ocultarBoton != true}">
                        <g:link class="btn btn-success btn-small tip-bottom" controller="revocacionDePoder" action="existe" id="${revocacionDePoderInstance?.id}">
                            <i class="icon-external-link"></i> Aceptar y Enviar Solicitud
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>  
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_GESTOR_EXTERNO">     
                    <g:if test="${!revocacionDePoderInstance.notificacionDeRechazo && !revocacionDePoderInstance.notas}">
                        <g:link controller="revocacionDePoder" action="notificacionDeRechazo" class="btn btn-small btn-danger tip-bottom" params="[ idRevocacionDePoder : revocacionDePoderInstance?.id ]">
                            <i class="icon-thumbs-down"></i> Rechazar Solicitud
                        </g:link> 
                    </g:if>
                </sec:ifAnyGranted>  
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO">
                    <g:if test="${cartaDeInstruccion}">
                        <g:link controller="revocacionDePoder" action="existeCarta" class="btn btn-small btn-info tip-bottom" id="${revocacionDePoderInstance?.id}">
                            <i class="icon-external-link"></i> Ver Carta de Instrucción
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_NOTARIO">
                    <g:if test="${cartaDeInstruccion && ocultarBoton != true}">
                        <g:link  controller="nota" action="create" class="btn btn-small btn-warning tip-bottom" params="[ revocacionDePoderId : revocacionDePoderInstance?.id]">
                            <i class="icon-external-link"></i> Enviar Copia Electrónica
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                    <g:if test="${cartaDeInstruccion && ocultarBoton != true && solicitudExterno == false}">
                        <g:link  action="entregarCopiaSolicitante" class="btn btn-small btn-purple tip-bottom" params="[ idRevocacionDePoder : revocacionDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Enviar Copia al Solicitante
                        </g:link>
                    </g:if>
                    <g:if test="${cartaDeInstruccion && ocultarBoton != true && solicitudExterno == true}">
                        <g:link  action="entregarCopiaGestorExterno" class="btn btn-small btn-purple tip-bottom" params="[ idRevocacionDePoder : revocacionDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Enviar Copia al Gestor Externo
                        </g:link>
                    </g:if>
                    <g:if test="${!cartaDeInstruccion && ocultarBoton != true}">
                        <g:link  controller="prorroga" action="create" class="btn btn-small btn-info tip-bottom" params="[ revocacionDePoderId : revocacionDePoderInstance?.id]">
                            <i class="icon-calendar"></i> Prorroga
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>                
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_GESTOR">
                    <g:if test="${ocultarBoton != true}">
                        <g:link action="turnarResolvedor" class="btn btn-small btn-info tip-bottom" params="[ id : revocacionDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Turnar a Resolvedor
                        </g:link>
                    </g:if>                    
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_GESTOR_EXTERNO">
                    <g:if test="${ocultarBoton != true && !revocacionDePoderInstance?.notas}">
                        <g:link action="turnarGestor1" class="btn btn-small btn-info tip-bottom" params="[ id : revocacionDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Turnar a Gestor
                        </g:link>
                    </g:if>
                    <g:if test="${cartaDeInstruccion && ocultarBoton != true && solicitudExterno == true}">
                        <g:link  action="entregarCopiaSolicitante" class="btn btn-small btn-purple tip-bottom" params="[ idRevocacionDePoder : revocacionDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Enviar Copia al Solicitante
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <g:link action="imprimir" class="btn btn-small btn-pink tip-bottom" params="[ id : revocacionDePoderInstance?.id]" target="_blank">
                    <i class="icon-print"></i> Imprimir Solicitud
                </g:link>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO">
                    <g:if test="${ocultarBoton != true && !revocacionDePoderInstance.notas}">
                        <a class="btn btn-small btn-inverse tip-bottom" href="#reasignarSolicitud" data-toggle="modal">
                            <i class="icon-reply"></i> Reasignar Solicitud
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
                                    <g:if test="${!revocacionDePoderInstance.prorrogas}">
                                        <h4 class="lighter"><i class="icon-file-text"></i> Solicitud de Revocación de Poder </h4>
                                    </g:if>
                                    <g:elseif test="${ocultarBoton != true && !cartaDeInstruccion}">
                                        <table class="bordered">
                                            <tr>
                                                <td style="width:33%">
                                                    <table style="width: 100%;border-collapse: collapse" border="1">
                                                        <tr>                                                        
                                                            <td style="width:50%">
                                                                <h4 class="lighter"><i class="icon-file-text"></i> Solicitud de Revocación de Poder </h4>                                    
                                                            </td>
                                                        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                                                            <td style="width:50%;text-align: right">
                                                                <div class="infobox infobox-blue2 infobox-small infobox-dark">
                                                                    <div class="infobox-icon">
                                                                        <i class="icon-calendar"></i>
                                                                    </div>
                                                                    <div class="infobox-data">
                                                                        <div class="infobox-content">Prorroga</div>
                                                                        <div class="infobox-content">- ${diasRestantes} día(s)</div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </sec:ifAnyGranted>
                                            </tr>
                                        </table>
                                        </td>
                                        </tr>
                                        </table>
                                    </g:elseif>
                                    <g:else>
                                        <h4 class="lighter"><i class="icon-file-text"></i> Solicitud de Revocación de Poder </h4>                                    
                                    </g:else>                                    
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <g:render template="/revocacionDePoder/solicitudRevocacion" />
                                        <div class="modal-footer wizard-actions col-xs-12">
                                            <g:if test="${revocacionDePoderInstance?.documentos}"> 
                                                <table class="table table-bordered table-striped" border="2">
                                                    <thead>
                                                        <tr>
                                                            <th colspan="2"><g:message code="revocacionDePoder.documentos.label" default="Copia de Escritura Pública de Otorgamiento de poder" /></th>                            
                                                        </tr>                            
                                                    </thead>
                                                    <tbody>                            
                                                        <tr>
                                                            <td style="text-align:center">
                                                                Descargar
                                                            </td>
                                                            <td style="text-align:center">
                                                                <g:each in="${revocacionDePoderInstance?.documentos}" var="d">
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
                                            <g:if test="${revocacionDePoderInstance?.prorrogas}">
                                                <div class="widget-box ">
                                                    <div class="widget-header">
                                                        <h4 class="lighter smaller">
                                                            <i class="icon-calendar blue"></i>
                                                            Prorrogas Agregadas
                                                        </h4>
                                                    </div>

                                                    <div class="widget-body">
                                                        <div class="widget-main no-padding">
                                                            <div class="dialogs">                
                                                                <g:each var="prorroga" in="${revocacionDePoderInstance?.prorrogas?.sort { it.dateCreated }}">
                                                                    <div class="itemdiv dialogdiv">                                            
                                                                        <div class="body">
                                                                            <div class="time">                        
                                                                                <span>Creada  Por: ${prorroga?.creadoPor?.firstName} ${prorroga?.creadoPor?.lastName}</span><br/>
                                                                                <i class="icon-time"></i>
                                                                                <span class="green">Fecha de Envio: <g:formatDate date="${prorroga?.fechaDeEnvio}" type="datetime" style="MEDIUM"/></span>                                                    
                                                                            </div>                                                                
                                                                            <div class="text">
                                                                                Motivos: ${prorroga?.motivos}                                                                                                                
                                                                            </div>
                                                                            <div class="text">
                                                                                Fecha Limite: <g:formatDate date="${prorroga?.fechaProrroga}" type="datetime" style="MEDIUM"/>                                                                                                              
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </g:each>
                                                            </div>
                                                        </div><!--/widget-main-->
                                                    </div><!--/widget-body-->
                                                </div><!--/widget-box-->
                                            </g:if>
                                            <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_GESTOR, ROLE_SOLICITANTE_EXTERNO, ROLE_GESTOR_EXTERNO, ROLE_SOLICITANTE_ESPECIAL, ROLE_PODERES_ENLACE">
                                                <g:if test="${revocacionDePoderInstance?.datosUsuarioExterno}">

                                                    <table class="table table-bordered table-striped" border="2">
                                                        <thead>
                                                            <tr>
                                                                <th colspan="2"><g:message code="revocacionDePoder.datosUsuarioExterno.label" default="Datos del Usuario Externo" /></th>                            
                                                            </tr>                            
                                                        </thead>
                                                        <tbody>                            
                                                            <tr>
                                                                <td style="text-align:center">
                                                                    Descargar
                                                                </td>
                                                                <td style="text-align:center">

                                                                    <g:link controller="poderes" action="downloadArchivo"  id="${revocacionDePoderInstance.id}">                                                           
                                                                        ${revocacionDePoderInstance?.nombreDatosUsuarioExterno?.encodeAsHTML()}
                                                                        <i class="icon-download"></i>
                                                                    </g:link>
                                                                </td>                        
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </g:if> 
                                            </sec:ifAnyGranted>
                                            <g:if test="${revocacionDePoderInstance?.notificacionDeRechazo}"> 
                                                <div class="widget-box">
                                                    <div class="widget-header" align="left">
                                                        <h4 class="lighter smaller">
                                                            <i class="icon-comment blue "></i>
                                                            Notificación de Rechazo
                                                        </h4>
                                                    </div>
                                                    <div class="widget-body">
                                                        <div class="widget-main no-padding">
                                                            <div class="dialogs">                                                                                
                                                                <div class="itemdiv dialogdiv">                                            
                                                                    <div class="body">
                                                                        <div class="time">                        
                                                                            <span>Enviada Por: ${revocacionDePoderInstance?.asignadaPor}</span><br/>
                                                                            <i class="icon-time"></i>
                                                                            <span class="green">Fecha de Envío: <g:formatDate date="${revocacionDePoderInstance?.fechaDeEnvio}" type="datetime" style="MEDIUM"/></span>                                                    
                                                                        </div>
                                                                        </br> 
                                                                        <div class="name" align="left">
                                                                            Motivo de Rechazo :
                                                                        </div>
                                                                        <div class="text" align="left">
                                                                            ${revocacionDePoderInstance?.notificacionDeRechazo}                                                                                       
                                                                        </div>
                                                                    </div>
                                                                </div>                                                                
                                                            </div>
                                                        </div><!--/widget-main-->
                                                    </div><!--/widget-body-->
                                                </div><!--/widget-box-->                                            
                                            </g:if>
                                        </div>
                                    </div> 
                                    <g:if test="${revocacionDePoderInstance?.notas}">
                                        <div class="widget-box ">
                                            <div class="widget-header">
                                                <h4 class="lighter smaller">
                                                    <i class="icon-comment blue"></i>
                                                    Testimonio de Escritura Pública de Revocación de poder.
                                                </h4>
                                            </div>
                                            <div class="widget-body">
                                                <div class="widget-main no-padding">
                                                    <div class="dialogs">                
                                                        <g:each var="nota" in="${revocacionDePoderInstance?.notas.sort { it.dateCreated }}">
                                                            <div class="itemdiv dialogdiv">                                            
                                                                <div class="body">
                                                                    <div class="time">                        
                                                                        <span>Agregada Por: ${nota?.agregadaPor?.firstName} ${nota?.agregadaPor?.lastName}</span><br/>
                                                                        <i class="icon-time"></i>
                                                                        <span class="green">Fecha de Creación: <g:formatDate date="${nota?.dateCreated}" type="datetime" style="MEDIUM"/></span>                                                    
                                                                    </div>

                                                                    <div class="name">
                                                                        Título: ${nota.titulo}
                                                                    </div>
                                                                    <div class="text">
                                                                        Descripcion: <%=nota.descripcion%><br/>
                                                                        <g:if test="${nota.documentos}">
                                                                            Archivos adjuntos<br/>
                                                                            <g:each in="${nota.documentos}" var="documento">                            
                                                                                <g:link controller="documento" action="downloadArchivo" id ="${documento.id}">
                                                                                    --${documento.nombre} 
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
                            <div id="reasignarSolicitud" class="modal hide" style="width:600px;">
                                <div class="modal-header">
                                    <button data-dismiss="modal" class="close" type="button">×</button>
                                    <h3>Usuarios</h3>
                                </div>
                                <div class="modal-body">
                                    <g:form name="myForm" class="form-horizontal" method="post">                                            
                                        <g:hiddenField name="revocacionDePoder.id" value="${revocacionDePoderInstance?.id}" />                                            
                                        <g:hiddenField name="version" value="${revocacionDePoderInstance?.version}" />
                                        <g:render template="/revocacionDePoder/reasignarSolicitudRevocacion" bean="${revocacionDePoder}"/>            
                                        <div class="form-actions">
                                            <g:actionSubmit class="btn btn-primary" action="reasignarSolicitud" value="${message(code: 'default.button.label', default: 'Aceptar')}" />
                                        </div>
                                    </g:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>        
        <div class="container-fluid">            
            <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES">
                <g:form class="form-actions">
                    <fieldset class="buttons">
                        <g:hiddenField name="id" value="${revocacionDePoderInstance?.id}" />
                        <g:link class="btn btn-primary" action="edit" id="${revocacionDePoderInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>                    
                        </fieldset>
                </g:form>
            </sec:ifAnyGranted>
        </div>
    </body>
</html>
