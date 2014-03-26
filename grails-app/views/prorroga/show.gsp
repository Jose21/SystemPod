
<%@ page import="com.app.sgpod.Prorroga" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'prorroga.label', default: 'Prorroga')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
                                    <table style="width: 100%;border-collapse: collapse" border="1">
                                        <tr>
                                            <td style="width:50%">
                                                <table style="width: 100%;border-collapse: collapse" border="1">
                                                    <tr>
                                                        <td style="width:50%">
                                                            <h4 class="lighter"><i class="icon-calendar"></i> Prorroga </h4>
                                                        </td>
                                                        <td style="width:50%">
                                                            <g:if test="${otorgamientoDePoderInstance?.id}">                                                                                                                                                              
                                                                <span>Asociada a la Solicitud   </span>                                                                
                                                                <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoDePoderInstance?.id}">
                                                                    <span class="label label-success arrowed-in">
                                                                        ${otorgamientoDePoderInstance?.id}-O
                                                                    </span>
                                                                </g:link>                                                                                              
                                                            </g:if>
                                                            <g:if test="${revocacionDePoderInstance?.id}">                                                                                                                                                              
                                                                <span>Asociada a la Solicitud   </span>                                                                
                                                                <g:link controller="revocacionDePoder" action="show" id="${revocacionDePoderInstance?.id}">
                                                                    <span class="label label-success arrowed-in">
                                                                        ${revocacionDePoderInstance?.id}-R
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

                                            <g:if test="${prorrogaInstance?.titulo}">
                                                <dl>
                                                    <dt><g:message code="prorroga.titulo.label" default="Título " /></dt>
                                                    <dd><g:fieldValue bean="${prorrogaInstance}" field="titulo"/></dd>
                                                </dl>
                                            </g:if>
                                            <g:if test="${prorrogaInstance?.motivos}">
                                                <dl>
                                                    <dt><g:message code="prorroga.motivos.label" default="Motivos" /></dt>
                                                    <dd><g:fieldValue bean="${prorrogaInstance}" field="motivos"/></dd>
                                                </dl>
                                            </g:if>
                                            <g:if test="${prorrogaInstance?.fechaProrroga}">
                                                <dl>
                                                    <dt><g:message code="prorroga.fechaProrroga.label" default="Fecha Limite" /></dt>
                                                    <dd><g:formatDate date="${prorrogaInstance?.fechaProrroga}" /></dd>
                                                </dl>
                                            </g:if>
                                            <g:if test="${prorrogaInstance?.creadoPor}">
                                                <dl>
                                                    <dt><g:message code="prorroga.creadoPor.label" default="Creado Por" /></dt>
                                                    <dd><g:fieldValue bean="${prorrogaInstance}" field="creadoPor"/></dd>
                                                </dl>
                                            </g:if>
                                            <g:if test="${prorrogaInstance?.fechaDeEnvio}">
                                                <dl>
                                                    <dt><g:message code="prorroga.fechaDeEnvio.label" default="Fecha De Envío" /></dt>
                                                    <dd><g:formatDate date="${prorrogaInstance?.fechaDeEnvio}" /></dd>
                                                </dl>
                                            </g:if>                                            
                                        </div>                          
                                    </div>
                                </div>                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>            
        </div>
        <div class="container-fluid">
            <!--g:form class="form-actions"-->
                <!--fieldset class="buttons">
                    <g:hiddenField name="id" value="${prorrogaInstance?.id}" />
                    <g:link class="btn btn-primary" action="edit" id="${prorrogaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset-->
            <!--/g:form-->          
        </div>
    </body>
</html>
