
<%@ page import="com.app.sgcon.Convenio" %>

<html>
    <head>
        <meta name="layout" content="mainConvenios">
        <title>Reporte: Convenios Por Rango De Fecha</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Reporte: Convenios Por Rango De Fecha</h1>      
        </div>
        <div class="container-fluid">
            <br/>
            <g:render template="/shared/alerts" />
            <g:form method="POST">
                <label for="objeto" class="control-label">
                    Rango de Fechas:
                </label>
                <div class="control-group">
                    <div class="row-fluid input-prepend">
                        <span class="add-on">
                            <i class="icon-calendar"></i>
                        </span>
                        <input class="span5" type="text" name="rangoDeFecha" id="rangoDeFecha" value="${rangoDeFecha?:""}" readonly="true" />
                        <g:actionSubmit class="btn btn-primary" action="conveniosPorFecha" value="Buscar" />
                    </div>
                </div>
            </g:form>
            <br/>
            <div class="container-fluid">      
                <g:form name="formConvenios" action="conveniosPorFecha" method="POST">
                    <g:hiddenField name="barraConvenios" value=""/>
                    <g:hiddenField name="rangoDeFecha" value="${rangoDeFecha?:""}"/>
                    <div id="containerTotalDeConvenios" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                </g:form>
                <table class="table table-bordered table-striped">
                    <thead>                
                    <br>
                    <tr>
                        <th><g:message code="convenio.id.label"  default="Identificador interno" /></th>                        
                        <th><g:message code="convenio.objeto.label" default="Objeto" /></th>
                        <th><g:message code="convenio.dateCreated.label" default="Fecha de Registro" /></th>
                        <th><g:message code="convenio.responsables.label" default="Responsables" /></th>
                        <th><g:message code="convenio.firmantes.label" default="Firmantes" /></th>
                        <th><g:message code="convenio.fechaDeFirma.label" default="Fecha De Firma" />
                        <th><g:message code="convenio.status.label" default="Status" /></th>
                    </tr>
                    </thead>
                    <tbody>
                        <g:if test="${conveniosPorFechaBean?.convenios}">
                            <tr><th colspan="8">CONVENIOS</th></tr>
                                    <g:each in="${conveniosPorFechaBean.convenios}" status="i" var="convenios">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td style="text-align:center"><g:link controller="convenio" action="show" id="${convenios.id}"><span class="badge">${convenios?.id}</span></g:link></td>                                    
                                    <td>${fieldValue(bean: convenios, field: "objeto")}</td>
                                    <td><g:formatDate date="${convenios?.dateCreated}" /></td>
                                    <td>
                                        <g:each in ="${convenios.responsables}" var="responsable">
                                            ${responsable.nombre}
                                            <br>
                                        </g:each>
                                    </td>
                                    <td>
                                        <g:each in ="${convenios.firmantes}" var="firmante">
                                            ${firmante.nombre}
                                            <br>
                                        </g:each>
                                    </td>
                                    <td><g:formatDate date="${convenios.fechaDeFirma}" /></td>
                                    <td>${fieldValue(bean: convenios, field: "status")}</td>
                                </tr>
                            </g:each>
                        </g:if>
                        <g:if test="${conveniosPorFechaBean?.conveniosContraidos}">
                            <tr><th colspan="8">CONTRAIDOS POR EL INFONAVIT</th></tr>
                                    <g:each in="${conveniosPorFechaBean.conveniosContraidos}" status="i" var="conveniosContraidos">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td style="text-align:center"><g:link controller="convenio" action="show" id="${conveniosContraidos.id}"><span class="badge">${conveniosContraidos?.id}</span></g:link></td>                                    
                                    <td>${fieldValue(bean: conveniosContraidos, field: "objeto")}</td>
                                    <td><g:formatDate date="${conveniosContraidos.dateCreated}" /></td>
                                    <td>
                                        <g:each in ="${conveniosContraidos.responsables}" var="responsable">
                                            ${responsable.nombre}
                                            <br>
                                        </g:each>
                                    </td>
                                    <td>
                                        <g:each in ="${conveniosContraidos.firmantes}" var="firmante">
                                            ${firmante.nombre}
                                            <br>
                                        </g:each>
                                    </td>
                                    <td><g:formatDate date="${conveniosContraidos.fechaDeFirma}" /></td>
                                    <td>${fieldValue(bean: conveniosContraidos, field: "status")}</td>
                                </tr>
                            </g:each>
                        </g:if>
                        <g:if test="${conveniosPorFechaBean?.conveniosNoContraidos}">
                            <tr><th colspan="8">CONTRAIDOS POR OTRAS DEPENDENCIAS</th></tr>
                                    <g:each in="${conveniosPorFechaBean.conveniosNoContraidos}" status="i" var="conveniosNoContraidos">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                    <td style="text-align:center"><g:link controller="convenio" action="show" id="${conveniosNoContraidos.id}"><span class="badge">${conveniosNoContraidos?.id}</span></g:link></td>                                    
                                    <td>${fieldValue(bean: conveniosNoContraidos, field: "objeto")}</td>
                                    <td><g:formatDate date="${conveniosNoContraidos.dateCreated}" /></td>
                                    <td>
                                        <g:each in ="${conveniosNoContraidos.responsables}" var="responsable">
                                            ${responsable.nombre}
                                            <br>
                                        </g:each>
                                    </td>
                                    <td>
                                        <g:each in ="${conveniosNoContraidos.firmantes}" var="firmante">
                                            ${firmante.nombre}
                                            <br>
                                        </g:each>
                                    </td>
                                    <td><g:formatDate date="${conveniosNoContraidos.fechaDeFirma}" /></td>
                                    <td>${fieldValue(bean: conveniosNoContraidos, field: "status")}</td>
                                </tr>
                            </g:each>
                        </g:if>
                    </tbody>
                </table>
            </div>
        </div>    
    </body>  
</html>
