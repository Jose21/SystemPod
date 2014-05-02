
<%@ page import="com.app.sgpod.Factura" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">           
            <div class="btn-group">
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR"> 
                    <g:if test="${ocultarBoton != true && !facturaInstance.fechaDePago}">
                        <g:link class="btn btn-success btn-small tip-bottom" action="asignarSolicitud" id="${facturaInstance?.id}">
                            <i class="icon-thumbs-up"></i> Asignar a Solicitudes
                        </g:link>
                    </g:if>
                </sec:ifAnyGranted>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_FACTURAS">  
                    <g:if test="${ocultarBoton != true}">
                        <a class="btn btn-small btn-purple tip-bottom" href="#agregarFecha" data-toggle="modal">
                            <i class="icon-thumbs-up"></i> Aceptar Solicitud
                        </a>
                    </g:if>
                </sec:ifAnyGranted> 
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_FACTURAS"> 
                    <g:if test="${ocultarBoton != true && !facturaInstance.fechaDePago}">
                        <a class="btn btn-small btn-danger tip-bottom" href="#comentarioDeRechazo" data-toggle="modal">
                            <i class="icon-thumbs-down"></i> Rechazar Solicitud
                        </a>
                    </g:if>
                </sec:ifAnyGranted> 
            </div>
        </div>
        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>                        
        </div>
        <div class="page-content">
            <g:render template="/shared/alerts" />
            <div class="row">
                <div class="col-xs-12">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="widget-box">
                                <div class="widget-header widget-header-blue widget-header-flat">
                                    <h4 class="lighter"><i class="icon-file-text"></i> Factura </h4>                                    
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">                                                                                
                                        <div class="itemdiv dialogdiv">                                            
                                            <div class="body">
                                                <div class="time">                        
                                                    <span>Enviada Por: ${facturaInstance?.asignadoPor?.firstName} ${facturaInstance?.asignadoPor?.lastName}</span><br/>
                                                    <i class="icon-time"></i>
                                                    <span class="green">Fecha de Envio: <g:formatDate date="${facturaInstance?.fechaDeEnvio}" type="datetime" style="MEDIUM"/></span>                                                    
                                                </div>

                                                <div class="name">
                                                    Nota:<br/>
                                                    ${facturaInstance?.nota}
                                                </div>
                                                <div class="text">                                                        
                                                    <br/>
                                                    <br/>                                                    
                                                </div>
                                            </div>
                                        </div>
                                        <g:if test="${facturaInstance?.comentarioDeRechazo}">
                                            <div class="itemdiv dialogdiv success">                                            
                                                <div class="body">                                                
                                                    <div class="name">
                                                        <span class="red">Motivos De Rechazo :<br/></span>
                                                            ${facturaInstance?.comentarioDeRechazo}
                                                    </div>                                                
                                                </div>
                                            </div>
                                        </g:if>
                                    </div>
                                </div> 
                                <g:if test="${otorgamientosList}">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th colspan="6"> Solicitudes correspondientes a la factura.</th>
                                            </tr>
                                            <tr>                                            
                                                <th></th>
                                                <th scope="col">Número de Solicitud</th>                                    
                                                <th scope="col">Notario Correspondiente</th>
                                                <th scope="col">Tipo De Poder</th>
                                                <th scope="col">Categoria</th>  
                                                <th scope="col">Escritura Pública</th>                                                                                                                               
                                            </tr>
                                        </thead>
                                        <tbody>                                                            
                                            <g:each in="${otorgamientosList}" status="i" var="otorgamientoInstance">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}"> 
                                                    <td></td>
                                                    <td>                                                                
                                                        <span class="label label-info arrowed-in">
                                                            ${otorgamientoInstance?.id}-O
                                                        </span>                                                                
                                                    </td>                                        
                                                    <td>${fieldValue(bean: otorgamientoInstance, field: "notarioCorrespondiente")}</td>
                                                    <td>${fieldValue(bean: otorgamientoInstance, field: "categoriaDeTipoDePoder.tipoDePoder.nombre")}</td>
                                                    <td>${fieldValue(bean: otorgamientoInstance, field: "categoriaDeTipoDePoder.nombre")}</td>                                                      
                                                    <td>${fieldValue(bean: otorgamientoInstance, field: "escrituraPublica")}</td>                                                            
                                                </tr>
                                            </g:each>
                                            <g:each in="${revocacionesList}" status="i" var="revocacionInstance">
                                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">  
                                                    <td></td>
                                                    <td>                                                                
                                                        <span class="label label-info arrowed-in">
                                                            ${revocacionInstance?.id}-R
                                                        </span>                                                                
                                                    </td>                                        
                                                    <td>${fieldValue(bean: revocacionInstance, field: "notarioCorrespondiente")}</td>
                                                    <td>${fieldValue(bean: revocacionInstance, field: "categoriaDeTipoDePoder.tipoDePoder.nombre")}</td>
                                                    <td>${fieldValue(bean: revocacionInstance, field: "categoriaDeTipoDePoder.nombre")}</td>                                                      
                                                    <td>${fieldValue(bean: revocacionInstance, field: "escrituraPublica")}</td>                                                            
                                                </tr>
                                            </g:each>                                                                    
                                        </tbody>
                                    </table>
                                </g:if>                                

                                <div class="modal-footer wizard-actions col-xs-12">                                     
                                    <g:if test="${facturaInstance?.documentos}"> 
                                        <table class="table table-bordered table-striped" border="2">
                                            <thead>
                                                <tr>
                                                    <th colspan="2"><g:message code="factura.documentos.label" default="Archivos adjuntos" /></th>                            
                                                </tr>                            
                                            </thead>
                                            <tbody>                            
                                                <tr>
                                                    <td style="text-align:center" width="40%">
                                                        Descargar
                                                    </td>
                                                    <td style="text-align:center" width="60%">
                                                        <g:each in="${facturaInstance?.documentos}" var="d">
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
                                    <div class="space-24"></div>
                                    <h3 class="header smaller lighter blue" align="left">
                                        Verificación de Documentos                                        
                                    </h3>                                    
                                    <div class="row-fluid">
                                        <g:form action="saveListaDocumentos">
                                            <g:hiddenField name="factura.id" value="${facturaInstance?.id}"/>
                                            <div class="span4">
                                                <div class="control-group">
                                                    <label class="control-label"></label>

                                                    <div class="controls">                                                        
                                                        <label>
                                                            <g:if test="${facturaInstance?.documentoCotizacion == false}">
                                                                <input name="archivoCotizacion" class="ace ace-checkbox-2" type="checkbox" /> 
                                                            </g:if> 
                                                            <g:else>
                                                                <input name="archivoCotizacion" class="ace ace-checkbox-2" type="checkbox" checked /> 
                                                            </g:else>  
                                                            <span class="lbl"> Cotización</span>
                                                        </label>                                                                                                        
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="span2">
                                                <div class="control-group">
                                                    <label class="control-label"></label>

                                                    <div class="controls">                                                                                                            
                                                        <label>
                                                            <g:if test="${facturaInstance?.documentoPdf == false}">
                                                                <input name="archivoPdf" class="ace ace-checkbox-2" type="checkbox" /> 
                                                            </g:if>
                                                            <g:else>
                                                                <input name="archivoPdf" class="ace ace-checkbox-2" type="checkbox" checked/>     
                                                            </g:else>    
                                                            <span class="lbl"> Pdf</span>
                                                        </label>                                                    
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="span2">
                                                <div class="control-group">
                                                    <label class="control-label"></label>

                                                    <div class="controls">                                                                                                                                                               
                                                        <label>
                                                            <g:if test="${facturaInstance?.documentoXml == false}">
                                                                <input name="archivoXml" class="ace ace-checkbox-2" type="checkbox" />
                                                            </g:if>
                                                            <g:else>
                                                                <input name="archivoXml" class="ace ace-checkbox-2" type="checkbox" checked/>
                                                            </g:else>
                                                            <span class="lbl"> Xml</span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR">
                                                <div class="form-actions">
                                                    <g:if test="${ocultarBoton != true}">
                                                        <g:submitButton name="create" class="btn btn-small btn-primary" value="${message(code: 'default.button.label', default: 'Guardar')}" />
                                                    </g:if>
                                                </div>
                                            </sec:ifAnyGranted> 
                                        </g:form>     
                                    </div>
                                    <g:if test="${facturaInstance?.fechaDePago}"> 
                                        <table class="table table-bordered table-striped" border="2">
                                        <thead>
                                            <tr>
                                                <th colspan="2"><g:message code="factura.fechaDePago.label" default="Pago Autorizado" /></th>                            
                                            </tr>                            
                                        </thead>
                                        <tbody>                            
                                            <tr>
                                                <td style="text-align:center" width="40%">
                                                    Fecha de Pago
                                                </td>
                                                <td style="text-align:center" width="60%">
                                                    <div class=" btn-small btn-info">                                                            
                                                        <g:formatDate date="${facturaInstance?.fechaDePago}" />
                                                    </div>
                                                </td>                        
                                            </tr>
                                            <tr>
                                                <td style="text-align:center" width="40%">
                                                    Número de Cesta
                                                </td>
                                                <td style="text-align:center" width="60%">
                                                    <div class=" btn-small btn-info">                                                            
                                                        ${facturaInstance?.numeroDeCesta}
                                                    </div>
                                                </td>                        
                                            </tr>
                                        </tbody>
                                        </table>
                                    </g:if>                                    
                                </div>
                                <div id="agregarFecha" class="modal hide" style="width:600px;">
                                    <div class="modal-header">
                                        <button data-dismiss="modal" class="close" type="button">×</button>
                                        <h3>Agregar Fecha de Pago</h3>
                                    </div>
                                    <div class="modal-body">
                                        <g:form name="myForm" class="form-horizontal" controller="factura" action="agregarFechaDePago" method="post">                                            
                                            <g:hiddenField name="factura.id" value="${facturaInstance?.id}" />                                            
                                            <g:hiddenField name="version" value="${facturaInstance?.version}" />
                                            <g:render template="/factura/fechaDePagoForm" bean="${factura}"/>            
                                            <div class="form-actions">
                                                <g:actionSubmit class="btn btn-primary" action="saveFecha" value="${message(code: 'default.button.label', default: 'Enviar')}" />
                                            </div>
                                        </g:form>
                                    </div>
                                </div>
                                <div id="comentarioDeRechazo" class="modal hide" style="width:600px;">
                                    <div class="modal-header">
                                        <button data-dismiss="modal" class="close" type="button">×</button>
                                        <h3>Motivos</h3>
                                    </div>
                                    <div class="modal-body">
                                        <g:form class="form-horizontal" controller="factura" action="agregarFechaDePago" method="post">                                            
                                            <g:hiddenField name="factura.id" value="${facturaInstance?.id}" />                                            
                                            <g:hiddenField name="version" value="${facturaInstance?.version}" />
                                            <g:render template="/factura/comentarioDeRechazo" bean="${factura}"/>            
                                            <div class="form-actions">
                                                <g:actionSubmit class="btn btn-primary" action="saveComentario" value="${message(code: 'default.button.label', default: 'Enviar')}" />
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
