
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
            <h1>Solicitud de Revocación De Poder</h1>
            <div class="btn-group">
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ADMINISTRADOR">
                    <g:if test="${!cartaDeInstruccion}">
                        <g:link class="btn btn-success btn-small tip-bottom" controller="revocacionDePoder" action="existe" id="${revocacionDePoderInstance?.id}">
                            <i class="icon-external-link"></i> Crear Carta de Instrucción
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>                
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ADMINISTRADOR, ROLE_PODERES_NOTARIO">
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
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ADMINISTRADOR">
                    <g:if test="${cartaDeInstruccion && ocultarBoton != true}">
                        <g:link  action="entregarCopiaSolicitante" class="btn btn-small btn-purple tip-bottom" params="[ idRevocacionDePoder : revocacionDePoderInstance?.id]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-external-link"></i> Enviar Copia al Solicitante
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
            </div>
        </div>

        <div class="container-fluid">
            <g:render template="/shared/alerts" />
            <br/>

            <div class="well">

                <g:if test="${revocacionDePoderInstance?.id}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.id.label" default="Número de Folio" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="id"/>-R</dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.escrituraPublica}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.escrituraPublica.label" default="Escritura Pública" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="escrituraPublica"/></dd>

                    </dl>
                </g:if>                             

                <g:if test="${revocacionDePoderInstance?.categoriaDeTipoDePoder}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.categoriaDeTipoDePoder.tipoDePoder.label" default="Tipo De Poder" /></dt>
                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="categoriaDeTipoDePoder.tipoDePoder.nombre"/></dd>
                        </br>
                        <dt><g:message code="revocacionDePoder.categoriaDeTipoDePoder.label" default="Categoria" /></dt>
                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="categoriaDeTipoDePoder.nombre"/></dd>
                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.delegacion}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.delegacion.label" default="Delegación" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="delegacion"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.motivoDeRevocacion}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.motivoDeRevocacion.label" default="Motivo De Revocación" /></dt>

                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="motivoDeRevocacion"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.solicitadoPor}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.solicitadoPor.label" default="Solicitado Por" /></dt>
                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="solicitadoPor"/></dd>

                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.asignar}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.asignar.label" default="Asignado A" /></dt>
                        <dd>${revocacionDePoderInstance?.asignar?.firstName} ${revocacionDePoderInstance?.asignar?.lastName}</dd>
                    </dl>
                </g:if>

                <g:if test="${revocacionDePoderInstance?.fechaDeRevocacion}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha De Revocación" /></dt>
                        <dd><g:formatDate date="${revocacionDePoderInstance?.fechaDeRevocacion}" /></dd>

                    </dl>
                </g:if>               

                <g:if test="${revocacionDePoderInstance?.comentarios}">
                    <dl>
                        <dt><g:message code="revocacionDePoder.comentarios.label" default="Comentarios" /></dt>
                        <dd><g:fieldValue bean="${revocacionDePoderInstance}" field="comentarios"/></dd>
                    </dl>
                </g:if>
                
                <g:if test="${revocacionDePoderInstance?.documentos}"> 
                    <table class="table table-bordered table-striped" border="2">
                        <thead>
                            <tr>
                                <th><g:message code="revocacionDePoder.documentos.label" default="Copia de Escritura Pública" /></th>                            
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

                <g:if test="${revocacionDePoderInstance?.notas}">
                    <div class="widget-box ">
                        <div class="widget-header">
                            <h4 class="lighter smaller">
                                <i class="icon-comment blue"></i>
                                Testimonio de Escritura Pública
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
                                                Descripcion: <%=nota.descripcion%>
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
