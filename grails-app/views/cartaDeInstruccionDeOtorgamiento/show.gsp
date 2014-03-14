
<%@ page import="com.app.sgpod.CartaDeInstruccionDeOtorgamiento" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="page-header position-relative">            
            <div class="btn-group">                                
                <g:link class="btn btn-success btn-small tip-bottom" action="imprimir" id="${cartaDeInstruccionDeOtorgamientoInstance?.id}" target="_blank">
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
                                        <g:render template="/cartaDeInstruccionDeOtorgamiento/carta" />
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
                    <g:hiddenField name="id" value="${cartaDeInstruccionDeOtorgamientoInstance?.id}" />
                    <g:hiddenField name="otorgamientoDePoder" value="${otorgamientoDePoderInstance?.id}"/>
                    <g:link class="btn btn-primary" action="edit" id="${cartaDeInstruccionDeOtorgamientoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                </fieldset-->
            <!--/g:form-->
            <div class="form-actions">
                <g:link class="btn btn-primary btn-mini" action="regresar" id="${cartaDeInstruccionDeOtorgamientoInstance?.id}">Regresar</g:link>
                </div>
            </div>
        </body>
    </html>
