
<%@ page import="com.app.sgpod.Factura" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>        
        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>
            <br/>
            <div class="tabbable">
                <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                    <li class="active">
                        <a data-toggle="tab" href="#folio">
                            <i class="icon-group bigger-130"></i>
                            <span class="bigger-110">Número de Folio <span class="badge"></span></span>
                        </a>
                    </li>                    
                </ul>
            </div>
            <div class="tab-content no-border no-padding">
                <div id="folio" class="tab-pane in active">  
                    <div class="message-container">
                        <div id="id-message-list-navbar" class="message-navbar align-center clearfix">                                                     
                            <g:form method="post">                                
                                <div class="control-group">
                                    <div class="row-fluid input-prepend">
                                        <label for="folio" class="control-label">
                                            <g:message code="factura.id.label" default="Folio" />
                                        </label>
                                        <g:textField name="id" required="" value="${facturaInstance?.id}"/>
                                        <g:actionSubmit class="btn btn-primary" action="buscarPorId" value="Buscar" />
                                    </div>
                                </div>
                            </g:form>
                        </div>
                    </div><!--/.message-container-->
                </div>
                <div class="widget-content nopadding">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <g:if test="${params.id}">
                                <tr>
                                    <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR FOLIO: " ${params.id} "</th>
                                </tr>
                            </g:if>                            
                            <tr>
                                <th><g:message code="factura.id.label"  default="Número de Folio" /></th>
                                <th><g:message code="factura.creadaPor.nombre.label" default="Creada Por" /></th>                                
                                <th><g:message code="factura.fechaDeEnvio.label" default="Fecha de Envio" /></th>                
                                <th><g:message code="factura.fechaDePago.label" default="Fecha De Pago" /></th>
                                <th><g:message code="factura.numeroDeCesta.label" default="Número de Cesta" /></th>                                
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${facturasList}" status="i" var="facturaInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td style="text-align:center"><g:link controller="factura" action="show" id="${facturaInstance.id}"><span class="badge">${facturaInstance?.id}-O</span></g:link></td>                                                                
                                    <td>${fieldValue(bean: facturaInstance, field: "creadaPor")}</td>
                                    <td><g:formatDate date="${facturaInstance.fechaDeEnvio}" /></td>
                                    <td><g:formatDate date="${facturaInstance.fechaDePago}" /></td>                                    
                                    <td>${fieldValue(bean: facturaInstance, field: "numeroDeCesta")}</td>                                    
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                    <div class="message-footer clearfix">
                        <div class="pull-left"> ${facturasListInstanceTotal?:0} resultado(s) en total. </div>
                    </div>
                </div>                        
            </div>            
        </div>
    </body>
</html>
