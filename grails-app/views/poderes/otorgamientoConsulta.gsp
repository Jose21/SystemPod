
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Consulta Otorgamiento')}" />    
        <title>Consulta de Otorgamiento</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Consulta de Otorgamiento de Poderes</h1>
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
                <li class="${porFechaOtorgamientoActive?:""}">
                    <a data-toggle="tab" href="#porFechaOtorgamiento">
                        <i class="icon-calendar bigger-130"></i>
                        <span class="bigger-110">Fecha de Otorgamiento <span class="badge"></span></span>
                    </a>
                </li>
                <li class="${porEscrituraPublicaActive?:""}">
                    <a data-toggle="tab" href="#porEscrituraPublica">
                        <i class="icon-calendar bigger-130"></i>
                        <span class="bigger-110">Número de Escritura Pública <span class="badge"></span></span>
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
                                    <g:message code="otorgamientoDePoder.apoderados.nombre.label" default="Nombre" />
                                </label>
                                <g:textField name="nombre" required="" value="${otorgamientoDePoderInstance?.nombre}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarNombreApoderado" value="Buscar" />
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
                                    <g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" />
                                </label>
                                <g:select id="delegacion" name="nombre" from="${com.app.sgpod.Delegacion.list(sort:'nombre')}" optionKey="nombre" required="" value="${delegacionInstance?.nombre}" noSelection="['':'-Elige Delegación-']" class="many-to-one"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorDelegacion" value="Buscar" />            
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>        
        <div id="porFechaOtorgamiento" class="tab-pane ${porFechaOtorgamientoActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porFechaOtorgamiento"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <span class="add-on">
                                    <i class="icon-calendar"></i>
                                </span>
                                <input class="span5" type="text" name="rangoDeFechaOtorgamiento" id="rangoDeFechaOtorgamiento" value="${rangoDeFechaOtorgamiento?rangoDeFechaOtorgamiento:""}" readonly="true" />
                                <g:actionSubmit class="btn btn-primary" action="buscarPorFechaOtorgamiento" value="Buscar" />
                            </div>
                        </div>
                    </g:form>
                </div>
            </div><!--/.message-container-->
        </div>
        <div id="porEscrituraPublica" class="tab-pane ${porEscrituraPublicaActive?:""}">  
            <div class="message-container">
                <div id="id-message-list-navbar" class="message-navbar align-center clearfix">
                    <div class="message-bar">
                    </div>
                    <g:form method="post">
                        <g:hiddenField name="inActive" value="porEscrituraPublica"/>
                        <div class="control-group">
                            <div class="row-fluid input-prepend">
                                <label for="escrituraPublica" class="control-label">
                                    <g:message code="otorgamientoDePoder.escrituraPublica.label" default="Número" />
                                </label>
                                <g:textField name="escrituraPublica" required="" value="${otorgamientoDePoderInstance?.escrituraPublica}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorEscrituraPublica" value="Buscar" />
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
                                    <g:message code="otorgamientoDePoder.tags.label" default="Palabra Clave" />
                                </label>
                                <g:textField name="tags" required="" value="${otorgamientoDePoderInstance?.tags}"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorTags" value="Buscar" />
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
                                    <g:message code="otorgamientoDePoder.notarioCorrespondiente.label" default="Notario" />
                                </label>
                                <g:select id="notario.id" name="id" from="${session.notarios}" optionKey="id" required="" value="${id}" noSelection="['':'-Elige Notario-']" class="many-to-one"/>
                                <g:actionSubmit class="btn btn-primary" action="buscarPorNotario" value="Buscar" />            
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
                                <g:actionSubmit class="btn btn-primary" action="buscarPorStatus" value="Buscar" />            
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
                                    <g:message code="otorgamientoDePoder.notarioCorrespondiente.label" default="Busqueda Total" />
                                </label>                                
                                <g:actionSubmit class="btn btn-primary" action="registrosTotales" value="Generar" />            
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
                        <th colspan="9"  style="text-align:center;font-size:16px">Resultado para la búsqueda por Nombre del Apoderado: " ${params.nombre} "</th>
                    </tr>
                </g:if>
                <g:if test="${params.delegacion}">
                    <tr>
                        <th colspan="9" style="text-align:center;font-size:16px">Resultado para la búsqueda por Delegación: " ${params.delegacion.nombre} "</br></br></th>
                    </tr>
                </g:if>                
                <g:if test="${rangoDeFechaRegistro}">
                    <tr>
                        <th colspan="9" style="text-align:center;font-size:16px">Resultado para la búsqueda por Fecha de Registro: " ${rangoDeFechaRegistro} "</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.escrituraPublica}">
                    <tr>
                        <th colspan="10" style="text-align:center;font-size:16px">Resultado para la búsqueda por Número de Escritura Pública: " ${params.escrituraPublica} "</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${params.tags}">
                    <tr>
                        <th colspan="10" style="text-align:center;font-size:16px">Resultado para la(s) palabra(s) clave: " ${params.tags} "</br></br></th>
                    </tr>
                </g:if>
                <g:if test="${nombreNotario}">
                    <tr>
                        <th colspan="10" style="text-align:center;font-size:16px">Resultado por el Notario: " ${nombreNotario} "</br></br></th>
                    </tr>
                </g:if>
                <tr>
                    <th><g:message code="otorgamientoDePoder.id.label"  default="Folio" /></th>                
                    <th><g:message code="otorgamientoDePoder.apoderados.nombre.label" default="Nombre Apoderado(s)" /></th>                
                    <th><g:message code="otorgamientoDePoder.escrituraPublica.label" default="Escritura Pública" /></th>                
                    <th><g:message code="otorgamientoDePoder.registroDeLaSolicitud.label" default="Fecha de Solicitud" /></th> 
                    <th><g:message code="otorgamientoDePoder.fechaDeOtorgamiento.label" default="Fecha de Otorgamiento" /></th>                
                    <th><g:message code="otorgamientoDePoder.categoriaDeTipoDePoder.tipoDePoder.label" default="Tipo De Poder" /></th>
                    <th><g:message code="otorgamientoDePoder.categoriaDeTipoDePoder.label" default="Categoria" /></th>
                    <th><g:message code="otorgamientoDePoder.delegacion.label" default="Delegación" />
                    <th><g:message code="otorgamientoDePoder.apoderados.statusDePoder.label" default="Estatus" />
                </tr>
            </thead>
            <tbody>
                <g:each in="${otorgamientoDePoderInstanceList}" status="i" var="otorgamientoDePoderInstance">
                    <g:each in ="${otorgamientoDePoderInstance.apoderados}" var="apoderado">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td style="text-align:center">
                                <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoDePoderInstance.id}">
                                    <span class="badge">${otorgamientoDePoderInstance?.id}-O</span></g:link>
                                </td>  
                                <td>
                                <g:if test="${otorgamientoDePoderInstance.totalApoderados == 0}">
                                    ${apoderado.nombre}  
                                </g:if>
                                <g:else>
                                    ${apoderado.nombre} y ${fieldValue(bean: otorgamientoDePoderInstance, field: "totalApoderados")} más.
                                </g:else>
                            </td>
                            <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "escrituraPublica")}</td>
                            <td><g:formatDate date="${otorgamientoDePoderInstance.registroDeLaSolicitud}" /></td>
                            <td align="center"><g:formatDate format="dd-MMM-yyyy" date="${otorgamientoDePoderInstance.fechaDeOtorgamiento}" /></td>
                            <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "tipoDePoder")}</td>
                            <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "categoriaDeTipoDePoder")}</td>
                            <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "delegacion")}</td>
                            <td>${fieldValue(bean: apoderado, field: "statusDePoder")}</td>
                        </tr>
                    </g:each>
                </g:each>
            </tbody>
        </table>
        <div class="message-footer clearfix">
            <div class="pull-left"> ${otorgamientoDePoderInstanceTotal?:0} resultado(s) en total. </div>
        </div>
        <g:if test="${otorgamientoDePoderInstanceTotal}">
            <export:formats formats="['excel', 'pdf']" action="generarReporteOtorgamiento"/>
        </g:if>
    </div>
</body>
</html>
