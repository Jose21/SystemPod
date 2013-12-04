<!--
  To change this license header, choose License Headers in Project Properties.
  To change this template file, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainConvenios">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte: Total De Convenios</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>Reporte: Total De Convenios</h1>      
        </div>
        <div class="container-fluid">
            <div class="container-fluid">      
                <g:form name="formConvenios" action="totalDeConvenios" method="POST">
                    <g:hiddenField name="barraConvenios" value=""/>
                    <div id="containerTotalDeConvenios" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
                </g:form>
            </div>
            <table class="table table-bordered table-striped">
                <thead>                
                <br>
                <tr>
                    <th><g:message code="convenio.id.label"  default="Identificador interno" /></th>
                    <th><g:message code="convenio.numeroDeConvenio.label" default="Número de Convenio" /></th>
                    <th><g:message code="convenio.objeto.label" default="Objeto" /></th>
                    <th><g:message code="convenio.dateCreated.label" default="Fecha de Registro" /></th>
                    <th><g:message code="convenio.responsables.label" default="Responsables" /></th>
                    <th><g:message code="convenio.firmantes.label" default="Firmantes" /></th>
                    <th><g:message code="convenio.fechaDeFirma.label" default="Fecha De Firma" />
                    <th><g:message code="convenio.status.label" default="Status" /></th>
                </tr>
                </thead>
                <tbody>
                    <g:if test="${conveniosPorFechaBean.convenios}">
                        <tr><th colspan="8">CONVENIOS</th></tr>
                                <g:each in="${conveniosPorFechaBean.convenios}" status="i" var="convenios">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="convenio" action="edit" id="${convenios.id}"><span class="badge">${convenios?.id}</span></g:link></td>
                                <td>${fieldValue(bean: convenios, field: "numeroDeConvenio")}</td>
                                <td>${fieldValue(bean: convenios, field: "objeto")}</td>
                                <td><g:formatDate date="${convenios.dateCreated}" /></td>
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
                    <g:if test="${conveniosPorFechaBean.conveniosContraidos}">
                        <tr><th colspan="8">CONTRAIDOS POR LA INSTITUCION</th></tr>
                                <g:each in="${conveniosPorFechaBean.conveniosContraidos}" status="i" var="conveniosContraidos">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="convenio" action="edit" id="${conveniosContraidos.id}"><span class="badge">${conveniosContraidos?.id}</span></g:link></td>
                                <td>${fieldValue(bean: conveniosContraidos, field: "numeroDeConvenio")}</td>
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
                    <g:if test="${conveniosPorFechaBean.conveniosNoContraidos}">
                        <tr><th colspan="8">CONTRAIDOS POR OTRAS DEPENDENCIAS</th></tr>
                                <g:each in="${conveniosPorFechaBean.conveniosNoContraidos}" status="i" var="conveniosNoContraidos">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td style="text-align:center"><g:link controller="convenio" action="edit" id="${conveniosNoContraidos.id}"><span class="badge">${conveniosNoContraidos?.id}</span></g:link></td>
                                <td>${fieldValue(bean: conveniosNoContraidos, field: "numeroDeConvenio")}</td>
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
    </body>  
</html>

