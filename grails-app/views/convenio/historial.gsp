
<%@ page import="com.app.sgcon.Convenio" %>
<%@ page import="com.app.sgcon.HistorialDeConvenio" %>

<html>
    <head>
        <meta name="layout" content="mainConvenios">
        <g:set var="entityName" value="${message(code: 'convenio.label', default: 'Convenio')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <!--table class="table table-bordered table-striped">
            <thead>
            <br>
            <tr>
                <th><g:message code="historialDeConvenio.id.label"  default="Identificador interno" /></th>
                <th><g:message code="historialDeConvenio.campo.label" default="Campo" /></th>
                <th><g:message code="historialDeConvenio.convenioId.label" default="Id del Convenio" /></th>
                <th><g:message code="historialDeConvenio.dateCreated.label" default="Fecha de Registro" /></th>
                <th><g:message code="historialDeConvenio.usuarioId.label" default="Usuario" /></th>
                <th><g:message code="historialDeConvenio.valorActual.label" default="Modificacion" />
                <th><g:message code="historialDeConvenio.valorAnterior.label" default="Original" /></th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${convenioInstanceList}" status="i" var="convenioInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>${fieldValue(bean: convenioInstance, field: "id")}</td>
                    <td>${fieldValue(bean: convenioInstance, field: "campo")}</td>
                    <td>${fieldValue(bean: convenioInstance, field: "convenioId")}</td>
                    <td><g:formatDate date="${convenioInstance.dateCreated}" /></td>
                    <td>${fieldValue(bean: convenioInstance, field: "usuarioId")}</td>
                    <td>${fieldValue(bean: convenioInstance, field: "valorActual")}</td>
                    <td>${fieldValue(bean: convenioInstance, field: "valorAnterior")}</td>
                </tr>
            </g:each>
        </tbody>
    </table-->
        <div id="timeline-1">
            <div class="row-fluid">
                <div class="offset1 span10">
                    <div class="timeline-container timeline-style2">
                        <div class="timeline-label">
                            <span class="label label-primary arrowed-in-right label-large">
                                <b>Historial del Convenio Numero: ${fieldValue(bean: convenioInstance, field: "id")} </b>
                            </span>
                        </div>
                        <g:each in="${convenioInstanceList}" status="i" var="convenioInstance">
                            <div class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <div class="timeline-items">
                                    <div class="timeline-item clearfix">
                                        <div class="timeline-info">
                                            <span class="timeline-date"><g:formatDate date="${convenioInstance.dateCreated}"/></span>

                                            <i class="timeline-indicator btn btn-info no-hover"></i>
                                        </div>
                                        <div class="widget-box transparent">
                                            <div class="widget-body">
                                                <div class="widget-main no-padding">${fieldValue(bean: convenioInstance, field: "accion")}</div>
                                            </div>
                                            <div class="widget-body">
                                                <g:if test="${convenioInstance.valorAnterior && convenioInstance.valorActual}">
                                                    <div class="widget-main no-padding">Campo: ${convenioInstance.campo}</div>
                                                    <div class="widget-main no-padding">Valor anterior: ${convenioInstance.valorAnterior?:""}</div>
                                                    <div class="widget-main no-padding">Valor Actual: ${convenioInstance.valorActual?:""}</div>                                                                                                                                                                  
                                                </g:if>
                                                <g:else>
                                                    <div class="widget-main no-padding">${convenioInstance.campo}</div>
                                                    <div class="widget-main no-padding">${convenioInstance.valorAnterior?:""}</div>
                                                    <div class="widget-main no-padding">${convenioInstance.valorActual?:""}</div>     
                                                </g:else>
                                            </div>                                            
                                            <div class="space-6"></div>
                                            <div class="widget-toolbox clearfix "></div>
                                        </div>
                                    </div><!--/.timeline-items-->
                                </div>
                            </div><!--/.timeline-container-->
                        </g:each>
                    </div>
                </div>
            </div>
    </body>
</html>
