<%@ page import="com.app.sgpod.ConfigurarParametro" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <g:set var="entityName" value="${message(code: 'configurarParametro.label', default: 'ConfigurarParametro')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>        
        <div class="container-fluid">
            <br/>
            <g:if test="${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> ${flash.message}
                </div>
            </g:if>

            <g:hasErrors bean="${configurarParametroInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${configurarParametroInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                </ul>
            </g:hasErrors>
            <div class="row">
                <div class="col-xs-12">
                    <div class="row-fluid">
                        <div class="span12">
                            <div class="widget-box">
                                <div class="widget-header widget-header-blue widget-header-flat">
                                    <h4 class="lighter"><i class="icon-cogs"></i> Configuración de Parametros</h4>
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main" >

                                        <g:form class="form-horizontal" method="post" >
                                            <g:hiddenField name="id" value="${configurarParametroInstance?.id}" />
                                            <g:hiddenField name="version" value="${configurarParametroInstance?.version}" />
                                            <g:render template="form"/>
                                            <div class="form-actions">
                                                <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                                <!--g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /-->
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
