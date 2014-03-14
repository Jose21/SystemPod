
<%@ page import="com.app.sgpod.CartaDeInstruccionDeRevocacion" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">            
            <div class="btn-group">                                
                <g:link class="btn btn-success btn-small tip-bottom" action="imprimir" id="${cartaDeInstruccionDeRevocacionInstance?.id}" target="_blank">
                    <i class="icon-print"></i> Imprimir
                </g:link>                
            </div>
        </div>
        <div class="container-fluid">
            <g:if test="${flash.message}">
                <br/>
                <div class="alert alert-info">
                    <strong>¡Información!</strong> ${flash.message}
                </div>
            </g:if>            
            <div class="row">
                <div class="col-xs-12">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="widget-box">
                                <div class="widget-header widget-header-blue widget-header-flat">                                    
                                    <h4 class="lighter"><i class="icon-file-text"></i> Carta de Instruccion </h4>                                                                        
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <g:render template="/cartaDeInstruccionDeRevocacion/carta" />
                                        <div class="modal-footer wizard-actions col-xs-12">                                                                                                                                    	
                                        </div>
                                    </div>
                                </div>                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--g:form class="form-actions"-->
                <!--fieldset class="buttons">
                    <g:hiddenField name="id" value="${cartaDeInstruccionDeRevocacionInstance?.id}" />
                    <g:hiddenField name="revocacionDePoder" value="${revocacionDePoderInstance?.id}"/>
                </fieldset-->
            <!--/g:form-->
            <div class="form-actions">
                <g:link class="btn btn-primary btn-mini" action="regresar" id="${cartaDeInstruccionDeRevocacionInstance?.id}">Regresar</g:link>
                </div>
            </div>
        </body>
    </html>
