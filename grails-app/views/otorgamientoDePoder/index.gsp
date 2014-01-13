
<%@ page import="com.app.sgpod.OtorgamientoDePoder" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainPoderes">
		<g:set var="entityName" value="${message(code: 'otorgamientoDePoder.label', default: 'Otorgamiento De Poder')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-poder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-poder" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
						<g:sortableColumn property="id" title="${message(code: 'otorgamientoDePoder.id.label', default: 'Númeo de Folio')}" />
						<g:sortableColumn property="registroDeLaSolicitud" title="${message(code: 'otorgamientoDePoder.registroDeLaSolicitud.label', default: 'Registro De La Solicitud')}" />
						<g:sortableColumn property="puesto" title="${message(code: 'otorgamientoDePoder.puesto.label', default: 'Puesto')}" />
						<g:sortableColumn property="contrato" title="${message(code: 'otorgamientoDePoder.contrato.label', default: 'Contrato')}" />
                                                <g:sortableColumn property="tipoDePoder" title="${message(code: 'otorgamientoDePoder.tipoDePoder.label', default: 'Tipo De Poder')}" />					
						<g:sortableColumn property="delegacion" title="${message(code: 'otorgamientoDePoder.delegacion.label', default: 'Delegacion')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${otorgamientoDePoderInstanceList}" status="i" var="otorgamientoDePoderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">					
						<td><g:link action="show" id="${otorgamientoDePoderInstance.id}">${fieldValue(bean: otorgamientoDePoderInstance, field: "id")}</g:link></td>					
						<td><g:formatDate date="${otorgamientoDePoderInstance.registroDeLaSolicitud}" /></td>							
						<td>${fieldValue(bean: otorgamientoDePoderInstance, field: "puesto")}</td>
						<td>${fieldValue(bean: otorgamientoDePoderInstance, field: "contrato")}</td>
                                                <td>${fieldValue(bean: otorgamientoDePoderInstance, field: "tipoDePoder")}</td>
						<td>${fieldValue(bean: otorgamientoDePoderInstance, field: "delegacion")}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${otorgamientoDePoderInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
