<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Consulta Revocación')}" />    
        <title>Consulta de Revocación</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Consulta de Revocación de Poderes</h1>
        </div><!--/.page-header-->
    <r:require module="export"/> 
    <div class="container-fluid">      
        <g:render template="/shared/alerts" />
        <br/>
        <div class="tabbable">
            <ul id="inbox-tabs" class="inbox-tabs nav nav-tabs padding-16 tab-size-bigger tab-space-1">
                <li class="${nombreApoderadoActive?:""}">
                    <a data-toggle="tab" href="#nombreApoderado">
                        <i class="icon-group bigger-130"></i>
                        <span class="bigger-110">Nombre del Apoderado <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porDelegacionActive?:""}">
                    <a data-toggle="tab" href="#porDelegacion">
                        <i class="icon-home bigger-130"></i>
                        <span class="bigger-110">Delegación<span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porNumeroEscrituraActive?:""}">
                    <a data-toggle="tab" href="#porNumeroEscritura">
                        <i class="icon-legal bigger-130"></i>
                        <span class="bigger-110">Número de Escritura Pública <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porFechaRevocacionActive?:""}">
                    <a data-toggle="tab" href="#porFechaRevocacion">
                        <i class="icon-calendar bigger-130"></i>
                        <span class="bigger-110">Fecha de Revocación<span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porTagsActive?:""}">
                    <a data-toggle="tab" href="#porTags">              
                        <i class="icon-tag bigger-130"></i>
                        <span class="bigger-110">Palabras Clave<span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porNotarioActive?:""}">
                    <a data-toggle="tab" href="#porNotario">              
                        <i class="icon-suitcase bigger-130"></i>
                        <span class="bigger-110">Notario<span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porStatusActive?:""}">
                    <a data-toggle="tab" href="#porStatus">              
                        <i class="icon-list bigger-130"></i>
                        <span class="bigger-110">Estatus<span class="badge"></span></span>
                    </a>
                </li>
                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_GESTOR, ROLE_PODERES_ENLACE">
                    <li class="${registrosTotalesActive?:""}">
                        <a data-toggle="tab" href="#registrosTotales">              
                            <i class="icon-file bigger-130"></i>
                            <span class="bigger-110">Descarga<span class="badge"></span></span>
                        </a>
                    </li>
                </sec:ifAnyGranted>
            </ul>
        </div>
    </div>
    <div class="tab-content no-border no-padding">
        <div id="nombreApoderado" class="tab-pane ${nombreApoderadoActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="nombreApoderado"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="nombre" class="control-label">
                                    <g:message code="revocacionDePoder.apoderados.nombre.label" default="Nombre" />
                                </label>
                                <g:textField name="nombre" required="" value="${revocacionDePoderInstance?.nombre}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarNombreApoderadoRevocacion" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porDelegacion" class="tab-pane ${porDelegacionActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porDelegacion"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="delegacion" class="control-label">
                                    <g:message code="revocacionDePoder.delegacion.label" default="Delegación" />
                                </label>
                                <g:select id="delegacion" name="nombre" from="${com.app.sgpod.Delegacion.list(sort:'nombre')}" optionKey="nombre" required="" value="${delegacionInstance?.nombre}" noSelection="['':'-Elige Delegación-']" class="many-to-one"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorDelegacionRevocacion" value="Buscar" />
                            </div>                            
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porNumeroEscritura" class="tab-pane ${porNumeroEscrituraActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porNumeroEscritura"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="escrituraPublicaRevocacion" class="control-label">
                                    <g:message code="revocacionDePoder.escrituraPublicaRevocacion.label" default="Número de Escritura:" />
                                </label>
                                <g:textField name="escrituraPublica" required="" value="${revocacionDePoderInstance?.escrituraPublicaRevocacion}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorNumeroEscrituraRevocacion" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porFechaRevocacion" class="tab-pane ${porFechaRevocacionActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porFechaRevocacion"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                                <input class="span5" type="text" name="rangoDeFechaRevocacion" id="rangoDeFechaRevocacion" value="${rangoDeFechaRevocacion?rangoDeFechaRevocacion:""}" readonly="true" />
                                <g:actionSubmit class="btn btn-primary" action="buscarPorFechaRevocacion" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porTags" class="tab-pane ${porTagsActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porTags"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="tags" class="control-label">
                                    <g:message code="revocacionDePoder.tags.label" default="Palabra Clave" />
                                </label>
                                <g:textField name="tags" required="" value="${revocacionDePoderInstance?.tags}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorTagsRevocacion" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porNotario" class="tab-pane ${porNotarioActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porNotario"/>                        
                        <div class="control-group">
                            <div class="row-fluid input-prepend">               
                                <label for="notarios" class="control-label">
                                    <g:message code="revocacionDePoder.notarioCorrespondiente.label" default="Notario" />
                                </label>
                                <g:select id="notario.id" name="id" from="${session.notarios}" optionKey="id" required="" value="${id}" noSelection="['':'-Elige Notario-']" class="many-to-one"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorNotarioRevocacion" value="Buscar" />            
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porStatus" class="tab-pane ${porStatusActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porStatus"/>                        
                        <div class="control-group">
                            <div class="row-fluid input-prepend">               
                                <label for="status" class="control-label">
                                    <g:message default="Estatus" />
                                </label>
                                <g:select  name="statusDePoder" from="${com.app.sgpod.Apoderado.constraints.statusDePoder.inList}" required="" value="${statusDePoder}" noSelection="['':'-Elige Estatus-']" class="many-to-one"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorStatusRevocacion" value="Buscar" />            
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="registrosTotales" class="tab-pane ${registrosTotalesActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="registrosTotales"/>                        
                        <div class="control-group">
                            <div class="row-fluid input-prepend">               
                                <label for="notarios" class="control-label">
                                    <g:message code="revocacionDePoder.label" default="Busqueda Total" />
                                </label>                                
                                <g:actionSubmit class="btn btn-primary" action="registrosTotalesRevocacion" value="Generar" />            
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <table class="table table-bordered table-striped">
            <thead>
                <g:if test="${params.nombre}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NOMBRE DEL APODERADO: " ${params.nombre} "</th>
                    </tr>
                </g:if>
                <g:if test="${params.delegacion}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR DELEGACIÓN: " ${params.delegacion} "</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.escrituraPublica}">
                    <tr>
                        <th colspan="8"  style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR NÚMERO DE ESCRITURA: " ${params.escrituraPublica} "</th>
                    </tr>
                </g:if>
                <g:if test="${params.rangoDeFechaRevocacion}">
                    <tr>
                        <th colspan="8" style="text-align:center;font-size:16px">RESULTADO PARA LA BúSQUEDA POR FECHA DE REGISTRO: " ${params.rangoDeFechaRevocacion} "</br></br></th>
                    </tr>
                </g:if> 
                <g:if test="${params.tags}">
                    <tr>
                        <th colspan="10" style="text-align:center;font-size:16px">RESULTADO PARA LA PALABRA: " ${params.tags} "</br></br></th>
                    </tr>
                </g:if>
                <tr>
                    <th><g:message code="revocacionDePoder.id.label"  default="Número de Folio" /></th>
                    <th><g:message code="revocacionDePoder.nombre.label" default="Apoderados a quien se Revoca el Poder" /></th>                    
                    <th><g:message code="revocacionDePoder.escrituraPublicaRevocacion.label" default="Escritura Publica" /></th>                    
                    <th><g:message code="revocacionDePoder.fechaDeRevocacion.label" default="Fecha de Revocación" /></th>
                    <th><g:message code="revocacionDePoder.delegacion.label" default="Delegación" />
                    <th><g:message code="revocacionDePoder.apoderados.statusDePoder.label" default="Estatus" />
                </tr>
            </thead>
            <tbody>
                <g:each in="${revocacionDePoderInstanceList}" status="i" var="revocacionDePoderInstance">
                    <g:each in="${revocacionDePoderInstance.apoderados}" var="apoderado">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td style="text-align:center"><g:link controller="revocacionDePoder" action="show" id="${revocacionDePoderInstance.id}"><span class="badge">${revocacionDePoderInstance?.id}-R</span></g:link></td>                        
                                <td>
                                <g:if test="${revocacionDePoderInstance.totalApoderados == 0}">
                                    ${apoderado.nombre}  
                                </g:if>
                                <g:else>
                                    ${apoderado.nombre} y ${fieldValue(bean: revocacionDePoderInstance, field: "totalApoderados")} más.
                                </g:else>
                            </td>                      
                            <td>${fieldValue(bean: revocacionDePoderInstance, field: "escrituraPublica")}</td>                        
                            <td><g:formatDate date="${revocacionDePoderInstance.fechaDeRevocacion}" /></td>
                            <td>${fieldValue(bean: revocacionDePoderInstance, field: "delegacion")}</td>
                            <td>${fieldValue(bean: apoderado, field: "statusDePoder")}</td>
                        </tr>
                    </g:each>
                </g:each>
            </tbody>
        </table>
        <div class="message-footer clearfix">
            <div class="pull-left"> ${revocacionDePoderInstanceTotal?:0} resultado(s) en total. </div>
        </div>
        <g:if test="${revocacionDePoderInstanceTotal}">
            <export:formats formats="['excel', 'pdf']" action="generarReporteRevocacion"/>
        </g:if>
    </div>
</body>
</html>

