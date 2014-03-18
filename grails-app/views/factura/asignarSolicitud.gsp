<%@ page import="com.app.sgpod.Factura" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'factura.label', default: 'Asignar Solicitud')}" />        
    </head>
    <body>
        <div class="page-content">
            <g:render template="/shared/alerts" />
            <div class="row">
                <div class="col-xs-12">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="widget-box">
                                <div class="widget-header widget-header-blue widget-header-flat">
                                    <h4 class="lighter"><i class="icon-file-text"></i> Seleccione las solicitudes pertenecientes a la factura actual </h4>                                    
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">                                        
                                        <div class="modal-footer wizard-actions col-xs-12"> 
                                            <g:form class="form-horizontal" controller="factura" method="post">            
                                                <table class="table table-bordered table-striped">
                                                    <thead>
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
                                                                <td style="text-align:center"><g:checkBox id="${otorgamientoInstance.id}" name="otorgamientoDePoderList" value="${otorgamientoInstance.id}" checked="false"/></td>
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
                                                                <td style="text-align:center"><g:checkBox id="${revocacionInstance.id}" name="revocacionDePoderList" value="${revocacionInstance.id}" checked="false"/></td>
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
                                                        <tr>
                                                            <td colspan="5" style="text-align:right">                                                                                                                                                                                                   
                                                                <g:hiddenField name="facturaInstance.id" value="${facturaInstance?.id}" />                                                                
                                                                <g:actionSubmit class="btn btn-success btn-btn" action="asignarFactura" value="Asignar" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                                            </td>
                                                        </tr>                            
                                                    </tbody>
                                                </table>
                                            </g:form>
                                        </div>
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

