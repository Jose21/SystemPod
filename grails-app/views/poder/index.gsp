
<%@ page import="com.app.sgpod.Poder" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainPoderes">
		<g:set var="entityName" value="${message(code: 'poder.label', default: 'Poder')}" />
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
					
						<g:sortableColumn property="numeroDeFolio" title="${message(code: 'poder.numeroDeFolio.label', default: 'Numero De Folio')}" />
					
						<g:sortableColumn property="registroDeLaSolicitud" title="${message(code: 'poder.registroDeLaSolicitud.label', default: 'Registro De La Solicitud')}" />
					
						<g:sortableColumn property="tipoDePoder" title="${message(code: 'poder.tipoDePoder.label', default: 'Tipo De Poder')}" />
					
						<g:sortableColumn property="delegacion" title="${message(code: 'poder.delegacion.label', default: 'Delegacion')}" />
					
						<g:sortableColumn property="puesto" title="${message(code: 'poder.puesto.label', default: 'Puesto')}" />
					
						<g:sortableColumn property="contrato" title="${message(code: 'poder.contrato.label', default: 'Contrato')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${poderInstanceList}" status="i" var="poderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${poderInstance.id}">${fieldValue(bean: poderInstance, field: "numeroDeFolio")}</g:link></td>
					
						<td><g:formatDate date="${poderInstance.registroDeLaSolicitud}" /></td>
					
						<td>${fieldValue(bean: poderInstance, field: "tipoDePoder")}</td>
					
						<td>${fieldValue(bean: poderInstance, field: "delegacion")}</td>
					
						<td>${fieldValue(bean: poderInstance, field: "puesto")}</td>
					
						<td>${fieldValue(bean: poderInstance, field: "contrato")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${poderInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
